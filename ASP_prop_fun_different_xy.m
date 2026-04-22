%ASP integral
%Arun Anand, last modified 06-06-2010

function [gg1,holo,ho_re]=conv_prop_fun(fftci1,dd,lambda,s1,s2,NA1,NA2);

ij=sqrt(-1);
s=size(fftci1);
s12=(round(s1/2));
s22=(round(s2/2));

k=2*pi/lambda;

x=linspace(-NA1,NA1,s2);
y=(linspace(-NA1,NA1,s1))';

X=x'*(ones(size(y.')));
X=X.';
Y=(y*(ones(size(x))))';
Y=Y.';
clear x y
clear x y
holo=X;
lambda2=lambda^2;
fact1=-ij*k*dd;

for i=1:s1
   for j=1:s2
      fr=fact1*((sqrt(1-(X(i,j))^2-(Y(i,j))^2)));
      holo(i,j)=exp(fr);
    end
 end

ho_re=fftci1.*holo;
gg1=(fft2(fftshift(ho_re)));