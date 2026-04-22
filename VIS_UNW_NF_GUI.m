u1=0; h1=0;ac1=0;ac2=0;ad1=0;ad2=0;
clear u1 h1 ac1 ac2 ad1 ad2;
[fn, pn]=uigetfile('*.tif','Load hologram2');
namef=[pn,fn];

u1=-unwrap_Gold2_1(namef);
figure(20);
imagesc(u1)
title('Continuous phase distribution');
colormap(gray)

% name_out=input('out file name ','s'); 
% save([name_out], 'unwrapped', '-ASCII');