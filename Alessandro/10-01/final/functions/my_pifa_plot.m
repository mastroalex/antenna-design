
function my_pifa_plot(p,f)
subfigure(3,2,1); 
mesh(p,'MaxEdgeLength',0.0035);
title('Mesh');
subfigure(3,2,3); 
beamwidth(p,f,0,0:1:360);
title('Beamwidth - H-cut');
subfigure(3,2,4); 
beamwidth(p,f,0:1:360,0);
title('Beamwidth - E-cut');
freqRange = 2e9:0.002e9:2.2e9;

% figure();
% mesh(p,'MaxEdgeLength',0.0035);
subfigure(3,2,5); 
impedance(p, freqRange); 
title('Impedance matched')

tic
freqRange = 2.0e9:0.0025e9:2.2e9;
subfigure(3,2,6); 
s = sparameters(p, freqRange); 
rfplot(s)
pifa_sparameters_time=toc;
assignin('base','pifa_sparameters_time',pifa_sparameters_time)

% tic
% figure;
% pattern(p,2.1e9,0,-180:180,'Type','gain');
% pifa_pattern_time=toc;
% assignin('base','pifa_pattern_time',pifa_pattern_time)

end 
