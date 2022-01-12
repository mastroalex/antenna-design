function my_gain_pattern(kfa,dotchy,chebc)

etaT = (1/5)*(abs(chebc(3)+2*chebc(4)+2*chebc(5))^2/(chebc(3)^2+2*chebc(4)^2+2*chebc(5)^2));
pcb_gain_azimuth_broadside = pattern(dotchy,2.1e9,-180:180,0,'Type','gain');
pcb_array_real_gain_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
pcb_array_ideal_gain_azimuth_broadside = patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
pcb_arf_azimuth_broadside = 2*arrayFactor(kfa,2.1e9,-180:180,0);
pcb_arf_azimuth_broadside = (10.^((pcb_arf_azimuth_broadside)/20));
pcb_gain_azimuth_broadside = 10.^((pcb_gain_azimuth_broadside-2.13)/10);
Gt_azimuth_broadside = etaT*pcb_gain_azimuth_broadside.*(pcb_arf_azimuth_broadside.^2/dot(chebc,chebc)); 
Gt_azimuth_broadside = 10*log10(Gt_azimuth_broadside);

assignin('base','etaT',etaT)
assignin('base','pcb_gain_azimuth_broadside',pcb_gain_azimuth_broadside)
assignin('base','pcb_array_real_gain_azimuth_broadside',pcb_array_real_gain_azimuth_broadside)
assignin('base','pcb_array_ideal_gain_azimuth_broadside',pcb_array_ideal_gain_azimuth_broadside)
assignin('base','pcb_arf_azimuth_broadside',pcb_arf_azimuth_broadside)
assignin('base','Gt_azimuth_broadside',Gt_azimuth_broadside)


figure;
pattern(kfa,2.1e9,-180:180,0,'Type','gain');
figure;
patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
figure;
polarpattern(Gt_azimuth_broadside); 
figure;
polarpattern(pcb_array_real_gain_azimuth_broadside);
hold on
polarpattern(pcb_array_ideal_gain_azimuth_broadside);
figure; 
polarpattern(pcb_array_ideal_gain_azimuth_broadside);
hold on 
polarpattern(Gt_azimuth_broadside);

% ELEVATION 
pcb_gain_elevation_broadside = pattern(dotchy,2.1e9,0,-180:180,'Type','gain');
pcb_array_real_gain_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','gain');
pcb_array_ideal_gain_elevation_broadside = patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
pcb_arf_elevation_broadside = 2*arrayFactor(kfa,2.1e9,0,-180:180);
pcb_arf_elevation_broadside = (10.^((pcb_arf_elevation_broadside)/20));
pcb_gain_elevation_broadside = 10.^((pcb_gain_elevation_broadside-2.13)/10);
Gt_elevation_broadside = etaT*pcb_gain_elevation_broadside.*(pcb_arf_elevation_broadside.^2/dot(chebc,chebc)); 
Gt_elevation_broadside = 10*log10(Gt_elevation_broadside);

figure;
pattern(kfa,2.1e9,0,-180:180,'Type','gain');
figure;
patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
figure;
polarpattern(Gt_elevation_broadside); 
figure;
polarpattern(pcb_array_real_gain_elevation_broadside);
hold on
polarpattern(pcb_array_ideal_gain_elevation_broadside);
figure;
polarpattern(pcb_array_ideal_gain_elevation_broadside);
hold on
polarpattern(Gt_elevation_broadside);

assignin('base','Gt_elevation_broadside',Gt_elevation_broadside)
assignin('base','pcb_array_real_gain_elevation_broadside',pcb_array_real_gain_elevation_broadside)
assignin('base','pcb_array_ideal_gain_elevation_broadside',pcb_array_ideal_gain_elevation_broadside)

%  gain_broadside = phased.ArrayGain('SensorArray',tcheB);
%  pifa_array_gain_azimuth_broadside=gain_broadside(2.1e9,[-180:180;zeros(1,361)]);
%  pifa_array_gain_elevation_broadside=gain_broadside(2.1e9,[zeros(1,181);-90:90]);
%  pcb_array_gain_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
%  pcb_array_gain_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','gain');

end