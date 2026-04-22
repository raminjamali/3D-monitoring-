HH=findobj(gcf,'Tag','E20');
lam=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E21');
dpix=str2num(get(HH,'String'));

HH=findobj(gcf,'Tag','E22');
Dn=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E23');
ML=str2num(get(HH,'String')); 

h1=u1*lam/(2*pi*Dn);

[sxh1 syh1]=size(h1);

ac1=[0:sxh1-1]*dpix/ML;
ac2=[0:syh1-1]*dpix/ML;
for ii=1:syh1
    ad1(:,ii)=ac1;
end;

for ii=1:sxh1
    ad2(ii,:)=ac2;
end;


figure(21);
mesh(ad2,ad1,h1);
%shading interp;
colormap gray