function [dotchy,kfa]=design_my_pcb_array(L,W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PCB ANTENNA DESIGNER %%%%%%%
%%%%%%%%%% PIFA APPROXIMATION %%%%%%%%%
%%%%%%%%%% MADE WITH A PCB STACK %%%%%%
%%%%%%%%%% AND ARRAY OF PCBs %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% SINGLE PCB %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Size of PCB
pcbThickness = 8e-4; 
pcbLength = 0.0158;   
pcbWidth = 0.0371;    

%Specifying Material of PCB
pcbMaterial = 'FR4';
pcbEpsilonR = 4.8;

%Creating dielectic Material
d = dielectric(pcbMaterial); %Creating dielectic Material
d.EpsilonR = pcbEpsilonR;
d.Thickness = pcbThickness;


h = 8e-4; 
Lshort = (L+h)/2;
GndPlane = antenna.Rectangle('Length',0.0296,'Width',0.058); %Creating Ground Plane of Antenna

AntennaPlane = antenna.Rectangle('Length',0.0158,'Width',0.0351,'Center',[0,0]); %Creating Feed Plane of Antenna 

ShortFace = antenna.Rectangle('Length',h,'Width',W,'Center',[0 0]);
Short_Face = rotateX(ShortFace,90);
ShortFace.Center = [7.9e-3 0];

% dotchy.Layers{1} = AntennaPlane;
% dotchy.Layers{2} = d;
% dotchy.Layers{3} = GndPlane; 

%Creating Different Shapes of antenna
dotchy = pcbStack;
dotchy.Name = 'Coax-fed slot';
dotchy.BoardShape = GndPlane;
dotchy.BoardThickness = pcbThickness;
dotchy.Layers = {AntennaPlane,d,GndPlane};
dotchy.FeedLocations = [-1.2e-3, 1e-3,1,3]; %[x Cordinate,y Cordinate,startLayer stopLayer]
dotchy.Conductor = metal('Copper');
dotchy.FeedDiameter = 4e-4; 
%dotchy.FeedViaModel = 'strip';
%loc1 = [0.0075 0.0075];
% loc2 = [0 0.01];

% tic
% freqRange = 2.0e9:0.0025e9:2.2e9;
% figure; 
% s = sparameters(dotchy, freqRange); 
% rfplot(s)
% pcb_sparameters_time=toc;
%assignin('base','pcb_sparameters_time',pcb_sparameters_time)

% Inserting multiple shorting pins loop

num_pin = 30;
M = zeros(num_pin,4);
y_pin = linspace(-W/2,W/2,num_pin)';
x_pin = (-7.5e-3)*ones(num_pin,1);
lay1 = ones(num_pin,1);
lay3 = 3*ones(num_pin,1); 

for i = 1:num_pin
M(i,4) = lay3(i,1);
M(i,3) = lay1(i,1);
M(i,1) = x_pin(i,1);
M(i,2) = y_pin(i,1);
end

dotchy.ViaLocations = M;
dotchy.ViaDiameter = 4e-4;
dotchy.Layers = {AntennaPlane,d,GndPlane};

% add(AntennaPlane,ShortFace);
figure;
show(dotchy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% PCBs ARRAY %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% conformalArray("Element",potchy,5)
dopt = 0.0939; 
% Lpatch = 0.0158; % or 0.3 
% your array looks like that:
% [*].dopt.[*].dopt.[*].dopt.[*].dopt.[*]
Ltot = 4*dopt;
pos = [ linspace(-Ltot/2,Ltot/2,5); 0 0 0 0 0   ;0 0 0 0 0];
kfa = conformalArray('Element',dotchy,'ElementPosition',pos');
% normalized tapering coefficients
c0 = 1.000; 
c1 = 0.7215;
c2 = 0.2336;
kfa.AmplitudeTaper = [c2; c1; c0; c1; c2 ];
% kfa.AmplitudeTaper = [c2; c1; c0; c1; c2]; 
figure;
show(kfa);
title('Array model with PCB stacks');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% END OF %%%%%%%%%%%%%%
%%%%%%% PCB ANTENNA DESIGNER %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end