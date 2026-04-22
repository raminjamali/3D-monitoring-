HH=findobj(gcf,'Tag','E20');
lam=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E21');
dpix=str2num(get(HH,'String'));

HH=findobj(gcf,'Tag','E22');
Dn=str2num(get(HH,'String')); 

HH=findobj(gcf,'Tag','E23');
ML=str2num(get(HH,'String')); 

h1=u1*lam/(2*pi*Dn);

[sxh1 syh1]=size(h1);

ac1=[0:sxh1-1]*dpix/ML;
ac2=[0:syh1-1]*dpix/ML;
for ii=1:syh1
    ad1(:,ii)=ac1;
end;

for ii=1:sxh1
    ad2(ii,:)=ac2;
end;


figure(22);
imagesc(h1);
colormap gray;

%---
mkdir('rms files');
cd_0=cd;
date_time=datevec(now);
h_date_time=date_time(4);
m_date_time=date_time(5);
s_date_time=round(date_time(6))
filename_=[cd_0,'\rms files\','RBC_set1_',datestr(date),'-',num2str(h_date_time),'-',num2str(m_date_time),'-',num2str(s_date_time),'.mat']
save(filename_,'h1')
cd=cd_0;