% specify details about each dataset that should be included in the
% channels.tsv file:
% - which channels are not ECoG (sEEG, stimulus triggers, microphone, ECG,
% EOG etc.)
% - which channels lie below the seizure onset zone, or need excluding for
% other reasons (e.g. bad electrode contact)

% this page gives the permitted "channel types" in BIDS format: https://bids-specification.readthedocs.io/en/stable/glossary.html#objects.columns.type__channels

% the first 19 fields in the struct are naming data

channelDetails(1).Subject = '01';
channelDetails(1).Task = 'naming';
channelDetails(1).NotECoG = {'DC09';'DC10';'DC11';'EOG'};
channelDetails(1).NotECoGType = {'TRIG';'TRIG';'TRIG';'EOG'};
channelDetails(1).BadElectrode = {'A06';'A11';'B04';'B13';'B14';'C03';'C04';'D01'};
channelDetails(1).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone';'seizure onset zone'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(2).Subject = '02';
channelDetails(2).Task ='naming';
channelDetails(2).NotECoG = {'EOG';'DC01';'DC02';'DC03'};
channelDetails(2).NotECoGType = {'EOG';'TRIG';'TRIG';'TRIG'};
channelDetails(2).BadElectrode = {'A06';'A11'};
channelDetails(2).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'};

channelDetails(3).Subject = '03';
channelDetails(3).Task = 'naming';
channelDetails(3).NotECoG = {'EOG';'DC01';'DC02';'DC03'};
channelDetails(3).NotECoGType = {'EOG';'TRIG';'TRIG';'TRIG'};
channelDetails(3).BadElectrode = {'B01';'B05';'B10';'B15';'B20';'C03';'C04';'C05';'D03';'D04';'D07';'D11';'D12';'D17';'D19'};
channelDetails(3).BadElectrodeStatusDescription = {'seizure onset zone'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'};

channelDetails(4).Subject = '04';
channelDetails(4).Task = 'naming';
channelDetails(4).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'DC01';'DC02';'DC03'};
channelDetails(4).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
channelDetails(4).BadElectrode = {'B01';'B06';'B11'; 'C06'};
channelDetails(4).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'overlaps another grid - no contact with brain'};

channelDetails(5).Subject = '05';
channelDetails(5).Task = 'naming';
channelDetails(5).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'MIC'};
channelDetails(5).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'MISC'};
channelDetails(5).BadElectrode = {'A01';'A02';'A06';'A07';'C01'};
channelDetails(5).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'};

channelDetails(6).Subject = '06';
channelDetails(6).Task = 'naming';
channelDetails(6).NotECoG = {'EOG';'DC01';'DC02';'MIC'};
channelDetails(6).NotECoGType = {'EOG';'TRIG';'TRIG';'MISC'};
channelDetails(6).BadElectrode = {'B20'};
channelDetails(6).BadElectrodeStatusDescription = {'seizure onset zone'};

channelDetails(7).Subject = '07';
channelDetails(7).Task = 'naming';
channelDetails(7).NotECoG = {'A01';'A02';'A03';'A04';'B01';'B02';'B03';'B04';'C01';'C02';'C03';'C04';'D01';'D02';'D03';'D04';'MIC';'DC01';'DC02';'REF01';'REF02';'REF03';'REF04'};
channelDetails(7).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'MISC';'TRIG';'TRIG';'REF';'REF';'REF';'REF'};
channelDetails(7).BadElectrode = {'I01';'I06';'I11'};
channelDetails(7).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(8).Subject = '08';
channelDetails(8).Task = 'naming';
channelDetails(8).NotECoG = {'A01';'A02';'A03';'A04';'A05';'A06';'B01';'B02';'B03';'B04';'B05';'B06';'C01';'C02';'C03';'C04';'C05';'C06';'REF01';'REF02';'REF03';'REF04';'DC08';'DC09';'DC10'};
channelDetails(8).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
channelDetails(8).BadElectrode = {'E01';'E02';'E03'};
channelDetails(8).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(9).Subject = '09';
channelDetails(9).Task = 'naming';
channelDetails(9).NotECoG = {'A01';'A02';'A03';'A04';'A05';'B01';'B02';'B03';'B04';'B05';'C01';'C02';'C03';'C04';'C05';'DC01';'DC03';'DC04';'REF01';'REF02';'REF03';'REF04';'REF05';'REF06'};
channelDetails(9).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'TRIG';'TRIG';'TRIG';'REF';'REF';'REF';'REF';'REF';'REF'};
channelDetails(9).BadElectrode = {'D19';'J05'};
channelDetails(9).BadElectrodeStatusDescription = {'seizure onset zone'; 'overlaps another grid - no contact with brain'};

