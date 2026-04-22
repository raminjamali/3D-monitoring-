clc
clear
[file,add]=uigetfile({'*.bmp';'*.tif'},'Select the LAST image:');
mkdir([add,'8bit'])

if strcmp(add(end-3:end-1),'ref')==1
    for ii=1:str2num(file(1:end-4))
        I=imread([add,num2str(ii),'.bmp']);
        I=im2double(I);
        I=mean(I,3);
        imwrite(I,[add,'8bit\',num2str(ii),'.bmp']);
    end
elseif strcmp(add(end-3:end-1),'sam')==1
    for ii=1:str2num(file(1:end-5))
        I=imread([add,num2str(ii),'.bmp']);
        I=im2double(I);
        I=mean(I,3);
        imwrite(I,[add,'8bit\',num2str(ii),'.bmp']);
        I=imread([add,num2str(ii),'f.bmp']);
        I=im2double(I);
        I=mean(I,3);
        imwrite(I,[add,'8bit\',num2str(ii),'f.bmp']);
    end
end