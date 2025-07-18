function reject_artefacts(p)  

    % conduct artefact rejection. This script is not suitable for deployment to
    % the CBU cluster.

    % Arguments
    % - p: subject ID (character vector)
    
    % setup
    root = '/group/mlr-lab/Saskia/ECoG_central';
    addpath([root,'/src']);
    % eeglab should have the cleanline and SASICA plugins installed. To 
    % adapt SASICA for ECoG, open eeg_SASICA.m and comment out lines 148-150
    % and 711-818.
    addpath([root,'/dependencies/']);
    addpath(genpath([root,'/dependencies/eeglab']));
    addpath(genpath([root,'/dependencies/cleanline']));
    cd(root);
    
    %% TODO: specify bad trials

    % get epoched data - naming and (if available) semantic judgement
    dataFiles = dir([root,'/work/sub-',p,'/*_epoched.mat']);

    % for each data file
    for d = 1:length(dataFiles)

        % Load data into EEGlab.
        load([dataFiles(d).folder, '/', dataFiles(d).name]);
        load([root,'/src/eeglab_init.mat']); 
        EEG.setname = ['sub-',p];
        EEG.data = data;
        EEG.nbchan = size(data,1);
        EEG.srate = 1000; % data collected at 2000 Hz have now been downsampled to 1000 Hz
        EEG.subject = ['sub-',p];
        EEG = eeg_checkset(EEG);
        eeglab redraw

        % create a filter
        trialFilter = ones(size(data,3),1);
        
        %% STEP 1 - common average referencing

        % compute and apply a common average reference
        EEG.data = reref(EEG.data,[]);

        % optionally, check the results of the rereferencing
        % eegplot(data,'data2',EEG.data)
            
        %% STEP 2 - automatic trial rejection with a liberal threshold
        % any trial with a deviation of over 10 standard deviations from
        % the channel mean (over all timepoints and trials) is marked for
        % auto-rejection.
        
        % initialise variables
        outlierTrials = [];
        channelSpikeCount = zeros(size(EEG.data,1),1);

        % for each channel
        for c = 1:size(EEG.data,1)

            % get data and calculate the mean and standard deviation for that
            % channel
            channelData = squeeze(EEG.data(c,:,:));
            m = mean(channelData,'all');
            s = std(channelData,0,'all');

            % find the indices of the trials where there are spikes over 10
            % standard deviations above or below the mean
            [~,o] = ind2sub(size(channelData),find(channelData > m+10*s | channelData < m-10*s));
            % add this list of trials to that participant's list of trials
            % to reject
            outlierTrials = vertcat(outlierTrials,o);

            % store the number of spikes per channel
            channelSpikeCount(c) = length(unique(o));

        end
        
        % Some trials contain spikes in multiple channels. We need only count
        % each trial once.
        outlierTrials = unique(outlierTrials);
        % mark those trials for rejection
        trialFilter(outlierTrials) = 0;
        
        % Plot a figure to assess the distribution of spikes across channels.
        % Sometimes there is one channel that has an atypically large number of
        % spikes. If this is the case, it can be better to reject that channel
        % rather than all those trials.
        f = figure;
        f = bar(1:size(EEG.data,1),squeeze(channelSpikeCount));
        xticks(1:size(EEG.data,1))
        xlabel('Electrode')
        ylabel('Number of outliers')
        title(['Sub-',p])
        saveas(gcf,[root,'/work/sub-',p,'/autorejection_per_channel.png'])
        % close(gcf)   
        
        %% Stage 3 - manual trial rejection
            
        % eegplot(EEG.data)

        % Set the y-axis to 500. Inspect the trials that are auto-rejected, to ensure that this is sensible.
        % Then make a note of any trials that:
             % - appear to contain ictal or interictal activity
             %   (https://www.learningeeg.com/epileptiform-activity). Be careful of wicket spikes, which look
             %   periodic but are actually a feature of the healthy temporal lobe.
             % - appear to contain artifacts, especially muscle activity.
             % - appear to show electrode pop.

        % Fill in the bad trials in specify_bad_trials.
        

        %% STEP 4 - Independent components analysis (ICA)
        
        % find the row of badTrials that corresponds to this patient and
        % task.
        % get the task
        tmp = extractBetween(dataFiles(d).name,'_task-','_epoched');
        task = tmp{1};
        % get the corresponding row of badTrials
        tmp = arrayfun(@(x) strcmp(x.Subject, p) && strcmp(x.Task, task), badTrials);
        patientBadTrials = badTrials(tmp);
        % flag the bad trials for removal
        trialFilter(patientBadTrials.BadTrials) = false;
        % get number of timepoints (to help with data reshaping later)
        [~, nTimepoints, ~] = size(EEG.data);

        % copy data (and save a copy for later)
        ICAData = EEG.data;
        data = EEG.data;
        % reject trials that are flagged for rejection from the ICA data
        % (not from the main data!)
        ICAData(:,:,trialFilter==0) = [];
        % reshape ICA data into a continuous recording
        ICAData = reshape(ICAData, size(ICAData,1), []);
        % Load ICA data into EEGlab
        EEG.data = ICAData; 
        
        % Conduct ICA. The number of ICs is 75% the number of good electrodes
        % (Clarke 2020).
        [weights,sphere,compvars,bias,signs,lrates,ICs] = runica(ICAData,'extended',1,'PCA',round(size(ICAData,1)*0.75));
        
        % save the results of the ICA
        save([root,'/work/sub-',p,'/ICA.mat'],'weights','sphere','compvars','bias','signs','lrates','ICs','-v7.3')
    
        % load the ICA results into EEGlab
        EEG.icaweights=weights;
        EEG.icasphere=sphere;
        EEG.icawinv=pinv(EEG.icaweights*EEG.icasphere); % see https://sccn.ucsd.edu/pipermail/eeglablist/2009/002907.html to explain why this is so
        EEG.icaact = reshape(ICs,round(size(ICAData,1)*0.75),nTimepoints,[]);
        EEG = eeg_checkset(EEG);
        % eeglab redraw
           
        %% STEP 4.1 - SASICA
        
            % We use SASICA to flag components with low autocorrelation
            % (usually represents muscle activity) and/or high focal trial acrivity
            % (usually represents muscle activity, electrode pop, or similar).
        
            % configure SASICA
            cfg = SASICA('getdefs');
            cfg.autocorr.enable = logical(1);
            cfg.trialfoc.enable= logical(1);
            % apply SASICA
            [EEG,cfg] = eeg_SASICA(EEG,cfg);
            % list trials with low autocorrelation or high focal trial activity
            flagcomps = find(EEG.reject.gcompreject);
        
            % Scroll component activations (view 20 trials at once for ease). See
            % whether you agree that the component looks noisy or has some unusual
            % trials. If you don't agree, don't reject the component. For focal
            % trial activity, consider rejecting the focal trials rather than the
            % whole component. NOTE: because only the (assumed) good trials have
            % been loaded into EEGlab, the trial indices displayed by EEGlab will
            % not be the true trial indices in the complete data. To find the true
            % trial indices to store in badtrials, use, for example:
            % tmp = EEG.data(1,1,345)
            % [x,y,z] = ind2sub(size(completedata),find(completedata==tmp))
            % z is the trial index in the complete data. If there are multiple
            % values of z, the correct value is the one where x = 1 and y = 1.
        
            % eegplot(EEG.data)
        
            %% 4.2 - Microsaccade filtering
        
            % This is based on the method of Clarke (2020). It works by:
                % 1. Performing ICA
                % 2. Filtering independent components for gamma/high gamma (the range in which we
                % expect to see microsaccadic activity)
                % 3. Convolving a template of saccade-related activity with the ICA
                % components
                % 4. Plotting a graph showing which components have the highest
                % number of saccade events. If it is clear that one or two
                % components have MANY more saccade events than others, these
                % components should be rejected.
        
            % Load the independent components into the data space of eeglab in order to use the filter  
            EEG.data = ICs;
            EEG = eeg_checkset(EEG);
            % filter the components for gamma and high-gamma activity
            EEG = pop_eegfiltnew(EEG,'locutoff',20,'hicutoff',190,'plotfreqz',0);
            fICs = EEG.data;
            fICs = reshape(fICs, size(fICs,1), []);
        
            % initialise variables
            mpd=20; % Minimum peak distance for saccades - originally mpd=round(20/(1000/srate)).
            locs = []; % this will contain the locations of the saccades within the IC
            z=[]; % this will contain the saccade-template-filtered ICs
        
            % for each component
            for i = 1:size(fICs,1)
                % filter the component with a saccade template
                z(i,:) = filtSRP(double(fICs(i,:))',1000);
                [pks,locs] = findpeaks(z(i,:),'minpeakheight',2*mean(abs(z(i,:)),2),'minpeakdistance',mpd);
                sac_rate(i) = length(locs)/(length(z)*1000); % number of events per second
            end
            % sort components by number of saccades
            sortsacs = sortrows([1:length(sac_rate); sac_rate]',2,'descend')';
            % plot a figure to assess whether some components have dramatically
            % more microsaccades than others
            f = figure;
            f = bar(sortsacs(2,:));
            set(gca,'xtick',[])
            xlabel('Component')
            ylabel('Number of saccades')
            title(['Sub-',p])
            saveas(gcf,[root,'/work/sub-',p,'/microsaccade_count.png'])
            close(gcf)  
        
            %% IF YOU AGREE THAT COMPONENTS SHOULD BE REJECTED - reject components
        
            % % list components
            % comps2keep = 1:size(ICs,1);
            % % mark flagged components for removal
            % comps2keep(ismember(comps2keep,flagcomps))=[];
            % icadat = reshape(completedata,size(completedata,1),[]);
            % % reject and reconstruct
            % [icaprojdata] = icaproj(icadat,weights,comps2keep);
            % % reshape
            % X = reshape(icaprojdata,s1,s2,s3);
        
            %% IF NO COMPONENTS NEED REJECTING
            X = completeData;
        
        
            %% Save
            save([root,'/work/sub-',p,'/clean.mat'],'X');
            mkdir([root,'/inspected/sub-',p,'/'])
            save([root,'/inspected/sub-',p,'/clean.mat'],'X');
        
            %% Save filter as part of metadata
            load([root,'/work/sub-',p,'/full/BoxCar/001/WindowStart/-1000/WindowSize/4000/metadata__',p,'.mat'])
            metadata.filters(10).label = 'badtrials';
            metadata.filters(10).dimension = 1;
            metadata.filters(10).filter = logical(trialfilter);
            save([root,'/work/sub-',p,'/metadata.mat'],'metadata');
        
            % Throw a warning if there is not at least one good trial for each
            % stimulus.
            detector = trialfilter(1:100)+trialfilter(101:200)+trialfilter(201:300)+trialfilter(301:400);
            livingdetector = trialfilter(1:50)+trialfilter(101:150)+trialfilter(201:250)+trialfilter(301:350);
            nonlivingdetector = trialfilter(51:100)+trialfilter(151:200)+trialfilter(251:300)+trialfilter(351:400);
            if ~isempty(find(detector==0))
                warning(['participant ',p,' is missing ',num2str(length(find(livingdetector==0))),' living trials and ',num2str(length(find(nonlivingdetector==0))),' nonliving trials.'])
            end
        
            %% Clear
            clearvars -except root subs badtrials
    end

