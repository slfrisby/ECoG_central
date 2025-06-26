% setup metadata input folder, needed for functions based on setup_data
% from ECoG_Data_Prep.

% initialise directory
if ~exist([root,'/work/details_for_setup_data/'])
    mkdir([root,'/work/details_for_setup_data/']);
    mkdir([root,'/work/details_for_setup_data/stimuli/']);
    mkdir([root,'/work/details_for_setup_data/coords/']);
end

% copy stimulus presentation orders into directory
copyfile([root,'/doc/stimuli/naming/order.csv'],[root,'/work/details_for_setup_data/stimuli/naming_order.csv']);
copyfile([root,'/doc/stimuli/semanticjudgement/order.csv'],[root,'/work/details_for_setup_data/stimuli/semantic_judgement_order.csv']);

% make directory containing coordinates of only good electrodes (i.e. not
% those that were below the seizure onset zone or had bad contact). 

% get list of patients
patients = dir([root,'/data/*']);
patients = patients([patients.isdir]);
patients = patients(~ismember({patients.name},{'.','..'}));

% initialise files
namingCsv = {};
semanticJudgementCsv = {};
% initialise counters
namingCounter = 1;
semanticJudgementCounter = 1;

% for each patient
for q = 1:length(patients)
    
    % get that patient's ID number
    tmp = regexp(patients(q).name,'\d+','match');
    p = tmp{1};

    % load naming channels
    namingChannels = readtable([root,'/data/',patients(q).name,'/ieeg/',patients(q).name,'_task-naming_run-01_channels.tsv'],'FileType','text','Delimiter','\t');

    % get only the good ECoG channels (exclude electrodes below the seizure
    % onset zone, electrodes with bad contact, sEEG, trigger channels,
    % etc.)
    tmp = namingChannels(strcmp(namingChannels.type,'ECOG') & strcmp(namingChannels.status,'good'),1);
    
    % fill in file
    namingCsv(namingCounter:namingCounter+size(tmp,1)-1,1) = repmat({str2num(p)},size(tmp,1),1);
    namingCsv(namingCounter:namingCounter+size(tmp,1)-1,2) = table2cell(tmp);

    % update counter
    namingCounter = namingCounter + size(tmp,1);
    
    % if there are semantic judgement data for that patient
    if exist([root,'/data/',patients(q).name,'/ieeg/',patients(q).name,'_task-semanticjudgement_run-01_channels.tsv'])
        
        % do the same with the semantic judgement data
        semanticJudgementChannels = readtable([root,'/data/',patients(q).name,'/ieeg/',patients(q).name,'_task-semanticjudgement_run-01_channels.tsv'],'FileType','text','Delimiter','\t');
        tmp = semanticJudgementChannels(strcmp(semanticJudgementChannels.type,'ECOG') & strcmp(semanticJudgementChannels.status,'good'),1);
        semanticJudgementCsv(semanticJudgementCounter:semanticJudgementCounter+size(tmp,1)-1,1) = repmat({str2num(p)},size(tmp,1),1);
        semanticJudgementCsv(semanticJudgementCounter:semanticJudgementCounter+size(tmp,1)-1,2) = table2cell(tmp);
        semanticJudgementCounter = semanticJudgementCounter + size(tmp,1);
    end
end

% convert files to table
namingCsv = table(namingCsv(:,1),namingCsv(:,2));
semanticJudgementCsv = table(semanticJudgementCsv(:,1),semanticJudgementCsv(:,2));
% rename columns
namingCsv.Properties.VariableNames = {'Patient','Electrode'};
semanticJudgementCsv.Properties.VariableNames = {'Patient','Electrode'};
% write
writetable(namingCsv,[root,'/work/details_for_setup_data/coords/naming_electrodes.csv']);
writetable(semanticJudgementCsv,[root,'/work/details_for_setup_data/coords/semantic_judgement_electrodes.csv']);
