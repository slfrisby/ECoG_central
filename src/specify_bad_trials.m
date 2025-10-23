
%% TODO: write script introduction

% the first 19 fields in the struct are naming data

badTrials(1).Subject = '01';
badTrials(1).Task = 'naming';
badTrials(1).BadTrials = [10;21;31;34;38;48;49;72;98;116;142;149;154;158;167;172;176;179;180;191;194;208;222;224;225;226;231;240;245;246;247;267;292;294;307;308;315;329;338;339;376;377;392;393];

badTrials(2).Subject = '02';
badTrials(2).Task ='naming';
badTrials(2).BadTrials = [6;11;12;16;17;19;20;24;28;30;38;39;48;49;51;52;56;57;63;64;70;71;75;76;79;80;82;83;88;93;96;97;104;107;111;113;117;122;123;126;127;128;132;145;146;147;152;156;164;175;186;187;189;199;201;208;216;223;224;225;228;235;233;238;239;245;246;247;248;250;260;261;262;266;268;269;270;275;279;286;288;289;292;296;305;307;308;312;313;320;322;323;325;329;332;336;339;340;341;344;345;347;348;349;350;354;355;359;364;366;369;371;372;373;374;375;376;377;379;380;387;388;390;391;395;398];

badTrials(3).Subject = '03';
badTrials(3).Task = 'naming';
badTrials(3).BadTrials = [30;38;47;54;57;73;81;103;117;120;121;127;130;147;152;165;166;202;227;234;255;261;266;269;285;290;313;330;342;345;346;347;358;365;366;379;400];

badTrials(4).Subject = '04';
badTrials(4).Task = 'naming';
badTrials(4).BadTrials = [6;8;14;18;22;23;37;39;48;51;54;55;58;65;74;75;80;81;93;96;101;109;113;117;141;143;148;149;160;167;177;179;184;186;205;207;209;217;228;236;238;241;245;251;257;259;268;273;281;282;285;296;299;302;305;318;324;337;341;345;347;350;354;364;378;388;391];

badTrials(5).Subject = '05';
badTrials(5).Task = 'naming';
badTrials(5).BadTrials = [6;7;8;9;12;13;14;22;26;29;30;31;32;34;37;43;45;51;64;65;68;70;77;78;79;82;91;92;95;102;108;114;116;117;122;130;137;139;160;162;168;178;182;183;187;189;192;199;209;213;215;222;231;233;236;245;248;266;278;281;286;287;288;291;297;307;320;321;329;332;338;341;345;352;356;357;358;365;366;371;372;377;380;381;383;384;389;391;395;396];

badTrials(6).Subject = '06';
badTrials(6).Task = 'naming';
badTrials(6).BadTrials = [13;28;41;45;52;58;65;69;83;91;94;99;101;108;118;119;125;127;128;129;130;132;133;134;136;138;139;140;143;150;152;155;156;157;159;163;164;166;167;168;173;176;178;179;181;182;183;185;187;191;192;194;195;197;200;201;202;203;205;207;208;211;216;220;221;222;223;228;229;236;237;239;240;244;245;248;251;252;253;258;261;262;263;264;266;269;274;278;279;280;282;284;285;288;289;291;298;299;300;304;305;306;307;309;310;313;315;317;318;319;321;322;323;324;325;327;329;330;332;334;335;336;337;338;339;343;344;347;350;351;356;358;360;361;365;367;369;370;371;377;378;379;380;383;385;386;390;391;392;394;396;398;399];

badTrials(7).Subject = '07';
badTrials(7).Task = 'naming';
badTrials(7).BadTrials = [19;22;35;38;39;45;55;64;65;67;72;75;76;77;78;80;90;94;103;105;110;112;113;117;118;127;131;138;158;159;161;168;170;171;176;179;180;181;182;184;187;188;189;195;196;201;202;203;204;205;207;210;211;220;221;228;229;232;233;234;235;237;239;240;247;249;253;257;258;259;260;269;270;272;273;274;275;277;279;282;283;284;286;288;299;302;305;307;309;311;312;313;314;315;317;318;319;321;323;325;327;328;329;330;333;334;335;336;337;338;339;340;342;344;345;346;347;349;350;351;353;354;355;356;358;359;360;363;364;369;372;373;374;375;377;378;379;381;384;385;390;392;395];

