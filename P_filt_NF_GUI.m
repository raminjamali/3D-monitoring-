%Filter for phase
%Arun Anand, last modified 06-06-2010

HH=findobj(gcf,'Tag','E6');
aa=str2num(get(HH,'String'));

BB=sin(phase_in);
CC=cos(phase_in);
DD=(1/aa)*ones(aa,aa);
EE=conv2(BB,DD,'same');
FF=conv2(CC,DD,'same');
GG=FF+i.*EE;
Dph_2pi=angle(GG)+pi;
phdiff1=Dph_2pi/(2*pi);
figure(9)
imshow(phdiff1);
title('Filtered Phase difference');