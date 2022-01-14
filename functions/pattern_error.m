function pattern_error(pifa_array_azimuth_broadside,pcb_array_azimuth_broadside,pifa_array_elevation_broadside,pcb_array_elevation_broadside,pifa_array_azimuth_steering_45,pcb_array_azimuth_steering_45,pifa_array_elevation_steering_45,pcb_array_elevation_steering_45)

min1=min(pifa_array_azimuth_broadside);
min2=min(pcb_array_azimuth_broadside);
min3=min(pifa_array_elevation_broadside);
min4=min(pcb_array_elevation_broadside);

min5=min(pifa_array_azimuth_steering_45);
min6=min(pcb_array_azimuth_steering_45);
min7=min(pifa_array_elevation_steering_45);
min8=min(pcb_array_elevation_steering_45);

minimus=min([min1,min2,min3,min4,min5,min6,min7,min8]);
minimus=abs(minimus);
pifa_array_azimuth_broadside=pifa_array_azimuth_broadside+minimus;
pcb_array_azimuth_broadside=pcb_array_azimuth_broadside+minimus;
pifa_array_elevation_broadside=pifa_array_elevation_broadside+minimus;
pcb_array_elevation_broadside=pcb_array_elevation_broadside+minimus;
pifa_array_azimuth_steering_45=pifa_array_azimuth_steering_45+minimus;
pcb_array_azimuth_steering_45=pcb_array_azimuth_steering_45+minimus;
pifa_array_elevation_steering_45=pifa_array_elevation_steering_45+minimus;
pcb_array_elevation_steering_45=pcb_array_elevation_steering_45+minimus;




[pk_pifa_array_azimuth_broadside, pk_pifa_array_azimuth_broadside_index]=findpeaks(pifa_array_azimuth_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pifa_array_azimuth_broadside=sort(pk_pifa_array_azimuth_broadside,'descend');
sort_pifa_array_azimuth_broadside=pk_pifa_array_azimuth_broadside;
pk_ML_pifa_array_azimuth_broadside=sort_pifa_array_azimuth_broadside(1);
pk_SL_pifa_array_azimuth_broadside=sort_pifa_array_azimuth_broadside(3);

[pk_pcb_array_azimuth_broadside, pk_pcb_array_azimuth_broadside_index]=findpeaks(pcb_array_azimuth_broadside,'MinPeakDistance',6,'SortStr','descend');
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
disp(strcat('Error % ML azimuth broadside: '," ",string(ERP_ML_pcb_pifa_azimuth_broadside*100)," ",'%'));
disp(strcat('Error % SL azimuth broadside: '," ",string(ERP_SL_pcb_pifa_azimuth_broadside*100)," ",'%'));
disp(" ")

[pk_pifa_array_elevation_broadside, pk_pifa_array_elevation_broadside_index]=findpeaks(pifa_array_elevation_broadside,'MinPeakDistance',6,'SortStr','descend');
%sort_pifa_array_elevation_broadside=sort(pk_pifa_array_elevation_broadside,'descend');
sort_pifa_array_elevation_broadside=pk_pifa_array_elevation_broadside;
pk_ML_pifa_array_elevation_broadside=sort_pifa_array_elevation_broadside(1);
pk_SL_pifa_array_elevation_broadside=sort_pifa_array_elevation_broadside(3);

[pk_pcb_array_elevation_broadside, pk_pcb_array_elevation_broadside_index]=findpeaks(pcb_array_elevation_broadside,'MinPeakDistance',6,'SortStr','descend');
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
disp(strcat('Error % ML elevation broadside: '," ",string(ERP_ML_pcb_pifa_elevation_broadside*100)," ",'%'));
disp(strcat('Error % SL elevation broadside: '," ",string(ERP_SL_pcb_pifa_elevation_broadside*100)," ",'%'));

%
disp(" ")
[pk_pifa_array_azimuth_steering_45, pk_pifa_array_azimuth_steering_45_index]=findpeaks(pifa_array_azimuth_steering_45,'MinPeakWidth',6,'SortStr','descend');
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
disp(strcat('Error % ML azimuth steering 45: '," ",string(ERP_ML_pcb_pifa_azimuth_steering_45*100)," ",'%'));
disp(strcat('Error % SL azimuth steering 45: '," ",string(ERP_SL_pcb_pifa_azimuth_steering_45*100)," ",'%'));
disp(" ")

[pk_pifa_array_elevation_steering_45,pk_pifa_array_elevation_steering_45_index]=findpeaks(pifa_array_elevation_steering_45,'MinPeakWidth',6);
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
disp(strcat('Error % ML elevation steering 45: '," ",string(ERP_ML_pcb_pifa_elevation_steering_45*100)," ",'%'));
disp(strcat('Error % SL elevation steering 45: '," ",string(ERP_SL_pcb_pifa_elevation_steering_45*100)," ",'%'));

end