badTrials(8).Subject = '08';
badTrials(8).Task = 'naming';
badTrials(8).BadTrials = [1;8;10;12;13;14;16;18;19;20;21;22;25;26;27;29;30;34;35;36;37;39;41;43;44;48;51;54;57;58;62;64;65;66;68;70;71;73;74;75;77;80;81;82;83;84;87;89;91;93;94;95;97;98;104;105;107;108;109;112;114;115;116;117;118;119;120;127;128;129;130;131;132;133;134;135;136;139;141;145;146;147;148;152;153;156;157;158;159;160;161;162;164;166;167;169;170;171;172;173;174;175;177;181;182;184;186;187;188;189;190;191;192;193;194;196;197;198;200;201;203;205;207;208;209;210;211;214;216;218;220;221;222;224;227;230;231;232;233;234;236;238;239;240;242;244;245;246;247;248;249;250;251;253;254;255;257;258;260;261;263;265;267;268;273;274;276;278;279;280;281;282;283;284;285;288;289;291;292;293;294;296;297;299;301;302;303;304;305;306;307;309;310;312;315;316;318;319;320;321;323;326;327;328;329;330;331;332;333;334;336;337;338;339;341;342;343;344;346;347;347;349;350;352;353;354;355;356;357;358;359;361;362;363;364;365;366;367;368;369;370;371;373;375;379;381;382;383;384;385;386;388;389;390;393;395;396;397;398;399;400];

badTrials(9).Subject = '09';
badTrials(9).Task = 'naming';
badTrials(9).BadTrials = [1;20;26;40;46;50;55;60;62;73;74;81;82;87;104;106;108;114;120;124;135;144;145;151;155;154;165;166;174;184;185;199;204;205;208;212;218;247;267;307;311;331;337;343;353;354;356;357;378;382;396;399];


badTrials(10).Subject = '10';
badTrials(10).Task = 'naming';
badTrials(10).BadTrials = [];


badTrials(11).Subject = '11'; 
badTrials(11).Task = 'naming';
badTrials(11).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG';'DC01';'DC03';'DC04';'RDEL';'RQF'};
badTrials(11).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG';'MISC';'MISC'};
badTrials(11).BadElectrode = {'B01';'C01';'C02';'C03';'C06';'C07';'C11'};
badTrials(11).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'bad electrode'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(12).Subject = '12';
badTrials(12).Task = 'naming';
badTrials(12).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'DC01';'DC03';'DC04'};
badTrials(12).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
badTrials(12).BadElectrode = {'C06';'C11'};
badTrials(12).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'};

badTrials(13).Subject = '13';
badTrials(13).Task = 'naming';
badTrials(13).BadTrials = [2;4;11;12;19;26;28;29;32;36;42;45;54;56;63;64;65;66;70;77;82;86;87;88;92;93;99;102;105;106;116;122;133;138;141;149;150;153;154;156;165;167;168;172;174;177;182;187;191;192;195;197;200;201;202;203;205;207;209;217;218;219;224;227;238;239;243;250;252;253;259;266;273;276;280;282;289;290;303;304;306;307;308;309;313;314;325;326;329;332;333;335;339;351;352;356;359;361;367;372;373;376;378;379;386;389;400];

badTrials(14).Subject = '14';
badTrials(14).Task = 'naming';
badTrials(14).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG';'DC01';'DC02';'DC03';'DC04'};
badTrials(14).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG';'TRIG'};
badTrials(14).BadElectrode = {'A01';'A02';'A03';'B01';'B02'};
badTrials(14).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(15).Subject = '15';
badTrials(15).Task = 'naming';
badTrials(15).BadTrials = [6;7;9;11;18;21;22;25;28;36;38;49;54;61;63;81;86;88;97;109;118;121;122;128;133;135;136;137;138;139;142;159;162;169;170;182;192;194;197;198;202;208;213;214;228;229;230;231;233;239;241;247;250;255;261;273;274;275;276;280;287;288;298;305;307;308;309;312;320;324;325;326;328;347;359;373;375;378;386;391;394;397];

