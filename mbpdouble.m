for n=2:14
    cd('C:\Users\Chang\Desktop\700c-1h-new\nazok\sam\New folder')
    i=(imread(['f (',num2str(n),').bmp']));%
    i=im2double(i(:,:,1));
  
    imwrite(i,'C:\Users\Chang\Desktop\700c-1h-new\nazok\sam\New folder\',num2str(n),'.bmp');
 
end

