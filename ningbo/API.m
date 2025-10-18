



[as,asd]=xlsread(xlsFilePath0,'ReservoirName');
% asd=readtable(xlsFilePath0, 'Sheet', 'ReservoirName');
% edc=readtable(xlsFilePath0, 'Sheet', 'basinarea');
edc=xlsread(xlsFilePath0,'basinarea');
edc=edc*10^6;
ku=9;
k=0.85;
ri=15;
result=zeros(1,ku);
excelFile = xlsFilePath0;
sourceSheetName = 'rainfalldatabase';
targetSheetName = 'precipitation';
dateColumnIndex = 1; 
currentDate = datetime('today');
startDate = currentDate - days(13);
endDate = currentDate + days(4);
[num, txt, raw] = xlsread(excelFile, sourceSheetName);
dates = raw(2:end, dateColumnIndex); 
dates = datetime(dates, 'InputFormat', 'yyyy/MM/dd');
validIndices = dates >= startDate & dates <= endDate;
matchedData = raw(validIndices, :);
xlswrite(excelFile, raw(1, :), targetSheetName, 'A2'); 
startRow = 2; 
xlswrite(excelFile, matchedData, targetSheetName, ['A' num2str(startRow)]);
clear excelFile sourceSheetName targetSheetName dateColumnIndex;
clear num txt raw dates startDate endDate validIndices matchedData startRow currentDate result;
[num, txt, raw] = xlsread(xlsFilePath0, 'baseflow');
currentYear = year(datetime('now'));
for ijj = 1:size(raw, 1)
    try
        
        dateObj = datetime(raw{i, 1}, 'InputFormat', 'yyyy/MM/dd');
        
        if year(dateObj) ~= currentYear
            
            newDateStr = sprintf('%d/%d/%d', currentYear, month(dateObj), day(dateObj));
            
            raw{i, 1} = newDateStr;
        end
    catch
        
    end
end
xlswrite(xlsFilePath0, raw, 'baseflow');
clear currentYear ijj;
clear num txt raw dateObj;

crtdate = datetime('now','TimeZone','local','Format','yyyy/MM/dd');%'d-MMM-y HH:mm:ss Z'
str2=':';
dtstr=datevec(crtdate);
dtstr(4:6)=0;
[~,textdate] = xlsread(xlsFilePath0,'precipitation');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
f_str1=num2str(Dindx+1);f_str3=num2str(Dindx-13);
d_str1=num2str(Dindx+2);d_str3=num2str(Dindx+4);
fdrng2=['B',f_str1,str2,'J',f_str3];
Rdrng2=['B',d_str1,str2,'J',d_str3];
wsx_one = xlsread(xlsFilePath0,'precipitation', fdrng2);
wsx_two = xlsread(xlsFilePath0,'precipitation', Rdrng2);
wsx=[wsx_one' wsx_two'];
wsx=wsx';
[sdf,textdate] = xlsread(xlsFilePath0,'baseflow');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
h_Q=sdf(1:Dindx,1:9); plm=zeros(Dindx,ku);k_plm=zeros(Dindx,ku);
p_plm=zeros(Dindx,ku);
N=11;kj=0.9;
for j=1:ku
    kop=0;
    for i=1:11:Dindx-N-1
    plm(Dindx-i,j)=min(h_Q(Dindx-i-N:Dindx-i,j));
    k_plm(Dindx-i,j)=plm(Dindx-i,j)*kj;
    end
     for i=1:11:Dindx-N-1
    if i>1
    if k_plm(Dindx-i,j)<plm(Dindx-i-N,j)&&k_plm(Dindx-i,j)<plm(Dindx-i+N,j)
            p_plm(Dindx-i,j)=plm(Dindx-i,j);
            kop=kop+1;
            x_y(kop,1)=Dindx-i-5;x_y(kop,2)=p_plm(Dindx-i,j);
    end
        if kop==2
            
x=x_y(:,1);
y=x_y(:,2);
pn=polyfit(x,y,1);
    ji=pn(1)*(Dindx-1)+pn(2);
    ji=min(ji,h_Q(Dindx-1));
    if ji<0
        ji=0;
    end
    f_ji=pn(1)*Dindx+pn(2);
     if f_ji<0
        f_ji=0;
    end
    fin_ji(1,j)= (f_ji+ji)/2;
        end
    end
     end
end
ji_Q=fin_ji;
for io=1:ku
    
    shuikumingcheng=asd{io,1};
        
    tgb=16;
  
yu_p=wsx(tgb,io);
yu_pa=0;
   for ioj=1:ri
    yu_pa=yu_pa+wsx(tgb-ioj,io)*k^(ioj);
   end
%    asd=readtable(xlsFilePath0, 'Sheet', 'ReservoirName');
% denggaoxian1=readtable(xlsFilePath0, 'Sheet', 'shuikumingcheng')

denggaoxian1=xlsread(xlsFilePath0,shuikumingcheng);
       denggaoxian1=denggaoxian1(:,1:3);
        qwe=find(denggaoxian1(:,1)>denggaoxian1(:,2));
        denggaoxian1(qwe,:) = [];
        tgb=find(denggaoxian1(:,1)<0);
        denggaoxian1(tgb,:) = []; 
        
denggaoxian=denggaoxian1(:,1:3);
[md,nd]=size(denggaoxian);
n=ceil(sqrt(md));
xx=linspace(min(denggaoxian(:,1)),max(denggaoxian(:,1)),n);
yy=linspace(min(denggaoxian(:,2)),max(denggaoxian(:,2)),n);
yy=yy';
for jj=1:n
    xx(jj,:)=xx(1,:);