badTrials(16).Subject = '17';
badTrials(16).Task = 'naming';
badTrials(16).BadTrials = [2;3;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;23;26;27;28;29;30;31;32;33;34;36;37;38;41;42;45;46;47;48;49;50;51;53;55;57;58;59;60;61;63;64;65;67;68;69;70;71;72;73;74;79;80;81;82;83;84;85;90;91;92;93;95;96;97;98;99;100;101;102;103;104;105;106;107;108;109;110;113;114;115;116;117;118;119;121;122;123;124;125;127;128;129;130;132;135;136;137;138;140;141;142;143;144;150;151;152;153;154;157;158;160;161;162;164;165;166;167;169;170;171;172;174;176;177;179;181;182;184;186;189;190;191;192;193;194;197;198;199;200;201;202;203;204;205;206;207;209;211;213;215;216;217;218;219;220;221;222;223;224;225;226;227;229;231;232;233;234;235;236;237;238;240;241;242;243;246;247;248;249;250;251;252;253;254;255;256;257;258;261;262;263;264;265;266;267;269;270;271;272;273;274;275;276;278;279;280;281;282;283;286;287;289;293;294;295;296;297;299;300;301;302;303;304;305;306;307;308;309;310;311;312;313;315;316;317;318;319;320;321;322;323;324;326;327;329;330;331;332;333;334;335;336;337;339;340;341;342;343;344;345;347;348;349;351;352;354;355;356;359;360;364;365;366;367;368;369;370;371;372;374;376;378;379;380;381;384;387;388;389;390;391;392;393;394;395;397;398;399];


badTrials(17).Subject = '20';
badTrials(17).Task = 'naming';
badTrials(17).BadTrials = [1;3;4;5;6;7;11;12;13;14;15;16;17;22;23;27;28;29;30;35;36;37;40;43;51;52;54;57;58;61;62;66;67;71;72;77;79;81;82;88;89;92;94;97;102;103;105;106;107;108;112;114;115;116;117;122;123;126;128;129;130;131;132;133;137;138;141;142;143;145;147;150;151;152;153;154;157;159;164;166;167;168;169;170;173;174;175;177;180;182;183;185;191;192;197;200;201;202;203;204;205;206;207;208;209;210;211;212;213;214;215;216;218;219;220;221;222;223;224;225;226;227;228;229;230;231;232;233;234;235;236;237;238;239;240;241;242;243;244;245;246;247;248;249;250;251;252;253;254;255;257;258;259;260;261;262;263;264;265;266;267;268;269;270;271;272;273;274;275;276;277;278;279;280;281;282;283;284;285;286;287;288;289;290;292;293;294;296;297;298;299;300;301;302;303;304;305;306;307;308;309;311;312;313;314;315;316;317;318;319;320;321;322;323;324;325;326;327;328;329;330;331;332;333;334;335;336;337;339;340;341;342;343;344;345;346;347;348;349;350;351;352;353;355;356;357;358;359;360;361;362;363;364;365;366;367;368;369;370;371;373;374;375;376;377;378;379;380;381;382;383;384;385;386;387;388;389;390;391;392;393;394;395;396;397;398;399;400];

