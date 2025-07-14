% specify the Hemisphere in which electrodes were implanted. This is needed
% for creating electrodes.tsv .

electrodeDetails(1).Subject = '01';
electrodeDetails(1).Hemisphere = {};

electrodeDetails(2).Subject = '02';
electrodeDetails(2).Hemisphere = 'L';

electrodeDetails(3).Subject = '03';
electrodeDetails(3).Hemisphere = 'L';

electrodeDetails(4).Subject = '04';
electrodeDetails(4).Hemisphere = 'L';

electrodeDetails(5).Subject = '05';
electrodeDetails(5).Hemisphere = 'L';

electrodeDetails(6).Subject = '06';
electrodeDetails(6).Hemisphere = 'R';

electrodeDetails(7).Subject = '07';
electrodeDetails(7).Hemisphere = 'L';

electrodeDetails(8).Subject = '08';
electrodeDetails(8).Hemisphere = 'R';

electrodeDetails(9).Subject = '09';
electrodeDetails(9).Hemisphere = 'L';

electrodeDetails(10).Subject = '10';
electrodeDetails(10).Hemisphere = 'L';

electrodeDetails(11).Subject = '11';
electrodeDetails(11).Hemisphere = 'L';

electrodeDetails(12).Subject = '12';
electrodeDetails(12).Hemisphere = 'R';

electrodeDetails(13).Subject = '13';
electrodeDetails(13).Hemisphere = 'L';

electrodeDetails(14).Subject = '14';
electrodeDetails(14).Hemisphere = 'L';

electrodeDetails(15).Subject = '15';
electrodeDetails(15).Hemisphere = 'L';

electrodeDetails(16).Subject = '17';
electrodeDetails(16).Hemisphere = 'L';

electrodeDetails(17).Subject = '20';
electrodeDetails(17).Hemisphere = 'L';

electrodeDetails(18).Subject = '21';
electrodeDetails(18).Hemisphere = 'L';

electrodeDetails(19).Subject = '22';
electrodeDetails(19).Hemisphere = 'L';

if ~exist([root,'/work/'])
	mkdir([root,'/work/']);
end
save([root,'/work/details_for_electrodes_tsv.mat'],'electrodeDetails');

