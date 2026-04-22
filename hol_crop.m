clc
clear all
close all
for n=1:1:3;
    cd('H:\SPIE\SPIE China\no anti\ref pics 7')
    A=imread(['1 (',num2str(n),').tif']);
    %Ar=imread([num2str(n),'r.bmp']);
    figure(1);imshow(A);
    [x0,y0]=ginput(1);
    B=imcrop(A,[x0-100,y0-100,200,200]);
    %Br=imcrop(Ar,[x0-200,y0-200,350,350]);
%     figure(2);imshow(B);
    %figure(3);imshow(Br);
    cd(['H:\SPIE\SPIE China\no anti\ref pics 7\crop']);
    imwrite(B,[num2str(n),'_crpd.tif']);
    %imwrite(Br,[num2str(n),'r_crpd.tif']);
       % cd('F:\2ch')
end
