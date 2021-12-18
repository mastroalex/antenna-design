# antenna-design
 
 ## Test mesh optimization 
 
### 16/12

 Ho testato la mesh su 50 valori da 0.002 a 0.1 `MaxEdgeLength`.

```matlab
mesh_val=linspace(0.001,0.1,50); 
SS=zeros(1,length(mesh_val));
close all
for i=1:length(mesh_val)
mesh(p,'MaxEdgeLength',mesh_val(i));
S=sparameters(p,f);
SS(i)=abs(S.Parameters);
i %check iteration (very slow cycle)
name=strcat('mesh_',num2str(mesh_val(i)),'.pdf');
saveas(figure(i),name,'pdf'); %save open figure (be careful)
close all
end
figure()
plot(mesh_val,SS,'b-*') % plot and save results
saveas(figure(1),'S11','pdf');
```

Andando sotto a 0.002 da problemi `Out of memory`. 

[Mesh migliore](https://github.com/mastroalex/antenna-design/blob/main/Alessandro/16-12/mesh_fig/mesh_0.002.pdf)

[Risultato](https://github.com/mastroalex/antenna-design/blob/main/Alessandro/16-12/mesh_fig/S11.pdf):

Zona piatta quella tra 0.03 e 0.05 ? 
<p align="center">
<img src="https://github.com/mastroalex/antenna-design/blob/main/Alessandro/16-12/mesh_fig/S11.png" alt="Result" style="width:40%; border:0;">
</p>

Ho provato anche con 100 valori: [risultato](https://github.com/mastroalex/antenna-design/blob/main/Alessandro/16-12/mesh_fig_2/S11.pdf)

### 17,18/12

See [17,18/12 Readme](/17-12/README.md)

