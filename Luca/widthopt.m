close all
f=2.1e9;
h=10e-4;
lambda=physconst('LightSpeed')/f;
epsr=4.800; %FR4 relative permettivity
Rin=50; %input resistance, requested
k0=2*pi*lambda;
beta=2*pi*(sqrt(epsr)/lambda);
L =0.07;
W=linspace(0.001,0.1,1000);
Lf=zeros(1,length(W));
Lfun=zeros(1,length(W));
Dm=zeros(1,length(W));
Dmun=zeros(1,length(W));
BWH=zeros(1,length(W));
BWHun=zeros(1,length(W));
for i=1:length(W)
Gf=W(i)/(120*lambda)*(1+0.5*(k0*h)^2);
Rr=1/Gf; %radiation resistance for the folded patch, which is twice the radiation resistance of a normal patch
Lfeed=L/pi*acos(sqrt(Rin/Rr));
Lf(i)=abs(Lfeed);
Dmax=2/15*((W(i)/lambda)^2)*Rr;
Dm(i)=Dmax;
BWh=2*acos(sqrt(1/(2+k0*W(i))));
BWH(i)=BWh;
end 
for i=1:length(W)
    LfM=max(Lf);
Lfun(i)=Lf(i)/LfM;
DmM=max(Dm);
Dmun(i)=Dm(i)/DmM;
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
title('Directivity');
subplot(2,2,4);
plot(W,Lfun,'b',W,Dmun,'r--',W,BWHun,'g');
title('Comparison after scaling');
