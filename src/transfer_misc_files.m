% Our ECoG transfers from Japan were accompanied by various miscellaneous
% files. Many of these are useful to store alongside the data. This script
% transfers and BIDS-formats the miscellaneous files.

% documents
if ~exist('/group/mlr-lab/Saskia/ECoG_central/doc/')
    mkdir('/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/naming/')
    mkdir('/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/')
end
% add to the documents folder:
% - data sharing agreement
copyfile('/group/mlr-lab/Saskia/ECoG_central/src/RG97578 (#17838) FEA - University of Wisconsin-Madison (fbMRC).pdf','/group/mlr-lab/Saskia/ECoG_central/doc/RG97578 (#17838) FEA - University of Wisconsin-Madison (fbMRC).pdf');
% - seizure onset zone information 
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/seizure_onset_zone.pdf','/group/mlr-lab/Saskia/ECoG_central/doc/seizure_onset_zone.pdf');

% - stimuli folders and lists for naming
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/naming_stimuli','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/naming/naming/');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/picture_namingERP_list.xls','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/naming/stimuli.xls');

% - stimuli folders and lists for semantic judgement
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/semantic_judge_jpg','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/visual_semantic');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/judge_scrambled_img','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/visual_control');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/semantic_judge_wav','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/auditory_semantic');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/noise_wavs','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/auditory_control');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/semantic_judgment_items_Sheet_2022forCambridge.xls','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/stimuli.xls');
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/semantic_judgement_stimuli_and_presentation_order/SemanticJudgementERP_explanation_202211.pdf','/group/mlr-lab/Saskia/ECoG_central/doc/stimuli/semanticjudgement/information.pdf');

% - atlas
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/MMNI152_T1_2mm_brain_nocereb.nii.gz','/group/mlr-lab/Saskia/ECoG_central/doc/MMNI152_T1_2mm_brain_nocereb.nii.gz');

% add extra info to patients' data folders:
% - video of patient 13
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/Pt13_semjudgetaskvideo.mp4','/group/mlr-lab/Saskia/ECoG_central/data/sub-13/ieeg/sub-13_task-semanticjudgement_run-01_video.mp4');
% - photo of patient 22
copyfile('/group/mlr-lab/Saskia/ECoG_central/raw/notes/Pt22_EOG_location.png','/group/mlr-lab/Saskia/ECoG_central/data/sub-22/ieeg/sub-22_photo.png');


