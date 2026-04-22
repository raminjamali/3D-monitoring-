phdiff1=imread('D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\results\6f\hol6.tif');
x=mat2cell(phdiff1, [256,256,256,256], [320,320,320,320]);
add='D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\results\6f\';
imwrite(x{1,1},[add,'x11.tif']);
imwrite(x{1,2},[add,'x12.tif']);
imwrite(x{1,3},[add,'x13.tif']);
imwrite(x{1,4},[add,'x14.tif']);
imwrite(x{2,1},[add,'x21.tif'])
imwrite(x{2,2},[add,'x22.tif'])
imwrite(x{2,3},[add,'x23.tif'])
imwrite(x{2,4},[add,'x24.tif'])
imwrite(x{3,1},[add,'x31.tif']);
imwrite(x{3,2},[add,'x32.tif']);
imwrite(x{3,3},[add,'x33.tif']);
imwrite(x{3,4},[add,'x34.tif']);
imwrite(x{4,1},[add,'x41.tif'])
imwrite(x{4,2},[add,'x42.tif'])
imwrite(x{4,3},[add,'x43.tif'])
imwrite(x{4,4},[add,'x44.tif'])