channelDetails(10).Subject = '10';
channelDetails(10).Task = 'naming';
channelDetails(10).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'RDEL';'RQF';'EKG';'DC01';'DC02';'DC03'};
channelDetails(10).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'MISC';'MISC';'ECG';'TRIG';'TRIG';'TRIG'};
channelDetails(10).BadElectrode = {'B05';'B06';'B07';'B13';'B14';'B15';'B16';'C01';'C05';'C06';'C07';'C09';'C11';'C12';'C16';'C17';'D04';'D06'};
channelDetails(10).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'bad electrode'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'bad electrode'};

channelDetails(11).Subject = '11'; 
channelDetails(11).Task = 'naming';
channelDetails(11).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG';'DC01';'DC03';'DC04';'RDEL';'RQF'};
channelDetails(11).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG';'MISC';'MISC'};
channelDetails(11).BadElectrode = {'B01';'C01';'C02';'C03';'C06';'C07';'C11'};
channelDetails(11).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(12).Subject = '12';
channelDetails(12).Task = 'naming';
channelDetails(12).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'DC01';'DC03';'DC04'};
channelDetails(12).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
channelDetails(12).BadElectrode = {'C06';'C11';'F01';'G17'};
channelDetails(12).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'bad electrode'};

channelDetails(13).Subject = '13';
channelDetails(13).Task = 'naming';
channelDetails(13).NotECoG = {'REFA01';'REFA02';'REFA03';'REFA04';'RDEL';'EKG';'DC04';'DC05';'DC06';'DC07';'DC08'};
channelDetails(13).NotECoGType = {'REF';'REF';'REF';'REF';'MISC';'ECG';'TRIG';'TRIG';'TRIG';'TRIG';'TRIG'};
channelDetails(13).BadElectrode = {'A01';'B01';'B02';'D01';'D02';'E01';'E02';};
channelDetails(13).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(14).Subject = '14';
channelDetails(14).Task = 'naming';
channelDetails(14).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG';'DC01';'DC02';'DC03';'DC04'};
channelDetails(14).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG';'TRIG'};
channelDetails(14).BadElectrode = {'A01';'A02';'A03';'B01';'B02'};
channelDetails(14).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(15).Subject = '15';
channelDetails(15).Task = 'naming';
channelDetails(15).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG1';'DC01';'DC02';'DC03'};
channelDetails(15).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
channelDetails(15).BadElectrode = {'D01'};
channelDetails(15).BadElectrodeStatusDescription = {'seizure onset zone'};

channelDetails(16).Subject = '17';
channelDetails(16).Task = 'naming';
channelDetails(16).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'EKG';'DC01';'DC02';'DC03'};
channelDetails(16).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
channelDetails(16).BadElectrode = {'A12';'B02';'B04';'C04';'C05';'C06';'C10';'C11';'C12';'C13';'C14';'C15';'D09';'D12';'D13';'D14';'E03';'E04';'E05';'E08';'E09';'E12';'E13';'E14';'E15';'E16';'E17';'E18';'E19';'F01';'F04';'F05';'F09';'G04';'G05';'G08';'G20'};
channelDetails(16).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(17).Subject = '20';
channelDetails(17).Task = 'naming';
channelDetails(17).NotECoG = {'DC01';'DC02';'DC03';'DC04';'EKG'};
channelDetails(17).NotECoGType = {'TRIG';'TRIG';'TRIG';'TRIG';'ECG'};
channelDetails(17).BadElectrode = {'E09';'E13';'E14';'E18';'F03';'F04'};
channelDetails(17).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(18).Subject = '21';
channelDetails(18).Task = 'naming';
channelDetails(18).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04';'EKG'};
channelDetails(18).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG';'ECG'};
channelDetails(18).BadElectrode = {'C01';'C02';'C03';'C04';'C05';'C06';'D01';'D02';'D03';'D04';'D05';'D06';'E03';'E06';'E07';'E08';'E11';'E12';'E13';'E14';'E15';'E18';'E20';'F01';'F02';'F03';'F04';'F05';'F07';'F08';'F11';'F12';'F13';'G10'};
channelDetails(18).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(19).Subject = '22';
channelDetails(19).Task = 'naming';
channelDetails(19).NotECoG = {'A01';'A02';'A03';'A04';'A05';'A06';'A07';'A08';'A09';'A10';'A11';'A12';'B01';'B02';'B03';'B04';'B05';'B06';'B07';'B08';'B09';'B10';'B11';'B12';'C01';'C02';'C03';'C04';'C05';'C06';'C07';'C08';'C09';'C10';'C11';'C12';'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04';'EKG';'VEOG';'HEOG';'VEOG1';'VEOG2';'HEOG1';'HEOG2'};
channelDetails(19).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG';'ECG';'EOG';'EOG';'EOG';'EOG';'EOG';'EOG'};
channelDetails(19).BadElectrode = {'A02';'A03';'A04';'D01';'E01';'E11';'E12';'H18';'I01';'I02';'I03';'I04';'I05';'I09';'I10';'I11';'I12';'I13'};
channelDetails(19).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'; 'bad electrode'};

