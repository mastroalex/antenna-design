%% PARAMETRI INIZIALI

clear 

h = 8e-4;
d = dielectric('FR4');
d.Thickness = h;
f = 2.1e9;
lambda0 = physconst('Lightspeed')/f;
k0=2*pi/lambda0;
p = pifa('Height',8e-4,'Substrate',d);
p.Conductor.Name = 'Copper';
p.Conductor.Conductivity = 5.96*1e7;
p.Conductor.Thickness = 3.556e-05;
p.PatchCenterOffset = [p.Length/2 0];
lfeed = 0.0125;
p.FeedOffset = [p.Length-lfeed 0];
%% SIMULAZIONE PER LIVELLO MESH 

L = 0.0171;
W = 0.0419;
% Gamma = zeros(length(L),length(W));
% Rr = zeros(length(W));
% l = zeros(length(L),length(W));
% v = linspace(0.003,0.006,100);
% Gamma=zeros(length(v));
Rr = (120*lambda0/W)*(1-(1/24)*(k0*h)^2)^(-1);
Rin = 50;
l = L/2-(L/pi)*acos(sqrt(Rin/Rr)); %% now it's from the shortC
p.Length = L;
p.Width = W;
p.ShortPinWidth = W;
gpL = 0.1;
gpW = 0.1;
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;
% parfor i=1:length(v)
% mesh(p,'MaxEdgeLength',v(i));
% drawnow
% Sp = sparameters(p,f);
% Gamma(i) = abs(Sp.Parameters);
% end 
% figure();
% plot(v,Gamma);
% show(p);
% pattern(p,f);
mesh(p, 'MaxEdgeLength',0.0035);
Sp = sparameters(p,(1890:21:2310)*1e6);
Gamm = abs(Sp.Parameters);
rfplot(Sp);
title('\Gamma_{dB} per L = 0.030 e W = 0.07 ');
xlabel('Frequenza (Hz)');
ylabel('\Gamma_{dB}');

%% SIMULAZIONE PER LIVELLO MESH 

L = 0.0171;
W = 0.0619;
% Gamma = zeros(length(L),length(W));
% Rr = zeros(length(W));
% l = zeros(length(L),length(W));
v = 0.003:0.0005:0.009;
% Gamma=zeros(length(v));
Rr = (120*lambda0/W)*(1-(1/24)*(k0*h)^2)^(-1);
Rin = 50;
l = L/2-(L/pi)*acos(sqrt(Rin/Rr)); %% now it's from the shortC
p.Length = L;
p.Width = W;
p.ShortPinWidth = W;
p.FeedOffset = [L/2-l 0];
gpL = 0.1;
gpW = 0.1;
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;
tic
parfor i=1:length(v)
mesh(p,'MaxEdgeLength',v(i));
drawnow
Sp = sparameters(p,f);
Gamma(i) = abs(Sp.Parameters);
end 
figure();
plot(v,Gamma);
toc
% show(p);
% pattern(p,f);
% mesh(p, 'MaxEdgeLength',0.003);
% Sp = sparameters(p,1.7e9:0.05e9:2.8e9);
% Gamm = abs(Sp.Parameters);
% rfplot(Sp);
% title('\Gamma_{dB} per L = 0.030 e W = 0.07 ');
% xlabel('Frequenza (Hz)');
% ylabel('\Gamma_{dB}');


%% SIMULAZIONE CONTOURF
L = 0.02:0.005:0.08;
W = 0.02:0.005:0.08;
Rr = zeros(length(L));
l = zeros(length(L),length(W));
Gamma = zeros(length(L),length(W));
tic
for i=1:length(L)
    for j=1:length(W)
Rr(j) = (120*lambda0/W(j))*(1-(1/24)*(k0*h)^2)^(-1);
Rin = 50;
l(i,j) = L(i)/2-(L(i)/pi)*acos(sqrt(Rin/Rr(j))); %% now it's from the shortC
p.Length = L(i);
p.Width = W(j);
p.FeedWidth = l(i,j);
gpL = 0.1;
gpW = 0.1;
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;
mesh(p, 'MaxEdgeLength',0.009);
Spar = sparameters(p,f);
Gamma(i,j) = abs(Spar.Parameters);
    end
end
contourf(L,W,Gamma)
toc

%% FREQUENZA DI RISONANZA
LW = physconst('Lightspeed')/(4*f*sqrt(4.8));
patch_pifa = design(p,f);
mesh(patch_pifa, 'MaxEdgeLength',0.006);
Sp = sparameters(patch_pifa,1.7e9:0.1e9:2.8e9);
Gamm = abs(Sp.Parameters);
rfplot(Sp);
title('\Gamma_{dB} per L = 0.030 e W = 0.07 ');
xlabel('Frequenza (Hz)');
ylabel('\Gamma_{dB}');