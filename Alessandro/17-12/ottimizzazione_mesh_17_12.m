%% aggiorno l'antenna  con le nuove dimensioni calcolate da Stefan

clear 

d = dielectric('FR4');
d.Thickness = 8e-4;
f = 2.1e9;
%L = 0.0294;
%W = 0.0419; 
L=0.03;
W=0.07;
l = L/2-0.0114; %% now it's from the shortC
p = pifa('Height',8e-4,'Substrate',d);
p.Length = L;
p.Width = W;
p.FeedWidth = l;
gpL = 0.1;
gpW = 0.1;
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;

show(p);
tit=strcat('L=',num2str(L),'; W=',num2str(W));
title(tit)
%%
S=sparameters(p,f);

%%
close all
tic
freq_span=linspace(1.5e9,2.7e9,30);
S=sparameters(p,freq_span);
rfplot(S)
toc
saveas(figure(1),'S11_20_testval','pdf');
save('S11.mat','S')
%%
f=1.955172413793104e9;
mesh_val=linspace(0.002,0.2,200);
SS=zeros(1,length(mesh_val));
close all
for i=1:length(mesh_val)
   % figure()
mesh(p,'MaxEdgeLength',mesh_val(i));
%drawnow;
S=sparameters(p,f);
SS(i)=abs(S.Parameters);
i
name=strcat('mesh_',num2str(mesh_val(i)),'.pdf');
saveas(figure(1),name,'pdf');
close all
end
mesh_prop=meshconfig(p,'Auto');
S=sparameters(p,f);
SS_auto=abs(S.Parameters);
figure()
plot(mesh_val,SS,'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,SS_auto,'r-o')
saveas(figure(1),'S11','pdf');

figure()
plot(mesh_val,20*log(SS),'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,20*log(SS_auto),'r-o')
saveas(figure(2),'S11_log','pdf');

%% refinement2
f=1.955172413793104e9;
mesh_val=linspace(0.002,0.057,200);
SS=zeros(1,length(mesh_val));
close all
meshconfig(p,'Manual');
for i=1:length(mesh_val)
   % figure()
mesh(p,'MaxEdgeLength',mesh_val(i));
%drawnow;
S=sparameters(p,f);
SS(i)=abs(S.Parameters);
i
name=strcat('mesh_',num2str(mesh_val(i)),'.pdf');
saveas(figure(1),name,'pdf');
close all
end
mesh_prop=meshconfig(p,'Auto');
S=sparameters(p,f);
SS_auto=abs(S.Parameters);
figure()
plot(mesh_val,SS,'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,SS_auto,'r-o')
saveas(figure(1),'S11','pdf');

figure()
plot(mesh_val,20*log(SS),'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,20*log(SS_auto),'r-o')
saveas(figure(2),'S11_log','pdf');

%% refinement3
f=1.955172413793104e9;
mesh_val=linspace(0.0011,0.057,200);
SS=zeros(1,length(mesh_val));
close all
meshconfig(p,'Manual');
for i=1:length(mesh_val)
   % figure()
mesh(p,'MaxEdgeLength',mesh_val(i));
%drawnow;
S=sparameters(p,f);
SS(i)=abs(S.Parameters);
i
name=strcat('mesh_',num2str(mesh_val(i)),'.pdf');
saveas(figure(1),name,'pdf');
close all
end
mesh_prop=meshconfig(p,'Auto');
S=sparameters(p,f);
SS_auto=abs(S.Parameters);
figure()
plot(mesh_val,SS,'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,SS_auto,'r-o')
saveas(figure(1),'S11','pdf');

figure()
plot(mesh_val,20*log(SS),'b-*')
hold on
plot(mesh_prop.MaxEdgeLength,20*log(SS_auto),'r-o')
saveas(figure(2),'S11_log','pdf');

%%
figure()
plot(mesh_val,SS,'b-*')
%%
close all
tic
meshconfig(p,'Manual');
mesh(p,'MaxEdgeLength',0.01);
freq_span=linspace(1.5e9,2.7e9,50);
S=sparameters(p,freq_span);
rfplot(S)
toc
saveas(figure(1),'S11_mesh0_01','pdf');
save('S11_mesh0_01.mat','S')