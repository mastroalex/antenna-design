close all
f=2.1e9;
h=10e-4;
lambda=physconst('LightSpeed')/f;
epsr=4.800; %FR4 relative permettivity
Rin=50; %input resistance, requested
k0=2*pi*lambda;
beta=2*pi*(sqrt(epsr)/lambda);
L =linspace(0.0165,0.0175,10); %range for L, it's testing on ten values
W=linspace(0.01,0.06,100); %range for W, testing on 100 equally spaced values
Lf=zeros(1,length(W));
Lfun=zeros(1,length(W));
Dm=zeros(1,length(W));
Dmun=zeros(1,length(W));
BWH=zeros(1,length(W));
BWHun=zeros(1,length(W));
Wval=zeros(1,length(L));
for j=1:length(L)
for i=1:length(W)
Gf=W(i)/(120*lambda)*(1+0.5*(k0*h)^2);
Rr=1/Gf; %radiation resistance for the folded patch, which is twice the radiation resistance of a normal patch
Lfeed=L(j)/pi*acos(sqrt(Rin/Rr));
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
figure 
plot(W,BWHun,'g',W,Lfun,'r',W,Dmun,'b');
%Wint=find(Lfun-Dmun<1e-11); %extracting the value of W which maximizes both the distance of the feed and the directivity
%Wval(j)=Wint;
end 
Wfin=max(Wval);