function p=design_my_pifa(L,W,h)
% clear; clc; 
f = 2.1e9; % resonant frequency 
p = design(pifa, f); 
assignin('base','f',f)

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

% W= 0.0351; 
% L = 0.0158; 

% h = 0.0008; % substrate thickness and patch height
lambda0 = physconst('Lightspeed')/f; % free space wavelength at given frequency
k0=2*pi/lambda0; % propagation constant
assignin('base','lambda0',lambda0)
assignin('base','k0',k0)

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
assignin('base','Rr',Rr)
assignin('base','Rin',Rin)

% FEED POINT - coming out of an impedance matching process
lfeed= 0.0067; % optimized value 
wfeed = 0.0010; % optimized value
assignin('base','lfeed',lfeed)
assignin('base','wfeed',wfeed)
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
end