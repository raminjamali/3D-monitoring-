phdiff1=imread('D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\results\6f\6.bmp');
x=mat2cell(phdiff1, [256,256,256,256], [320,320,320,320]);
add='D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\results\6f\';
imwrite(x{1,1},[add,'y11.tif']);
imwrite(x{1,2},[add,'y12.tif']);
imwrite(x{1,3},[add,'y13.tif']);
imwrite(x{1,4},[add,'y14.tif']);
imwrite(x{2,1},[add,'y21.tif'])
imwrite(x{2,2},[add,'y22.tif'])
imwrite(x{2,3},[add,'y23.tif'])
imwrite(x{2,4},[add,'y24.tif'])
imwrite(x{3,1},[add,'y31.tif']);
imwrite(x{3,2},[add,'y32.tif']);
imwrite(x{3,3},[add,'y33.tif']);
imwrite(x{3,4},[add,'y34.tif']);
imwrite(x{4,1},[add,'y41.tif'])
imwrite(x{4,2},[add,'y42.tif'])
imwrite(x{4,3},[add,'y43.tif'])
imwrite(x{4,4},[add,'y44.tif'])