% the next 8 fields are semantic judgement

channelDetails(20).Subject = '08';
channelDetails(20).Task = 'semanticjudgement';
channelDetails(20).NotECoG = {'A01';'A02';'A03';'A04';'A05';'A06';'B01';'B02';'B03';'B04';'B05';'B06';'C01';'C02';'C03';'C04';'C05';'C06';'REF01';'REF02';'REF03';'REF04';'DC08';'DC09';'DC10'};
channelDetails(20).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
channelDetails(20).BadElectrode = {'E01';'E02';'E03'};
channelDetails(20).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(21).Subject = '10';
channelDetails(21).Task = 'semanticjudgement';
channelDetails(21).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'EKG';'DC01';'DC02';'DC03';'DC04'};
channelDetails(21).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG';'TRIG'};
channelDetails(21).BadElectrode = {'B05';'B06';'B07';'B13';'B14';'B15';'B16';'C01';'C05';'C06';'C11';'C12';'C16';'C17'};
channelDetails(21).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(22).Subject = '12';
channelDetails(22).Task = 'semanticjudgement';
channelDetails(22).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'DC01';'DC03';'DC04'};
channelDetails(22).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
channelDetails(22).BadElectrode = {'C06';'C11'};
channelDetails(22).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'};

channelDetails(23).Subject = '13';
channelDetails(23).Task = 'semanticjudgement';
channelDetails(23).NotECoG = {'REFA01';'REFA02';'REFA03';'REFA04';'RDEL';'EKG';'DC04';'DC05';'DC06';'DC07';'DC08'};
channelDetails(23).NotECoGType = {'REF';'REF';'REF';'REF';'MISC';'ECG';'TRIG';'TRIG';'TRIG';'TRIG';'TRIG'};
channelDetails(23).BadElectrode = {'A01';'B01';'B02';'D01';'D02';'E01';'E02';};
channelDetails(23).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(24).Subject = '14';
channelDetails(24).Task = 'semanticjudgement';
channelDetails(24).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04'};
channelDetails(24).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG'};
channelDetails(24).BadElectrode = {'A01';'A02';'A03';'B01';'B02'};
channelDetails(24).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(25).Subject = '15';
channelDetails(25).Task = 'semanticjudgement';
channelDetails(25).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG1';'DC01';'DC02';'DC03'};
channelDetails(25).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
channelDetails(25).BadElectrode = {'D01'};
channelDetails(25).BadElectrodeStatusDescription = {'seizure onset zone'};

channelDetails(26).Subject = '17';
channelDetails(26).Task = 'semanticjudgement';
channelDetails(26).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'EKG';'DC01';'DC02';'DC03'};
channelDetails(26).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
channelDetails(26).BadElectrode = {'A12';'B02';'B04';'C04';'C05';'C06';'C10';'C11';'C12';'C13';'C14';'C15';'D09';'D12';'D13';'D14';'E03';'E04';'E05';'E08';'E09';'E12';'E13';'E14';'E15';'E16';'E17';'E18';'E19';'F01';'F04';'F05';'F09';'G04';'G05';'G06';'G08';'G20'};
channelDetails(26).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'};

channelDetails(27).Subject = '21';
channelDetails(27).Task = 'semanticjudgement';
channelDetails(27).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04';'EKG'};
channelDetails(27).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG';'ECG'};
channelDetails(27).BadElectrode = {'C01';'C02';'C03';'C04';'C05';'C06';'D01';'D02';'D03';'D04';'D05';'D06';'E03';'E06';'E07';'E08';'E11';'E12';'E13';'E14';'E15';'E18';'E20';'F01';'F02';'F03';'F04';'F05';'F07';'F08';'F12';'F13';'G10'};
channelDetails(27).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

% save
if ~exist([root,'/work/'])
	mkdir([root,'/work/']);
end
save([root,'/work/details_for_channels_tsv.mat'],'channelDetails');
