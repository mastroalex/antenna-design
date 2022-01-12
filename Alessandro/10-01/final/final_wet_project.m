%%% Blasi Luca
%%% Mastrofini Alessandro
%%% Mucenica Stefan Leonard
%%% University of Rome Tor Vergata
%%% Folded Patch Design
%%% Pleas visit: https://github.com/mastroalex/antenna-design 

%% Please, first of all, set Current Folder to script path!

addpath(strcat(pwd,'/functions')); %load function from subfolder
%clear all
load(strcat(pwd,'\data_and_calculations\antenna_variables.mat'))
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

%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% REAL/IDEAL GAIN PATTERNS %%%%%%%%%%%
%%%%%% ACTUALLY ONLY DIRECTIVITY %%%%%%%%%%
%%%%%% WITH patternMultiply %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% etaT = (1/5)*(abs(chebc(3)+2*chebc(4)+2*chebc(5))^2/(chebc(3)^2+2*chebc(4)^2+2*chebc(5)^2));
% pcb_gain_azimuth_broadside = pattern(dotchy,2.1e9,-180:180,0,'Type','gain');
% pcb_array_real_gain_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% pcb_array_ideal_gain_azimuth_broadside = patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
% pcb_arf_azimuth_broadside = 2*arrayFactor(kfa,2.1e9,-180:180,0);
% pcb_arf_azimuth_broadside = (10.^((pcb_arf_azimuth_broadside)/20));
% pcb_gain_azimuth_broadside = 10.^((pcb_gain_azimuth_broadside-2.13)/10);
% Gt_azimuth_broadside = etaT*pcb_gain_azimuth_broadside.*(pcb_arf_azimuth_broadside.^2/dot(chebc,chebc)); 
% Gt_azimuth_broadside = 10*log10(Gt_azimuth_broadside);
% 
% 
% figure;
% pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% figure;
% patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
% figure;
% polarpattern(Gt_azimuth_broadside); 
% figure;
% polarpattern(pcb_array_real_gain_azimuth_broadside);
% hold on
% polarpattern(pcb_array_ideal_gain_azimuth_broadside);
% figure; 
% polarpattern(pcb_array_ideal_gain_azimuth_broadside);
% hold on 
% polarpattern(Gt_azimuth_broadside);
% 
% % ELEVATION 
% pcb_gain_elevation_broadside = pattern(dotchy,2.1e9,0,-180:180,'Type','gain');
% pcb_array_real_gain_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','gain');
% pcb_array_ideal_gain_elevation_broadside = patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
% pcb_arf_elevation_broadside = 2*arrayFactor(kfa,2.1e9,0,-180:180);
% pcb_arf_elevation_broadside = (10.^((pcb_arf_elevation_broadside)/20));
% pcb_gain_elevation_broadside = 10.^((pcb_gain_elevation_broadside-2.13)/10);
% Gt_elevation_broadside = etaT*pcb_gain_elevation_broadside.*(pcb_arf_elevation_broadside.^2/dot(chebc,chebc)); 
% Gt_elevation_broadside = 10*log10(Gt_elevation_broadside);
% 
% figure;
% pattern(kfa,2.1e9,0,-180:180,'Type','gain');
% figure;
% patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
% figure;
% polarpattern(Gt_elevation_broadside); 
% figure;
% polarpattern(pcb_array_real_gain_elevation_broadside);
% hold on
% polarpattern(pcb_array_ideal_gain_elevation_broadside);
% figure;
% polarpattern(pcb_array_ideal_gain_elevation_broadside);
% hold on
% polarpattern(Gt_elevation_broadside);



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
EH_90_center = EHfields(kfa,2.1e9,pfresnel_broadside);

