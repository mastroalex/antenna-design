function my_field_single_point(EH_90_center,EH_center_45)

% E and H vectors evaluated in specific points 
Ec90 = EH_90_center(1,:);
Hc90 = EH_90_center(2,:);
Ec45 = EH_center_45(1,:);
Hc45 = EH_center_45(2,:);
nEc90 = [abs(Ec90(1)) abs(Ec90(2)) abs(Ec90(3)) abs(Ec90(4)) abs(Ec90(5))];
nHc90 = [abs(Hc90(1)) abs(Hc90(2)) abs(Hc90(3)) abs(Hc90(4)) abs(Hc90(5))];
nEc45 = [abs(Ec45(1)) abs(Ec45(2)) abs(Ec45(3)) abs(Ec45(4)) abs(Ec45(5))];
nHc45 = [abs(Hc45(1)) abs(Hc45(2)) abs(Hc45(3)) abs(Hc45(4)) abs(Hc45(5))];
assignin('base','nEc90',nEc90)
assignin('base','nHc90',nHc90)
assignin('base','nEc45',nEc45)
assignin('base','nHc45',nHc45)

end