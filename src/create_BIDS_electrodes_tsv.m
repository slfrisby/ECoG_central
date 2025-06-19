function create_BIDS_electrodes_tsv(path)

    % make electrodes.tsv file to accompany data files in BIDS format. 

    % Arguments:
    % - path: path to data file. The name of the data file should be in
    % BIDS format. Character vector

    % get root directory from path 
    root = eraseBetween(path,'/data','.mat','Boundaries','inclusive');

    % load coordinates file 
    opts = detectImportOptions([root,'/doc/mni_coordinates.csv']);  
    opts = setvartype(opts, [1:5], 'char'); 
    allCoords = readtable([root,'/doc/mni_coordinates.csv'],opts);

    % from the path, get the patient ID (electrodes.tsv files are the same
    % for all tasks)
    tmp = extractBetween(path,'sub-','/ieeg');
    p = tmp{1};

    % make .tsv file following this template: https://github.com/bids-standard/bids-starter-kit/blob/main/matlabCode/ieeg/createBIDS_electrodes_tsv.m
    % start by getting that patient's electrodes and their coordinates
    tsvFile = allCoords(ismember(allCoords.Patient,p),2:end);
    % label columns correctly
    tsvFile = renamevars(tsvFile,['Electrode'],['name']);

    % set other important variables
    
    % recording diameter is in mm^2. The recording diameter is 2.3 mm so
    tsvFile.size = repmat({4.1548},length(tsvFile.name),1);

    % details about how the electrodes are made and connected
    tsvFile.material = repmat({'platinum'},length(tsvFile.name),1);
    tsvFile.manufacturer = repmat({'Ad-Tech Medical'},length(tsvFile.name),1);
    tsvFile.group = regexprep(tsvFile.name, '\d+', '');
    
    % load variable containing the hemisphere of each participant
    if ~exist([root,'/work/details_for_electrodes_tsv.mat'])
        specify_electrode_details;
    end
    load([root,'/work/details_for_electrodes_tsv.mat']);

    % find the row of electrodeDetails that corresponds to this patient and
    % task
    tmp = arrayfun(@(x) strcmp(x.Subject, p), electrodeDetails);
    patientDetails = electrodeDetails(tmp);
    % use this to set the hemisphere in the .tsv file
    tsvFile.hemisphere = repmat({patientDetails.Hemisphere},length(tsvFile.name),1);

    % save .tsv
    [filepath,name,~] = fileparts(path);
    writetable(tsvFile,[filepath,'/',eraseBetween(name,'_task','_ieeg','Boundaries','inclusive'),'_electrodes.tsv'],'filetype','text','delimiter','\t');

    % Also make an essential .json file called coordsystem.json, following
    % this template: https://github.com/bids-standard/bids-starter-kit/blob/main/matlabCode/ieeg/createBIDS_coordsystem_json.m
    json.iEEGCoordinateSystem = 'MNI152NLin6ASym';
    json.iEEGCoordinateUnits = 'mm';

    % write .json
    fid = fopen([filepath,'/',eraseBetween(name,'task','_ieeg','Boundaries','inclusive'),'coordsystem.json'],'w');
    fwrite(fid,jsonencode(json,'PrettyPrint',true),'char');

end