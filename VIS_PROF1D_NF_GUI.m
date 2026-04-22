mline_out=0;
clear mline_out;
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
ac2=[0:syh1-1]'*dpix/ML;
for ii=1:syh1
    ad1(:,ii)=ac1;
end;

for ii=1:sxh1
    ad2(ii,:)=ac2;
end;


figure(23);
imagesc(h1);
colormap gray;
title('Select the line (Click at begining and end)');
[xx,yy]=ginput(2);
xa=round(xx(1));
ya=round(yy(1));
xb=round(xx(2));
yb=round(yy(2));
ms=(yb-ya)/(xb-xa);
Cs=ya-ms*xa;

ele1=abs(xb-xa);
ele2=abs(yb-ya);
kk=0;
h1a=h1;


if abs(ms)<=1;
    for ii=1:ele1
        xi=xa+kk;
        yi=round(ms*xi+Cs);
        h2=h1(yi,xi);
        d1=sqrt(xi^2+yi^2)*dpix/ML;
        mline_out(ii,1)=xi*dpix/ML;
        mline_out(ii,2)=yi*dpix/ML;
        mline_out(ii,3)=d1;
        mline_out(ii,4)=h2;
        h1a(yi,xi)=0;
        kk=kk+1;
    end;

    figure(23)
    imagesc(h1a);

    figure(24)
    plot(mline_out(:,1),mline_out(:,4));
    title('height profile along the line in Figure 23');
    xlabel('distance (m)');
    ylabel('height (m)');
end;
    

if abs(ms)>1;
    for ii=1:ele2
        yi=ya+kk;
        xi=round((yi-Cs)/ms);
        h2=h1(yi,xi);
        d1=sqrt(xi^2+yi^2)*dpix/ML;
        mline_out(ii,1)=xi*dpix/ML;
        mline_out(ii,2)=yi*dpix/ML;
        mline_out(ii,3)=d1;
        mline_out(ii,4)=h2;
        h1a(yi,xi)=0;
        kk=kk+1;
    end;

    figure(23)
    imagesc(h1a);
    
    figure(24)
    clf;
    plot(mline_out(:,3),mline_out(:,4));
    title('height profile along the line in Figure 23');
    xlabel('distance (m)');
    ylabel('height (m)');
end;
pause;
[xx,yy]=ginput(2);
dyy=yy(1)-yy(2);
title(['height=',num2str(dyy)]);
dyy    
