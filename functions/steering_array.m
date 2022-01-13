function steering_array(kfa,Frequency,dopt,tcheB,PropagationSpeed,PhaseShiftBits)


% PIFAs beamsteering at 45°
format = 'polar';
Freq3D = 2.1e9;
SteeringAngles = [0;45]; 

w_ster = zeros(getNumElements(tcheB), length(Frequency));
SteerVector = phased.SteeringVector('SensorArray', tcheB,...
 'PropagationSpeed', PropagationSpeed, 'NumPhaseShifterBits', PhaseShiftBits(1));
for idx = 1:length(Frequency)
    w_ster(:, idx) = step(SteerVector, Frequency(idx), SteeringAngles(:, idx));
end

% PCBs Beamsteering at 45°
lambda0 = 0.1428;
k0 = 2*pi/lambda0;
u0 = -k0*dopt*cos(pi/4);
an = zeros(5,1);
for i=0:4
an(i+1,1) = i*u0; 
end
kfa_ster=kfa;
kfa_ster.PhaseShift = an*(180/pi); 

assignin('base','kfa_ster',kfa_ster)
assignin('base','w_ster',w_ster)

end