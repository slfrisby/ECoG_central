% visualise electrodes on the cortical surface. 

% setup
root = '/group/mlr-lab/Saskia/ECoG_central/';
addpath([root,'/dependencies/'])
addpath('/group/mlr-lab/AH/Projects/spm12/');

% configure output directory
if ~exist([root,'/derivatives/figures/'])
    mkdir([root,'/derivatives/figures/'])
end

% get information about atlas
header = spm_vol([root,'/doc/MMNI152_T1_2mm_brain_nocereb.nii.gz']);
% get transformation matrix
T = header.mat;
% make empty volumes the same size as the atlas
namingVolume = nan(header.dim);
semanticJudgementVolume = nan(header.dim);

% load electrode locations
namingCoords = readtable([root,'/doc/mni_coordinates.csv']);
% Patient 17 is excluded from analysis, so do not plot these coordinates.
namingCoords(namingCoords.Patient==17,:) = [];
% as a separate variable, get coordinates from just the patients for whom
% we have semantic judgement data
semanticJudgementCoords = namingCoords(ismember(namingCoords.Patient,[8,10,12,13,14,15,21]),:);
% keep only the coordinates
namingCoords = table2array(namingCoords(:,3:5));
semanticJudgementCoords = table2array(semanticJudgementCoords(:,3:5));
% get rid of electrodes for which we do not have coordinates
namingCoords = rmmissing(namingCoords);
semanticJudgementCoords = rmmissing(semanticJudgementCoords);
% convert electrode locations into matrix space
namingCoords = mni2cor(namingCoords,T);
semanticJudgementCoords = mni2cor(semanticJudgementCoords,T);

% for each electrode in the naming data
for i = 1:size(namingCoords,1)
    % set that value in the volume as 1
    namingVolume(namingCoords(i,1),namingCoords(i,2),namingCoords(i,3)) = 1;
end
% for each electrode in the semantic judgement data
for i = 1:size(semanticJudgementCoords,1)
    % set that value in the volume as 1
    semanticJudgementVolume(semanticJudgementCoords(i,1),semanticJudgementCoords(i,2),semanticJudgementCoords(i,3)) = 1;
end

% save image. Using niftiwrite preserves nans in the image,
% which is important - using zeros will mean that the sparse 1s used to
% indicate electrode location are destroyed during smoothing. The header
% information will no longer be correct - this will be fixed later
if ~exist([root,'/work'])
    mkdir([root,'/work'])
end
niftiwrite(namingVolume,[root,'/work/namingVolume.nii']);
niftiwrite(semanticJudgementVolume,[root,'/work/semanticJudgementVolume.nii']);

% smooth at 2mm FWHM. This makes it easy to visualise electrodes 

clear matlabbatch
matlabbatch{1}.spm.spatial.smooth.data = cellstr([root,'/work/namingVolume.nii']);
matlabbatch{1}.spm.spatial.smooth.fwhm = [2 2 2];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed_';
spm_jobman('run',matlabbatch);

clear matlabbatch
matlabbatch{1}.spm.spatial.smooth.data = cellstr([root,'/work/semanticJudgementVolume.nii']);
matlabbatch{1}.spm.spatial.smooth.fwhm = [2 2 2];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed_';
spm_jobman('run',matlabbatch);

% load image
tmp = spm_vol([root,'/work/smoothed_namingVolume.nii']);
namingVolume = spm_read_vols(tmp);
% binarise above threshold (for clarity of the resulting image) 
namingVolume(namingVolume > 0.001) = 1;
namingVolume(namingVolume < 1) = 0;
% fix header
tmp = header;
tmp.fname = [root,'/derivatives/figures/electrodes_naming.nii'];
% write
spm_write_vol(tmp,namingVolume);

% load image
tmp = spm_vol([root,'/work/smoothed_semanticJudgementVolume.nii']);
semanticJudgementVolume = spm_read_vols(tmp);
% binarise above threshold (for clarity of the resulting image) 
semanticJudgementVolume(semanticJudgementVolume > 0.001) = 1;
semanticJudgementVolume(semanticJudgementVolume < 1) = 0;
% fix header
tmp = header;
tmp.fname = [root,'/derivatives/figures/electrodes_semanticjudgement.nii'];
% write
spm_write_vol(tmp,semanticJudgementVolume);

