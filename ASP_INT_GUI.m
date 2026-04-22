%main program for dtermining the phase difference of two digital holograms
%using ASP integral
%Arun Anand, Last modified 06-06-2010

%%Inputting the holograms

HH=findobj(gcf,'Tag','E1');
lambda=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E2');
dpix_x=str2num(get(HH,'String'));

HH=findobj(gcf,'Tag','E3');
dpix_y=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E4');
dist=str2num(get(HH,'String')); 


[fn, pn]=uigetfile('*.bmp','Load hologram2');
vv2=[pn,fn];



X=(imread(vv1));
rec_ASP_rect_NF_GUI;           
phase1=ph0yy;
p1a=(phase1+pi)/(2*pi);
figure(6)
imshow(p1a(:,:,1));
colormap('gray');
title('Phase1');
    
X=(imread(vv2));
rec_ASP_rect_NF_GUI;           
phase2=ph0yy;
p2a=(phase2+pi)/(2*pi);
figure(7)
imshow(p2a);
colormap('gray');
title('Phase2');
    
dphase=phase1-phase2;   
    
for ii=1:tm(1)
    for jj=1:tm(2)
        if dphase(ii,jj)<0
            dphase(ii,jj)=dphase(ii,jj)+2*pi;
        end;
    end;
end;

phdiff=dphase/(2*pi);
figure(8)
imshow(phdiff);
colormap('gray');
title('phase difference');

phase_in=dphase;