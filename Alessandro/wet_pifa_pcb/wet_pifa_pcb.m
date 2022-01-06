%% LOAD THE PIFA antenna parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% PIFA RESULTING DESIGN %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear; clc; 
f = 2.1e9; % resonant frequency 
p = design(pifa, f); 
% creating standard pifa with shorting width equalling W 
% This makes it have the same structure of a (lambda/4) 
% folded patch antenna

% NON optimized patch length and width
% They have been evaluated by using Wolfram Mathematica
% Right there, the classic formulas from Balanis have been executed

% W = 0.0419;
% L = 0.0171;

% OPTIMIZED patch length and width
% This values come out after the mesh refinement process 
% and impedance matching 

W= 0.0351; 
L = 0.0158; 

h = 0.0008; % substrate thickness and patch height
lambda0 = physconst('Lightspeed')/f; % free space wavelength at given frequency
k0=2*pi/lambda0; % propagation constant

% patch parameters setting
p.Length = L;
p.Width = W;
p.Height = h;
p.Substrate.Name = 'FR4';
p.Substrate.EpsilonR = 4.8;
p.Substrate.LossTangent = 0.026;

% Substrate thickness h=8e-4 has been used by following the Antenna Toolbox
% rationale, which doesn't give any precise guideline in the mesh refinement process
% by means of an accuracy indication in the case of 
% h between (lambda/50, lambda/10). h would have belonged to this range
% in case of h={1.0e-3, 1.6e-3}. Out of this range, for h < lambda/50, the mesh is
% regarded as a thin one, and the tool suggests to set 'auto' mesh level to aquire 
% best accuracy. In the case of h comparable to lambda/10, the tool requires at least
% a max mesh edge length comparable to the lambda/10 value. 
% That's why we selected h = 8e-4;
p.Substrate.Thickness = h;
p.ShortPinWidth = W; 
% since no folded patch antenna structure is directly available 
% in the tool, by selecting (short circuit width) wsc = W, 
% the pifa structure equals the design of a folded patch antenna
p.PatchCenterOffset = [0 0];
Rr = (120*lambda0/W)*(1-(1/24)*(k0*h)^2)^(-1);
Rin = 50;

% FEED POINT - coming out of an impedance matching process
lfeed= 0.0067; % optimized value 
wfeed = 0.0010; % optimized value

% wfeed = 0;
% lfeed = (L/pi)*acos(sqrt(Rin/Rr)); % standard computation 

p.FeedOffset = [lfeed-L/2 wfeed];

% OPTIMIZED ground lenght and width
% we started with [gpL, gpW] = [0.08, 0.08]
gpL = 0.0296;
gpW = 0.058; 
p.GroundPlaneLength = gpL;
p.GroundPlaneWidth = gpW;

% selection of a realistic conductor
% Copper is used in our University lab
p.Conductor.Name = 'Copper';
p.Conductor.Conductivity = 5.96*1e7;
p.Conductor.Thickness = 3.556e-05;


% show the 
figure;
show(p);
% title('Finally designed folded patch');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% END PIFA DESIGN %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% LOAD THE TCHEB ARRAY of PIFAs parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SENSOR ARRAY ANALYZER %%%%%%%%%%%
%%%%%%%%%%%% TCHEBYSHEV ARRAY OF %%%%%%%%%%%%%
%%%%%%%%%%%% PIFAS DESIGN %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tcheB = phased.ULA('NumElements',5,...
'ArrayAxis','x');
tcheB.ElementSpacing = 0.0939;
sll = 41.58;
chebn = chebwin(5, sll);
tcheB.Taper = chebn;

Cheb_Currents = 41.2*chebwin(5,sll);

tcheB.Element = p;

Frequency = 2.1e9;
PropagationSpeed = 300000000;

% Assign Steering Angles
% SteeringAngles = [0;90];
SteeringAngles = [0;90];

