clc
close all
clear all
max_file_num=19;% number of image sequences
min_file_num=2; 
volume=zeros((max_file_num-min_file_num)+1,1);
volume(min_file_num-1)=0;
ii=[];
jj=[];
for i=min_file_num:max_file_num;
    i;
    cd('D:\DFM\rms files');
    filename=['1 (',num2str(i),').mat'];
    h0=importdata(filename); % loads the mat file 
    figure(1);imagesc(h0); 
    colormap gray
    gry=((h0(:,:,1)-(min(min(h0)).*ones(size(h0)))))./(max(max(h0))-min(min(h0)));
    cd('D:\DFM\rms files')
    imwrite((gry),['gry(',num2str(i),').jpg'],'jpg')
    figure(2);imshow(gry)
    [x y]=ginput;
    x=round(x);y=round(y);
    bw_c=poly2mask(x,y,size(gry,1),size(gry,2));
    bw1=bw_c.*gry;
    ni=size(find(bw1));%%% finding the size of bw1
    nii=ni(1);
    si=sum(sum(bw1));%%%% sum of elements isn't equal zero
    hi=si./nii;
    cd('D:\DFM\rms files')  
    imwrite(bw1,['gm (',num2str(i),').tif']);
    figure(3);imshow(bw1);
    volume(i)=sum(sum(bw1));
    rate=abs(volume(i)-volume(i-1));
    jj=[jj,rate];
    ii=[ii,i];
    i;
    h(i)
end