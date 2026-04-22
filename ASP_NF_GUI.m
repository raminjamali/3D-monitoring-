%main program for dtermining the phase difference of two digital holograms using ASP integral.
%Arun Anand, Last modified 13-10-2007



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

X=(imread(vv1));
    
    
rec_ASP_rect_NF_GUI;           
phase1=ph0yy+pi;
    
p1a=(phase1/(2*pi));
figure(3);
colormap('gray');
imshow(p1a);
title('Phase distribution');
      
    
figure(4);
Object_inten=c1_2.*conj(c1_2);
m_inten=(Object_inten*br/max(max(Object_inten)));
imshow(m_inten);
title('Intensity distribution');