function tcheB=design_my_pifa_array(p)

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

chebc = 41.2*chebwin(5,sll);
assignin('base','chebn',chebn)
assignin('base','chebc',chebc)

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


end
