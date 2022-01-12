function compare_arrays_plot(kfa,tcheB,w)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 2D PATTERNS %%%%%%%%%%%%%%%%%
%%%%%% AZIMUTH CUT %%%%%%%%%%%%%%%%%
%%%%%% ELEVATION CUT %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BROADSIDE %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PCBs
pcb_array_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
pcb_array_azimuth_broadside = pcb_array_azimuth_broadside';
pcb_array_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');

assignin('base','pcb_array_azimuth_broadside',pcb_array_azimuth_broadside)
assignin('base','pcb_array_elevation_broadside',pcb_array_elevation_broadside)

% PIFAs
pifa_array_azimuth_broadside = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
pifa_array_elevation_broadside = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

assignin('base','pifa_array_azimuth_broadside',pifa_array_azimuth_broadside)
assignin('base','pifa_array_elevation_broadside',pifa_array_elevation_broadside)

% SINGLE 2D PLOTS
figure;
pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
figure;
patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

% COMPARED 2D PLOTS 
figure; 
polarpattern(pcb_array_azimuth_broadside)
hold on
polarpattern(pifa_array_azimuth_broadside);

figure;
polarpattern(pcb_array_elevation_broadside)
hold on
polarpattern(pifa_array_elevation_broadside);
end

