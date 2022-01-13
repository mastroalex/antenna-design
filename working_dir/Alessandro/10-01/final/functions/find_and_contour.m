function contourTime=find_and_contour(p,lambda0,k0,h,f)
%clear L W l 
L = 0.0156:0.0001:0.0163;
W = 0.034:0.0001:0.049;

Rr = zeros(length(W),1);
l = zeros(length(L),length(W));
Gamma = zeros(length(L),length(W));
gpL = 0.029:0.0001:0.0297;
gpW = 0.044:0.0001:0.059; 

tic
disp('Total steps: ');
disp(length(L)*length(W));
for i=1:length(L)
    for j=1:length(W)
Rr(j,1) = (120*lambda0/W(j))*(1-(1/24)*(k0*h)^2)^(-1);
Rin = 50;
l(i,j) = (L(i)/pi)*acos(sqrt(Rin/Rr(j))); %% now it's from the shortC
    end
end

for i=1:length(L)
    for j=1:length(W)
    p.Length = L(i);
p.Width = W(j);
p.PatchCenterOffset = [0 0];
p.FeedOffset = [l(i,j)-L(i)/2 0];
p.ShortPinWidth = W(j);
p.GroundPlaneLength = gpL(i);
p.GroundPlaneWidth = gpW(j);
mesh(p, 'MaxEdgeLength',0.0035);
Spar = sparameters(p,f);
Gamma(i,j) = abs(Spar.Parameters);
disp('Step L: ');
disp(i);
disp('Step W: ');
disp(j);
    end
end
contourTime=toc

% CONTOURS 

figure();
contourf(W,L,Gamma);
colorbar;
figure();
contourf(W,L,20*log10(Gamma));
colorbar;
assignin('base','Gamma',Gamma)

end