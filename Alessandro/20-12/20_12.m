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
lambda=physconst('LightSpeed')/f;
lambda4=lambda/4;
show(p);
tit=strcat('L=',num2str(L),'; W=',num2str(W));
title(tit)

p=pifa_antennaDesigner2;
h=0.0008;
epsr=4.8;
epseff=((epsr+1)/2+(epsr+1)/2)/(sqrt(1+12*h/W)); %costante dielettrica efficace
lambda=physconst('LightSpeed')/(f*sqrt(epseff));
lambda4=lambda/4;
p.Length = lambda4;
l = (p.Length)/2-0.01;
p.FeedOffset=[l 0];
close all
tic
meshconfig(p,'Manual');
mesh(p,'MaxEdgeLength',0.004);
close all
freq_span=linspace(1.9e9,2.3e9,50);
S=sparameters(p,freq_span);
rfplot(S)
toc