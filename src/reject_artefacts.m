function reject_artefacts(p)  

    % conduct artefact rejection. This script should be run step-by-step
    % locally, and you should inspect the data and edit specify_bad_trials
    % to your satisfaction. The script can then be deployed to the CBU
    % cluster so that the ICA completes faster.

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
    addpath(genpath([root,'/dependencies/SASICA']));
    cd(root);
    
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
        % eeglab redraw

        % create a filter. This will be used to filter out (1) trials
        % exceeding the automatic threshold and (2) trials identified as
        % bad via visual inspection (see below for full details).
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
            m = mean(channelData,'all','omitnan');
            s = std(channelData,0,'all','omitnan');

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
        close(gcf)   
        
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
        
        % bring the badTrials variable into the workspace
        load([root,'/work/details_for_trial_rejection.mat']);
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

        % copy data to reshape ready for ICA
        ICAData = EEG.data;
        % (also save a copy of the data which will not be edited during
        % ICA)
        completeData = EEG.data;
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
        save([root,'/work/sub-',p,'/sub-',p,'_task-',task,'_ICA.mat'],'weights','sphere','compvars','bias','signs','lrates','ICs','-v7.3')
    
        % load the ICA results into EEGlab
        EEG.icaweights = weights;
        EEG.icasphere = sphere;
        EEG.icawinv = pinv(EEG.icaweights*EEG.icasphere); % see https://sccn.ucsd.edu/pipermail/eeglablist/2009/002907.html to explain why this is so
        EEG.icaact = reshape(ICs,round(size(ICAData,1)*0.75),nTimepoints,[]);
        EEG = eeg_checkset(EEG);
        % eeglab redraw
           
        %% STEP 4.1 - SASICA
        
            % We use SASICA to flag components with low autocorrelation
            % (usually represents muscle activity) and/or high focal trial acrivity
            % (usually represents muscle activity, electrode pop, or similar).
        
            % configure SASICA
            cfg = SASICA('getdefs');
            cfg.autocorr.enable = true;
            cfg.trialfoc.enable= true;
            % apply SASICA
            [EEG,cfg] = eeg_SASICA(EEG,cfg);
            % save figure
            saveas(gcf,[root,'/work/sub-',p,'/sub-',p,'_task-',task,'_SASICA.png'])
           
            % Scroll component activations (view 20 trials at once for ease). See
            % whether you agree that the component looks noisy or has some unusual
            % trials. If you don't agree, don't reject the component. For focal
            % trial activity, consider rejecting the focal trials rather than the
            % whole component. NOTE: because only the (assumed) good trials have
            % been loaded into EEGlab, the trial indices displayed by EEGlab will
            % not be the true trial indices in the complete data. To find the true
            % trial indices to store in badTrials, use, for example:
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
        
            % initialise variables - minimum distance between saccades (in
            % miliseconds), saccade-filtered ICs, saccade rate
            minPeakDistance = 20;
            sfICs = [];
            saccadeRate = zeros(1,size(ICs,1));
            
            % for each component
            for i = 1:size(fICs,1)
                % filter the component with a saccade template
                sfICs(i,:) = filtSRP(double(fICs(i,:))',1000);
                % get the locations of saccade events within the IC. Specify that these
                % must be larger in amplitude than twice the mean and that
                % they must be at least 20 ms apart
                [~,locations] = findpeaks(sfICs(i,:),'minpeakheight',2*mean(abs(sfICs(i,:)),2),'minpeakdistance',minPeakDistance);
                % calculate the number of events per second
                saccadeRate(i) = length(locations)/(length(sfICs)*1000); % number of events per second
            end

            % plot a figure to assess whether some components have dramatically
            % more microsaccades than others
            f = figure;
            bar(1:size(sfICs,1),saccadeRate');
            set(gca,'xtick',1:size(sfICs,1));
            xlabel('Component')
            ylabel('Number of saccades')
            title(['Sub-',p])
            saveas(f,[root,'/work/sub-',p,'/sub-',p,'_task-',task,'_microsaccade-count.png'])
            close(f)  
        
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
            save([root,'/work/sub-',p,'/sub-',p,'_task-',task,'_preprocessed.mat'],'X','-v7.3');
        
            % Throw a warning if there is not at least one good trial for each
            % stimulus.
            
            % if it is naming data
            if strcmp(task,'naming')
                % there are 400 trials - 4 repeats of 100 stimuli. Count
                % how many repeats of each stimulus are good
                nGoodTrials = trialFilter(1:100) + trialFilter(101:200) + trialFilter(201:300) + trialFilter(301:400);
                % if there are items with no good trials
                if ~isempty(find(nGoodTrials == 0))
                    % throw a warning, explaining how many living and
                    % nonliving stimuli are missing any good trials
                    warning(['Participant ',p,' lacks any good trials for ',num2str(length(find(nGoodTrials == 0))),' items: ',num2str(length(find(nGoodTrials(1:50) == 0))),' living items and ',num2str(length(find(nGoodTrials(51:100) == 0))),' nonliving items.']);
                end
            
            % else if it is semantic judgement data
            elseif strcmp(task,'semanticjudgement')
                % there are 960 trials. The first 3 blocks of 96 are visual
                % semantic, the next 3 blocks of 96 are auditory semantic,
                % the next 2 blocks are visual control, and the final 2
                % blocks are auditory control. 
                nGoodTrials(:,1) = trialFilter(1:96) + trialFilter(97:192) + trialFilter(193:288);
                nGoodTrials(:,2) = trialFilter(289:384) + trialFilter(385:480) + trialFilter(481:576);
                nGoodTrials(:,3) = trialFilter(577:672) + trialFilter(673:768);
                nGoodTrials(:,4) = trialFilter(769:864) + trialFilter(865:960);
                % within each block, stimuli 1:24 are living, stimuli 25:48
                % are nonliving, stimuli 49:72 are the SAME living stimuli,
                % and stimuli 73:96 are the SAME nonliving stimuli. Count
                % how many repeats of the same stimulus are good
                nGoodTrials = nGoodTrials(1:48,:) + nGoodTrials(49:96,:);

                 if ~isempty(find(nGoodTrials == 0))
                    % throw a warning, explaining how many living and
                    % nonliving stimuli are missing any good trials
                    warning(['Participant ',p,' lacks any good trials for ',num2str(length(find(nGoodTrials == 0))),' items: ' ...
                        num2str(length(find(nGoodTrials(:,1) == 0))), ' visual semantic items (',num2str(length(find(nGoodTrials(1:24,1) == 0))),' living and ',num2str(length(find(nGoodTrials(25:48,1) == 0))),' nonliving), ' ...
                        num2str(length(find(nGoodTrials(:,2) == 0))), ' auditory semantic items (',num2str(length(find(nGoodTrials(1:24,2) == 0))),' living and ',num2str(length(find(nGoodTrials(25:48,2) == 0))),' nonliving), ' ...
                        num2str(length(find(nGoodTrials(:,3) == 0))), ' visual control items (',num2str(length(find(nGoodTrials(1:24,3) == 0))),' living and ',num2str(length(find(nGoodTrials(25:48,3) == 0))),' nonliving), ' ...
                        num2str(length(find(nGoodTrials(:,4) == 0))), ' auditory control items (',num2str(length(find(nGoodTrials(1:24,4) == 0))),' living and ',num2str(length(find(nGoodTrials(25:48,4) == 0))),' nonliving).'])    
                end
       
            end
            % done
            disp('Done!')
    end

