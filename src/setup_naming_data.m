function setup_naming_data(varargin)
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
        base_dir = 'naming/avg';
    else
        base_dir = 'naming/full';
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
    file_stim_order = fullfile(STIM_DIR, 'naming_order.csv');
    stim_order = readtable(file_stim_order);
    nsessions = numel(unique(stim_order.Session));

    %% Generate sort indices
    x = tabulate(stim_order.Session);
    stim_order_ix = mat2cell(stim_order.ItemIndex, x(:,2), 1);
    stim_sort_ix = cell(size(x,1),1);
    for i = 1:size(x,1)
        [~,stim_sort_ix{i}] = sort(stim_order_ix{i});
    end

    % Load coordinates
    tmp = readtable(fullfile(COORD_DIR,'naming_electrodes.csv'));
    subject = tmp.Patient;
    electrode = tmp.Electrode;
    x = tabulate(subject);
    ELECTRODE = mat2cell(electrode,x(:,2),1);
   
    %% Load And Process Data
    % NOTE: In the source data, naming conventions are not consistent. The
    % following structures explicitly represent all the file and field names that
    % need to be referenced.

    DATA = [];
    
    filelist(1).subject = 1;
    filelist(1).filename = 'sub-01_task-naming_filtered.mat'; 
    filelist(1).variables = {'Pt01_namingERP_anony'};
    filelist(1).sessions = {1:4};
    filelist(1).sessiontag = 'ERP_tag%02d';

    filelist(2).subject = 2;
    filelist(2).filename = 'sub-02_task-naming_filtered.mat'; 
    filelist(2).variables = {'Pt02_namingERP_anony'};
    filelist(2).sessions = {1:4};
    filelist(2).sessiontag = 'tag%02d_all';

    filelist(3).subject = 3;
    filelist(3).filename = 'sub-03_task-naming_filtered.mat'; 
    filelist(3).variables = {'Pt03_namingERP_anony'};
    filelist(3).sessions = {1:4};
    filelist(3).sessiontag = 'tag%02d_all';

    filelist(4).subject = 4;
    filelist(4).filename = 'sub-04_task-naming_filtered.mat'; 
    filelist(4).variables = {'Pt04_namingERP_anony_SS01_02','Pt04_namingERP_anony_SS03_04'};
    filelist(4).sessions = {1:2,3:4};
    filelist(4).sessiontag = 'tag_ss%02d';

    filelist(5).subject = 5;
    filelist(5).filename = 'sub-05_task-naming_filtered.mat'; 
    filelist(5).variables = {'Pt05_namingERP_anony_01'};
    filelist(5).sessions = {1:4};
    filelist(5).sessiontag = 'tag_ss%02d';

    filelist(6).subject = 6;
    filelist(6).filename = 'sub-06_task-naming_filtered.mat'; 
    filelist(6).variables = {'Pt06_namingERP_anony'};
    filelist(6).sessions = {1:4};
    filelist(6).sessiontag = 'tag%02d_all';

    filelist(7).subject = 7;
    filelist(7).filename = 'sub-07_task-naming_filtered.mat'; 
    filelist(7).variables = {'Pt07_namingERP_anony_SS01_02','Pt07_namingERP_anony_SS03_04'};
    filelist(7).sessions = {1:2,3:4};
    filelist(7).sessiontag = 'tag%02d_all';

    filelist(8).subject = 8;
    filelist(8).filename = 'sub-08_task-naming_filtered.mat'; 
    filelist(8).variables = {'Pt08_namingERP_anony'};
    filelist(8).sessions = {1:4};
    filelist(8).sessiontag = 'tag_%02d';

    filelist(9).subject = 9;
    filelist(9).filename = 'sub-09_task-naming_filtered.mat'; 
    filelist(9).variables = {'Pt09_namingERP_anony'};
    filelist(9).sessions = {1:4};
    filelist(9).sessiontag = 'nam_tag%02d';

    filelist(10).subject = 10;
    filelist(10).filename = 'sub-10_task-naming_filtered.mat'; 
    filelist(10).variables = {'Pt10_namingERP_anony'};
    filelist(10).sessions = {1:4};
    filelist(10).sessiontag = 'tagall%02d';

    filelist(11).subject = 11;
    filelist(11).filename = 'sub-11_task-naming_filtered.mat'; 
    filelist(11).variables = {'Pt11_namingERP_anony'};
    filelist(11).sessions = {1:4};
    filelist(11).sessiontag = 'tagss%02d';

    filelist(12).subject = 12;
    filelist(12).filename = 'sub-12_task-naming_filtered.mat'; 
    filelist(12).variables = {'Pt12_namingERP_anony'};
    filelist(12).sessions = {1:4};
    filelist(12).sessiontag = 'nam_%02d';

    filelist(13).subject = 13;
    filelist(13).filename = 'sub-13_task-naming_filtered.mat'; 
    filelist(13).variables = {'namingERP_Pt13_ANONY'};
    filelist(13).sessions = {1:4};
    filelist(13).sessiontag = 'tag_nam%02d';

    filelist(14).subject = 14;
    filelist(14).filename = 'sub-14_task-naming_filtered.mat'; 
    filelist(14).variables = {'namingERP_Pt14_ANONY'};
    filelist(14).sessions = {1:4};
    filelist(14).sessiontag = 'ss%02d';

    filelist(15).subject = 15;
    filelist(15).filename = 'sub-15_task-naming_filtered.mat'; 
    filelist(15).variables = {'namingERP_Pt15_ANONY'};
    filelist(15).sessions = {1:4};
    filelist(15).sessiontag = 'tag%02d';

    filelist(16).subject = 17;
    filelist(16).filename = 'sub-17_task-naming_filtered.mat';
    filelist(16).variables = {'namingERP_Pt17_ANONY'};
    filelist(16).sessions = {1:4};
    filelist(16).sessiontag = 'tag_ss%02d';

    filelist(17).subject = 20;
    filelist(17).filename = 'sub-20_task-naming_filtered.mat';
    filelist(17).variables = {'namingERP_Pt20_ANONY'};
    filelist(17).sessions = {1:4};
    filelist(17).sessiontag = 'Tag1_ss%01d';

    filelist(18).subject = 21;
    filelist(18).filename = 'sub-21_task-naming_filtered.mat';
    filelist(18).variables = {'namingERP_Pt21_ANONY'};
    filelist(18).sessions = {1:4};
    filelist(18).sessiontag = 'tag_ss%02d';

    filelist(19).subject = 22;
    filelist(19).filename = 'sub-22_task-naming_filtered.mat';
    filelist(19).variables = {'SemJudgeERP_Pt22_ANONY_wEOG'}; % Akihiro confirms that this is naming data - the variable is mislabelled
    filelist(19).sessions = {1:4};
    filelist(19).sessiontag = 'tag_ss%02d';

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
     
        tagfmt = F.sessiontag;
        stim_order.OnsetIndex = nan(size(stim_order,1),1);
        for iSession = 1:nsessions
            tagname = sprintf(tagfmt,iSession);
            z = stim_order.Session == iSession;
            stim_order.OnsetIndex(z) = Pt.(tagname);
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
            save(dpath_out, 'X', '-v7.3');
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
