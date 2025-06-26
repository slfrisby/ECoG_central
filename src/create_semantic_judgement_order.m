% make a .csv file containing the stimulus presentation orders for semantic
% judgement. 

% load the key file, containing stimulus identities
key = readtable('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_key.csv');

% initialise the order file
order = table;

% there are ten sessions, each containing 96 trials
order.Session = repelem((1:10)',96);
order.Trial = repmat((1:96)',10,1);

% IMPORTANT: the final file will contain:
% rows 1:96 - visual semantic block 1
% rows 97:192 - visual semantic block 2
% rows 193:288 - visual semantic block 3
% rows 289:384 - auditory semantic block 1
% rows 385:480 - auditory semantic block 2
% rows 481:576 - auditory semantic block 3
% rows 577:672 - visual control block 1
% rows 673:786 - visual control block 2
% rows 787:864 - auditory control block 1
% rows 865:960 - auditory control block 3

% load stimulus presentation orders
session1 = readtable('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/Judge_SS01.xlsx');
session2 = readtable('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/Judge_SS02.xlsx');
session3 = readtable('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/Judge_SS03.xlsx');

% fill in order file
order.ItemIndex = [session1.JPG_WAVNumber; session2.JPG_WAVNumber; session3.JPG_WAVNumber; session1.JPG_WAVNumber; session2.JPG_WAVNumber; session3.JPG_WAVNumber; session1.JPG_WAVNumber; session2.JPG_WAVNumber; session1.JPG_WAVNumber; session2.JPG_WAVNumber];

% write .csv
writetable(order,'/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/order.csv');