% gain_broadside = phased.ArrayGain('SensorArray',tcheB);
% pifa_array_gain_azimuth_broadside=gain_broadside(2.1e9,[-180:180;zeros(1,361)]);
% pifa_array_gain_elevation_broadside=gain_broadside(2.1e9,[zeros(1,181);-90:90]);
% pcb_array_gain_azimuth_broadside = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% pcb_array_gain_elevation_broadside = pattern(kfa,2.1e9,0,-180:180,'Type','gain');

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
% pcb_array_azimuth_steering_45 = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
% pcb_array_azimuth_steering_45 = pcb_array_azimuth_steering_45';
% pcb_array_elevation_steering_45 = pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
% 
% % PIFAs
% pifa_array_azimuth_steering_45 = patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
% pifa_array_elevation_steering_45 = patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 
% 
% % SINGLE 2D PLOTS
% figure;
% pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
% figure;
% pattern(kfa,2.1e9,0,-180:180,'Type','directivity');
% figure;
% patternAzimuth(tcheB,2.1e9,0,'Type','directivity','weights',w);
% figure;
% patternElevation(tcheB,2.1e9,0,'Type','directivity','weights',w); 
% 
% % COMPARED 2D PLOTS 
% figure; 
% polarpattern(pcb_array_azimuth_steering_45);
% hold on
% polarpattern(pifa_array_azimuth_steering_45); 
% 
% figure; 
% polarpattern(pcb_array_elevation_steering_45);
% hold on
% polarpattern(pifa_array_elevation_steering_45);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% REAL/IDEAL GAIN PATTERNS %%%%%%%%%%%
%%%%%% ACTUALLY ONLY DIRECTIVITY %%%%%%%%%%
%%%%%% WITH patternMultiply %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pcb_array_real_gain_azimuth_steering_45 = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% pcb_array_ideal_gain_azimuth_steering_45 = patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
% 
% figure;
% pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% figure;
% patternMultiply(kfa,2.1e9,-180:180,0,'Type','gain');
% figure;
% polarpattern(pcb_array_real_gain_azimuth_steering_45);
% hold on
% polarpattern(pcb_array_ideal_gain_azimuth_steering_45);
% 
% % ELEVATION 
% pcb_array_real_gain_elevation_steering_45 = pattern(kfa,2.1e9,0,-180:180,'Type','gain');
% pcb_array_ideal_gain_elevation_steering_45 = patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
% 
% figure;
% pattern(kfa,2.1e9,0,-180:180,'Type','gain');
% figure;
% patternMultiply(kfa,2.1e9,0,-180:180,'Type','gain');
% figure;
% polarpattern(pcb_array_real_gain_elevation_steering_45);
% hold on
% polarpattern(pcb_array_ideal_gain_elevation_steering_45);

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
EH_center_45 = EHfields(kfa,2.1e9,pfresnel_steering_45);

% gain_45 = phased.ArrayGain('SensorArray',tcheB,'WeightsInputPort',true);
% pifa_array_gain_azimuth_45 = gain_45(2.1e9,[-180:180 ; zeros(1,361)],w);
% pifa_array_gain_elevation_45 = gain_45(2.1e9,[zeros(1,181);-90:90],w);
% 
% pcb_array_gain_azimuth_45 = pattern(kfa,2.1e9,-180:180,0,'Type','gain');
% pcb_array_gain_elevation_45 = pattern(kfa,2.1e9,0,-180:180,'Type','gain');


