% Dark field microscopy module using rDHM.
% P. Asgari and Y. Pourvais, July 2015.
%% Inspired from ASP_NF_GUI
warning off;

HH=findobj(gcf,'Tag','E1');
lambda=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E2');
dpix_x=str2num(get(HH,'String'));

HH=findobj(gcf,'Tag','E3');
dpix_y=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E4');
dist=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E5');
br=str2num(get(HH,'String')); 

%%
r=5;
[M,N]=size(h_fft1);
figure;imagesc(log(abs(h_fft1))); colormap gray; 
axis([fix(N/2-100) fix(N/2+100) fix(M/2-100) fix(M/2+100)]);
title('select the DC spot radius')
AA=ginput(1);
% xdc=AA(1,1);
% ydc=AA(1,2);
xdc=N/2;
ydc=M/2;
r=(xdc-AA(1,1)).^2+(ydc-AA(1,2));
r=sqrt(r);

[XX,YY]=meshgrid(1:size(h_fft1,2),1:size(h_fft1,1));
F=double((XX-xdc).^2+(YY-ydc).^2>r^2);
%% Inspired from rec_ASP_rect_NF_GUI
si=size(h_fft1);
s1=si(1);
s2=si(2);
NA1=abs(lambda/dpix_x)/2;
NA2=abs(lambda/dpix_y)/2;
z1=dist;
[c1_2,holo,ho_re]=ASP_prop_fun_different_xy(h_fft1,z1,lambda,s1,s2,NA1,NA2);   %sub-program for diffraction integral using ASP
%%


Filtered_Spectrum=ho_re.*F;
figure;imagesc(log(abs(Filtered_Spectrum))); colormap gray;
title('Filtered Spectrum')

I_DFM=(fft2(fftshift(Filtered_Spectrum))); %inspired from: ASP_prop_fun_different_xy
I_DFM=I_DFM.*conj(I_DFM);
I_DFM=(I_DFM*br/max(max(I_DFM)));

figure;imshow(abs(I_DFM)); colormap gray;title('Dark Field Image')