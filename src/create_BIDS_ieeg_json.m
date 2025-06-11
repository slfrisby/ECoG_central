function create_BIDS_ieeg_json(path)

    % make sidecar .json to accompany data files in BIDS format. 

    % Arguments:
    % - path: path to data file. The name of the data file should be in
    % BIDS format. Character vector

    % setup
    addpath(genpath('/group/mlr-lab/Saskia/ECoG_central/dependencies'));

    % load details needed to create .json files. If the details file is
    % missing, create it
    if ~exist('/group/mlr-lab/Saskia/ECoG_central/work/details_for_json.mat')
        specify_json_details;
    end
    load('/group/mlr-lab/Saskia/ECoG_central/work/details_for_json.mat');

    % from the path, get:
    % - the patient ID
    tmp = extractBetween(path,'sub-','/ieeg');
    p = tmp{1};
    % - the task
    tmp = extractBetween(path,'_task-','_run');
    task = tmp{1};
    % - the run number
    tmp = extractBetween(path,'_run-','_ieeg');
    run = tmp{1};

    % find the row of jsonDetails that corresponds to this patient and
    % task
    tmp = arrayfun(@(x) strcmp(x.Subject, p) && strcmp(x.Task, task), jsonDetails);
    patientDetails = jsonDetails(tmp);

    % create .json file following this template: https://github.com/bids-standard/bids-starter-kit/blob/main/matlabCode/ieeg/createBIDS_ieeg_json.m

    % required fields
    json.TaskName = patientDetails.Task;
    json.SamplingFrequency = patientDetails.SamplingFrequency;
    json.PowerLineFrequency = 60;
    json.SoftwareFilters = 'n/a';

    % recommended fields
    HardwareFilters.HighpassFilter.CutoffFrequency = 'n/a';
    % patients recorded at 1000 Hz had a low-pass filter imposed at 300 Hz.
    % Others (recorded at 2000 Hz) had a low-pass filter imposed at 600 Hz
    if patientDetails.SamplingFrequency == 1000
        HardwareFilters.LowpassFilter.CutoffFrequency = 300;
    elseif patientDetails.SamplingFrequency == 2000
        HardwareFilters.LowpassFilter.CutoffFrequency = 600;
    end
    json.HardwareFilters = HardwareFilters; 

    json.Manufacturer = 'Ad-Tech Medical';
    json.ManufacturersModelName = 'n/a';
    json.TaskDescription = 'n/a';
    json.Instructions = 'n/a';
    json.CogAtlasID = 'https://www.cognitiveatlas.org/FIXME';
    json.CogPOID = 'http://www.cogpo.org/ontologies/CogPOver1.owl#FIXME';
    json.InstitutionName = 'n/a';
    json.InstitutionAddress = 'n/a';
    json.DeviceSerialNumber = 'n/a';
    json.ECOGChannelCount = patientDetails.ECOGChannelCount;
    json.SEEGChannelCount = patientDetails.SEEGChannelCount;
    json.EEGChannelCount = 0;
    json.EOGChannelCount = patientDetails.EOGChannelCount;
    json.ECGChannelCount = patientDetails.ECGChannelCount;
    json.EMGChannelCount = 0;
    json.MiscChannelCount = patientDetails.MiscChannelCount;
    json.TriggerChannelCount = patientDetails.TriggerChannelCount;
    json.RecordingDuration = 0;
    json.RecordingType = 'continuous';
    json.EpochLength = 5;
    json.SubjectArtefactDescription = 'n/a';
    json.SoftwareVersions = 'n/a';

    % required fields
    json.iEEGReference = patientDetails.iEEGReference;

    % recommended fields
    json.ElectrodeManufacturer = 'Ad-Tech Medical';
    json.ElectrodeManufacturersModelName = 'n/a';
    json.iEEGGround = 'n/a';
    json.iEEGPlacementScheme = 'n/a';
    json.iEEGElectrodeGroups = 'n/a';

    % write .json
    [filepath,name,~] = fileparts(path);
    fid = fopen([filepath,'/',name,'.json'],'w');
    fwrite(fid,jsonencode(json,'PrettyPrint',true),'char');

end