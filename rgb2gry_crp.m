clear all
close all
clc
% cd('E:\OPTIC\Trapping\move\rbc04_1')
% % [fn, pn]=uigetfile('*.bmp','Load hologram1');
% % hol=[pn,fn];
% % hol_=(imread(hol));
%     hol_rgb=(imread(['rbc04_10000.bmp']));%
% % for n=2:67;
% %     hol_rgb=(imread(['1 (',num2str(n),').bmp']));
% figure(1); imshow(hol_rgb);size(hol_rgb)
% hol_gry=rgb2gray(hol_rgb);
% figure(2); imshow(hol_gry);size(hol_gry)
% cd('E:\OPTIC\Trapping\move\rbc04_1\gray')
% imwrite(hol_gry,'rbc04_10000_.tif');
% % hol_crpd=imcrop(hol_gry,[400 220 767 767]);
% % imwrite(hol_crpd,['1 (',num2str(n),')_crpd.bmp'],'bmp');
% % end
% % figure(3); imshow(hol_crpd);size(hol_crpd)
for n=1:3;
    cd('H:\SPIE\SPIE China\no anti\ref pics 7\crop')
    hol_rgb=(imread(['1 (',num2str(n),').tif']));%
    hol_gry=rgb2gray(hol_rgb);
    cd('H:\SPIE\SPIE China\no anti\ref pics 7\gray');
    imwrite(hol_gry,['1 (',num2str(n),').tif']);
end
