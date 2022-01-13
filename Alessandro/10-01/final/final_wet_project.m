%%% Blasi Luca
%%% Mastrofini Alessandro
%%% Mucenica Stefan Leonard
%%% University of Rome Tor Vergata
%%% Folded Patch Design
%%% Pleas visit: https://github.com/mastroalex/antenna-design 
%% Please, first of all, set Current Folder to script path!
% load('myworkspace.mat')
addpath(strcat(pwd,'/functions')); %load function from subfolder
%clear all
load(strcat(pwd,'/data_and_calculations/antenna_variables.mat'))
%% LOAD THE PIFA antenna parameters
p=design_my_pifa(L,W,h); 
%%
my_pifa_plot(p,f);
%%
refinement_time=refine_mesh_test(p,f);
refinement_time2=refine_mesh_test2(p,f);
refinement_time3=refine_mesh_f(p,f);
%%
impedance_match(p,f,L,lfeed);
%% contour plot to find optimal L & W
contourTime=find_and_contour(p,lambda0,k0,h,f);
%% LOAD THE TCHEB ARRAY of PIFAs parameters
tcheB=design_my_pifa_array(p);
%% CALC ARRAY FACTOR FOR tcheB ARRAY WITH p ELEMENTs
calc_and_plot_array_factor_pifa(p,chebc,chebn,tcheB,w);
%% LOAD THE PCB stack and the array of PCBs parameters
[dotchy,kfa]=design_my_pcb_array(L,W);
%% ARRAY PLOTS WITH PIFAs VS PCBs
compare_arrays_plot(kfa,tcheB,w);
%% GAIN PATTERN real/ideal
my_gain_pattern(kfa,dotchy,chebc);
my_field(kfa);
%% BEAMSTEERING 45° of boresight
steering_array(kfa,Frequency,dopt,tcheB,PropagationSpeed,PhaseShiftBits)
my_gain_pattern_45(kfa_ster,w_ster,tcheB)
my_field_45(kfa_ster,dopt,fre,fraun,lambda0)
my_field_single_point(EH_90_center,EH_center_45)
%% time benchmark
time_data=[array_pcb_pattern_time, array_pifa_pattern_time ; pcb_pattern_time, pifa_pattern_time; pcb_sparameters_time, pifa_sparameters_time ];
figure;
bar(categorical({'array pattern','antenna pattern','sparameters'}),time_data)
legend('PCB','PIFA')
ylabel('time(s)')
%% Error 
pattern_error(pifa_array_azimuth_broadside,pcb_array_azimuth_broadside,...
    pifa_array_elevation_broadside, pcb_array_elevation_broadside,...
    pifa_array_azimuth_steering_45, pcb_array_azimuth_steering_45,...
    pifa_array_elevation_steering_45, pcb_array_elevation_steering_45)
%% ARRAY FACTOR
my_array_factor(kfa,dotchy,chebc,chebn)
%% save workspace
% save('myworkspace.mat')