% converts raw ECoG and sEEG naming and semantic judgement data to BIDS 
% format. This makes it easy to use and share data. NOTE: the BIDS 
% formatting will not be perfect, but imperfect BIDS format is still helpful!

% setup
% the root directory contains the /raw directory
root = '/group/mlr-lab/Saskia/ECoG_central/';
% add source code to path
addpath([root,'/src']);

cd(root);

% 1. INITIALISE BIDS DIRECTORY STRUCTURE

% initialise BIDS directory structure
mkdir([root,'/data']);

% make dataset_description.json, CHANGES, and README files. These should be
% included with BIDS-formatted datasets, but they are not particularly
% important for our ECoG analyses. 

% make dataset_description.json
fid = fopen([root,'/data/dataset_description.json'],'w');
fwrite(fid,jsonencode(struct('Name','','BIDSVersion','1.10.1'),'PrettyPrint',true),'char');
fclose(fid);

% the README file is copied from /src (check that you are happy with the
% contents!)
copyfile([root,'/src/README.md'],[root,'/data/README.md']);

% 2. ORGANISE ADDITIONAL INFORMATION

% this includes extra data files - including seizure onset zone information,
% atlases, stimuli, and images and videos of some patients
transfer_misc_files;

% 3. ORGANISE DATA

% get all folders in the /raw/data directory
patients = dir([root,'/raw/data/*']);
patients = patients([patients.isdir]);
patients = patients(~ismember({patients.name},{'.','..'}));

% for each patient
for q = 11%:length(patients)

    % get that patient's ID number
    tmp = regexp(patients(q).name,'\d+','match');
    p = tmp{1};

    % make BIDS-compliant data folder
    mkdir([root,'/data/sub-',p,'/ieeg/']);

    % get data files
    dataFiles = dir([root,'/raw/data/*',p,'*/*.mat']); 

    % there are 2 naming data files for participant 22. We need the revised
    % version, which includes EOG. So do a bug fix
    if strcmp(p, '22')
        dataFiles = dataFiles(strcmp({dataFiles.name},{'Pt22_namingERP_rev.mat'}));
    end

    % for each data file
    for d = 1:length(dataFiles)
        
        % if it is naming data
        if contains(dataFiles(d).name,'naming')
            % set the BIDS filename
            BIDSFilename = [root,'/data/sub-',p,'/ieeg/sub-',p,'_task-naming_run-01_ieeg.mat'];
        % or if it is semantic judgement data
        elseif contains(dataFiles(d).name,'SemJudge')
            BIDSFilename = [root,'/data/sub-',p,'/ieeg/sub-',p,'_task-semanticjudgement_run-01_ieeg.mat'];
        end
            % copy the file, renaming it according to BIDS naming
            % conventions
            copyfile([dataFiles(d).folder,'/',dataFiles(d).name],BIDSFilename);
            % fix a common electrode mislabelling problem
            fix_electrode_labelling(BIDSFilename);
            % make sidecar .json
            create_BIDS_ieeg_json(BIDSFilename);
            % make channels.tsv
            create_BIDS_channels_tsv(BIDSFilename);
            % make electrodes.tsv file unless it exists already
            if ~exist([eraseBetween(BIDSFilename,'task','.mat','Boundaries','inclusive'),'electrodes.tsv'])
                create_BIDS_electrodes_tsv(BIDSFilename);
            end         
    end
end


