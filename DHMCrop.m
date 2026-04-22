function dim=DHMCrop
[no1,no1add]=uigetfile('*.*','Select no.1 photo');
I1=imread(strcat(no1add,no1));
figure;imagesc(I1);colormap gray
[I1,dim]=imcrop(I1);
[no2,no2add]=uigetfile('*.*','Select no.2 photo');
I1=imread(strcat(no2add,no2));
I2=imcrop(I2,dim);
[no3,no3add]=uigetfile('*.*','Select no.3 photo');
I3=imread(strcat(no3add,no3));
I3=imcrop(I3,dim);
[no4,no4add]=uigetfile('*.*','Select no.4 photo');
I4=imread(strcat(no4add,no4));
I4=imcrop(I4,dim);
[no11,no4add]=uigetfile('*.*','Select no.11 photo');
I11=imread(strcat(no11add,no11));
I11=imcrop(I11,dim);
[no22,no22add]=uigetfile('*.*','Select no.22 photo');
I22=imread(strcat(no22add,no22));
I22=imcrop(I22,dim);
[no33,no33add]=uigetfile('*.*','Select no.33 photo');
I33=imread(strcat(no33add,no33));
I33=imcrop(I33,dim);
[no44,no44add]=uigetfile('*.*','Select no.44 photo');
I44=imread(strcat(no44add,no44));
I44=imcrop(I44,dim);


[no1,no1add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.1 photo save...','');
[no2,no2add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.2 photo save...','');
[no3,no3add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.3 photo save...','');
[no4,no4add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.4 photo save...','');
[no11,no11add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.11 photo save...','');
[no22,no22add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.22 photo save...','');
[no33,no33add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.33 photo save...','');
[no44,no44add]=uiputfile({'*.bmp';'*.jpg';'*.*'},'Cropped no.44 photo save...','');


imwrite(I1,strcat(no1add,no1));
imwrite(I2,strcat(no2add,no2));
imwrite(I3,strcat(no3add,no3));
imwrite(I4,strcat(no4add,no4));
imwrite(I11,strcat(no1add,no11));
imwrite(I22,strcat(no2add,no22));
imwrite(I33,strcat(no3add,no33));
imwrite(I44,strcat(no4add,no44))

close all
end