% E and H vectors evaluated in specific points 
Ec90 = EH_90_center(1,:);
Hc90 = EH_90_center(2,:);
Ec45 = EH_center_45(1,:);
Hc45 = EH_center_45(2,:);
nEc90 = [abs(Ec90(1)) abs(Ec90(2)) abs(Ec90(3)) abs(Ec90(4)) abs(Ec90(5))];
nHc90 = [abs(Hc90(1)) abs(Hc90(2)) abs(Hc90(3)) abs(Hc90(4)) abs(Hc90(5))];
nEc45 = [abs(Ec45(1)) abs(Ec45(2)) abs(Ec45(3)) abs(Ec45(4)) abs(Ec45(5))];
nHc45 = [abs(Hc45(1)) abs(Hc45(2)) abs(Hc45(3)) abs(Hc45(4)) abs(Hc45(5))];
%%
[pk_pifa_array_azimuth_broadside pk_pifa_array_azimuth_broadside_index]=findpeaks(pifa_array_azimuth_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pifa_array_azimuth_broadside=sort(pk_pifa_array_azimuth_broadside,'descend');
sort_pifa_array_azimuth_broadside=pk_pifa_array_azimuth_broadside;
pk_ML_pifa_array_azimuth_broadside=sort_pifa_array_azimuth_broadside(1);
pk_SL_pifa_array_azimuth_broadside=sort_pifa_array_azimuth_broadside(3);

[pk_pcb_array_azimuth_broadside pk_pcb_array_azimuth_broadside_index]=findpeaks(pcb_array_azimuth_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pcb_array_azimuth_broadside=sort(pk_pcb_array_azimuth_broadside,'descend');
sort_pcb_array_azimuth_broadside=pk_pcb_array_azimuth_broadside;
pk_ML_pcb_array_azimuth_broadside=sort_pcb_array_azimuth_broadside(1);
pk_SL_pcb_array_azimuth_broadside=pcb_array_azimuth_broadside(pk_pifa_array_azimuth_broadside_index(3));

ER_ML_pcb_pifa_azimuth_broadside=pk_ML_pifa_array_azimuth_broadside-pk_ML_pcb_array_azimuth_broadside;
ER_SL_pcb_pifa_azimuth_broadside=pk_SL_pifa_array_azimuth_broadside-pk_SL_pcb_array_azimuth_broadside;
disp(strcat('Error ML azimuth broadside: '," ",string(ER_ML_pcb_pifa_azimuth_broadside)));
disp(strcat('Error SL azimuth broadside: '," ",string(ER_SL_pcb_pifa_azimuth_broadside)));

ERP_ML_pcb_pifa_azimuth_broadside=(pk_ML_pifa_array_azimuth_broadside-pk_ML_pcb_array_azimuth_broadside)/pk_ML_pifa_array_azimuth_broadside;
ERP_SL_pcb_pifa_azimuth_broadside=(pk_SL_pifa_array_azimuth_broadside-pk_SL_pcb_array_azimuth_broadside)/pk_SL_pifa_array_azimuth_broadside;
disp(strcat('Error % ML azimuth broadside: '," ",string(ERP_ML_pcb_pifa_azimuth_broadside)));
disp(strcat('Error % SL azimuth broadside: '," ",string(ERP_SL_pcb_pifa_azimuth_broadside)));
disp(" ")

[pk_pifa_array_elevation_broadside pk_pifa_array_elevation_broadside_index]=findpeaks(pifa_array_elevation_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pifa_array_elevation_broadside=sort(pk_pifa_array_elevation_broadside,'descend');
sort_pifa_array_elevation_broadside=pk_pifa_array_elevation_broadside;
pk_ML_pifa_array_elevation_broadside=sort_pifa_array_elevation_broadside(1);
pk_SL_pifa_array_elevation_broadside=sort_pifa_array_elevation_broadside(3);

[pk_pcb_array_elevation_broadside pk_pcb_array_elevation_broadside_index]=findpeaks(pcb_array_elevation_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pcb_array_elevation_broadside=sort(pk_pcb_array_elevation_broadside,'descend');
sort_pcb_array_elevation_broadside=pk_pcb_array_elevation_broadside;
pk_ML_pcb_array_elevation_broadside=sort_pcb_array_elevation_broadside(1);
pk_SL_pcb_array_elevation_broadside=pcb_array_elevation_broadside(pk_pifa_array_elevation_broadside_index(3));

ER_ML_pcb_pifa_elevation_broadside=pk_ML_pifa_array_elevation_broadside-pk_ML_pcb_array_elevation_broadside;
ER_SL_pcb_pifa_elevation_broadside=pk_SL_pifa_array_elevation_broadside-pk_SL_pcb_array_elevation_broadside;
disp(strcat('Error ML elevation broadside: '," ",string(ER_ML_pcb_pifa_elevation_broadside)));
disp(strcat('Error SL elevation broadside: '," ",string(ER_SL_pcb_pifa_elevation_broadside)));

ERP_ML_pcb_pifa_elevation_broadside=(pk_ML_pifa_array_elevation_broadside-pk_ML_pcb_array_elevation_broadside)/pk_ML_pifa_array_elevation_broadside;
ERP_SL_pcb_pifa_elevation_broadside=(pk_SL_pifa_array_elevation_broadside-pk_SL_pcb_array_elevation_broadside)/pk_SL_pifa_array_elevation_broadside;
disp(strcat('Error % ML elevation broadside: '," ",string(ERP_ML_pcb_pifa_elevation_broadside)));
disp(strcat('Error % SL elevation broadside: '," ",string(ERP_SL_pcb_pifa_elevation_broadside)));

%
disp(" ")
[pk_pifa_array_azimuth_steering_45 pk_pifa_array_azimuth_steering_45_index]=findpeaks(pifa_array_azimuth_steering_45,'MinPeakWidth',6,'SortStr','descend');
%sort_pifa_array_azimuth_steering_45=sort(pk_pifa_array_azimuth_steering_45,'descend');
sort_pifa_array_azimuth_steering_45=pk_pifa_array_azimuth_steering_45;
pk_ML_pifa_array_azimuth_steering_45=sort_pifa_array_azimuth_steering_45(1);
pk_SL_pifa_array_azimuth_steering_45=sort_pifa_array_azimuth_steering_45(5);

pk_pcb_array_azimuth_steering_45=findpeaks(pcb_array_azimuth_steering_45,'MinPeakWidth',6);
sort_pcb_array_azimuth_steering_45=sort(pk_pcb_array_azimuth_steering_45,'descend');
pk_ML_pcb_array_azimuth_steering_45=sort_pcb_array_azimuth_steering_45(1);
pk_SL_pcb_array_azimuth_steering_45=pcb_array_azimuth_steering_45(pk_pifa_array_azimuth_steering_45_index(5));

ER_ML_pcb_pifa_azimuth_steering_45=pk_ML_pifa_array_azimuth_steering_45-pk_ML_pcb_array_azimuth_steering_45;
ER_SL_pcb_pifa_azimuth_steering_45=pk_SL_pifa_array_azimuth_steering_45-pk_SL_pcb_array_azimuth_steering_45;
disp(strcat('Error ML azimuth steering 45: '," ",string(ER_ML_pcb_pifa_azimuth_steering_45)));
disp(strcat('Error SL azimuth steering 45: '," ",string(ER_SL_pcb_pifa_azimuth_steering_45)));

ERP_ML_pcb_pifa_azimuth_steering_45=(pk_ML_pifa_array_azimuth_steering_45-pk_ML_pcb_array_azimuth_steering_45)/pk_ML_pifa_array_azimuth_steering_45;
ERP_SL_pcb_pifa_azimuth_steering_45=(pk_SL_pifa_array_azimuth_steering_45-pk_SL_pcb_array_azimuth_steering_45)/pk_SL_pifa_array_azimuth_steering_45;
disp(strcat('Error % ML azimuth steering 45: '," ",string(ERP_ML_pcb_pifa_azimuth_steering_45)));
disp(strcat('Error % SL azimuth steering 45: '," ",string(ERP_SL_pcb_pifa_azimuth_steering_45)));
disp(" ")

[pk_pifa_array_elevation_steering_45 pk_pifa_array_elevation_steering_45_index]=findpeaks(pifa_array_elevation_steering_45,'MinPeakWidth',6);
%sort_pifa_array_elevation_steering_45=sort(pk_pifa_array_elevation_steering_45,'descend');
sort_pifa_array_elevation_steering_45=pk_pifa_array_elevation_steering_45;
pk_ML_pifa_array_elevation_steering_45=sort_pifa_array_elevation_steering_45(1);
pk_SL_pifa_array_elevation_steering_45=sort_pifa_array_elevation_steering_45(5);

pk_pcb_array_elevation_steering_45=findpeaks(pcb_array_elevation_steering_45,'MinPeakWidth',6);
sort_pcb_array_elevation_steering_45=sort(pk_pcb_array_elevation_steering_45,'descend');
pk_ML_pcb_array_elevation_steering_45=sort_pcb_array_elevation_steering_45(1);
pk_SL_pcb_array_elevation_steering_45=pcb_array_elevation_steering_45(pk_pifa_array_elevation_steering_45_index(5));

ER_ML_pcb_pifa_elevation_steering_45=pk_ML_pifa_array_elevation_steering_45-pk_ML_pcb_array_elevation_steering_45;
ER_SL_pcb_pifa_elevation_steering_45=pk_SL_pifa_array_elevation_steering_45-pk_SL_pcb_array_elevation_steering_45;
disp(strcat('Error ML elevation steering 45: '," ",string(ER_ML_pcb_pifa_elevation_steering_45)));
disp(strcat('Error SL elevation steering 45: '," ",string(ER_SL_pcb_pifa_elevation_steering_45)));

ERP_ML_pcb_pifa_elevation_steering_45=(pk_ML_pifa_array_elevation_steering_45-pk_ML_pcb_array_elevation_steering_45)/pk_ML_pifa_array_elevation_steering_45;
ERP_SL_pcb_pifa_elevation_steering_45=(pk_SL_pifa_array_elevation_steering_45-pk_SL_pcb_array_elevation_steering_45)/pk_SL_pifa_array_elevation_steering_45;
disp(strcat('Error % ML elevation steering 45: '," ",string(ERP_ML_pcb_pifa_elevation_steering_45)));
disp(strcat('Error % SL elevation steering 45: '," ",string(ERP_SL_pcb_pifa_elevation_steering_45)));
%% Azimuth array factor plot

af_azimuth_polar = 2*arrayFactor(kfa,2.1e9,-180:180,0);
figure;polarpattern(af_azimuth_polar,'TitleTop','pcb array factor with arrayFactor()');
figure;plot(-180:180,af_azimuth_polar);title('pcb array factor with arrayFactor()');

pat_dotchy_az = pattern(dotchy,2.1e9,-180:180,0,'Type','directivity');
pat_kfa_az = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
Df_az = 10.^((pat_kfa_az-pat_dotchy_az)/10);
F = sqrt(Df_az*(dot(chebc,chebc)/0.79));
Fn = sqrt(Df_az*(dot(chebn,chebn)/0.79));
FdB = 20*log10(Fn);
figure; 
polarpattern(FdB,'TitleTop','pcb array factor with mathematics'); 
figure;plot(-180:180,FdB);title('pcb array factor with mathematics');

figure;polarpattern(af_azimuth_polar);
hold on
polarpattern(FdB,'TitleTop','pcb array factor Toolbox vs mathematics','LineStyle',{'-','--'},'LegendLabels',{'ToolBox', 'Calculated'}); 
hold off

figure;plot(-180:180,af_azimuth_polar);
hold on
plot(-180:180,FdB,'LineStyle','--');
title('pcb array factor Toolbox vs mathematics');
legend('ToolBox', 'Calculated');
hold off

%% Elevation array factor plot


af_elevation_polar = 2*arrayFactor(kfa,2.1e9,-180:180,0);
figure;polarpattern(af_elevation_polar,'TitleTop','pcb array factor with arrayFactor()');
figure;plot(-180:180,af_elevation_polar);title('pcb array factor with arrayFactor()');

pat_dotchy_el = pattern(dotchy,2.1e9,-180:180,0,'Type','directivity');
pat_kfa_el = pattern(kfa,2.1e9,-180:180,0,'Type','directivity');
Df_az = 10.^((pat_kfa_el-pat_dotchy_el)/10);
F = sqrt(Df_az*(dot(chebc,chebc)/0.79));
Fn = sqrt(Df_az*(dot(chebn,chebn)/0.79));
FdB = 20*log10(Fn);
figure; 
polarpattern(FdB,'TitleTop','pcb array factor with mathematics'); 
figure;plot(-180:180,FdB);title('pcb array factor with mathematics');

figure;polarpattern(af_elevation_polar);
hold on
polarpattern(FdB,'TitleTop','pcb array factor Toolbox vs mathematics','LineStyle',{'-','--'},'LegendLabels',{'ToolBox', 'Calculated'}); 
hold off

figure;plot(-180:180,af_elevation_polar);
hold on
plot(-180:180,FdB,'LineStyle','--');
title('pcb array factor Toolbox vs mathematics');
legend('ToolBox', 'Calculated');
hold off

%% save workspace
% save('myworkspace.mat')
%
%
%
%