badTrials(18).Subject = '21';
badTrials(18).Task = 'naming';
badTrials(18).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04';'EKG'};
badTrials(18).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG';'ECG'};
badTrials(18).BadElectrode = {'C01';'C02';'C03';'C04';'C05';'C06';'D01';'D02';'D03';'D04';'D05';'D06';'E03';'E06';'E07';'E08';'E11';'E12';'E13';'E14';'E15';'E18';'E20';'F01';'F02';'F03';'F04';'F05';'F07';'F08';'F12';'F13';'G10'};
badTrials(18).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(19).Subject = '22';
badTrials(19).Task = 'naming';
badTrials(19).BadTrials = [3;4;5;6;8;9;10;13;14;15;16;21;23;25;26;27;29;30;31;34;36;41;44;45;46;47;48;52;55;56;62;64;65;66;67;68;69;72;73;74;75;76;78;79;81;82;83;84;85;90;98;99;100;104;105;108;109;110;115;116;119;122;125;126;127;130;131;132;136;137;138;140;141;145;149;155;162;165;166;167;170;173;175;176;178;182;183;185;187;188;189;190;191;193;194;195;199;200;202;203;204;205;207;211;212;214;215;218;219;225;227;228;229;231;233;235;236;241;242;244;246;248;251;252;253;254;255;257;258;259;261;265;271;272;274;277;279;282;283;284;285;289;290;291;293;294;297;298;300;304;306;314;316;317;318;320;322;323;325;326;328;330;331;332;333;335;336;337;338;341;346;347;348;349;351;354;355;356;360;363;365;372;373;375;376;378;379;380;381;383;384;385;387;388;389;392;393;394;395;397;399;400];

% the next 8 fields are semantic judgement

badTrials(20).Subject = '08';
badTrials(20).Task = 'semanticjudgement';
badTrials(20).NotECoG = {'A01';'A02';'A03';'A04';'A05';'A06';'B01';'B02';'B03';'B04';'B05';'B06';'C01';'C02';'C03';'C04';'C05';'C06';'REF01';'REF02';'REF03';'REF04';'DC08';'DC09';'DC10'};
badTrials(20).NotECoGType = {'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'SEEG';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
badTrials(20).BadElectrode = {'E01';'E02';'E03'};
badTrials(20).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(21).Subject = '10';
badTrials(21).Task = 'semanticjudgement';
badTrials(21).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'EKG';'DC01';'DC02';'DC03'};
badTrials(21).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
badTrials(21).BadElectrode = {'B05';'B06';'B07';'B13';'B14';'B15';'B16';'C01';'C05';'C06';'C11';'C12';'C16';'C17'};
badTrials(21).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'overlaps another grid - no contact with brain'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(22).Subject = '12';
badTrials(22).Task = 'semanticjudgement';
badTrials(22).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'DC01';'DC03';'DC04'};
badTrials(22).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG'};
badTrials(22).BadElectrode = {'C06';'C11'};
badTrials(22).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'};

badTrials(23).Subject = '13';
badTrials(23).Task = 'semanticjudgement';
badTrials(23).NotECoG = {'REFA01';'REFA02';'REFA03';'REFA04';'RDEL';'EKG';'DC04';'DC05';'DC06';'DC07';'DC08'};
badTrials(23).NotECoGType = {'REF';'REF';'REF';'REF';'MISC';'ECG';'TRIG';'TRIG';'TRIG';'TRIG';'TRIG'};
badTrials(23).BadElectrode = {'A01';'B01';'B02';'D01';'D02';'E01';'E02';};
badTrials(23).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(24).Subject = '14';
badTrials(24).Task = 'semanticjudgement';
badTrials(24).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04'};
badTrials(24).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG'};
badTrials(24).BadElectrode = {'A01';'A02';'A03';'B01';'B02'};
badTrials(24).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(25).Subject = '15';
badTrials(25).Task = 'semanticjudgement';
badTrials(25).NotECoG = {'REF01';'REF02';'REF03';'REF04';'EKG1';'DC01';'DC02';'DC03'};
badTrials(25).NotECoGType = {'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
badTrials(25).BadElectrode = {'D01'};
badTrials(25).BadElectrodeStatusDescription = {'seizure onset zone'};

badTrials(26).Subject = '17';
badTrials(26).Task = 'semanticjudgement';
badTrials(26).NotECoG = {'REF01';'REF02';'REF03';'REF04';'REF05';'REF06';'EKG';'DC01';'DC02';'DC03'};
badTrials(26).NotECoGType = {'REF';'REF';'REF';'REF';'REF';'REF';'ECG';'TRIG';'TRIG';'TRIG'};
badTrials(26).BadElectrode = {'A12';'B02';'B04';'C04';'C05';'C06';'C10';'C11';'C12';'C13';'C14';'C15';'D09';'D12';'D13';'D14';'E03';'E04';'E05';'E08';'E09';'E12';'E13';'E14';'E15';'E16';'E17';'E18';'E19';'F01';'F04';'F05';'F09';'G04';'G05';'G08';'G20'};
badTrials(26).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};

