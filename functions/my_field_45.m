function my_field_45(kfa,dopt,fre,fraun,lambda0)

L_max = 4*dopt+0.0158; 

LL = linspace(-L_max/2,L_max/2,10);
[X,Y]=meshgrid(LL,LL); 
%fre=0.62*sqrt((L_max)^3/lambda0);
pfre_steering_45=[X(:)';Y(:)';(fre/2)*ones(1,numel(X))];
pfraun_steering_45=[X(:)';Y(:)';(fraun/2)*ones(1,numel(X))];
pfar_steering_45=[X(:)';Y(:)';(4*fraun)*ones(1,numel(X))];
subfigure(3,3,1);
EHfields(kfa,2.1e9,pfre_steering_45);
title('pfre steering 45')
subfigure(3,3,2);
EHfields(kfa,2.1e9,pfraun_steering_45);
title('pfraun steering 45')
subfigure(3,3,3);
EHfields(kfa,2.1e9,pfar_steering_45)
title('pfar field steering 45')


Xsp = [-2*dopt -dopt 0 dopt 2*dopt];
Ysp = [0 0 0 0 0]; 
% fre=0.62*sqrt((L_max)^3/lambda0);
pfresnel_steering_45 = [Xsp(:)';Ysp(:)';(fre/2)*ones(1,numel(Xsp))];
pfraunhofer_steering_45 = [Xsp(:)';Ysp(:)';(fraun/2)*ones(1,numel(Xsp))];
pfarfield_steering_45 = [Xsp(:)';Ysp(:)';4*fraun*ones(1,numel(Xsp))];
subfigure(3,3,4);
EHfields(kfa,2.1e9,pfresnel_steering_45);
title('pfre steering 45 center')
subfigure(3,3,5);
EHfields(kfa,2.1e9,pfraunhofer_steering_45);
title('pfraun steering 45 center')
subfigure(3,3,6);
EHfields(kfa,2.1e9,pfarfield_steering_45);
title('pfar field steering 45 center')

EH_center_45 = EHfields(kfa,2.1e9,pfresnel_steering_45);
EH_center_45_fraunhofer = EHfields(kfa,2.1e9,pfraunhofer_steering_45);
EH_center_45_farfield = EHfields(kfa,2.1e9,pfarfield_steering_45);
assignin('base','EH_center_45',EH_center_45)
assignin('base','EH_center_45_fraunhofer',EH_center_45_fraunhofer)
assignin('base','EH_center_45_farfield',EH_center_45_farfield)

end