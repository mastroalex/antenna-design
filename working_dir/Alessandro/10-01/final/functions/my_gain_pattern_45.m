function my_gain_pattern_45(kfa_ster,w_ster,tcheB)


%PCBs
pcb_array_azimuth_steering_45 = pattern(kfa_ster,2.1e9,-180:180,0,'Type','directivity');
pcb_array_azimuth_steering_45 = pcb_array_azimuth_steering_45';
pcb_array_elevation_steering_45 = pattern(kfa_ster,2.1e9,0,-180:180,'Type','directivity');

assignin('base','pcb_array_azimuth_steering_45',pcb_array_azimuth_steering_45)
assignin('base','pcb_array_elevation_steering_45',pcb_array_elevation_steering_45)

% PIFAs
pifa_array_azimuth_steering_45 = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w_ster);
pifa_array_elevation_steering_45 = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w_ster); 

assignin('base','pifa_array_azimuth_steering_45',pifa_array_azimuth_steering_45)
assignin('base','pifa_array_elevation_steering_45',pifa_array_elevation_steering_45)


% SINGLE 2D PLOTS
figure;
pattern(kfa_ster,2.1e9,-180:180,0,'Type','directivity');
figure;
pattern(kfa_ster,2.1e9,0,-180:180,'Type','directivity');
figure;
patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w_ster);
figure;
patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w_ster); 

% COMPARED 2D PLOTS 
figure; 
polarpattern(pcb_array_azimuth_steering_45);
hold on
polarpattern(pifa_array_azimuth_steering_45); 

figure; 
polarpattern(pcb_array_elevation_steering_45);
hold on
polarpattern(pifa_array_elevation_steering_45);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% REAL/IDEAL GAIN PATTERNS %%%%%%%%%%%
%%%%% ACTUALLY ONLY DIRECTIVITY %%%%%%%%%%
%%%%% WITH patternMultiply %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pcb_array_real_gain_azimuth_steering_45 = pattern(kfa_ster,2.1e9,-180:180,0,'Type','gain');
pcb_array_ideal_gain_azimuth_steering_45 = patternMultiply(kfa_ster,2.1e9,-180:180,0,'Type','gain');

assignin('base','pcb_array_real_gain_azimuth_steering_45',pcb_array_real_gain_azimuth_steering_45)
assignin('base','pcb_array_ideal_gain_azimuth_steering_45',pcb_array_ideal_gain_azimuth_steering_45)


figure;
pattern(kfa_ster,2.1e9,-180:180,0,'Type','gain');
figure;
patternMultiply(kfa_ster,2.1e9,-180:180,0,'Type','gain');
figure;
polarpattern(pcb_array_real_gain_azimuth_steering_45);
hold on
polarpattern(pcb_array_ideal_gain_azimuth_steering_45);

% ELEVATION 
pcb_array_real_gain_elevation_steering_45 = pattern(kfa_ster,2.1e9,0,-180:180,'Type','gain');
pcb_array_ideal_gain_elevation_steering_45 = patternMultiply(kfa_ster,2.1e9,0,-180:180,'Type','gain');

assignin('base','pcb_array_real_gain_elevation_steering_45',pcb_array_real_gain_elevation_steering_45)
assignin('base','pcb_array_ideal_gain_elevation_steering_45',pcb_array_ideal_gain_elevation_steering_45)


figure;
pattern(kfa_ster,2.1e9,0,-180:180,'Type','gain');
figure;
patternMultiply(kfa_ster,2.1e9,0,-180:180,'Type','gain');
figure;
polarpattern(pcb_array_real_gain_elevation_steering_45);
hold on
polarpattern(pcb_array_ideal_gain_elevation_steering_45);


% gain_45 = phased.ArrayGain('SensorArray',tcheB,'WeightsInputPort',true);
% pifa_array_gain_azimuth_45 = gain_45(2.1e9,[-180:180 ; zeros(1,361)],w_ster);
% pifa_array_gain_elevation_45 = gain_45(2.1e9,[zeros(1,181);-90:90],w_ster);
% 
% pcb_array_gain_azimuth_45 = pattern(kfa_ster,2.1e9,-180:180,0,'Type','gain');
% pcb_array_gain_elevation_45 = pattern(kfa_ster,2.1e9,0,-180:180,'Type','gain');

end