badTrials(27).Subject = '21';
badTrials(27).Task = 'semanticjudgement';
badTrials(27).NotECoG = {'REF01';'REF02';'REF03';'REF04';'DC01';'DC02';'DC03';'DC04';'EKG'};
badTrials(27).NotECoGType = {'REF';'REF';'REF';'REF';'TRIG';'TRIG';'TRIG';'TRIG';'ECG'};
badTrials(27).BadElectrode = {'C01';'C02';'C03';'C04';'C05';'C06';'D01';'D02';'D03';'D04';'D05';'D06';'E03';'E06';'E07';'E08';'E11';'E12';'E13';'E14';'E15';'E18';'E20';'F01';'F02';'F03';'F04';'F05';'F07';'F08';'F12';'F13';'G10'};
badTrials(27).BadElectrodeStatusDescription = {'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'; 'seizure onset zone'};












subs = {'01';'02','03','04','05','06','07','08','09','10','11','12','13','14','15','17','20','21','22'};
badtrials = struct;
badtrials(1).subject = 1;
badtrials(1).trials = [34,98,142,149,179,180,194,222,224,294,308,393];
badtrials(2).subject = 2;
badtrials(2).trials = [24,80,83,113,117,164,165,175,209,225,233,254,261,270,296,307,308,339,340,341,344,354,359,364,365,366,372,380,390,391];
badtrials(3).subject = 3;
badtrials(3).trials = [269,346];
badtrials(4).subject = 4;
badtrials(4).trials = [6,8,22,48,51,75,78,89,96,97,102,118,122,134,143,148,154,157,160,167,169,177,179,184,205,208,217,223,236,238,241,245,251,265,285,305,307,311,315,324,341,348,360,388,400];
badtrials(5).subject = 5;
badtrials(5).trials = [6,29,30,31,32,34,64,91,102,160,222,231,273,380,381,389];
badtrials(6).subject = 6;
badtrials(6).trials = [28,52,65,69,83,94,119,127,130,143,150,155,156,164,166,168,179,185,194,197,207,211,236,246,264,285,288,300,305,309,313,317,319,325,327,329,332,334,343,344,358,365,369,382,386,394,396,399];
badtrials(7).subject = 7;
badtrials(7).trials = [65,72,80,90,105,110,117,146,164,168,170,171,179,181,187,202,203,204,207,210,220,221,222,228,229,233,234,235,247,249,251,253,266,267,273,277,278,279,283,286,288,299,305,306,307,309,310,318,320,321,325,327,333,336,338,342,345,350,358,359,363,371,372,374,379,381,384,385,397,399];
badtrials(8).subject = 8;
badtrials(8).trials = [10,16,19,35,36,37,43,48,53,57,65,66,70,71,73,75,77,81,82,83,84,87,89,91,94,95,98,104,105,107,108,109,114,115,116,117,119,127,128,129,130,131,132,133,134,135,136,139,141,147,148,152,153,158,161,162,164,171,175,177,182,184,186,188,191,192,193,197,199,200,201,203,205,207,208,209,210,211,214,218,220,221,222,224,227,232,233,234,236,239,242,244,245,247,248,249,250,251,253,254,258,263,273,276,279,280,282,283,288,289,291,292,293,296,297,299,301,303,304,305,306,307,310,315,316,320,327,328,329,330,331,332,333,336,337,338,339,341,342,343,346,349,350,353,354,355,357,358,359,362,363,364,366,367,368,369,370,371,371,374,375,381,383,384,385,388,389,391,393,395,399,400];
badtrials(9).subject = 9;
badtrials(9).trials = [1,40,46,50,60,82,108,114,124,144,155,174,199,208,212,218,331,337,343,353,357,371,378,382,388,396,399];
badtrials(10).subject = 10;
badtrials(10).trials = [27,45,64,137,231,235,329,363,371];
badtrials(11).subject = 11;
badtrials(11).trials = [6,17,19,21,32,43,44,48,55,56,58,59,63,64,73,81,86,86,90,92,99,104,111,120,133,145,152,163,168,188,197,200,250,263,281,307,310,371,398];
badtrials(12).subject = 12;
badtrials(12).trials = [5,7,14,18,19,23,25,26,34,35,36,41,45,47,50,59,63,67,70,73,74,75,77,81,82,86,91,93,98,100,103,107,108,110,111,125,131,146,149,153,162,164,165,171,186,197,212,227,230,236,237,240,242,247,249,254,256,261,265,266,267,278,281,282,291,292,294,295,301,303,306,307,316,317,318,323,328,334,335,339,344,348,365,374,380,384,386,395,398,399];
badtrials(13).subject = 13;
badtrials(13).trials = [4,11,12,26,29,32,36,45,54,63,64,77,88,92,93,102,105,106,117,133,138,141,149,150,154,156,165,167,168,174,187,191,199,200,201,202,209,210,217,218,219,239,243,250,253,276,280,288,289,303,306,307,308,309,310,313,314,324,329,339,351,356,359,367,372,376,378];
badtrials(14).subject = 14;
badtrials(14).trials = [8,9,20,39,58,65,73,74,95,106,107,110,115,125,126,127,148,160,171,177,182,184,202,216,220,221,227,230,234,258,261,268,271,275,276,308,312,317,318,320,321,375,376,377,380,388];
badtrials(15).subject = 15;
badtrials(15).trials = [6,9,21,33,36,53,61,63,80,81,88,118,120,122,123,128,133,142,167,182,184,192,194,197,207,208,216,225,248,255,273,274,276,280,307,308,313,320,323,324,331,356,359,373,378,391,397,398];
badtrials(16).subject = 17;
badtrials(16).trials = [3,5,7,8,11,12,13,14,16,19,23,26,27,28,29,30,31,33,34,36,37,41,42,45,46,47,48,49,51,53,55,57,58,60,61,63,64,65,67,68,69,70,71,72,73,74,79,82,83,84,85,89,90,91,92,93,95,97,98,99,101,102,103,104,106,107,108,109,110,112,113,114,115,117,118,121,124,125,126,127,128,129,130,132,135,136,138,140,141,142,143,144,150,151,152,153,154,158,160,161,162,164,165,166,169,170,171,174,176,177,179,181,182,186,189,190,191,193,194,197,199,200,202,203,204,205,206,207,209,211,213,215,216,218,219,220,221,222,223,225,226,227,230,231,233,234,235,236,237,238,240,242,243,246,247,249,250,251,252,253,254,255,257,261,262,263,264,265,266,267,270,271,272,273,274,275,276,277,278,279,281,286,287,289,290,293,294,295,296,297,299,300,301,303,304,305,307,308,309,310,311,312,313,315,316,317,318,319,320,321,322,323,324,325,326,327,330,331,332,333,334,335,336,337,339,340,343,344,345,347,348,349,351,353,354,355,356,357,359,360,364,366,367,368,369,371,372,373,374,376,378,379,380,381,388,389,390,391,392,393,394,395,397,399];
badtrials(17).subject = 20;
badtrials(17).trials = [89,152,177,206,211,212,230,234,236,245,249,251,259,282,297,326,327,328,330,339,343,369,371,393,396,400];
badtrials(18).subject = 21;
badtrials(18).trials = [7,8,9,20,32,34,39,43,47,49,50,53,62,64,65,69,76,78,79,82,86,94,99,100,105,108,110,113,118,125,130,132,135,137,141,147,149,151,152,153,165,173,174,175,177,179,188,197,203,207,208,212,213,217,222,223,227,230,237,238,242,243,247,254,256,257,259,261,264,265,269,271,272,276,282,283,284,285,291,299,302,304,306,310,313,315,316,317,319,322,326,324,327,332,334,337,339,345,346,348,350,353,354,363,368,380,386,399];
badtrials(19).subject = 22;
badtrials(19).trials = [110,125,126,215,229,318,387];


% Participants 7 and 8 have obviously autocorrelated components, but these
% have been retained because the component clearly contains signal as well
% as noise. 
