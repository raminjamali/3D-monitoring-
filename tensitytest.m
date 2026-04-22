Iavg=0
d=zeros(1,376);
for i=1:376
%     Ii=imread(strcat('F:\arm-1\','1 (',num2str(n),'),'.bmp'));
cd('F:\arm-1')
    li=(imread(['1 (',num2str(i),').bmp']));
    li=li(:,:,1);
    for n=1:1280
          ten=sum(sum(li));  
    end
    d(1,i)=ten;
end
