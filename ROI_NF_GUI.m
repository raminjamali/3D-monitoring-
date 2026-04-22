figure(8);
[xx yy]=ginput(2);
phROI1=phdiff(yy(1):yy(2),xx(1):xx(2));
figure(10);
imshow(phROI1);

if exist('phdiff1')==1;
    phROI2=phdiff1(yy(1):yy(2),xx(1):xx(2));
    figure(11);
    imshow(phROI2);
end;