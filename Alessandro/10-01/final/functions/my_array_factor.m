function my_array_factor(kfa,dotchy,chebc,chebn)
% Azimuth array factor plot

af_azimuth_polar = 2*arrayFactor(kfa,2.1e9,-180:180,0);
subfigure(3,4,1);polarpattern(af_azimuth_polar,'TitleTop','pcb array factor with arrayFactor()');
subfigure(3,4,2);plot(-180:180,af_azimuth_polar);title('pcb array factor with arrayFactor()');
assignin('base','af_azimuth_polar',af_azimuth_polar)

pat_dotchy_az = pattern(dotchy,2.1e9,-180:180,0,'Type','directivity');
pat_kfa_az = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
Df_az = 10.^((pat_kfa_az-pat_dotchy_az)/10);
F = sqrt(Df_az*(dot(chebc,chebc)/0.79));
Fn = sqrt(Df_az*(dot(chebn,chebn)/0.79));
FdB = 20*log10(Fn);
subfigure(3,4,3); 
polarpattern(FdB,'TitleTop','pcb array factor with mathematics'); 
subfigure(3,4,4);plot(-180:180,FdB);title('pcb array factor with mathematics');
assignin('base','pat_dotchy_az',pat_dotchy_az)
assignin('base','pat_kfa_az',pat_kfa_az)

subfigure(3,4,5);polarpattern(af_azimuth_polar);
hold on
polarpattern(FdB,'TitleTop','pcb array factor Toolbox vs mathematics','LineStyle',{'-','--'},'LegendLabels',{'ToolBox', 'Calculated'}); 
hold off

subfigure(3,4,6);plot(-180:180,af_azimuth_polar);
hold on
plot(-180:180,FdB,'LineStyle','--');
title('pcb array factor Toolbox vs mathematics');
legend('ToolBox', 'Calculated');
hold off

% Elevation array factor plot


af_elevation_polar = 2*arrayFactor(kfa,2.1e9,-180:180,0);
subfigure(3,4,7);polarpattern(af_elevation_polar,'TitleTop','pcb array factor with arrayFactor()');
subfigure(3,4,8);plot(-180:180,af_elevation_polar);title('pcb array factor with arrayFactor()');
assignin('base','af_elevation_polar',af_elevation_polar)

pat_dotchy_el = pattern(dotchy,2.1e9,-180:180,0,'Type','directivity');
pat_kfa_el = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
Df_az = 10.^((pat_kfa_el-pat_dotchy_el)/10);
F = sqrt(Df_az*(dot(chebc,chebc)/0.79));
Fn = sqrt(Df_az*(dot(chebn,chebn)/0.79));
FdB = 20*log10(Fn);
subfigure(3,4,9); 
polarpattern(FdB,'TitleTop','pcb array factor with mathematics'); 
subfigure(3,4,10);plot(-180:180,FdB);title('pcb array factor with mathematics');
assignin('base','pat_dotchy_el',pat_dotchy_el)
assignin('base','pat_kfa_el',pat_kfa_el)

subfigure(3,4,11);polarpattern(af_elevation_polar);
hold on
polarpattern(FdB,'TitleTop','pcb array factor Toolbox vs mathematics','LineStyle',{'-','--'},'LegendLabels',{'ToolBox', 'Calculated'}); 
hold off

subfigure(3,4,12);plot(-180:180,af_elevation_polar);
hold on
plot(-180:180,FdB,'LineStyle','--');
title('pcb array factor Toolbox vs mathematics');
legend('ToolBox', 'Calculated');
hold off
end