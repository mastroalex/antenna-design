# Design of folded patch

**Wireless Electromagnetic Technologies**  - University of Rome Tor Vergata

<p align="center">
<img src="https://www.baicr.it/wp-content/uploads/2017/06/Logo_Tor_Vergata-1.png" alt="Tor Vergata" style="width:10%; border:0;">
</p>


> Blasi Luca<br>
> Mastrofini Alessandro<br>
> Mucenica Leonard Stefan

## Abstract 
 
The latest developments in Computer Aided Engineering, by means of the remarkable progress that several softwares have been made in terms of computational speed and of enlarged ranges of phaenomena that can be simulated and accurately analyzed, represent an immense span to inventiveness. For this particular instance, it is also a great opportunity for who wants to reach or already has an expertise in the Antenna Design field. In this article, among a vast amount of possibilities, some of the Matlab toolboxes dedicated to antenna designing have been adopted in such a way as to create the structure of a coaxial-fed folded patch antenna combined with a low performance dielectric substrate (i.e. FR4). The main purpose was to obtain an antenna resonating at 2.1 GHz and with an input impedance matched at 50 Ohms. Subsequently, this designed radiating object has been introduced in a broader structure, that is a linear array of five antennas, as its representative single element. The Tchebyshev array synthesis has been used in order to reach particular design and radiating behaviour. Specifically, the beam- steering in the broadside and at 45◦ off the boresight direction have been analyzed by means of the overall gain and the electric and magnetic field behaviour close and far from the array. All the mathematical models which have been used together with the software feedback represent the structure of an overall process of development, optimization and analysis which have been very carefully performed and shown in the following paragraphs.

> ❗️ **Read full [report](https://github.com/mastroalex/antenna-design/blob/main/report.pdf)** .

---
# Design

Read more on report. 

Read `Methods` for single function analyze. 

Complete file: [final_wet_project.m](https://github.com/mastroalex/antenna-design/blob/main/final_wet_project.m) .

```matlab
% load('myworkspace.mat')
addpath(strcat(pwd,'/functions')); %load function from subfolder
%clear all
load(strcat(pwd,'/data_and_calculations/antenna_variables.mat'))
p=design_my_pifa(L,W,h); 
my_pifa_plot(p,f);
refinement_time=refine_mesh_test(p,f);
refinement_time2=refine_mesh_test2(p,f);
refinement_time3=refine_mesh_f(p,f);
impedance_match(p,f,L,lfeed);
contourTime=find_and_contour(p,lambda0,k0,h,f);
tcheB=design_my_pifa_array(p);
calc_and_plot_array_factor_pifa(p,chebc,chebn,tcheB,w);
[dotchy,kfa]=design_my_pcb_array(L,W);
compare_arrays_plot(kfa,tcheB,w);
my_gain_pattern(kfa,dotchy,chebc);
my_field(kfa);
steering_array(kfa,Frequency,dopt,tcheB,PropagationSpeed,PhaseShiftBits)
my_gain_pattern_45(kfa_ster,w_ster,tcheB)
my_field_45(kfa_ster,dopt,fre,fraun,lambda0)
my_field_single_point(EH_90_center,EH_center_45)
time_data=[array_pcb_pattern_time, array_pifa_pattern_time ; pcb_pattern_time, pifa_pattern_time; pcb_sparameters_time, pifa_sparameters_time ];
figure;
bar(categorical({'array pattern','antenna pattern','sparameters'}),time_data)
legend('PCB','PIFA')
ylabel('time(s)')
pattern_error(pifa_array_azimuth_broadside,pcb_array_azimuth_broadside,...
    pifa_array_elevation_broadside, pcb_array_elevation_broadside,...
    pifa_array_azimuth_steering_45, pcb_array_azimuth_steering_45,...
    pifa_array_elevation_steering_45, pcb_array_elevation_steering_45)
my_array_factor(kfa,dotchy,chebc,chebn)

```
--- 

## Patch 
<p align="center">
<img src="https://github.com/mastroalex/antenna-design/blob/main/Report/figures/gain_patch2.png" alt="Patch" style="width:40%; border:0;">
</p>

## Array
<p align="center">
<img src="https://github.com/mastroalex/antenna-design/blob/main/Report/figures/array.svg" alt="Array" style="width:90%; border:0;">
</p>

# Requirements

<details>
  <summary><b> Project parameters </b></summary>
  <br/>

## A. Design a Tchebyshev array factor of five elements with a main lobe / side lobe ratio of R=120. Optimize the inter-element spacing to minimize the beamwidth
1.	Determine the current coefficients (normalized to maximum)
2.	Evaluate the array tapering efficiency.
3.	Evaluate the beamwidth of the array factor and compare with a uniform array
4.	Plot the array pattern (rectangular and polar diagrams)


## B. Design a rectangular folded (λ/4) patch fed by a coaxial cable for (2.0+n0.1) GHz , whose size is compatible with the inter-antenna distance derived above
1.	Use the FR-4 Substrate (available thickness: { 0.8, 1.0, 1.6) mm)
2.	Evaluate by equations the size (L, W), directivity, BW, position of the feed to match 50 ohm.
3.	Refinement with Matlab MoM. Plot currents, impedances, reflection coefficient and gain patterns.

## C. Evaluate the performance of the overall array of patches in both broadside case and 45° off the boresight direction (PSI= 90°-45°)
1.	Identify phase coefficients for beam-steering
2.	Compute and plot the total array gain by using the pattern multiplication principle
3.	Compute and plot the total array gain by mean of a fullwave model of the array with Matlab MoM.
4.	Plot of the near field just over the array plane to analyze the fringing field from the edges and observe possible non-uniformity due to the inter-antenna coupling.


</details>  
