function setup_semantic_judgement_data(varargin)
    % Adapted from setup_data (ECoG_Data_Prep).

    p = parse_from_matlab_or_json(varargin{:});

    WindowStartInMilliseconds = p.Results.WindowStart;
    WindowSizeInMilliseconds = p.Results.WindowSize;
    BaselineSizeInMilliseconds = p.Results.BaselineWindow;
    BoxCarSize = p.Results.boxcar;
    AverageOverSessions = p.Results.average;
    OVERWRITE = p.Results.overwrite;
    SUBJECTS = p.Results.subjects;
    DATA_DIR = p.Results.dataroot;
    if isempty(p.Results.datarootout)
        DATA_ROOT_OUT = DATA_DIR;
    else
        DATA_ROOT_OUT = p.Results.datarootout;
    end
    META_DIR = p.Results.metaroot;
    STIM_DIR = fullfile(META_DIR,'stimuli');
    COORD_DIR = fullfile(META_DIR,'coords');

    %% Define Output directory
    if AverageOverSessions == 1
        base_dir = 'semanticjudgement/avg';
    else
        base_dir = 'semanticjudgement/full';
    end
    DATA_DIR_OUT = fullfile(...
        DATA_ROOT_OUT,...
        base_dir,...
        'BoxCar',sprintf('%03d',BoxCarSize),...
        'WindowStart',sprintf('%04d',WindowStartInMilliseconds),...
        'WindowSize',sprintf('%04d',WindowSizeInMilliseconds)...
    );
    if ~exist(DATA_DIR_OUT,'dir')
        mkdir(DATA_DIR_OUT)
    end

    fprintf('Looking for source ECoG data in:\n\t%s\n',fullfile(DATA_DIR));
    fprintf('Average over sessions: %d\n', AverageOverSessions);
    fprintf('Box-car size for time-series averaging: %d\n', BoxCarSize);
    fprintf('Size of baseline window (pre stim onset): %d\n', BaselineSizeInMilliseconds);
    fprintf('Beginning of time selection window: %d ms post stim onset\n', WindowStartInMilliseconds);
    fprintf('Length of time window selection: %d ms\n', WindowSizeInMilliseconds);
    fprintf('Processed data will be written to:\n\t%s\n', DATA_DIR_OUT);
    fprintf('Subjects:\n');
    disp(SUBJECTS)

    %% Read presentation order from file
    % All subjects have the same order
    file_stim_order = fullfile(STIM_DIR, 'semantic_judgement_order.csv');
    stim_order = readtable(file_stim_order);
    nsessions = numel(unique(stim_order.Session));

    %% Generate sort indices
    x = tabulate(stim_order.Session);
    stim_order_ix = mat2cell(stim_order.ItemIndex, x(:,2), 1);
    stim_sort_ix = cell(size(x,1),1);
    for i = 1:size(x,1)
        [~,stim_sort_ix{i}] = sort(stim_order_ix{i});
    end
    % note that stimuli are presented twice per block, so two consecutive
    % values in the sort index denote the same stimulus. E.g. suppose the
    % first value in the sort index is 40 and the second is 91. This means
    % that stimulus 1 appears 40th AND 91st. 

    % Load coordinates
    tmp = readtable(fullfile(COORD_DIR,'semantic_judgement_electrodes.csv'));
    subject = tmp.Patient;
    electrode = tmp.Electrode;
    x = tabulate(subject);
    ELECTRODE = mat2cell(electrode,x(:,2),1);

   
    %% Load And Process Data
    % NOTE: In the source data, naming conventions are not consistent. The
    % following structures explicitly represent all the file and field names that
    % need to be referenced.

    DATA = [];
    
    filelist(1).subject = 8;
    filelist(1).filename = 'sub-08_task-semanticjudgement_filtered.mat'; 
    filelist(1).variables = {'SemJudgeERP_Pt08_ANONY'};
    filelist(1).sessions = {1:10};
    filelist(1).sessiontag = {'ss01_vis01','ss03_vis02','ss05_vis03','ss02_aud01','ss04_aud02','ss06_aud03','ss07_vis_ctrl01','ss09_vis_ctrl02','ss08_aud_ctrl01','ss10_aud_ctrl02'};

    filelist(2).subject = 10;
    filelist(2).filename = 'sub-10_task-semanticjudgement_filtered.mat';
    filelist(2).variables = {'SemJudgeERP_Pt10_ANONY'};
    filelist(2).sessions = {1:10};
    filelist(2).sessiontag = {'ss01_vis01','ss04_vis02','ss09_vis03','ss02_aud01','ss03_aud02','ss10_aud3','ss05_vis_ctrl01','ss06_vis_ctrl02','ss07_aud_ctrl01','ss08_aud_ctrl02'};
    
    % Patient 12 also has separate tags for living and nonliving trials
    filelist(3).subject = 12;
    filelist(3).filename = 'sub-12_task-semanticjudgement_filtered.mat'; 
    filelist(3).variables = {'SemJudgeERP_Pt12_ANONY'};
    filelist(3).sessions = {1:10};
    filelist(3).sessiontag = {'ss01_vis01','ss04_vis02','ss10_vis03','ss02_aud01','ss03_aud02','ss09_aud03','ss05_vis_ctrl01','ss08_vis_ctrl02','ss06_aud_ctrl01','ss07_aud_ctrl02'};

    filelist(4).subject = 13;
    filelist(4).filename = 'sub-13_task-semanticjudgement_filtered.mat'; 
    filelist(4).variables = {'SemJudgeERP_Pt13_ANONY'};
    filelist(4).sessions = {1:10};
    filelist(4).sessiontag = {'ss01_vis01','ss04_vis02','ss10_vis03','ss02_aud01','ss03_aud02','ss09_aud03','ss05_vis_ctrl01','ss08_vis_ctrl02','ss06_aud_ctrl01','ss07_aud_ctrl02'};

    filelist(5).subject = 14;
    filelist(5).filename = 'sub-14_task-semanticjudgement_filtered.mat'; 
    filelist(5).variables = {'SemJudgeERP_Pt14_ANONY'};
    filelist(5).sessions = {1:10};
    filelist(5).sessiontag = {'ss01_vis01','ss04_vis02','ss10_vis03','ss02_aud01','ss03_aud02','ss09_aud03','ss05_visctrl01','ss08_visctrl02','ss06_audctrl01','ss07_audctrl02'};

    filelist(6).subject = 15;
    filelist(6).filename = 'sub-15_task-semanticjudgement_filtered.mat'; 
    filelist(6).variables = {'SemJudgeERP_Pt15_ANONY'};
    filelist(6).sessions = {1:10};
    filelist(6).sessiontag = {'ss01_visual01','ss04_visual02','ss07_visual03','ss02_auditory01','ss03_auditory02','ss08_auditory03','ss05_vis_control01','ss10_vis_control02','ss06_aud_control01','ss09_aud_control02'};

    filelist(7).subject = 17;
    filelist(7).filename = 'sub-17_task-semanticjudgement_filtered.mat';
    filelist(7).variables = {'SemJudgeERP_Pt17_ANONY'};
    filelist(7).sessions = {1:10};
    filelist(7).sessiontag = {'ss01_vis01','ss04_vis02','ss07_vis03','ss02_aud01','ss03_aud02','ss08_aud03','ss05_vis_ctrl01','','ss06_aud_ctrl01',''};

    filelist(8).subject = 21;
    filelist(8).filename = 'sub-21_task-semanticjudgement_filtered.mat';
    filelist(8).variables = {'SemJudgeERP_Pt21_ANONY'};
    filelist(8).sessions = {1:10};
    filelist(8).sessiontag = {'ss01_vis01','ss04_vis02','ss09_vis03','ss02_aud01','ss03_aud02','ss10_aud03','ss05_vis_ctrl01','ss08_vis_ctrl02','ss06_aud_ctrl01','ss07_aud_ctrl02'};

    for iSubject=1:numel(SUBJECTS)
        F = selectbyfield(filelist, 'subject', SUBJECTS(iSubject));
        if any(cellfun('isempty', struct2cell(F)))
            fprintf('Skipping subject %d, %s because of missing data.\n',SUBJECTS(iSubject));
            continue
        else
            fprintf('Beginning subject %d, %s.\n',SUBJECTS(iSubject));
        end
        dpath_out = fullfile(DATA_DIR_OUT, sprintf('s%02d_%s.mat',SUBJECTS(iSubject)));
        spath = fullfile(DATA_DIR,F.filename);
        fprintf('Loading %s...\n', spath);

        if isempty(DATA)
            Pt = load(spath);
        else
            Pt = DATA{iSubject};
        end

        nChunks = numel(F.variables);
        if nChunks > 1
            nTicks = 0;
            for iChunk = 1:nChunks
                cvar = F.variables{iChunk};
                nTicks = nTicks + size(Pt.(cvar).DATA,1);
            end
            interval = Pt.(cvar).DIM(1).interval;
            electrodeLabels = Pt.(cvar).DIM(2).label;
            Pt.LFP(1) = init_source_struct(nTicks,electrodeLabels,interval);
            for iChunk = 1:nChunks
                cvar = F.variables{iChunk};
                sessions = F.sessions{iChunk};
                tagfmt = F.sessiontag;
                if iChunk == 1
                    a = 1;
                    b = size(Pt.(cvar).DATA,1);
                    Pt.LFP.DATA(a:b,:) = Pt.(cvar).DATA;
                    Pt.LFP.DIM(1).scale(a:b) = Pt.(cvar).DIM(1).scale;
                    psize = b;
                    pscale = max(Pt.(cvar).DIM(1).scale);
                    Pt = rmfield(Pt,cvar);
                else
                    a = psize + 1;
                    b = psize + size(Pt.(cvar).DATA,1);
                    Pt.LFP.DATA(a:b,:) = Pt.(cvar).DATA;
                    Pt.LFP.DIM(1).scale(a:b) = Pt.(cvar).DIM(1).scale + pscale;

                    for iSession = sessions
                        tag = sprintf(tagfmt,iSession);
                        Pt.(tag) = Pt.(tag) + psize;
                    end

                    psize = b;
                    pscale = max(Pt.(cvar).DIM(1).scale);
                    Pt = rmfield(Pt,cvar);
                end
            end
        else
            cvar = F.variables{1};
            Pt.LFP = Pt.(cvar);
            Pt = rmfield(Pt,cvar);
        end
        
        tmp = arrayfun(@(x) x.subject == F.subject, filelist);
        ecoord = ELECTRODE{tmp};
        edata = cellstr(Pt.LFP.DIM(2).label);
        zc = ismember(ecoord, edata);
        ecoord = ecoord(zc);
     
        stim_order.OnsetIndex = nan(size(stim_order,1),1);
        for iSession = 1:nsessions
            tmp = F.sessiontag(iSession);
            tagname = tmp{1};
            z = stim_order.Session == iSession;
            % if the patient did not do that session
            if ~isfield(Pt,tagname)
                % leave the onset indices of the missing trials as nans
                continue
            else
                % if some trials are missing (i.e. if the onset is nan)
                if size(Pt.(tagname),2) < 96
                    % leave the onset indices of the missing trials as nans
                    stim_order.OnsetIndex(z) = [Pt.(tagname),nan(1, 96 - size(Pt.(tagname),2))];
                else
                    stim_order.OnsetIndex(z) = Pt.(tagname);
                end  
            end
        end

        Hz = 1 / Pt.LFP.DIM(1).interval; % ticks per second
        window_size  = ( WindowSizeInMilliseconds / 1000) * Hz; % in ticks (where a tick is a single time-step).

        % Will return a session -by- electrode cell array, each containing a
        % trial -by- time matrix.
        disp([WindowStartInMilliseconds, WindowSizeInMilliseconds]);  
        ECA = pull_trial_profiles(Pt.LFP, stim_order, [WindowStartInMilliseconds, WindowSizeInMilliseconds], BaselineSizeInMilliseconds, BoxCarSize, ecoord);

        % Average over sessions?
        if AverageOverSessions
            % data array is sessions x items x time, and mean operates over
            % the first dimension by default.
            for iElectrode = 1:numel(ECA)
                ECA(iElectrode).data = squeeze(mean(ECA(iElectrode).data));
            end
        else
            % permute will make items the first dimension, and the reshape
            % will then block rows by session
            for iElectrode = 1:numel(ECA)
               ntp_boxcar = size(ECA(iElectrode).data, 3);
               ECA(iElectrode).data = reshape((permute(ECA(iElectrode).data,[2,1,3])), [], ntp_boxcar);
            end
        end

        X = cat(2, ECA.data);

        if exist(dpath_out,'file') && ~OVERWRITE
            fprintf('Subject %d not written to disk, %s because output already exists.\n',SUBJECTS(iSubject))
        else
            save(dpath_out, 'X','-v7.3');
            fprintf('Subject written to %s\n', dpath_out);
        end
        Pt = [];
    end

