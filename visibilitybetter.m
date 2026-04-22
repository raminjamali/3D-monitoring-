clear
clc
for n=1:18;
    cd('D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\sam\r')
    ll=(imread([num2str(n),'r.bmp']));%
    cd('D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\sam\f');
    dd=(imread([num2str(n),'f.bmp']));%
    gg=dd-ll;
    cd('D:\Arbab Doc\HDM\for second\fall-94\800-304-nazok\1\sam\b');
    imwrite(gg,[num2str(n),'b.bmp']);
end