end
for jj=1:n
    yy(:,jj)=yy(:,1);
end
zz=griddata(denggaoxian(:,1),denggaoxian(:,2),denggaoxian(:,3),xx,yy);
h=figure('visible','off');
contour(xx,yy,zz,10,'ShowText','on');
h=figure('visible','off');
[c,h]=contour(xx,yy,zz,[yu_pa yu_pa],'ShowText','on');
clabel(c,h,'fontsize',14); 
 yhn=find(c(1,:)~=yu_pa);
 [mi,ni]=size(yhn);
for jop=1:ni
    x(1,jop)=c(1,(yhn(jop)));
   y(1,jop)=c(2,(yhn(jop)));
end
            P = polyfit(y,x,2);
      xi = polyval(P,y);  
        result(1,io)=edc(io)*(P(1)*(yu_p)^2+P(2)*yu_p+P(3))*10^(-3)/86400;
      if result(1,io)<0
          result(1,io)=0;
      end
      
      result(1,io)=result(1,io)+ji_Q(io);
end
result_one=result;
for io=1:ku
    
    shuikumingcheng=asd{io,1};
        
    tgb=17;
  
yu_p=wsx(tgb,io);
yu_pa=0;
   for ioj=1:ri
    yu_pa=yu_pa+wsx(tgb-ioj,io)*k^(ioj);
   end
denggaoxian1=xlsread(xlsFilePath0,shuikumingcheng);
       denggaoxian1=denggaoxian1(:,1:3);
        qwe=find(denggaoxian1(:,1)>denggaoxian1(:,2));
        denggaoxian1(qwe,:) = [];
        tgb=find(denggaoxian1(:,1)<0);
        denggaoxian1(tgb,:) = []; 
        
denggaoxian=denggaoxian1(:,1:3);
[md,nd]=size(denggaoxian);
n=ceil(sqrt(md));
xx=linspace(min(denggaoxian(:,1)),max(denggaoxian(:,1)),n);
yy=linspace(min(denggaoxian(:,2)),max(denggaoxian(:,2)),n);
yy=yy';
for jj=1:n
    xx(jj,:)=xx(1,:);
end
for jj=1:n
    yy(:,jj)=yy(:,1);
end
zz=griddata(denggaoxian(:,1),denggaoxian(:,2),denggaoxian(:,3),xx,yy);
figure('visible','off')
contour(xx,yy,zz,10,'ShowText','on');
figure('visible','off')
[c,h]=contour(xx,yy,zz,[yu_pa yu_pa],'ShowText','on');
clabel(c,h,'fontsize',14); 
 yhn=find(c(1,:)~=yu_pa);
 [mi,ni]=size(yhn);
for jop=1:ni
    x(1,jop)=c(1,(yhn(jop)));
   y(1,jop)=c(2,(yhn(jop)));
end
            P = polyfit(y,x,2);
      xi = polyval(P,y);  
        result(1,io)=edc(io)*(P(1)*(yu_p)^2+P(2)*yu_p+P(3))*10^(-3)/86400;
      if result(1,io)<0
          result(1,io)=0;
      end
       
      result(1,io)=result(1,io)+ji_Q(io);
end
result_two=result;
for io=1:ku
    
    shuikumingcheng=asd{io,1};
    
    tgb=18;
  
yu_p=wsx(tgb,io);
yu_pa=0;
   for ioj=1:ri
    yu_pa=yu_pa+wsx(tgb-ioj,io)*k^(ioj);
   end
denggaoxian1=xlsread(xlsFilePath0,shuikumingcheng);
       denggaoxian1=denggaoxian1(:,1:3);
        qwe=find(denggaoxian1(:,1)>denggaoxian1(:,2));
        denggaoxian1(qwe,:) = [];
        tgb=find(denggaoxian1(:,1)<0);
        denggaoxian1(tgb,:) = []; 
        
denggaoxian=denggaoxian1(:,1:3);
[md,nd]=size(denggaoxian);
n=ceil(sqrt(md));
xx=linspace(min(denggaoxian(:,1)),max(denggaoxian(:,1)),n);
yy=linspace(min(denggaoxian(:,2)),max(denggaoxian(:,2)),n);
yy=yy';
for jj=1:n
    xx(jj,:)=xx(1,:);
end
for jj=1:n
    yy(:,jj)=yy(:,1);
end
zz=griddata(denggaoxian(:,1),denggaoxian(:,2),denggaoxian(:,3),xx,yy);
figure('visible','off')
contour(xx,yy,zz,10,'ShowText','on');
figure('visible','off')
[c,h]=contour(xx,yy,zz,[yu_pa yu_pa],'ShowText','on');
clabel(c,h,'fontsize',14); 
 yhn=find(c(1,:)~=yu_pa);
 [mi,ni]=size(yhn);
for jop=1:ni
    x(1,jop)=c(1,(yhn(jop)));
   y(1,jop)=c(2,(yhn(jop)));
end
            P = polyfit(y,x,2);
      xi = polyval(P,y);  
        result(1,io)=edc(io)*(P(1)*(yu_p)^2+P(2)*yu_p+P(3))*10^(-3)/86400;
      if result(1,io)<0
          result(1,io)=0;
      end
       
      result(1,io)=result(1,io)+ji_Q(io);
end
result_three=result;
yubao_result=[result_one' result_two' result_three'];
yubao_result=yubao_result';
[~,textdate] = xlsread(xlsFilePath3,'Qin');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
x_Rdrng2=num2str(Dindx+1);
x_Rdrng2=['B',x_Rdrng2];
xlswrite(xlsFilePath3,yubao_result,'Qin',x_Rdrng2);
Result8=yubao_result';
close all
