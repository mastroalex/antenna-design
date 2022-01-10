
function refinement_time2=refine_mesh_test2(p,f)
plotFrequency = 2.1*1e9;
% Define frequency range 
v = 0.0025:0.0001:0.009;
smin = zeros(1,length(v));
freqRange = 2.0e9:0.0025e9:2.2e9;

tic
for i=1:length(v)
mesh(p,'MaxEdgeLength',v(i));
% sparameter
figure;
s = sparameters(p, freqRange); 
svar = 20*log10(abs(s.Parameters));
smin(1,i) = min(min(min(svar)));
disp('Step: ');
disp(length(v)-i);
end
figure();
plot(v,smin);
refinement_time2=toc;
end
