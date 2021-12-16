clear 

d = dielectric('FR4');
d.Thickness = 8e-4;
f = 2.1e9;
L = 0.0294;
W = 0.0419; 
l = L/2-0.0114; %% now it's from the shortC
p = pifa('Height',8e-4,'Substrate',d);
p.Length = L;
p.Width = W;
p.FeedWidth = l;
gpL = 0.1;
gpW = 0.1;
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;

%%
S=sparameters(p,f);

%%
tic
freq_span=1.5e9:0.1e9:2.7e9;
S=sparameters(p,freq_span);
rfplot(S)
toc

%%
mesh_val=linspace(0.001,0.1,70);
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
saveas(figure(i),name,'pdf');
close all
end
figure()
plot(mesh_val,SS,'b-*')
saveas(figure(1),'S11','pdf');
% meshconfig(antenna,'Auto')
%%
figure()
plot(mesh_val,SS,'b-*')