%Selecting desired portions of angular spectrum using a rectangular window 
%Arun Anand, last modified 06-06-2010
%Last modified by Y. Pourvais and P. Asgari, July 2015;

%close all;
clear all;
[fn, pn]=uigetfile('*.bmp','Load hologram');
vv1=[pn,fn];
X=(imread(vv1));

h64 = double(X)+1;
tm=size(h64);
sx=max(tm);
pnew=sx;

h1 = h64;
s=size(h1);

xc=round(tm(1)/2)+1;
yc=round(tm(2)/2)+1;
xd=round(tm(1)/2);
yd=round(tm(2)/2);
h2=h1;

figure(1);
h_fft1=(fftshift(fft2(h2)));
gg2a=abs(h_fft1);
imshow(log(gg2a+1),[]);
title('Spectrum');


[xi yi]=ginput(2);
% x1=round(xi(1));
% x2=round(xi(2));
% y1=round(yi(1));
% y2=round(yi(2));

xm=round(xi(1));
x2=round(xi(2));
ym=round(yi(1));
y2=round(yi(2));

x1=x2-2*(x2-xm);
y1=y2-2*(y2-ym);
dx=x2-x1;
dy=y2-y1;

if mod(dx,2)==0
    x2=x2+1;
end;

if mod(dy,2)==0
    y2=y2+1;
end;

dx=x2-x1;
dy=y2-y1;

% %% this is to put the center of the spot on the center of the crop area:
% [m,ym]=max(gg2a(y1:y2,x1:x2));
% ym=ym(1)+y1-1;
% [m,xm]=max(max(gg2a(y1:y2,x1:x2)));
% xm=xm+x1-1;
% clear m
% 
% x1=xm-dx/2+1/2;
% y1=ym-dy/2+1/2;
% x2=xm+dx/2-1/2;
% y2=ym+dy/2-1/2;
% 
% dx=x2-x1;
% dy=y2-y1;
% %%

h_fft2=h_fft1(y1:y2,x1:x2);

%a2=zeros(pnew);
a2=zeros(tm(1),tm(2));
ax=floor(dx/2);
ay=floor(dy/2);
a2(xc-ay:xc+ay+1, yc-ax:yc+ax+1)=h_fft2;
h_fft1=a2;
gg2a=abs(h_fft1);
figure(2);
imshow(log(gg2a+1),[]);
title('Filtered and shifted spectrum');