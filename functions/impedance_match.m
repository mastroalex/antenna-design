function impedance_match(p,f,L,lfeed)
tic
%lfeed = 0.0060:0.0001:0.008;
wfeed = -0.005:0.0001:0.005;
figure();
mesh(p,'MaxEdgeLength',0.0035);
for i=1:length(wfeed)
p.FeedOffset = [lfeed-L/2 wfeed(i)];
% p.FeedOffset = [lfeed(i)-L/2 0];
freqRange = 2e9:0.002e9:2.2e9;
figure();
% sparameter
impedance(p, f);
title(string(wfeed(i)));
disp('Step: ');
disp(length(wfeed)-i);
end
disp('Done!');
impedanceMatch_time=toc;
assignin('base','impedanceMatch_time',impedanceMatch_time)

end