% Assign Phase shift quantization bits
PhaseShiftBits = 0;

% Create Figure

% Plot Array Geometry
figure;
%viewArray(tcheB,'ShowNormal',false,...
%  'ShowTaper',false,'ShowIndex','None',...
%  'ShowLocalCoordinates',true,'ShowAnnotation',false,...
%  'Orientation',[0;0;0]);
viewArray(tcheB,'ShowNormal',false,...
  'ShowTaper',false,'ShowIndex','None');

% Steering weights (for broadside, the result is w=ones(5,1)) 
format = 'polar';
Freq3D = 2.1e9;

w = zeros(getNumElements(tcheB), length(Frequency));
SteerVector = phased.SteeringVector('SensorArray', tcheB,...
 'PropagationSpeed', PropagationSpeed, 'NumPhaseShifterBits', PhaseShiftBits(1));
for idx = 1:length(Frequency)
    w(:, idx) = step(SteerVector, Frequency(idx), SteeringAngles(:, idx));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% END OF %%%%%%%%%%%%%%%%%%%%
%%%%%%%% SENSOR ARRAY ANALYZER %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% LOAD THE PCB stack and the array of PCBs parameters

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

L = 0.0158;
W = 0.0351;
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
%figure;
%show(dotchy);

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

%%
figure;
efficiency(kfa,2.1e9)

%% ARRAY PLOTS WITH PIFAs VS PCBs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 2D PATTERNS %%%%%%%%%%%%%%%%%
%%%%%% AZIMUTH CUT %%%%%%%%%%%%%%%%%
%%%%%% ELEVATION CUT %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BROADSIDE %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PCBs
pcb_array_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
pcb_array_azimuth_broadside = pcb_array_azimuth_broadside';
pcb_array_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');

% PIFAs
pifa_array_azimuth_broadside = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
pifa_array_elevation_broadside = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

% SINGLE 2D PLOTS
figure;
pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
figure;
patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

% COMPARED 2D PLOTS 
figure; 
polarpattern(pcb_array_azimuth_broadside)
hold on
polarpattern(pifa_array_azimuth_broadside);

figure;
polarpattern(pcb_array_elevation_broadside)
hold on
polarpattern(pifa_array_elevation_broadside);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% REAL/IDEAL GAIN PATTERNS %%%%%%%%%%%
%%%%%% ACTUALLY ONLY DIRECTIVITY %%%%%%%%%%
%%%%%% WITH patternMultiply %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pcb_array_real_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
pcb_array_ideal_azimuth_broadside = patternMultiply(kfa,2.1e9,-180:180,0,'Type','directivity');

