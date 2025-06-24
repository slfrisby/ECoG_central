% visualise each participant's grids individually. The electrodes are
% labelled with different colours. Visualise the grids using MRIcroGL - set
% the range to [1,20] and the colour to actc. This will show electrodes in
% a colour range with electrode 1 in blue and electrode 20 as red. A sharp
% colour discontinuity indicates a mislabelled electrode. (Note:
% occasionally electrodes overlap and this means that they are plotted as
% the same colour.)

% N.B. this tool does NOT work perfectly and should be used ONLY to get a
% general gist of the grid labelling!

% setup
root = '/group/mlr-lab/Saskia/ECoG_central/';
addpath([root,'/dependencies/']);
addpath('/group/mlr-lab/AH/Projects/spm12/');

% get information about atlas
header = spm_vol([root,'/doc/MMNI152_T1_2mm_brain_nocereb.nii.gz']);
% get transformation matrix
T = header.mat;

% load electrode locations
allDetails = readtable([root,'/doc/mni_coordinates.csv']);

% find number of patients
patients = dir([root,'/data/*']);
patients = patients([patients.isdir]);
patients = patients(~ismember({patients.name},{'.','..'}));

% for each patient
for q = 1:length(patients)

    % get that patient's ID number
    tmp = regexp(patients(q).name,'\d+','match');
    p = tmp{1};

    % get that patient's details
    patientDetails = allDetails(allDetails.Patient==str2num(p),:);

    % get a variable showing which electrodes belong to which grid
    gridIndex = regexprep(patientDetails.Electrode, '\d+', '');

    % get the patient's coordinates
    coords = table2array(patientDetails(:,3:5));
    % remove any missing values
    missingIndex = ismissing(coords);
    coords = rmmissing(coords);
    % (and remove the corresponding values in the grid index)
    gridIndex = gridIndex(~missingIndex(:,1));
    % convert coordinates into matrix space
    coords = mni2cor(coords,T);

    % make an empty volume the same size as the atlas
    volume = nan(header.dim);

    % % for each electrode
    for i = 1:size(coords,1)
        % set that value in the volume as 1
        volume(coords(i,1),coords(i,2),coords(i,3)) = 1;
    end
    
    % save image. Using niftiwrite preserves nans in the image,
    % which is important - using zeros will mean that the sparse 1s used to
    % indicate electrode location are destroyed during smoothing. The header
    % information will no longer be correct - this will be fixed later
    if ~exist([root,'/work/',patients(q).name])
        mkdir([root,'/work/',patients(q).name])
    end
    niftiwrite(volume,[root,'/work/',patients(q).name,'/coordsBinary.nii']);

    % smooth at 2mm FWHM. This makes it easy to visualise electrodes 

    clear matlabbatch
    matlabbatch{1}.spm.spatial.smooth.data = cellstr([root,'/work/',patients(q).name,'/coordsBinary.nii']);
    matlabbatch{1}.spm.spatial.smooth.fwhm = [1 1 1];
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed_';
    spm_jobman('run',matlabbatch);

    % load image
    tmp = spm_vol([root,'/work/',patients(q).name,'/smoothed_coordsBinary.nii']);
    volume = spm_read_vols(tmp);
    % binarise above threshold (for clarity of the resulting image) 
    volume(volume > 0.001) = 1;
    volume(volume < 1) = 0;

    % within each grid, assign a 1 to electrode 01, a 2 to electrode 02,
    % etc. 

    % get the alphabetical names of the patient's grids
    grids = unique(regexprep(patientDetails.Electrode, '\d+', ''));

    % for each grid
    for g = 1:length(grids)
        
        % get the coordinates in that grid
        gridCoords = coords(strcmp(gridIndex,grids(g)),:);

        % initialise counter
        counter = 1;

        % for each electrode
        for i = 1:size(gridCoords,1)
            % set that value in the volume to the value of the counter.
            % N.B. At this stage, this only affects the single voxel to
            % which the electrode is attributed - not the smoothed sphere
            % around the electrode.
            volume(gridCoords(i,1),gridCoords(i,2),gridCoords(i,3)) = counter;
            counter = counter + 1;
        end
    end

    % get a binary mask of nonzero elements
    mask = volume ~= 0;
    % find connected components
    connectedComps = bwconncomp(mask,26); % '26' means 'treat diagonally-connected elements as connected, not just face=connected elements'
    % replace values in each cluster
    for i = 1:connectedComps.NumObjects
        idx = connectedComps.PixelIdxList{i};
        maxValue = max(volume(idx));
        volume(idx) = maxValue;
    end

    % fix header
    tmp = header;
    tmp.fname = [root,'/work/',patients(q).name,'/coordsForChecking.nii'];
    % write
    spm_write_vol(tmp,volume);

end   



    
