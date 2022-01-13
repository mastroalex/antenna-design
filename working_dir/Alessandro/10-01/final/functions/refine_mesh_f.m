
function refinement_time3=refine_mesh_f(p,f)
tic
v=linspace(0.0025,0.005,70);
smin = zeros(1,length(v));
freqRange = linspace(1.5e9,2.4e9,80);
frequenza=zeros(1,length(v));
for i=1:length(v)
mesh(p,'MaxEdgeLength',v(i));
drawnow
s = sparameters(p,freqRange);
testo = strcat('\Gamma_{dB} for mesh ='," ", string(v(i)));
%figure();
%rfplot(s)
title(testo,'Interpreter','tex');
stringa_salvataggio=strcat('S11_mesh_',string(v(i)),'.mat');
%save(stringa_salvataggio,'s') uncomment for debug and read single
%sparameters 
slog=20*log10(abs(s.Parameters));
ssintax=slog(:,:);
frequenza(i)=s.Frequencies(ssintax==min(ssintax));
smin(i)=min(ssintax);
disp('Step: ');
disp(length(v)+1-i);
close all
end 
figure();
plot(v,smin);
refinement_time3=toc;
figure;
plot(v,frequenza);
title('Resonance F. vs mesh level')
figure;
plot(v,abs(frequenza-2.1e9));
assignin('base','smin3',smin)
assignin('base','v3',v)
assignin('base','frequenza_v3',frequenza)

end
