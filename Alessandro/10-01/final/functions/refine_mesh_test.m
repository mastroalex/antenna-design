
function refinement_time=refine_mesh_test(p,f)
v = 0.0026:0.000025:0.0039;
smin = zeros(1,length(v));
freqRange = 2e9:0.0025e9:2.2e9;

tic
for i=1:length(v)
mesh(p,'MaxEdgeLength',v(i));
drawnow
s = sparameters(p,freqRange);
svar = 20*log10(abs(s.Parameters));
smin(1,i) = min(min(min(svar)));
disp('Step: ');
disp(length(v)+1-i);
end 
figure();
plot(v,smin);
refinement_time=toc;
end
