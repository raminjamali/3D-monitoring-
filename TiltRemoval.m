z=UVCE1;
[x,y] = meshgrid(1:size(z,2),1:size(z,1));
P = polyfitn([x(:),y(:)],z(:),'x, y, constant');
C=P.Coefficients;
% C=C.*2;
P=C(1).*x+C(2).*y+C(3);

z2=z-P;
figure;mesh(z);figure;mesh(z2);
h1=z2;

save Tilted.mat z
save TilteRemoved.mat z2