figure;
pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
patternMultiply(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
polarpattern(pcb_array_real_azimuth_broadside);
hold on
polarpattern(pcb_array_ideal_azimuth_broadside);

% ELEVATION 
pcb_array_real_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
pcb_array_ideal_elevation_broadside = patternMultiply(kfa,2.1e9,0,-180:180,'Type','directivity');

figure;
pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
patternMultiply(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
polarpattern(pcb_array_real_elevation_broadside);
hold on
polarpattern(pcb_array_ideal_elevation_broadside);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% ELECTRIC AND MAGNETIC %%%%%%%%%%%%%%%%%
%%%%%%% NEAR FIELDS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L_max = 4*dopt+0.0158; 

LL = linspace(-L_max/2,L_max/2,10);
[X,Y]=meshgrid(LL,LL); 
fre=0.62*sqrt((L_max)^3/lambda0);
pfre_broadside=[X(:)';Y(:)';(fre/2)*ones(1,prod(size(X)))];
figure;
EHfields(kfa,2.1e9,pfre_broadside);


Xsp = [-2*dopt -dopt 0 dopt 2*dopt];
Ysp = [0 0 0 0 0]; 
fre=0.62*sqrt((L_max)^3/lambda0);
pfresnel_broadside = [Xsp(:)';Ysp(:)';(fre/2)*ones(1,prod(size(Xsp)))];
figure;
EHfields(kfa,2.1e9,pfresnel_broadside);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% BEAMSTEETING %%%%%%%%%%%%%
%%%%%% AT 45° OFF %%%%%%%%%%%%%%%
%%%%%% BORESIGHT %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PIFAs beamsteering at 45°
format = 'polar';
Freq3D = 2.1e9;
SteeringAngles = [0;45]; 

w = zeros(getNumElements(tcheB), length(Frequency));
SteerVector = phased.SteeringVector('SensorArray', tcheB,...
 'PropagationSpeed', PropagationSpeed, 'NumPhaseShifterBits', PhaseShiftBits(1));
for idx = 1:length(Frequency)
    w(:, idx) = step(SteerVector, Frequency(idx), SteeringAngles(:, idx));
end

% PCBs Beamsteering at 45°
lambda0 = 0.1428;
k0 = 2*pi/lambda0;
u0 = -k0*dopt*cos(pi/4);
an = zeros(5,1);
for i=0:4
an(i+1,1) = i*u0; 
end
kfa.PhaseShift = an*(180/pi); 

% PCBs
pcb_array_azimuth_steering_45 = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
pcb_array_azimuth_steering_45 = pcb_array_azimuth_steering_45';
pcb_array_elevation_steering_45 = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');

% PIFAs
pifa_array_azimuth_steering_45 = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
pifa_array_elevation_steering_45 = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

% SINGLE 2D PLOTS
figure;
pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
figure;
patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 

% COMPARED 2D PLOTS 
figure; 
polarpattern(pcb_array_azimuth_steering_45);
hold on
polarpattern(pifa_array_azimuth_steering_45); 

figure; 
polarpattern(pcb_array_elevation_steering_45);
hold on
polarpattern(pifa_array_elevation_steering_45);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% REAL/IDEAL GAIN PATTERNS %%%%%%%%%%%
%%%%%% ACTUALLY ONLY DIRECTIVITY %%%%%%%%%%
%%%%%% WITH patternMultiply %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pcb_array_real_azimuth_steering_45 = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
pcb_array_ideal_azimuth_steering_45 = patternMultiply(kfa,2.1e9,-180:180,0,'Type','directivity');

figure;
pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
patternMultiply(kfa,2.1e9,-180:180,0,'Type','directivity');
figure;
polarpattern(pcb_array_real_azimuth_steering_45);
hold on
polarpattern(pcb_array_ideal_azimuth_steering_45);

% ELEVATION 
pcb_array_real_elevation_steering_45 = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
pcb_array_ideal_elevation_steering_45 = patternMultiply(kfa,2.1e9,0,-180:180,'Type','directivity');

figure;
pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
patternMultiply(kfa,2.1e9,0,-180:180,'Type','directivity');
figure;
polarpattern(pcb_array_real_elevation_steering_45);
hold on
polarpattern(pcb_array_ideal_elevation_steering_45);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% ELECTRIC AND MAGNETIC %%%%%%%%%%%%%%%%%
%%%%%%% NEAR FIELDS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L_max = 4*dopt+0.0158; 

LL = linspace(-L_max/2,L_max/2,10);
[X,Y]=meshgrid(LL,LL); 
fre=0.62*sqrt((L_max)^3/lambda0);
pfre_steering_45=[X(:)';Y(:)';(fre/2)*ones(1,prod(size(X)))];
figure;
EHfields(kfa,2.1e9,pfre_steering_45);


Xsp = [-2*dopt -dopt 0 dopt 2*dopt];
Ysp = [0 0 0 0 0]; 
fre=0.62*sqrt((L_max)^3/lambda0);
pfresnel_steering_45 = [Xsp(:)';Ysp(:)';(fre/2)*ones(1,prod(size(Xsp)))];
figure;
EHfields(kfa,2.1e9,pfresnel_steering_45);