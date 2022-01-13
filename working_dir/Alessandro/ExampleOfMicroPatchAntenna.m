%This Code was Written By Nemeen Shah
%Subscribe to My YouTube Channel: https://Youtube.com/NematicsLab

%Size of PCB
pcbThickness = 8e-4;  %1.6mm
pcbLength = 0.0158;   %152.4mm or 6inch
pcbWidth = 0.0371;    %101.6mm 0r 4inch

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
GndPlane = antenna.Rectangle('Length',0.03,'Width',0.058); %Creating Ground Plane of Antenna

AntennaPlane = antenna.Rectangle('Length',0.0158,'Width',0.0351,'Center',[0,0]); %Creating Feed Plane of Antenna 

ShortFace = antenna.Rectangle('Length',h,'Width',W,'Center',[0 0]);
Short_Face = rotateX(ShortFace,90);
ShortFace.Center = [7.9e-3 0];



%Creating Different Shapes of antenna
dotchy = pcbStack;
dotchy.Name = 'Coax-fed slot';
dotchy.BoardShape = GndPlane;
dotchy.BoardThickness = pcbThickness;
dotchy.Layers = {AntennaPlane,d,GndPlane};
dotchy.FeedLocations = [-1.2e-3, 1e-3,1,3]; %[x Cordinate,y Cordinate,startLayer stopLayer]
dotchy.Conductor = metal('Copper');
%dotchy.FeedViaModel = 'strip';
%loc1 = [0.0075 0.0075];
% loc2 = [0 0.01];


%%
num_pin = 10;
M = zeros(num_pin,4);
y_pin = linspace(-W/2,W/2,num_pin)';
x_pin = (-7e-3)*ones(num_pin,1);
lay1 = ones(num_pin,1);
lay3 = 3*ones(num_pin,1); 
%% 
for i = 1:num_pin
M(i,4) = lay3(i,1);
M(i,3) = lay1(i,1);
M(i,1) = x_pin(i,1);
M(i,2) = y_pin(i,1);
end
%%
dotchy.ViaLocations = M;
dotchy.ViaDiameter = 1.6e-3;
dotchy.Layers = {AntennaPlane,d,GndPlane};

% add(AntennaPlane,ShortFace);
figure;
show(dotchy);


%% 
% conformalArray("Element",potchy,5)
Ltot = 0.33;
pos = [linspace(-Ltot/2,Ltot/2,5); 0 0 0 0 0;  0 0 0 0 0];
kfa = conformalArray('Element',dotchy,'ElementPosition',pos');
kfa.AmplitudeTaper = [0.23 0.72 1.00 0.72 0.23]; 
figure;
show(kfa);
figure;
pattern(kfa,2.1e9);
figure;
patternMultiply(kfa,2.1e9);

%% 
freqRange = 2e9:0.002e9:2.2e9;

% sparameter
figure();
mesh(dotchy,'MaxEdgeLength',0.0035);
figure();
impedance(p, freqRange); 
title('Impedance matched')

%% % Define plot frequency 
plotFrequency = 2.1*1e9;
% Define frequency range 
freqRange = 2.0e9:0.0025e9:2.2e9;
figure;
mesh(p,'MaxEdgeLength',0.0035);
% sparameter
figure;
s = sparameters(dotchy, freqRange); 
rfplot(s)


%% Creating PCB Stack
figure(1);
show(dotchy); %Display Antenna 

figure(2);
pattern(dotchy,1.82e9);  %Display Radiation Pattern at 1.943GHZ

figure(3);
impedance(dotchy,1.6e9:2e7:2.2e9);   %Display Impedance Graph from 1.6GHz to 2.2GHz

freq = linspace(1.6e9, 2.2e9, 50); % Creating Frequency Vector
s = sparameters(dotchy,freq,50); % Calalculate S11 for all frequencys

figure(4);
rfplot(s);%Diplay S11 Plot

%Generating Gerber Files for Fabrication 
C = PCBConnectors.SMA_Cinch;
W = PCBServices.PCBWayWriter;
W.Filename = 'antenna_design_example';

gerberWrite(dotchy,W,C);

%This will genrate a ZIP file in your project folder with Name "antenna_design_Example.zip"
%Now just Upload the Gerber file to any PCB Service online and you are ready to go

%Else if you want to make PCB Yourself then upload the files to https://www.gerber-viewer.com/
%from there you can conver the gerber into PDF and take print of all individual layers
 
