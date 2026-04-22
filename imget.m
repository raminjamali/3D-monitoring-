function [I,add]=imget
[file,add]=uigetfile({'*.jpg;*.bmp;*.tif','All Image Files'},...
    'Select Image',[]);
I=imread([add,file]);