end

function t = tabulate(x)
    u = unique(x);
    n = numel(u);
    N = numel(x);
    if iscell(u)
        t = cell(n, 3);
        t(:,1) = u;
        for i = 1:n
            t{i,2} = nnz(strcmp(u{i},x));
            t{i,3} = t{i,2} ./ N;
        end
    else
        t = zeros(n, 3);
        t(:,1) = u;
        for i = 1:n
            t(i,2) = nnz(u(i) == x);
        end
        t(:,3) = t(:,2) ./ N;
    end
end

function p = parse_from_matlab_or_json(varargin)
    % In this case, arguments can be handled in their expected types
    % (numbers as numbers, etc). The input may be coming directly from
    % the Matlab command line or script, or parsed from a json file.
    p = inputParser();
    addParameter(p, 'WindowStart',[]);
    addParameter(p, 'WindowSize',[]);
    addParameter(p, 'BaselineWindow',0);
    addParameter(p, 'subjects', [1:3,5,7:10]);
    addParameter(p, 'boxcar', 10, @isscalar);
    addParameter(p, 'slope_interval', 0, @isscalar);
    addParameter(p, 'average', 1);
    addParameter(p, 'datacode', 'raw', @ischar);
    addParameter(p, 'dataroot', 'D:\ECoG\KyotoNaming\data');
    addParameter(p, 'metaroot', 'C:\Users\mbmhscc4\MATLAB\ECOG\naming\data');
    addParameter(p, 'datarootout', []);
    addParameter(p, 'cvpath', []);
    addParameter(p, 'overwrite', 0);
    addParameter(p, 'WriteIndividualMetadata', 0);
    addParameter(p, 'Pt', []);
    parse(p, varargin{:});
    if isempty(p.Results.WindowStart)
        error('A window start time must be provided.');
    end
    if isempty(p.Results.WindowSize)
        error('A window size must be provided.');
    end
end
