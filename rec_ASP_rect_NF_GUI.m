%propagation of the object wavefronts 
%Arun Anand, last modified 06-06-2010.

h64 = double(X) + 1;
h1 = h64;
s=size(h1);

h2=h1;
h_fft1=(fftshift(fft2(h2)));
gg2a=abs(h_fft1);
h_fft2=h_fft1(y1:y2,x1:x2);

a2=zeros(tm(1),tm(2));
a2(xc-ay:xc+ay+1, yc-ax:yc+ax+1)=h_fft2;
h_fft1=a2;
gg2a=abs(h_fft1);

si=size(h_fft1);
s1=si(1);
s2=si(2);
NA1=abs(lambda/dpix_x)/2;
NA2=abs(lambda/dpix_y)/2;
z1=dist;
[c1_2,holo]=ASP_prop_fun_different_xy(h_fft1,z1,lambda,s1,s2,NA1,NA2);   %sub-program for diffraction integral using ASP

ph0yy=angle(c1_2);    