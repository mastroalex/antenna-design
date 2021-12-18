clear 

h = 8e-4;
d = dielectric('FR4');
d.Thickness = h;
f = 2.1e9;
lambda0 = physconst('Lightspeed')/f;
k0=2*pi/lambda0;
dL=0.000361;
p = pifa('Height',8e-4,'Substrate',d);
L = 0.0326;
W = 0.0419;
Gamma = zeros(length(L),length(W));
Rr = zeros(length(W));
l = zeros(length(L),length(W));
% v = linspace(0.003,0.006,100);
% Gamma=zeros(length(v));
% Rr = (120*lambda0/W)*(1-(1/24)*(k0*h)^2)^(-1);
% Rin = 50;
% l = L/2-(L/pi)*acos(sqrt(Rin/Rr)); %% now it's from the shortC
% p.Length = L;
% p.Width = W;
% p.FeedWidth = l;
% gpL = 0.1;
% gpW = 0.1;
% p.GroundPlaneLength = gpL;
% p.GroundPlaneWidth = gpW;
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
% Sp = sparameters(p,1.7e9:0.1e9:2.9e9);
% rfplot(Sp);
% title('\Gamma_{dB} per L = 0.030 e W = 0.07 ');
% xlabel('Frequenza (Hz)');
% ylabel('\Gamma_{dB}');
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
mesh(p, 'MaxEdgeLength',0.0033);
Spar = sparameters(p,1.7e9:0.1e9:2.5e9);
rfplot(Spar);
Gamma(i,j) = abs(Spar.Parameters);
    end
end
contourf(L,W,Gamma)
toc
