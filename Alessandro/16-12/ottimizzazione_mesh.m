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
mesh_val=[0.001 0.01 0.1];
for i=1:length(mesh_val)
mesh(p,'MaxEdgeLength',mesh_val(i));
S=sparameters(p,f);
SS(i)=abs(S.Parameters);
end
figure()
plot(mesh_val,SS)
% meshconfig(antenna,'Auto')