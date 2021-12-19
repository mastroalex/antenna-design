close all
f=2.1e9;
h=10e-4;
lambda=physconst('LightSpeed')/f;
epsr=4.800; %FR4 relative permettivity
Rin=50; %input resistance, requested
k0=2*pi*lambda;
beta=2*pi*(sqrt(epsr)/lambda);
L =0.03;
W=linspace(0.001,0.01,1000);
Lf=zeros(1,length(W));
for i=1:length(W)
Gf=W(i)/(120*lambda)*(1+0.5*(k0*h)^2);
Rr=1/Gf; %radiation resistance for the folded patch, calculated from the Gf, that depends on the W width
Lfeed=L/pi*acos(sqrt(Rin/Rr));
Lf(i)=abs(Lfeed);
LfM=max(Lf);
Lfun(i)=Lf(i)/LfM;
Dmax=2/15*((W(i)/lambda)^2)*Rr;
Dm(i)=Dmax;
DmM=max(Dm);
Dmun(i)=Dm(i)/DmM;
BWh=2*acos(sqrt(1/(2+k0*W(i))));
BWH(i)=BWh;
BWHM=max(BWH);
BWHun(i)=BWH(i)/BWHM;
end 
subplot(2,2,1);
plot(W,Lf,'b',W,L,'b--');
title('feed distance');
subplot(2,2,2);
plot(W,BWH,'g');
title('Beam Width H-cut');
subplot(2,2,3);
plot(W,Dm,'r--'); 
title('Directibvity');
subplot(2,2,4);
plot(W,Lfun,'b',W,Dmun,'r',W,BWHun,'g');
title('Comparison after scaling');
