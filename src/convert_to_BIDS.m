% converts raw ECoG and sEEG naming and semantic judgement data to BIDS 
% format. This makes it easy to use and share data. NPTE: the BIDS 
% formatting will not be perfect, but imperfect BIDS format is still helpful!

% BEFORE YOU BEGIN, set up a directory structure like this:
% - create a directory called /raw.
% - within /raw, create the following directories:
% -- /data. Within /data, create a directory for each patient. Ensure 
% that each patient has the same number of digits in the patient ID (e.g.
% Pt01, ... Pt22, NOT Pt1, ... Pt22). In those directories, put the .mat 
% files containing that participant's ECoG data.
% 
% ALSO BEFORE YOU BEGIN, make the following edits:
% - edit src/README.md to suit the dataset that you are working with.
% Templates and guidance can be found here:
% https://bids.neuroimaging.io/getting_started/templates/index.html#dataset_description.json
% - edit specify_json_details.m to provide the correct details for your
% patients.
% - edit create_BIDS_ieeg.json. Ensure that the file paths are correct and
% that the line noise, filters, and trial lengths are set correctly for your data.

% setup
% add source code and dependencies to path
addpath('/group/mlr-lab/Saskia/ECoG_central/src');
addpath(genpath('/group/mlr-lab/Saskia/ECoG_central/dependencies'));
% the root directory contains the /raw directory
root = '/group/mlr-lab/Saskia/ECoG_central/';
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

% 2. ORGANISE DATA

% get all folders in the /raw/data directory
patients = dir([root,'/raw/data/*']);
patients = patients([patients.isdir]);
patients = patients(~ismember({patients.name},{'.','..'}));

% for each patient
for q = 1:length(patients)

    % get that patient's ID number
    tmp = regexp(patients(q).name,'\d+','match');
    p = tmp{1};

    % make BIDS-compliant data folder
    mkdir([root,'/data/sub-',p,'/ieeg/']);

    % get data files
    dataFiles = dir([root,'/raw/data/*',p,'*/*.mat']); 

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
    end
end
