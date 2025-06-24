% plot density of electrode coverage. 

% setup
root = '/group/mlr-lab/Saskia/ECoG_central/';
addpath([root,'/dependencies/']);
addpath('/group/mlr-lab/AH/Projects/spm12/');

% configure output directory
if ~exist([root,'/derivatives/figures/'])
    mkdir([root,'/derivatives/figures/'])
end

% set which patients did which tasks (excluding exclusions)
namingPatients = {'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','20','21','22'};
semanticJudgementPatients = {'08','10','12','13','14','15','21'};

% recycle files created while checking electrode labelling
if ~exist([root,'/work/sub-01/coordsBinary.nii'])
    check_electrode_labelling;
end

% for each patient
for i = 1:length(namingPatients)

    % smooth binary electrode image (this was done before at 1 mm FWHM,
    % but 2 mm FWHM is better here, to enable comparison with the electrode plots)
    clear matlabbatch
    matlabbatch{1}.spm.spatial.smooth.data = cellstr([root,'/work/sub-',namingPatients{i},'/coordsBinary.nii']);
    matlabbatch{1}.spm.spatial.smooth.fwhm = [2 2 2];
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed2mm_';
    spm_jobman('run',matlabbatch);

    % load smoothed image
    tmp = spm_vol([root,'/work/sub-',namingPatients{i},'/smoothed2mm_coordsBinary.nii']);
    volume = spm_read_vols(tmp);
    % binarise above threshold
    volume(volume > 0.001) = 1;
    volume(volume < 1) = 0;

    % if this is the first patient, initialise output
    if i == 1
        namingDensity = zeros(size(volume));
        semanticJudgementDensity = zeros(size(volume));
    end

    % add electrodes to density map
    namingDensity = namingDensity + volume;
    if ismember(namingPatients{i},semanticJudgementPatients)
        semanticJudgementDensity = semanticJudgementDensity + volume;
    end

end

% write
tmp = spm_vol([root,'/doc/MMNI152_T1_2mm_brain_nocereb.nii.gz']);
tmp.fname = [root,'derivatives/figures/density_naming.nii'];
spm_write_vol(tmp,namingDensity);
tmp.fname = [root,'derivatives/figures/density_semanticjudgement.nii'];
spm_write_vol(tmp,semanticJudgementDensity);
