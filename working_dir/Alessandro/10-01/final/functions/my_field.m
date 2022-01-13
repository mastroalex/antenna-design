function my_field(kfa)
lambda0 = 0.1428; 
dopt=0.0939;
assignin('base','dopt',dopt)

L_max = 4*dopt+0.0158; 

LL = linspace(-L_max/2,L_max/2,10);
[X,Y]=meshgrid(LL,LL); 
fre=0.62*sqrt((L_max)^3/lambda0);
fraun=2*L_max^2/lambda0;
assignin('base','fre',fre)
assignin('base','fraun',fraun)

pfraun_broadside=[X(:)';Y(:)';(fraun/2)*ones(1,numel(X))];
pfar_broadside=[X(:)';Y(:)';(4*fraun)*ones(1,numel(X))];
pfre_broadside=[X(:)';Y(:)';(fre/2)*ones(1,numel(X))];
subfigure(3,3,1);
EHfields(kfa,2.1e9,pfre_broadside);
title('pfre broadside')
subfigure(3,3,2);
EHfields(kfa,2.1e9,pfraun_broadside);
title('pfraun broadside')
subfigure(3,3,3);
EHfields(kfa,2.1e9,pfar_broadside);
title('pfar broadside')

Xsp = [-2*dopt -dopt 0 dopt 2*dopt];
Ysp = [0 0 0 0 0]; 
fre=0.62*sqrt((L_max)^3/lambda0);
pfresnel_broadside = [Xsp(:)';Ysp(:)';(fre/2)*ones(1,numel(Xsp))];
pfraunhofer_broadside = [Xsp(:)';Ysp(:)';(fraun/2)*ones(1,numel(Xsp))];
pfarfield_broadside = [Xsp(:)';Ysp(:)';(4*fraun)*ones(1,numel(Xsp))];
subfigure(3,3,4);
EHfields(kfa,2.1e9,pfresnel_broadside);
title('pfresnel broadside center')
%ylim([-0.15 0.15])
subfigure(3,3,5);
EHfields(kfa,2.1e9,pfraunhofer_broadside);
title('pfrau broadside center')
subfigure(3,3,6);
EHfields(kfa,2.1e9,pfarfield_broadside);
title('pfarfield broadside center')

EH_90_center = EHfields(kfa,2.1e9,pfresnel_broadside);
EH_90_center_fraun = EHfields(kfa,2.1e9,pfraunhofer_broadside);
EH_90_center_farf = EHfields(kfa,2.1e9,pfarfield_broadside);
assignin('base','EH_90_center',EH_90_center)
assignin('base','EH_90_center_fraun',EH_90_center_fraun)
assignin('base','EH_90_center_farf',EH_90_center_farf)


end