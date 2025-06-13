function create_BIDS_channels_tsv(path)

    % make channels.tsv file to accompany data files in BIDS format. 

    % Arguments:
    % - path: path to data file. The name of the data file should be in
    % BIDS format. Character vector

    % load data file
    tmp = load(path);

    % use indexing to locate the main data structs within this file
    variableNames = fieldnames(tmp);
    dataIndex = false(length(fieldnames(tmp)),1);
    for i = 1:length(fieldnames(tmp))
        if isstruct(tmp.(variableNames{i}))
            dataIndex(i) = true;
        end
    end
    variableNames = variableNames(dataIndex);
    % some datasets contain 2 variables of data. In this case, just use the
    % first one
    if length(variableNames) > 1
        variableNames = variableNames(1);
    end
    
    % within the main data struct, get the names of the channels
    name = cellstr(tmp.(variableNames{1}).DIM(2).label);

    % also calculate the sampling rate
    samplingRate = 1/tmp.(variableNames{1}).DIM(1).interval;
    % and, based on this, the low-pass filter
    if samplingRate == 2000
        lowPassFilter = 600;
    elseif samplingRate == 1000
        lowPassFilter = 300;
    end

    % setup channels.tsv file. Fill in each field with the most typical
    % value
    tsvFile = table(name);
    tsvFile.type = repmat({'ECOG'},length(name),1);
    tsvFile.units = repmat({'mV'},length(name),1);
    tsvFile.low_cutoff = repmat({'n/a'},length(name),1);
    tsvFile.high_cutoff = repmat({samplingRate},length(name),1);
    tsvFile.status = repmat({'good'},length(name),1);
    tsvFile.status_description = repmat({'n/a'},length(name),1);

    % however, not all channels have the most typical value. So overwrite
    % the entries for those channels using the correct value using the
    % details file.
    % if the details file is missing, create it
    if ~exist('/group/mlr-lab/Saskia/ECoG_central/work/details_for_channels_tsv.mat')
        specify_channel_details;
    end
    load('/group/mlr-lab/Saskia/ECoG_central/work/details_for_channels_tsv.mat');

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

    % find the row of channelDetails that corresponds to this patient and
    % task
    tmp = arrayfun(@(x) strcmp(x.Subject, p) && strcmp(x.Task, task), channelDetails);
    patientDetails = channelDetails(tmp);

    % replace the channel type of channels with a different type
    tsvFile.type(ismember(tsvFile.name,patientDetails.NotECoG)) = patientDetails.NotECoGType;
    
    % replace the status and description of bad channels with an appropriate
    % status and description
    tsvFile.status(ismember(tsvFile.name,patientDetails.BadElectrode)) = {'bad'};
    tsvFile.status_description(ismember(tsvFile.name,patientDetails.BadElectrode)) = patientDetails.BadElectrodeStatusDescription;
    
    % save .tsv
    [filepath,name,~] = fileparts(path);
    writetable(tsvFile,[filepath,'/',erase(name,'ieeg'),'channels.tsv'],'filetype','text','delimiter','\t');


    %% TODO: throw error if it can't find one of the specific channels when editing
    %% TODO: BIDS validate
    
end