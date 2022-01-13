function calc_and_plot_array_factor_pifa(p,chebc,chebn,tcheB,w)

pat_p_az = pattern(p,2.1e9,-180:180,0,'Type','directivity');
pat_ar_az = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
pat_af_az = pat_ar_az-pat_p_az'; 
Df_az = 10.^((pat_ar_az-pat_p_az')/10);
F = sqrt(Df_az*(dot(chebc,chebc)/0.79));
Fn = sqrt(Df_az*(dot(chebn,chebn)/0.79));
FdB = 20*log10(Fn);
%figure; 
%polarpattern(FdB,'TitleTop','calculated array factor'); 

pat_p_el = pattern(p,2.1e9,0,-180:180,'Type','directivity');
pat_ar_el = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w);
pat_af_el = pat_ar_el-pat_p_el; 

subfigure(2,2,1); 
polarpattern(pat_af_az,'TitleTop','calculated array factor az');
subfigure(2,2,2); 
polarpattern(pat_af_el,'TitleTop','calculated array factor el'); 
subfigure(2,2,3); 
plot(-180:180,pat_af_az); title('calculated array factor az');
subfigure(2,2,4); 
plot(-180:180,pat_af_el);  title('calculated array factor el');

assignin('base','pat_p_az',pat_p_az)
assignin('base','pat_ar_az',pat_ar_az)
assignin('base','pat_af_az',pat_af_az)
assignin('base','pat_p_el',pat_p_el)
assignin('base','pat_ar_el',pat_ar_el)
assignin('base','pat_af_el',pat_af_el)


end
