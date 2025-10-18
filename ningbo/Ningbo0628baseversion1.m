clear;
clc;

folderPath = fullfile(pwd, 'Input and Output');
xlsFilePath0 = fullfile(folderPath, 'parameters.xlsx');
xlsFilePath3 = fullfile(folderPath, 'Inflow.xlsx');
xlsFilePath1 = fullfile(folderPath, 'NBresult.xlsx');
xlsFilePath4 = fullfile(folderPath, 'data.xlsx');

Kp=1;
if Kp==2
    run('lstm3.m'); 
else
    run('API.m'); 
end

Itrnmb=100;            
crtdate = datetime('now','TimeZone','local','Format','yyyy/MM/dd');%'d-MMM-y HH:mm:ss Z'
dtstr=datevec(crtdate);
dtstr(4:6)=0;   
tt1=datetime(dtstr(1),6,1,0,0,0,'TimeZone','Asia/Shanghai');  
tt2=datetime(dtstr(1),10,16,0,0,0,'TimeZone','Asia/Shanghai');
HWS=xlsread(xlsFilePath4,'levelstorage');
hws1=HWS(:,1);hws2=HWS(:,3);hws3=HWS(:,5);hws4=HWS(:,7); 
hws5=HWS(:,9);hws6=HWS(:,11);hws7=HWS(:,13);hws8=HWS(:,15); hws9=HWS(:,17);
whs1=HWS(:,2);whs2=HWS(:,4);whs3=HWS(:,6);whs4=HWS(:,8);
whs5=HWS(:,10);whs6=HWS(:,12);whs7=HWS(:,14);whs8=HWS(:,16);whs9=HWS(:,18);
hws1=hws1(~isnan(hws1));  whs1=whs1(~isnan(whs1)); 
hws2=hws2(~isnan(hws2)); whs2=whs2(~isnan(whs2));
hws3=hws3(~isnan(hws3)); whs3=whs3(~isnan(whs3));
hws4=hws4(~isnan(hws4)); whs4=whs4(~isnan(whs4));
hws5=hws5(~isnan(hws5)); whs5=whs5(~isnan(whs5));
hws6=hws6(~isnan(hws6)); whs6=whs6(~isnan(whs6));
hws7=hws7(~isnan(hws7)); whs7=whs7(~isnan(whs7));
hws8=hws8(~isnan(hws8)); whs8=whs8(~isnan(whs8));
hws9=hws9(~isnan(hws9)); whs9=whs9(~isnan(whs9));
clear HWS
Dtinput=xlsread(xlsFilePath4,'input');
Da=Dtinput(:,1);Db=Dtinput(:,2);Dc=Dtinput(:,3);Dd=Dtinput(:,4);De=Dtinput(:,5);
Df=Dtinput(:,6);Dg=Dtinput(:,7);Dh=Dtinput(:,8);Di=Dtinput(:,9);Dj=Dtinput(:,10);
Dk=Dtinput(:,11);Dl=Dtinput(:,12);Dm=Dtinput(:,13);SP1=Dtinput(:,14);
clear Dtinput
Dtinput=xlsread(xlsFilePath4,'inputMax');
DaM=Dtinput(:,1);DbM=Dtinput(:,2);DcM=Dtinput(:,3);DdM=Dtinput(:,4);DeM=Dtinput(:,5);
DfM=Dtinput(:,6);DgM=Dtinput(:,7);DhM=Dtinput(:,8);DiM=Dtinput(:,9);DjM=Dtinput(:,10);
DkM=Dtinput(:,11);DlM=Dtinput(:,12);DmM=Dtinput(:,13);SP1M=Dtinput(:,14);
clear Dtinput
if Da>DaM
    Da=DaM;
elseif Da<0
    Da=0;
end
if Db>DbM
    Db=DbM;
elseif Db<0
    Db=0;
end
if Dc>DcM
    Dc=DcM;
elseif Dc<0
    Dc=0;
end
if Dd>DdM
    Dd=DdM;
elseif Dd<0
    Dd=0;
end
if De>DeM
    De=DeM;
elseif De<0
    De=0;
end
if Df>DfM
    Df=DfM;
elseif Df<0
    Df=0;
end
if Dg>DgM
    Dg=DgM;
elseif Dg<0
    Dg=0;
end
if Dh>DhM
    Dh=DhM;
elseif Dh<0
    Dh=0;
end
if Di>DiM
    Di=DiM;
elseif Di<0
    Di=0;
end
if Dj>DjM
    Dj=DjM;
elseif Dj<0
    Dj=0;
end
if Dk>DkM
    Dk=DkM;
elseif Dk<0
    Dk=0;
end
if Dl>DlM
    Dl=DlM;
elseif Dl<0
    Dl=0;
end
if Dm>DmM
    Dm=DmM;
elseif Dm<0
    Dm=0;
end
if SP1>SP1M
    SP1=SP1M;
elseif SP1<0
    SP1=0;
end
clear DaM DbM DcM DdM DeM DfM DgM DhM DiM DjM DkM DlM DmM SP1M
HDI=xlsread(xlsFilePath4,'leveldischarge');
hdI1=HDI(:,1);hdI2=HDI(:,3);hdI3=HDI(:,5);hdI4=HDI(:,7);        
hdI5=HDI(:,9);hdI6=HDI(:,11);hdI7=HDI(:,13);hdI8=HDI(:,15);hdI9=HDI(:,17);     
dIh1=HDI(:,2);dIh2=HDI(:,4);dIh3=HDI(:,6);dIh4=HDI(:,8);            
dIh5=HDI(:,10);dIh6=HDI(:,12);dIh7=HDI(:,14);dIh8=HDI(:,16);dIh9=HDI(:,18);        
hdI1=hdI1(~isnan(hdI1)); dIh1=dIh1(~isnan(dIh1));  
hdI2=hdI2(~isnan(hdI2)); dIh2=dIh2(~isnan(dIh2));
hdI3=hdI3(~isnan(hdI3)); dIh3=dIh3(~isnan(dIh3));
hdI4=hdI4(~isnan(hdI4)); dIh4=dIh4(~isnan(dIh4));
hdI5=hdI5(~isnan(hdI5)); dIh5=dIh5(~isnan(dIh5));
hdI6=hdI6(~isnan(hdI6)); dIh6=dIh6(~isnan(dIh6));
hdI7=hdI7(~isnan(hdI7)); dIh7=dIh7(~isnan(dIh7));
hdI8=hdI8(~isnan(hdI8)); dIh8=dIh8(~isnan(dIh8));
hdI9=hdI9(~isnan(hdI9)); dIh9=dIh9(~isnan(dIh9));
clear HDI
RCstrn=zeros(9,8);WLcrct=zeros(9,4);      
RCstrn(1, :)=[37.5 27.0 0.35 50 500 10 10 3];RCstrn(2, :)=[59.75 60.0 0.5 393 8000 33.55 15 3.5];
RCstrn(3, :)=[140 100.0 0.5 1340 18000 74 30 3.8];RCstrn(4, :)=[20.5 13.22 0.35 150 500 10.0 10 3];
RCstrn(5, :)=[76.17 67.17 0.5 210 5000 45 15 3.5];RCstrn(6, :)=[0 14.37 0 120 500 0 10 0];
RCstrn(7, :)=[174.13 145.13 0.5 280 12600 100.93 22 4.5];RCstrn(8, :)=[48.5 37.38 0.35 400 4800 30.5 22 3];
RCstrn(9, :)=[70.7 66 1.0 400 2750 52.3 22 15];
Kf=8.0; Kf2=7.8;  
WLcrct(1, :)=[54 55 59.56 27];WLcrct(2, :)=[81.05 82.65 89.26 44.05];WLcrct(3, :)=[170 170 173.5 100];
WLcrct(4, :)=[29.22 31.42 33.92 13.22];WLcrct(5, :)=[105.17 109.67 117.77 67.17];WLcrct(6, :)=[31.12 32.62 34.51 14.37];
WLcrct(7, :)=[227.13 231.13 237.12 145.13];WLcrct(8, :)=[62.18 68.08 72.41 37.38];WLcrct(9, :)=[96 98 102.86 66];
Vctrl(1)=interp1(hws1,whs1,WLcrct(1,3));     
Vctrl(2)=interp1(hws2,whs2,WLcrct(2,3));
Vctrl(3)=interp1(hws3,whs3,WLcrct(3,3));
Vctrl(4)=interp1(hws4,whs4,WLcrct(4,3));
Vctrl(5)=interp1(hws5,whs5,WLcrct(5,3));
Vctrl(6)=interp1(hws6,whs6,WLcrct(6,3));
Vctrl(7)=interp1(hws7,whs7,WLcrct(7,3));
Vctrl(8)=interp1(hws8,whs8,WLcrct(8,3));
Vctrl(9)=interp1(hws9,whs9,WLcrct(9,3));
Vlm(1)=interp1(hws1,whs1,WLcrct(1,1));     
Vlm(2)=interp1(hws2,whs2,WLcrct(2,1));
Vlm(3)=interp1(hws3,whs3,WLcrct(3,1));
Vlm(4)=interp1(hws4,whs4,WLcrct(4,1));
Vlm(5)=interp1(hws5,whs5,WLcrct(5,1));
Vlm(6)=interp1(hws6,whs6,WLcrct(6,1));
Vlm(7)=interp1(hws7,whs7,WLcrct(7,1));
Vlm(8)=interp1(hws8,whs8,WLcrct(8,1));
Vlm(9)=interp1(hws9,whs9,WLcrct(9,1));
Vn(1)=interp1(hws1,whs1,WLcrct(1,2));     
Vn(2)=interp1(hws2,whs2,WLcrct(2,2));
Vn(3)=interp1(hws3,whs3,WLcrct(3,2));
Vn(4)=interp1(hws4,whs4,WLcrct(4,2));
Vn(5)=interp1(hws5,whs5,WLcrct(5,2));
Vn(6)=interp1(hws6,whs6,WLcrct(6,2));
Vn(7)=interp1(hws7,whs7,WLcrct(7,2));
Vn(8)=interp1(hws8,whs8,WLcrct(8,2));
Vn(9)=interp1(hws9,whs9,WLcrct(9,2));

[~,textdate] = xlsread(xlsFilePath4,'crtcndtn');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
str1=num2str(Dindx);str2=':';
Rdrng1=['B',str1,str2,'S',str1];
Rcrnt = xlsread(xlsFilePath4,'crtcndtn', Rdrng1);

VZcrnt(1)=interp1(hws1,whs1,Rcrnt(1));     
VZcrnt(2)=interp1(hws2,whs2,Rcrnt(3));
VZcrnt(3)=interp1(hws3,whs3,Rcrnt(5));
VZcrnt(4)=interp1(hws4,whs4,Rcrnt(7));
VZcrnt(5)=interp1(hws5,whs5,Rcrnt(9));
VZcrnt(6)=interp1(hws6,whs6,Rcrnt(11));
VZcrnt(7)=interp1(hws7,whs7,Rcrnt(13));
VZcrnt(8)=interp1(hws8,whs8,Rcrnt(15));
VZcrnt(9)=interp1(hws9,whs9,Rcrnt(17));
Qoutmax(1)=interp1(hdI1,dIh1,Rcrnt(1));     
Qoutmax(2)=interp1(hdI2,dIh2,Rcrnt(3));
Qoutmax(3)=interp1(hdI3,dIh3,Rcrnt(5));
Qoutmax(4)=interp1(hdI4,dIh4,Rcrnt(7));
Qoutmax(5)=interp1(hdI5,dIh5,Rcrnt(9));
Qoutmax(6)=interp1(hdI6,dIh6,Rcrnt(11));
Qoutmax(7)=interp1(hdI7,dIh7,Rcrnt(13));
Qoutmax(8)=interp1(hdI8,dIh8,Rcrnt(15));
Qoutmax(9)=interp1(hdI9,dIh9,Rcrnt(17));
[~,textdate] = xlsread(xlsFilePath3,'Qin');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
str1=num2str(Dindx);str3=num2str(Dindx+3);  
Rdrng2=['B',str1,str2,'J',str3];
Qin = xlsread(xlsFilePath3,'Qin', Rdrng2);

ddt=24;             
Ni=72/ddt;         
Nc=Ni/3;          
DT=ddt*0.36; 
NI=Ni*9;       
M=100;    
ZZ=zeros(M,NI);               
VZZ=zeros(M,NI);              
Qout=zeros(M,NI);             
Vout=zeros(M,NI);             
Wsp1=zeros(M,Ni);Wsp2=zeros(M,Ni);Wsp3=zeros(M,Ni);Wsp4=zeros(M,Ni);Wsp5=zeros(M,Ni); 
Wsp6=zeros(M,Ni);Wsp7=zeros(M,Ni);Wsp8=zeros(M,Ni);Wsp9=zeros(M,Ni);Wsp10=zeros(M,Ni); 
Wsp11=zeros(M,Ni);Wsp12=zeros(M,Ni);Wsp13=zeros(M,Ni);Wsp14=zeros(M,Ni);Wsp15=zeros(M,Ni);  
Wsp16=zeros(M,Ni);Wsp17=zeros(M,Ni);Wsp18=zeros(M,Ni);Wsp19=zeros(M,Ni);Wsp20=zeros(M,Ni);
Wsp21=zeros(M,Ni);Wsp22=zeros(M,Ni);Wsp23=zeros(M,Ni);Tmp1=zeros(1,Ni);
Qfa=zeros(M,NI);               
Qspls=zeros(M,NI);             
Head=zeros(M,NI);             
Navrg=zeros(M,NI);            
VWtr=zeros(9,1);             
Enrg=zeros(9,1);             
Pwr=zeros(M,1); Vwr=zeros(M,1);  
Pwr2=zeros(M,1);Vwr2=zeros(M,1);                 
Indx=linspace(1,100)';               

Prob=zeros(M,1);        

lmt=0;                  
FtFct= zeros(Itrnmb,1);

for I=1:M
    Wsp5(I,:)=min(Dc,35*rand(1,Ni));
    Wsp20(I,:)=Dc-Wsp5(I,:);
    Wsp2(I,:)=min(Db,10*rand(1,Ni));
    Wsp3(I,:)=Db-Wsp2(I,:);
    Wsp1(I,:)=min(Da,20+15*rand(1,Ni));   
    Wsp4(I,:)=Da-Wsp1(I,:);
    Wsp6(I,:)=min(De,20*rand(1,Ni));
    for J=1:Ni
        if Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)>77
            Tmp1(1,J)=Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J);
            Wsp3(I,J)=Wsp3(I,J)-Wsp3(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
            Wsp4(I,J)=Wsp4(I,J)-Wsp4(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
            Wsp5(I,J)=Wsp5(I,J)-Wsp5(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
            Wsp1(I,J)=min(35,Da-Wsp4(I,J));
            
            
            
            Wsp2(I,J)=Db-Wsp3(I,J);   
            Wsp20(I,J)=Dc-Wsp5(I,J);   
        end
    end
    Wsp7(I,:)=min(3,Dd);
    Wsp8(I,:)=(0.5*rand+0.5)*(Wsp3(I,:)+Wsp4(I,:)+Wsp5(I,:)+Wsp6(I,:));
    Wsp9(I,:)=(Wsp3(I,:)+Wsp4(I,:)+Wsp5(I,:)+Wsp6(I,:))-Wsp8(I,:);
    for J=1:Ni
        while Wsp8(I,J)>62||Wsp9(I,J)>35   
            Wsp8(I,J)=(0.5*rand+0.5)*(Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)+Wsp6(I,J));
            Wsp9(I,J)=(Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)+Wsp6(I,J))-Wsp8(I,J);
        end
    end

    Wsp13(I,:)=20*rand(1,Ni);
    Wsp14(I,:)=De-Wsp6(I,:);
    Wsp17(I,:)=min(Dh,9.5);
    Wsp16(I,:)=min(Dg,15+10*rand(1,Ni));
    Wsp15(I,:)=Dg-Wsp16(I,:);
    
    
    
    
    
    
    
    
    
    Wsp10(I,:)=min(1.5,Dk);
    
    
    
    
    
    
    
    
    
    Wsp18(I,:)=min(50,Df);
    Wsp12(I,:)=Wsp18(I,:)+Wsp14(I,:)+Wsp15(I,:)-Wsp13(I,:);
    Wsp11(I,:)=Wsp12(I,:)+Di+Dj-SP1;
    for J=1:Ni
        if Wsp11(I,J)>60-SP1
            Wsp13(I,J)=Wsp13(I,J)+Wsp11(I,J)-(60-SP1);
            Wsp11(I,J)=60-SP1;
            Wsp12(I,J)=Wsp11(I,J)-Di-Dj+SP1;
            if Wsp13(I,J)>20
                Wsp18(I,J)=Wsp18(I,J)-(Wsp13(I,J)-20);
                Wsp13(I,J)=20;
            end
        end
        if Wsp18(I,J)<Df
            Wsp19(I,J)=Df-Wsp18(I,J);
        end
    end
    Wsp21(I,:)=min(8,Di);
    Wsp22(I,:)=min(3,Dj);
    Wsp23(I,:)=min(5.5,Dl+Dm);
end
for I=1:M
    Qout(I,:)=[Qin(1,1)+rand(1,Nc)*(Qin(2,1)-Qin(1,1)) Qin(2,1)+rand(1,Nc)*(Qin(3,1)-Qin(2,1)) Qin(3,1)+rand(1,Nc)*(Qin(4,1)-Qin(3,1))...
        Qin(1,2)+rand(1,Nc)*(Qin(2,2)-Qin(1,2)) Qin(2,2)+rand(1,Nc)*(Qin(3,2)-Qin(2,2)) Qin(3,2)+rand(1,Nc)*(Qin(4,2)-Qin(3,2))...
        Qin(1,3)+rand(1,Nc)*(Qin(2,3)-Qin(1,3)) Qin(2,3)+rand(1,Nc)*(Qin(3,3)-Qin(2,3)) Qin(3,3)+rand(1,Nc)*(Qin(4,3)-Qin(3,3))...
        Qin(1,4)+rand(1,Nc)*(Qin(2,4)-Qin(1,4)) Qin(2,4)+rand(1,Nc)*(Qin(3,4)-Qin(2,4)) Qin(3,4)+rand(1,Nc)*(Qin(4,4)-Qin(3,4))...
        Qin(1,5)+rand(1,Nc)*(Qin(2,5)-Qin(1,5)) Qin(2,5)+rand(1,Nc)*(Qin(3,5)-Qin(2,5)) Qin(3,5)+rand(1,Nc)*(Qin(4,5)-Qin(3,5))...
        Qin(1,6)+rand(1,Nc)*(Qin(2,6)-Qin(1,6)) Qin(2,6)+rand(1,Nc)*(Qin(3,6)-Qin(2,6)) Qin(3,6)+rand(1,Nc)*(Qin(4,6)-Qin(3,6))...
        Qin(1,7)+rand(1,Nc)*(Qin(2,7)-Qin(1,7)) Qin(2,7)+rand(1,Nc)*(Qin(3,7)-Qin(2,7)) Qin(3,7)+rand(1,Nc)*(Qin(4,7)-Qin(3,7))...
        Qin(1,8)+rand(1,Nc)*(Qin(2,8)-Qin(1,8)) Qin(2,8)+rand(1,Nc)*(Qin(3,8)-Qin(2,8)) Qin(3,8)+rand(1,Nc)*(Qin(4,8)-Qin(3,8))...
        Qin(1,9)+rand(1,Nc)*(Qin(2,9)-Qin(1,9)) Qin(2,9)+rand(1,Nc)*(Qin(3,9)-Qin(2,9)) Qin(3,9)+rand(1,Nc)*(Qin(4,9)-Qin(3,9))];
    
    
    
    
    
    
    
    
    if Qout(I,7)<(Wsp10(I,1)+Wsp11(I,1))/DT+0.1   
        Qout(I,7)=(Wsp10(I,1)+Wsp11(I,1))/DT+0.1;
    end
    if Qout(I,8)<(Wsp10(I,2)+Wsp11(I,2))/DT+0.1
        Qout(I,8)=(Wsp10(I,2)+Wsp11(I,2))/DT+0.1;
    end
    if Qout(I,9)<(Wsp10(I,3)+Wsp11(I,3))/DT+0.1
        Qout(I,9)=(Wsp10(I,3)+Wsp11(I,3))/DT+0.1;
    end
    for J=1:3:NI  
        if Qout(I,J)>=Qoutmax(ceil(J/3))
            Qout(I,J)=Qoutmax(ceil(J/3));
        end
    end

end
Prob(1)=0;
for I=1:M
    VWtr(1)=0;VWtr(2)=0;VWtr(3)=0;VWtr(4)=0;VWtr(5)=0;VWtr(6)=0;VWtr(7)=0;VWtr(8)=0;VWtr(9)=0;
    Vwr(I)=0;Pwr(I)=0;Enrg(2)=0;Enrg(3)=0;Enrg(5)=0;Enrg(7)=0;Enrg(8)=0;Enrg(9)=0;
    
    for J=1:NI
        jj=ceil(J/3); 
        nn= mod(J,3); 
        if nn==0
            nn=3;
        end
        
        if jj==1    
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
            end
            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)   
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    else         
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    end
                    Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));

                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                end
                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws1,whs1,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp1(I,nn)=0;Wsp2(I,nn)=0;
                    else
                        Wsp1(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*7/9;    
                        Wsp2(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*2/9;
                        Qout(I,J)=Qout(I,J)-2*(Wsp1(I,nn)+Wsp2(I,nn))/DT;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                end
            end         
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp1(I,1)+Wsp1(I,2)+Wsp1(I,3)+Wsp2(I,1)+Wsp2(I,2)+Wsp2(I,3));
            end
            
        elseif jj==2     
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
            end
            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                end
                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws2,whs2,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp7(I,nn)=0;Wsp8(I,nn)=0;
                    else
                        Wsp7(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*60/63;    
                        Wsp8(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*3/63;
                        Qout(I,J)=Qout(I,J)-2*(Wsp7(I,nn)+Wsp8(I,nn))/DT;    

                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.16*Wsp7(I,1)+0.5*Wsp8(I,1)...
                    +0.16*Wsp7(I,2)+0.5*Wsp8(I,2)+0.16*Wsp7(I,3)+0.5*Wsp8(I,3)+0.533*Enrg(jj)/10000;
            end
            
        elseif jj==3     
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
            end
            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1    
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=Wsp10(I,nn)+Wsp11(I,nn)+0.1;   
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws3,whs3,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)-0.1<=0  
                        Qout(I,J)=0.1;Wsp10(I,nn)=0;Wsp11(I,nn)=0;     
                    elseif Qout(I,J)-0.1>=0 && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp11(I,nn)-10)/DT   
                        Wsp10(I,nn)=0;    
                        Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT;                     

                    elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Wsp11(I,nn)-10)/DT && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp10(I,nn)+Wsp11(I,nn))/DT
                        
                        Wsp10(I,nn)=min(Dk,(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT);
                        Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT-Wsp10(I,nn);
                    else
                        msgbox('mistake in line 903 for resevoir 3');
                    end

                    if Wsp11(I,nn)+SP1<Di+Dj
                        Wsp12(I,nn)=0;
                        Wsp21(I,nn)=(Wsp11(I,nn)+SP1)*Di/(Di+Dj);
                        Wsp22(I,nn)=(Wsp11(I,nn)+SP1)-Wsp21(I,nn);
                    else
                        Wsp21(I,nn)=Di;
                        Wsp22(I,nn)=Dj;
                        Wsp12(I,nn)=Wsp11(I,nn)-Di-Dj+SP1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp10(I,1)+Wsp11(I,1)...
                    +Wsp10(I,2)+Wsp11(I,2)+Wsp10(I,3)+Wsp11(I,3))+0.57*Enrg(jj)/10000;
            end
            
        elseif jj==4     
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
            end
            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                end
                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws4,whs4,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp13(I,nn)=0;
                    else
                        Wsp13(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                        Qout(I,J)=Qout(I,J)-2*Wsp13(I,nn)/DT;

                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;    
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp13(I,1)+Wsp13(I,2)+Wsp13(I,3));
            end
            

        elseif jj==5      
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
            end
            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                end
                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws5,whs5,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp17(I,nn)=0;Wsp16(I,nn)=0;
                    else
                        Wsp17(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*10/35;    
                        Wsp16(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*5/7;
                        Qout(I,J)=Qout(I,J)-2*(Wsp17(I,nn)+Wsp16(I,nn))/DT;

                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp16(I,1)+Wsp17(I,1)...
                    +Wsp16(I,2)+Wsp17(I,2)+Wsp16(I,3)+Wsp17(I,3))+0.54*Enrg(jj)/10000;
            end
            

        elseif jj==6     
            if  Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)
                A1=Wsp14(I,nn)/(Wsp14(I,nn)+Wsp15(I,nn));
                Wsp14(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*A1;
                Wsp15(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*(1-A1);
                Wsp18(I,nn)=0;
            elseif Wsp12(I,nn)+Wsp13(I,nn)>Wsp14(I,nn)+Wsp15(I,nn) && Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)+Wsp18(I,nn)+0.00001
                Wsp18(I,nn)=Wsp12(I,nn)+Wsp13(I,nn)-Wsp14(I,nn)-Wsp15(I,nn);
            else
                msgbox('warning！something was wrong in line1286, Wsp12+13 should not>1415+18');
            end
            if Wsp18(I,nn)<Df
                Wsp19(I,nn)=Df-Wsp18(I,nn);
            else
                Wsp19(I,nn)=0;
            end
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
            end
            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                end
                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws6,whs6,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=0 
                        Qout(I,J)=0.1;Wsp19(I,nn)=0;Wsp23(I,nn)=0;
                    elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Dl+Dm)/DT
                        Wsp23(I,nn)=Dl+Dm;
                        Wsp19(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)-Wsp23(I,nn);    
                        Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;

                    else
                        Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;
                        Wsp19(I,nn)=0;
                        Wsp23(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                end
            end         
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.5*(Wsp19(I,1)+Wsp19(I,2)+Wsp19(I,3))+2.14*(Wsp23(I,1)+Wsp23(I,2)+Wsp23(I,3));
            end
            

        elseif jj==7      
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
            end
            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws7,whs7,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.595*Enrg(jj)/10000;
            end
            

        elseif jj==8      
            
            if nn==1    
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
            end
            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1    
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                end
                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws8,whs8,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp20(I,nn)=0;
                    else
                        Wsp20(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                        Qout(I,J)=Qout(I,J)-2*Wsp20(I,nn)/DT;

                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp20(I,1)+Wsp20(I,2)+Wsp20(I,3))+0.541*Enrg(jj)/10000;
            end
            
        elseif jj==9      
            if nn==1
                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
            else   
                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
            end
            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
            
            
            if crtdate>=tt1 && crtdate<=tt2   
                
                if Qin(nn+1,jj)>=RCstrn(jj,4)
                    if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                        
                        Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                        
                        Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end
                    Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                    if Qout(I,J)>=Qoutmax(jj)
                        Qout(I,J)=Qoutmax(jj);
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end
                    
                elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                    if ZZ(I,J)>WLcrct(jj,3)
                        ZZ(I,J)=WLcrct(jj,3);
                        VZZ(I,J)=Vctrl(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end
                    
                else
                    if ZZ(I,J)>WLcrct(jj,1)
                        Qout(I,J)=RCstrn(jj,7);   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    else
                        ZZ(I,J)=WLcrct(jj,1);
                        VZZ(I,J)=Vlm(jj);
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                    end
                    Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                    elseif Qout(I,J)<=0.1
                        Qout(I,J)=0.1;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                end  
            else   
                if ZZ(I,J)>WLcrct(jj,2)
                    ZZ(I,J)=WLcrct(jj,2);
                    VZZ(I,J)=Vn(jj);
                end
                if nn==1          
                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                else
                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                end
                
                Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                if Qout(I,J)>=Qcstrn
                    Qout(I,J)=Qcstrn;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    
                    
                end
            end   

            
            if ZZ(I,J)<=RCstrn(jj,2)   
                Qout(I,J)=0.1;
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                end
                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                if ZZ(I,J)<=RCstrn(jj,2)   
                    ZZ(I,J)=RCstrn(jj,2);
                    VZZ(I,J)=interp1(hws9,whs9,ZZ(I,J));
                    if nn==1              
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    if Qout(I,J)<=0.1  
                        Qout(I,J)=0.1;Wsp9(I,nn)=0;
                    else
                        Wsp9(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                        
                        Qout(I,J)=Qout(I,J)-2*Wsp9(I,nn)/DT;  
                        
                        
                        
                        
                        
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                    else
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                end
            end
            
            if Qout(I,J)<=RCstrn(jj, 3)   
                Qfa(I,J)=0;
            elseif Qout(I,J)>=RCstrn(jj, 8)
                Qfa(I,J)=RCstrn(jj, 8);
            else
                Qfa(I,J)=Qout(I,J);
            end
            Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
            if ZZ(I,J)>=RCstrn(jj,1)       
                Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                if Navrg(I,J)>RCstrn(jj,5)            
                    Navrg(I,J)=RCstrn(jj,5);
                end
            else
                Navrg(I,J)=0;             
            end
            Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
            if nn==3       
                VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp9(I,1)+Wsp9(I,2)+Wsp9(I,3))+0.541*Enrg(jj)/10000;
            end
        end
        
        
        
        
        
        
    end    
    
    
    for nn=1:Ni
        if Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))
            Wsp4(I,nn)=Wsp8(I,nn)+Wsp9(I,nn);   
            Wsp3(I,nn)=0;Wsp5(I,nn)=0;Wsp6(I,nn)=0;
        elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))
            Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
            Wsp5(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn)); 
            Wsp3(I,nn)=0;Wsp6(I,nn)=0;
        elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)
            Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
            Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
            Wsp6(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn));
            Wsp3(I,nn)=0;
        elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)+Db-Wsp2(I,nn)+0.0000001
            Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
            Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
            Wsp6(I,nn)=De-Wsp14(I,nn);
            Wsp3(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn))-De+Wsp14(I,nn);
        else
            msgbox('sth.was wrong in line 1978')
        end   
    end
    Pwr(I)= Enrg(2)+Enrg(3)+Enrg(5)+Enrg(7)+Enrg(8)+Enrg(9);
    Vwr(I)= VWtr(1)+VWtr(2)+VWtr(3)+VWtr(4)+VWtr(5)+VWtr(6)+VWtr(7)+VWtr(8)+VWtr(9);
end
Wsp=[Wsp1 Wsp2 Wsp3 Wsp4 Wsp5 Wsp6 Wsp7 Wsp8 Wsp9 Wsp10 Wsp11 Wsp12 Wsp13 Wsp14 Wsp15 Wsp16 Wsp17 Wsp18 Wsp19 Wsp20 Wsp21 Wsp22 Wsp23];
A=[Qout Wsp Vwr];  
clmnmb=numel(A(1, :));
C=zeros(M,clmnmb-1);
B=sortrows(A,clmnmb);     
Vrb= B(:,1:clmnmb-1);
Vwr = B(:,clmnmb);
NUM=M/2;
S=0;
for I=NUM+1:M
    S= S+Pwr(I);   
end
for I=NUM+1:M
    Prob(I)= Pwr(I)/S;   
end
for kk=1:Itrnmb      
    lmt=lmt+1;      
    
    for I = NUM+1:M
        Qoutmax(1)=interp1(hdI1,dIh1,Rcrnt(1));     
        Qoutmax(2)=interp1(hdI2,dIh2,Rcrnt(3));
        Qoutmax(3)=interp1(hdI3,dIh3,Rcrnt(5));
        Qoutmax(4)=interp1(hdI4,dIh4,Rcrnt(7));
        Qoutmax(5)=interp1(hdI5,dIh5,Rcrnt(9));
        Qoutmax(6)=interp1(hdI6,dIh6,Rcrnt(11));
        Qoutmax(7)=interp1(hdI7,dIh7,Rcrnt(13));
        Qoutmax(8)=interp1(hdI8,dIh8,Rcrnt(15));
        Qoutmax(9)=interp1(hdI8,dIh8,Rcrnt(17));
        
        K= randi([NUM,M]);      
        while K==I            
            K= randi([NUM,M]);
        end
        C(I,:)= Vrb(I,:)-rand*(Vrb(I,:)-Vrb(K,:));

        
        
        Qout(I,:) = C(I,1:NI);Wsp1(I,:) = C(I,NI+1:NI+3);Wsp2(I,:) = C(I,NI+4:NI+6);Wsp3(I,:) = C(I,NI+7:NI+9);
        Wsp4(I,:) = C(I,NI+10:NI+12);Wsp5(I,:)= C(I,NI+13:NI+15);Wsp6(I,:)= C(I,NI+16:NI+18);Wsp7(I,:)= C(I,NI+19:NI+21);
        Wsp8(I,:) = C(I,NI+22:NI+24);Wsp9(I,:)= C(I,NI+25:NI+27);Wsp10(I,:)= C(I,NI+28:NI+30);Wsp11(I,:)= C(I,NI+31:NI+33);
        Wsp12(I,:) = C(I,NI+34:NI+36);Wsp13(I,:)= C(I,NI+37:NI+39);Wsp14(I,:)= C(I,NI+40:NI+42);Wsp15(I,:)= C(I,NI+43:NI+45);
        Wsp16(I,:) = C(I,NI+46:NI+48);Wsp17(I,:)= C(I,NI+49:NI+51);Wsp18(I,:)= C(I,NI+52:NI+54);Wsp19(I,:)= C(I,NI+55:NI+57);
        Wsp20(I,:) = C(I,NI+58:NI+60);Wsp21(I,:)= C(I,NI+61:NI+63);Wsp22(I,:)= C(I,NI+64:NI+66);Wsp23(I,:)= C(I,NI+67:NI+69);
        for J=1:3:NI  
            if Qout(I,J)>=Qoutmax(ceil(J/3))
                Qout(I,J)=Qoutmax(ceil(J/3));
            end
        end
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        VWtr(1)=0;VWtr(2)=0;VWtr(3)=0;VWtr(4)=0;VWtr(5)=0;VWtr(6)=0;VWtr(7)=0;VWtr(8)=0;VWtr(9)=0;
        Vwr2(I)=0;Pwr2(I)=0;Enrg(2)=0;Enrg(3)=0;Enrg(5)=0;Enrg(7)=0;Enrg(8)=0;Enrg(9)=0;
        for J=1:NI
            jj=ceil(J/3); 
            nn= mod(J,3); 
            if nn==0
                nn=3;
            end
            
            if jj==1    
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                end
                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)   
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        else         
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));

                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws1,whs1,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp1(I,nn)=0;Wsp2(I,nn)=0;
                        else
                            Wsp1(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*7/9;    
                            Wsp2(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*2/9;
                            Qout(I,J)=Qout(I,J)-2*(Wsp1(I,nn)+Wsp2(I,nn))/DT;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    end
                end         
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp1(I,1)+Wsp1(I,2)+Wsp1(I,3)+Wsp2(I,1)+Wsp2(I,2)+Wsp2(I,3));
                end
                
            elseif jj==2     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                end
                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws2,whs2,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp7(I,nn)=0;Wsp8(I,nn)=0;
                        else
                            Wsp7(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*60/63;    
                            Wsp8(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*3/63;
                            Qout(I,J)=Qout(I,J)-2*(Wsp7(I,nn)+Wsp8(I,nn))/DT;    

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.16*Wsp7(I,1)+0.5*Wsp8(I,1)...
                        +0.16*Wsp7(I,2)+0.5*Wsp8(I,2)+0.16*Wsp7(I,3)+0.5*Wsp8(I,3)+0.533*Enrg(jj)/10000;
                end
                
            elseif jj==3     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1    
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=Wsp10(I,nn)+Wsp11(I,nn)+0.1;   
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws3,whs3,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)-0.1<=0  
                            Qout(I,J)=0.1;Wsp10(I,nn)=0;Wsp11(I,nn)=0;     
                        elseif Qout(I,J)-0.1>=0 && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp11(I,nn)-10)/DT   
                            Wsp10(I,nn)=0;    
                            Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT;                     

                        elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Wsp11(I,nn)-10)/DT && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp10(I,nn)+Wsp11(I,nn))/DT
                            
                            Wsp10(I,nn)=min(Dk,(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT);
                            Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT-Wsp10(I,nn);
                        else
                            msgbox('mistake in line 903 for resevoir 3');
                        end

                        if Wsp11(I,nn)+SP1<Di+Dj
                            Wsp12(I,nn)=0;
                            Wsp21(I,nn)=(Wsp11(I,nn)+SP1)*Di/(Di+Dj);
                            Wsp22(I,nn)=(Wsp11(I,nn)+SP1)-Wsp21(I,nn);
                        else
                            Wsp21(I,nn)=Di;
                            Wsp22(I,nn)=Dj;
                            Wsp12(I,nn)=Wsp11(I,nn)-Di-Dj+SP1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp10(I,1)+Wsp11(I,1)...
                        +Wsp10(I,2)+Wsp11(I,2)+Wsp10(I,3)+Wsp11(I,3))+0.57*Enrg(jj)/10000;
                end
                
            elseif jj==4     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                end
                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws4,whs4,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp13(I,nn)=0;
                        else
                            Wsp13(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            Qout(I,J)=Qout(I,J)-2*Wsp13(I,nn)/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;    
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp13(I,1)+Wsp13(I,2)+Wsp13(I,3));
                end
                

            elseif jj==5      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                end
                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws5,whs5,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp17(I,nn)=0;Wsp16(I,nn)=0;
                        else
                            Wsp17(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*10/35;    
                            Wsp16(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*5/7;
                            Qout(I,J)=Qout(I,J)-2*(Wsp17(I,nn)+Wsp16(I,nn))/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp16(I,1)+Wsp17(I,1)...
                        +Wsp16(I,2)+Wsp17(I,2)+Wsp16(I,3)+Wsp17(I,3))+0.54*Enrg(jj)/10000;
                end
                

            elseif jj==6     
                if  Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)
                    A1=Wsp14(I,nn)/(Wsp14(I,nn)+Wsp15(I,nn));
                    Wsp14(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*A1;
                    Wsp15(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*(1-A1);
                    Wsp18(I,nn)=0;
                elseif Wsp12(I,nn)+Wsp13(I,nn)>Wsp14(I,nn)+Wsp15(I,nn) && Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)+Wsp18(I,nn)+0.00001
                    Wsp18(I,nn)=Wsp12(I,nn)+Wsp13(I,nn)-Wsp14(I,nn)-Wsp15(I,nn);
                else
                    msgbox('warning！something was wrong in line1286, Wsp12+13 should not>1415+18');
                end
                if Wsp18(I,nn)<Df
                    Wsp19(I,nn)=Df-Wsp18(I,nn);
                else
                    Wsp19(I,nn)=0;
                end
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                end
                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws6,whs6,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=0 
                            Qout(I,J)=0.1;Wsp19(I,nn)=0;Wsp23(I,nn)=0;
                        elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Dl+Dm)/DT
                            Wsp23(I,nn)=Dl+Dm;
                            Wsp19(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)-Wsp23(I,nn);    
                            Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;

                        else
                            Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;
                            Wsp19(I,nn)=0;
                            Wsp23(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end
                end         
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.5*(Wsp19(I,1)+Wsp19(I,2)+Wsp19(I,3))+2.14*(Wsp23(I,1)+Wsp23(I,2)+Wsp23(I,3));
                end
                

            elseif jj==7      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws7,whs7,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.595*Enrg(jj)/10000;
                end
                

            elseif jj==8      
                
                if nn==1    
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                end
                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1    
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws8,whs8,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp20(I,nn)=0;
                        else
                            Wsp20(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            Qout(I,J)=Qout(I,J)-2*Wsp20(I,nn)/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp20(I,1)+Wsp20(I,2)+Wsp20(I,3))+0.541*Enrg(jj)/10000;
                end
                
            elseif jj==9      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                end
                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws9,whs9,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp9(I,nn)=0;
                        else
                            Wsp9(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            
                            Qout(I,J)=Qout(I,J)-2*Wsp9(I,nn)/DT;  
                            
                            
                            
                            
                            
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp9(I,1)+Wsp9(I,2)+Wsp9(I,3))+0.541*Enrg(jj)/10000;
                end
            end
            
            
            
            
            
            
        end    
        
        
        for nn=1:Ni
            if Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))
                Wsp4(I,nn)=Wsp8(I,nn)+Wsp9(I,nn);   
                Wsp3(I,nn)=0;Wsp5(I,nn)=0;Wsp6(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn)); 
                Wsp3(I,nn)=0;Wsp6(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                Wsp6(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn));
                Wsp3(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)+Db-Wsp2(I,nn)+0.0000001
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                Wsp6(I,nn)=De-Wsp14(I,nn);
                Wsp3(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn))-De+Wsp14(I,nn);
            else
                msgbox('sth.was wrong in line 3747')

            end   
        end
        tst1=Wsp8+Wsp9-(Wsp3+Wsp4+Wsp5+Wsp6);   
        tst2=Wsp12+Wsp13-(Wsp15+Wsp14+Wsp18);   
        Wsp(I,:)=[Wsp1(I,:) Wsp2(I,:) Wsp3(I,:) Wsp4(I,:) Wsp5(I,:) Wsp6(I,:) Wsp7(I,:) Wsp8(I,:)...
            Wsp9(I,:) Wsp10(I,:) Wsp11(I,:) Wsp12(I,:) Wsp13(I,:) Wsp14(I,:) Wsp15(I,:) Wsp16(I,:)...
            Wsp17(I,:) Wsp18(I,:) Wsp19(I,:) Wsp20(I,:) Wsp21(I,:) Wsp22(I,:) Wsp23(I,:)];
        C(I,:)=[Qout(I,:) Wsp(I,:)];   
        Pwr2(I)= Enrg(2)+Enrg(3)+Enrg(5)+Enrg(7)+Enrg(8)+Enrg(9);
        Vwr2(I)= VWtr(1)+VWtr(2)+VWtr(3)+VWtr(4)+VWtr(5)+VWtr(6)+VWtr(7)+VWtr(8)+VWtr(9);

        
        
        if Vwr(I)<Vwr2(I)
            Vrb(I,:)=C(I,:);       
            Vwr(I)=Vwr2(I);Pwr(I)=Pwr2(I);
            
        end
        
        
        
    end
    
    S=0;
    for I=NUM+1:M
        S= S+Vwr(I);   
    end
    for I=NUM+1:M
        Prob(I)= Vwr(I)/S;   
    end
    Slct=0;
    
    for I=1:NUM
        sel=rand;
        sumPs=0;
        i=NUM+1;
        while sumPs<sel               
            sumPs=sumPs+Prob(i);
            i=i+1;
        end
        Slct=i-1;
        
        
        
        Qoutmax(1)=interp1(hdI1,dIh1,Rcrnt(1));     
        Qoutmax(2)=interp1(hdI2,dIh2,Rcrnt(3));
        Qoutmax(3)=interp1(hdI3,dIh3,Rcrnt(5));
        Qoutmax(4)=interp1(hdI4,dIh4,Rcrnt(7));
        Qoutmax(5)=interp1(hdI5,dIh5,Rcrnt(9));
        Qoutmax(6)=interp1(hdI6,dIh6,Rcrnt(11));
        Qoutmax(7)=interp1(hdI7,dIh7,Rcrnt(13));
        Qoutmax(8)=interp1(hdI8,dIh8,Rcrnt(15));
        Qoutmax(9)=interp1(hdI7,dIh7,Rcrnt(17));

        
        
        C(I,:)= Vrb(I,:)-rand*(Vrb(I,:)-Vrb(Slct,:));
        
        
        

        Qout(I,:) = C(I,1:NI);Wsp1(I,:) = C(I,NI+1:NI+3);Wsp2(I,:) = C(I,NI+4:NI+6);Wsp3(I,:) = C(I,NI+7:NI+9);
        Wsp4(I,:) = C(I,NI+10:NI+12);Wsp5(I,:)= C(I,NI+13:NI+15);Wsp6(I,:)= C(I,NI+16:NI+18);Wsp7(I,:)= C(I,NI+19:NI+21);
        Wsp8(I,:) = C(I,NI+22:NI+24);Wsp9(I,:)= C(I,NI+25:NI+27);Wsp10(I,:)= C(I,NI+28:NI+30);Wsp11(I,:)= C(I,NI+31:NI+33);
        Wsp12(I,:) = C(I,NI+34:NI+36);Wsp13(I,:)= C(I,NI+37:NI+39);Wsp14(I,:)= C(I,NI+40:NI+42);Wsp15(I,:)= C(I,NI+43:NI+45);
        Wsp16(I,:) = C(I,NI+46:NI+48);Wsp17(I,:)= C(I,NI+49:NI+51);Wsp18(I,:)= C(I,NI+52:NI+54);Wsp19(I,:)= C(I,NI+55:NI+57);
        Wsp20(I,:) = C(I,NI+58:NI+60);Wsp21(I,:)= C(I,NI+61:NI+63);Wsp22(I,:)= C(I,NI+64:NI+66);Wsp23(I,:)= C(I,NI+67:NI+69);
        for J=1:NI              
            if Qout(I,J)>=Qoutmax(ceil(J/3))
                Qout(I,J)=Qoutmax(ceil(J/3));
            end
        end

        
        

        VWtr(1)=0;VWtr(2)=0;VWtr(3)=0;VWtr(4)=0;VWtr(5)=0;VWtr(6)=0;VWtr(7)=0;VWtr(8)=0;
        Vwr2(I)=0;Pwr2(I)=0;Enrg(2)=0;Enrg(3)=0;Enrg(5)=0;Enrg(7)=0;Enrg(8)=0;
        for J=1:NI
            jj=ceil(J/3); 
            nn= mod(J,3); 
            if nn==0
                nn=3;
            end
            
            if jj==1    
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                end
                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)   
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        else         
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        end
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));

                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws1,whs1,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp1(I,nn)=0;Wsp2(I,nn)=0;
                        else
                            Wsp1(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*7/9;    
                            Wsp2(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*2/9;
                            Qout(I,J)=Qout(I,J)-2*(Wsp1(I,nn)+Wsp2(I,nn))/DT;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    end
                end         
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp1(I,1)+Wsp1(I,2)+Wsp1(I,3)+Wsp2(I,1)+Wsp2(I,2)+Wsp2(I,3));
                end
                
            elseif jj==2     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                end
                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws2,whs2,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp7(I,nn)=0;Wsp8(I,nn)=0;
                        else
                            Wsp7(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*60/63;    
                            Wsp8(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*3/63;
                            Qout(I,J)=Qout(I,J)-2*(Wsp7(I,nn)+Wsp8(I,nn))/DT;    

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.16*Wsp7(I,1)+0.5*Wsp8(I,1)...
                        +0.16*Wsp7(I,2)+0.5*Wsp8(I,2)+0.16*Wsp7(I,3)+0.5*Wsp8(I,3)+0.533*Enrg(jj)/10000;
                end
                
            elseif jj==3     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1    
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=Wsp10(I,nn)+Wsp11(I,nn)+0.1;   
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws3,whs3,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)-0.1<=0  
                            Qout(I,J)=0.1;Wsp10(I,nn)=0;Wsp11(I,nn)=0;     
                        elseif Qout(I,J)-0.1>=0 && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp11(I,nn)-10)/DT   
                            Wsp10(I,nn)=0;    
                            Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT;                     

                        elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Wsp11(I,nn)-10)/DT && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp10(I,nn)+Wsp11(I,nn))/DT
                            
                            Wsp10(I,nn)=min(Dk,(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT);
                            Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT-Wsp10(I,nn);
                        else
                            msgbox('mistake in line 903 for resevoir 3');
                        end

                        if Wsp11(I,nn)+SP1<Di+Dj
                            Wsp12(I,nn)=0;
                            Wsp21(I,nn)=(Wsp11(I,nn)+SP1)*Di/(Di+Dj);
                            Wsp22(I,nn)=(Wsp11(I,nn)+SP1)-Wsp21(I,nn);
                        else
                            Wsp21(I,nn)=Di;
                            Wsp22(I,nn)=Dj;
                            Wsp12(I,nn)=Wsp11(I,nn)-Di-Dj+SP1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp10(I,1)+Wsp11(I,1)...
                        +Wsp10(I,2)+Wsp11(I,2)+Wsp10(I,3)+Wsp11(I,3))+0.57*Enrg(jj)/10000;
                end
                
            elseif jj==4     
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                end
                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws4,whs4,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp13(I,nn)=0;
                        else
                            Wsp13(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            Qout(I,J)=Qout(I,J)-2*Wsp13(I,nn)/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;    
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp13(I,1)+Wsp13(I,2)+Wsp13(I,3));
                end
                

            elseif jj==5      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                end
                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws5,whs5,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp17(I,nn)=0;Wsp16(I,nn)=0;
                        else
                            Wsp17(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*10/35;    
                            Wsp16(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*5/7;
                            Qout(I,J)=Qout(I,J)-2*(Wsp17(I,nn)+Wsp16(I,nn))/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp16(I,1)+Wsp17(I,1)...
                        +Wsp16(I,2)+Wsp17(I,2)+Wsp16(I,3)+Wsp17(I,3))+0.54*Enrg(jj)/10000;
                end
                

            elseif jj==6     
                if  Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)
                    A1=Wsp14(I,nn)/(Wsp14(I,nn)+Wsp15(I,nn));
                    Wsp14(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*A1;
                    Wsp15(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*(1-A1);
                    Wsp18(I,nn)=0;
                elseif Wsp12(I,nn)+Wsp13(I,nn)>Wsp14(I,nn)+Wsp15(I,nn) && Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)+Wsp18(I,nn)+0.00001
                    Wsp18(I,nn)=Wsp12(I,nn)+Wsp13(I,nn)-Wsp14(I,nn)-Wsp15(I,nn);
                else
                    msgbox('warning！something was wrong in line1286, Wsp12+13 should not>1415+18');
                end
                if Wsp18(I,nn)<Df
                    Wsp19(I,nn)=Df-Wsp18(I,nn);
                else
                    Wsp19(I,nn)=0;
                end
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                end
                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws6,whs6,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=0 
                            Qout(I,J)=0.1;Wsp19(I,nn)=0;Wsp23(I,nn)=0;
                        elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Dl+Dm)/DT
                            Wsp23(I,nn)=Dl+Dm;
                            Wsp19(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)-Wsp23(I,nn);    
                            Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;

                        else
                            Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;
                            Wsp19(I,nn)=0;
                            Wsp23(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    end
                end         
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.5*(Wsp19(I,1)+Wsp19(I,2)+Wsp19(I,3))+2.14*(Wsp23(I,1)+Wsp23(I,2)+Wsp23(I,3));
                end
                

            elseif jj==7      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                end
                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws7,whs7,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.595*Enrg(jj)/10000;
                end
                

            elseif jj==8      
                
                if nn==1    
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                end
                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1    
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws8,whs8,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp20(I,nn)=0;
                        else
                            Wsp20(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            Qout(I,J)=Qout(I,J)-2*Wsp20(I,nn)/DT;

                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp20(I,1)+Wsp20(I,2)+Wsp20(I,3))+0.541*Enrg(jj)/10000;
                end
                
            elseif jj==9      
                if nn==1
                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                else   
                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                end
                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                
                
                if crtdate>=tt1 && crtdate<=tt2   
                    
                    if Qin(nn+1,jj)>=RCstrn(jj,4)
                        if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                            
                            Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                            
                            Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        if Qout(I,J)>=Qoutmax(jj)
                            Qout(I,J)=Qoutmax(jj);
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        
                    elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                        if ZZ(I,J)>WLcrct(jj,3)
                            ZZ(I,J)=WLcrct(jj,3);
                            VZZ(I,J)=Vctrl(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                        
                    else
                        if ZZ(I,J)>WLcrct(jj,1)
                            Qout(I,J)=RCstrn(jj,7);   
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                            else   
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        else
                            ZZ(I,J)=WLcrct(jj,1);
                            VZZ(I,J)=Vlm(jj);
                            if nn==1          
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                        end
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                        elseif Qout(I,J)<=0.1
                            Qout(I,J)=0.1;
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end  
                else   
                    if ZZ(I,J)>WLcrct(jj,2)
                        ZZ(I,J)=WLcrct(jj,2);
                        VZZ(I,J)=Vn(jj);
                    end
                    if nn==1          
                        Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                    else
                        Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                    end
                    
                    Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                    Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                    if Qout(I,J)>=Qcstrn
                        Qout(I,J)=Qcstrn;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        
                        
                    end
                end   

                
                if ZZ(I,J)<=RCstrn(jj,2)   
                    Qout(I,J)=0.1;
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        ZZ(I,J)=RCstrn(jj,2);
                        VZZ(I,J)=interp1(hws9,whs9,ZZ(I,J));
                        if nn==1              
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                            
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        if Qout(I,J)<=0.1  
                            Qout(I,J)=0.1;Wsp9(I,nn)=0;
                        else
                            Wsp9(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                            
                            Qout(I,J)=Qout(I,J)-2*Wsp9(I,nn)/DT;  
                            
                            
                            
                            
                            
                        end
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                        else
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    end
                end
                
                if Qout(I,J)<=RCstrn(jj, 3)   
                    Qfa(I,J)=0;
                elseif Qout(I,J)>=RCstrn(jj, 8)
                    Qfa(I,J)=RCstrn(jj, 8);
                else
                    Qfa(I,J)=Qout(I,J);
                end
                Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                if ZZ(I,J)>=RCstrn(jj,1)       
                    Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                    if Navrg(I,J)>RCstrn(jj,5)            
                        Navrg(I,J)=RCstrn(jj,5);
                    end
                else
                    Navrg(I,J)=0;             
                end
                Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                if nn==3       
                    VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp9(I,1)+Wsp9(I,2)+Wsp9(I,3))+0.541*Enrg(jj)/10000;
                end
            end
            
            
            
            
            
            
        end    
        
        
        for nn=1:Ni
            if Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))
                Wsp4(I,nn)=Wsp8(I,nn)+Wsp9(I,nn);   
                Wsp3(I,nn)=0;Wsp5(I,nn)=0;Wsp6(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn)); 
                Wsp3(I,nn)=0;Wsp6(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                Wsp6(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn));
                Wsp3(I,nn)=0;
            elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)+Db-Wsp2(I,nn)+0.0000001
                Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                Wsp6(I,nn)=De-Wsp14(I,nn);
                Wsp3(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn))-De+Wsp14(I,nn);
            else
                msgbox('sth.was wrong in line 5441')
            end   
        end
        tst1=Wsp8+Wsp9-(Wsp3+Wsp4+Wsp5+Wsp6);   
        tst2=Wsp12+Wsp13-(Wsp15+Wsp14+Wsp18);   
        Wsp(I,:)=[Wsp1(I,:) Wsp2(I,:) Wsp3(I,:) Wsp4(I,:) Wsp5(I,:) Wsp6(I,:) Wsp7(I,:) Wsp8(I,:)...
            Wsp9(I,:) Wsp10(I,:) Wsp11(I,:) Wsp12(I,:) Wsp13(I,:) Wsp14(I,:) Wsp15(I,:) Wsp16(I,:)...
            Wsp17(I,:) Wsp18(I,:) Wsp19(I,:) Wsp20(I,:) Wsp21(I,:) Wsp22(I,:) Wsp23(I,:)];
        C(I,:)=[Qout(I,:) Wsp(I,:)];   
        Pwr2(I)= Enrg(2)+Enrg(3)+Enrg(5)+Enrg(7)+Enrg(8)+Enrg(9);
        Vwr2(I)= VWtr(1)+VWtr(2)+VWtr(3)+VWtr(4)+VWtr(5)+VWtr(6)+VWtr(7)+VWtr(8)+VWtr(9);

        
        
        if Vwr(I)<Vwr2(I)
            Vrb(I,:)=C(I,:);       
            Vwr(I)=Vwr2(I);Pwr(I)=Pwr2(I);
            
        end
        
        
        
    end
    
    
    if lmt>=10            
        for I=NUM:M-10         
            Wsp5(I,:)=min(Dc,35*rand(1,Ni));
            Wsp20(I,:)=Dc-Wsp5(I,:);
            Wsp2(I,:)=min(Db,10*rand(1,Ni));
            Wsp3(I,:)=Db-Wsp2(I,:);
            Wsp1(I,:)=min(Da,20+15*rand(1,Ni));   
            Wsp4(I,:)=Da-Wsp1(I,:);
            Wsp6(I,:)=min(De,20*rand(1,Ni));
            for J=1:Ni
                if Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)>77
                    Tmp1(1,J)=Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J);
                    Wsp3(I,J)=Wsp3(I,J)-Wsp3(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
                    Wsp4(I,J)=Wsp4(I,J)-Wsp4(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
                    Wsp5(I,J)=Wsp5(I,J)-Wsp5(I,J)*(Tmp1(1,J)-77)/Tmp1(1,J);
                    Wsp1(I,J)=min(35,Da-Wsp4(I,J));
                    Wsp2(I,J)=Db-Wsp3(I,J);   
                    Wsp20(I,J)=Dc-Wsp5(I,J);   
                end
            end
            Wsp7(I,:)=min(3,Dd);
            Wsp8(I,:)=(0.5*rand+0.5)*(Wsp3(I,:)+Wsp4(I,:)+Wsp5(I,:)+Wsp6(I,:));
            Wsp9(I,:)=(Wsp3(I,:)+Wsp4(I,:)+Wsp5(I,:)+Wsp6(I,:))-Wsp8(I,:);
            for J=1:Ni
                while Wsp8(I,J)>62||Wsp9(I,J)>35   
                    Wsp8(I,J)=(0.5*rand+0.5)*(Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)+Wsp6(I,J));
                    Wsp9(I,J)=(Wsp3(I,J)+Wsp4(I,J)+Wsp5(I,J)+Wsp6(I,J))-Wsp8(I,J);
                end
            end
            Wsp13(I,:)=20*rand(1,Ni);
            Wsp14(I,:)=De-Wsp6(I,:);
            Wsp17(I,:)=min(Dh,9.5);
            Wsp16(I,:)=min(Dg,15+10*rand(1,Ni));
            Wsp15(I,:)=Dg-Wsp16(I,:);
            Wsp10(I,:)=min(1.5,Dk);
            Wsp18(I,:)=min(50,Df);
            Wsp12(I,:)=Wsp18(I,:)+Wsp14(I,:)+Wsp15(I,:)-Wsp13(I,:);
            Wsp11(I,:)=Wsp12(I,:)+Di+Dj-SP1;
            for J=1:Ni
                if Wsp11(I,J)>60-SP1
                    Wsp13(I,J)=Wsp13(I,J)+Wsp11(I,J)-(60-SP1);
                    Wsp11(I,J)=60-SP1;
                    Wsp12(I,J)=Wsp11(I,J)-Di-Dj+SP1;
                    if Wsp13(I,J)>20
                        Wsp18(I,J)=Wsp18(I,J)-(Wsp13(I,J)-20);
                        Wsp13(I,J)=20;
                    end
                end
                if Wsp18(I,J)<Df
                    Wsp19(I,J)=Df-Wsp18(I,J);
                end
            end
            Wsp21(I,:)=min(8,Di);
            Wsp22(I,:)=min(3,Dj);
            Wsp23(I,:)=min(5.5,Dl+Dm);
            
            if crtdate>tt1 && crtdate<=tt2   
                Qout(I,:)=[Qin(1,1)+rand(1,Nc)*(Qin(2,1)-Qin(1,1)) Qin(2,1)+rand(1,Nc)*(Qin(3,1)-Qin(2,1)) Qin(3,1)+rand(1,Nc)*(Qin(4,1)-Qin(3,1))...
                    Qin(1,2)+rand(1,Nc)*(Qin(2,2)-Qin(1,2)) Qin(2,2)+rand(1,Nc)*(Qin(3,2)-Qin(2,2)) Qin(3,2)+rand(1,Nc)*(Qin(4,2)-Qin(3,2))...
                    Qin(1,3)+rand(1,Nc)*(Qin(2,3)-Qin(1,3)) Qin(2,3)+rand(1,Nc)*(Qin(3,3)-Qin(2,3)) Qin(3,3)+rand(1,Nc)*(Qin(4,3)-Qin(3,3))...
                    Qin(1,4)+rand(1,Nc)*(Qin(2,4)-Qin(1,4)) Qin(2,4)+rand(1,Nc)*(Qin(3,4)-Qin(2,4)) Qin(3,4)+rand(1,Nc)*(Qin(4,4)-Qin(3,4))...
                    Qin(1,5)+rand(1,Nc)*(Qin(2,5)-Qin(1,5)) Qin(2,5)+rand(1,Nc)*(Qin(3,5)-Qin(2,5)) Qin(3,5)+rand(1,Nc)*(Qin(4,5)-Qin(3,5))...
                    Qin(1,6)+rand(1,Nc)*(Qin(2,6)-Qin(1,6)) Qin(2,6)+rand(1,Nc)*(Qin(3,6)-Qin(2,6)) Qin(3,6)+rand(1,Nc)*(Qin(4,6)-Qin(3,6))...
                    Qin(1,7)+rand(1,Nc)*(Qin(2,7)-Qin(1,7)) Qin(2,7)+rand(1,Nc)*(Qin(3,7)-Qin(2,7)) Qin(3,7)+rand(1,Nc)*(Qin(4,7)-Qin(3,7))...
                    Qin(1,8)+rand(1,Nc)*(Qin(2,8)-Qin(1,8)) Qin(2,8)+rand(1,Nc)*(Qin(3,8)-Qin(2,8)) Qin(3,8)+rand(1,Nc)*(Qin(4,8)-Qin(3,8))...
                    Qin(1,9)+rand(1,Nc)*(Qin(2,9)-Qin(1,9)) Qin(2,9)+rand(1,Nc)*(Qin(3,9)-Qin(2,9)) Qin(3,9)+rand(1,Nc)*(Qin(4,9)-Qin(3,9))];
            else
                Qout(I,:)=[rand(1,Nc)*Qin(1,1) rand(1,Nc)*Qin(2,1) rand(1,Nc)*Qin(3,1) rand(1,Nc)*Qin(1,2) rand(1,Nc)*Qin(2,2) rand(1,Nc)*Qin(3,2)...
                    rand(1,Nc)*Qin(1,3) rand(1,Nc)*Qin(2,3) rand(1,Nc)*Qin(3,3) rand(1,Nc)*Qin(1,4) rand(1,Nc)*Qin(2,4) rand(1,Nc)*Qin(3,4)...
                    rand(1,Nc)*Qin(1,5) rand(1,Nc)*Qin(2,5) rand(1,Nc)*Qin(3,5) rand(1,Nc)*Qin(1,6) rand(1,Nc)*Qin(2,6) rand(1,Nc)*Qin(3,6)...
                    rand(1,Nc)*Qin(1,7) rand(1,Nc)*Qin(2,7) rand(1,Nc)*Qin(3,7) rand(1,Nc)*Qin(1,8) rand(1,Nc)*Qin(2,8) rand(1,Nc)*Qin(3,8)...
                    rand(1,Nc)*Qin(1,9) rand(1,Nc)*Qin(2,9) rand(1,Nc)*Qin(3,9)];
                
            end
            if Qout(I,7)<(Wsp10(I,1)+Wsp11(I,1))/DT+0.1   
                Qout(I,7)=(Wsp10(I,1)+Wsp11(I,1))/DT+0.1;
            end
            if Qout(I,8)<(Wsp10(I,2)+Wsp11(I,2))/DT+0.1
                Qout(I,8)=(Wsp10(I,2)+Wsp11(I,2))/DT+0.1;
            end
            if Qout(I,9)<(Wsp10(I,3)+Wsp11(I,3))/DT+0.1
                Qout(I,9)=(Wsp10(I,3)+Wsp11(I,3))/DT+0.1;
            end
            for J=1:3:NI  
                if Qout(I,J)>=Qoutmax(ceil(J/3))
                    Qout(I,J)=Qoutmax(ceil(J/3));
                end
            end
            
            
            VWtr(1)=0;VWtr(2)=0;VWtr(3)=0;VWtr(4)=0;VWtr(5)=0;VWtr(6)=0;VWtr(7)=0;VWtr(8)=0;VWtr(9)=0;
            Vwr(I)=0;Pwr(I)=0;Enrg(2)=0;Enrg(3)=0;Enrg(5)=0;Enrg(7)=0;Enrg(8)=0;Enrg(9)=0;
            for J=1:NI
                jj=ceil(J/3); 
                nn= mod(J,3); 
                if nn==0
                    nn=3;
                end
                
                if jj==1    
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                    end
                    ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp1(I,nn)-Wsp2(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp1(I,nn)+Wsp2(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                end
                                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                end
                                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)   
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                                end
                                ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            else         
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            end
                            Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));

                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp1(I,nn)-Wsp2(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI1,dIh1,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                        end
                        ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws1,whs1,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp1(I,nn)=0;Wsp2(I,nn)=0;
                            else
                                Wsp1(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*7/9;    
                                Wsp2(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*2/9;
                                Qout(I,J)=Qout(I,J)-2*(Wsp1(I,nn)+Wsp2(I,nn))/DT;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2)+Qout(I,J))*DT-Wsp1(I,nn)-Wsp2(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp1(I,nn)-Wsp2(I,nn);
                            end
                            ZZ(I,J)=interp1(whs1,hws1,VZZ(I,J));
                        end
                    end         
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp1(I,1)+Wsp1(I,2)+Wsp1(I,3)+Wsp2(I,1)+Wsp2(I,2)+Wsp2(I,3));
                    end
                    
                elseif jj==2     
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                    end
                    ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp7(I,nn)-Wsp8(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp7(I,nn)+Wsp8(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                end
                                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                end
                                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                                end
                                ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp7(I,nn)-Wsp8(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                        end
                        ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws2,whs2,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp7(I,nn)=0;Wsp8(I,nn)=0;
                            else
                                Wsp7(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*60/63;    
                                Wsp8(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*3/63;
                                Qout(I,J)=Qout(I,J)-2*(Wsp7(I,nn)+Wsp8(I,nn))/DT;    

                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp7(I,nn)-Wsp8(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp7(I,nn)-Wsp8(I,nn);
                            end
                            ZZ(I,J)=interp1(whs2,hws2,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.16*Wsp7(I,1)+0.5*Wsp8(I,1)...
                            +0.16*Wsp7(I,2)+0.5*Wsp8(I,2)+0.16*Wsp7(I,3)+0.5*Wsp8(I,3)+0.533*Enrg(jj)/10000;
                    end
                    
                elseif jj==3     
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1    
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI3,dIh3,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=Wsp10(I,nn)+Wsp11(I,nn)+0.1;   
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws3,whs3,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)-0.1<=0  
                                Qout(I,J)=0.1;Wsp10(I,nn)=0;Wsp11(I,nn)=0;     
                            elseif Qout(I,J)-0.1>=0 && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp11(I,nn)-10)/DT   
                                Wsp10(I,nn)=0;    
                                Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT;                     

                            elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Wsp11(I,nn)-10)/DT && 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=(Wsp10(I,nn)+Wsp11(I,nn))/DT
                                
                                Wsp10(I,nn)=min(Dk,(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT);
                                Wsp11(I,nn)=(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*DT-Wsp10(I,nn);
                            else
                                msgbox('mistake in line 903 for resevoir 3');
                            end

                            if Wsp11(I,nn)+SP1<Di+Dj
                                Wsp12(I,nn)=0;
                                Wsp21(I,nn)=(Wsp11(I,nn)+SP1)*Di/(Di+Dj);
                                Wsp22(I,nn)=(Wsp11(I,nn)+SP1)-Wsp21(I,nn);
                            else
                                Wsp21(I,nn)=Di;
                                Wsp22(I,nn)=Dj;
                                Wsp12(I,nn)=Wsp11(I,nn)-Di-Dj+SP1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs3,hws3,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp10(I,1)+Wsp11(I,1)...
                            +Wsp10(I,2)+Wsp11(I,2)+Wsp10(I,3)+Wsp11(I,3))+0.57*Enrg(jj)/10000;
                    end
                    
                elseif jj==4     
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                    end
                    ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp13(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp13(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                                end
                                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                                end
                                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                                end
                                ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp13(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI4,dIh4,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                        end
                        ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws4,whs4,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp13(I,nn)=0;
                            else
                                Wsp13(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                                Qout(I,J)=Qout(I,J)-2*Wsp13(I,nn)/DT;

                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp13(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp13(I,nn);
                            end
                            ZZ(I,J)=interp1(whs4,hws4,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;    
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp13(I,1)+Wsp13(I,2)+Wsp13(I,3));
                    end
                    

                elseif jj==5      
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                    end
                    ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp16(I,nn)-Wsp17(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp16(I,nn)+Wsp17(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                                end
                                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                                end
                                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp16(I,nn)-Wsp17(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp16(I,nn)-Wsp17(I,nn);
                                end
                                ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp17(I,nn)-Wsp16(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI5,dIh5,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                        end
                        ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws5,whs5,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp17(I,nn)=0;Wsp16(I,nn)=0;
                            else
                                Wsp17(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*10/35;    
                                Wsp16(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)*5/7;
                                Qout(I,J)=Qout(I,J)-2*(Wsp17(I,nn)+Wsp16(I,nn))/DT;

                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp17(I,nn)-Wsp16(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp17(I,nn)-Wsp16(I,nn);
                            end
                            ZZ(I,J)=interp1(whs5,hws5,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp16(I,1)+Wsp17(I,1)...
                            +Wsp16(I,2)+Wsp17(I,2)+Wsp16(I,3)+Wsp17(I,3))+0.54*Enrg(jj)/10000;
                    end
                    

                elseif jj==6     
                    if  Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)
                        A1=Wsp14(I,nn)/(Wsp14(I,nn)+Wsp15(I,nn));
                        Wsp14(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*A1;
                        Wsp15(I,nn)=(Wsp12(I,nn)+Wsp13(I,nn))*(1-A1);
                        Wsp18(I,nn)=0;
                    elseif Wsp12(I,nn)+Wsp13(I,nn)>Wsp14(I,nn)+Wsp15(I,nn) && Wsp12(I,nn)+Wsp13(I,nn)<=Wsp14(I,nn)+Wsp15(I,nn)+Wsp18(I,nn)+0.00001
                        Wsp18(I,nn)=Wsp12(I,nn)+Wsp13(I,nn)-Wsp14(I,nn)-Wsp15(I,nn);
                    else
                        msgbox('warning！something was wrong in line1286, Wsp12+13 should not>1415+18');
                    end
                    if Wsp18(I,nn)<Df
                        Wsp19(I,nn)=Df-Wsp18(I,nn);
                    else
                        Wsp19(I,nn)=0;
                    end
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                    end
                    ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp19(I,nn)-Wsp23(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp19(I,nn)+Wsp23(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                end
                                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                end
                                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                                end
                                ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp19(I,nn)-Wsp23(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI6,dIh6,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                        end
                        ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws6,whs6,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1<=0 
                                Qout(I,J)=0.1;Wsp19(I,nn)=0;Wsp23(I,nn)=0;
                            elseif 0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1>(Dl+Dm)/DT
                                Wsp23(I,nn)=Dl+Dm;
                                Wsp19(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1)-Wsp23(I,nn);    
                                Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;

                            else
                                Qout(I,J)=Qout(I,J)-2*(Wsp19(I,nn)+Wsp23(I,nn))/DT;
                                Wsp19(I,nn)=0;
                                Wsp23(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp19(I,nn)-Wsp23(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp19(I,nn)-Wsp23(I,nn);
                            end
                            ZZ(I,J)=interp1(whs6,hws6,VZZ(I,J));
                        end
                    end         
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.5*(Wsp19(I,1)+Wsp19(I,2)+Wsp19(I,3))+2.14*(Wsp23(I,1)+Wsp23(I,2)+Wsp23(I,3));
                    end
                    

                elseif jj==7      
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                    end
                    ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                                end
                                ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI7,dIh7,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                        end
                        ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws7,whs7,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT;    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT;
                            end
                            ZZ(I,J)=interp1(whs7,hws7,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj))+0.595*Enrg(jj)/10000;
                    end
                    

                elseif jj==8      
                    
                    if nn==1    
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                    end
                    ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp20(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp20(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI2,dIh2,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                                end
                                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                                end
                                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1    
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                                end
                                ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp20(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI8,dIh8,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                        end
                        ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws8,whs8,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp20(I,nn)=0;
                            else
                                Wsp20(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                                Qout(I,J)=Qout(I,J)-2*Wsp20(I,nn)/DT;

                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp20(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp20(I,nn);
                            end
                            ZZ(I,J)=interp1(whs8,hws8,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp20(I,1)+Wsp20(I,2)+Wsp20(I,3))+0.541*Enrg(jj)/10000;
                    end
                    
                elseif jj==9      
                    if nn==1
                        VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                    else   
                        VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                    end
                    ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                    
                    
                    if crtdate>=tt1 && crtdate<=tt2   
                        
                        if Qin(nn+1,jj)>=RCstrn(jj,4)
                            if nn==1 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                                
                                Qout(I,J)=Qout(I,J)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            elseif nn==2 && Vctrl(jj)-VZZ(I,J)<= 0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))*DT-0.5*(Qout(I,J)+Qout(I,J+1))*DT-Wsp9(I,nn)   
                                
                                Qout(I,J+1)=Qout(I,J+1)+0.5*(Qin(nn+1,jj)+Qin(nn+2,jj))-0.5*(Qout(I,J)+Qout(I,J+1))-(Wsp9(I,nn)+Vctrl(jj)-VZZ(I,J))/DT;
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            end
                            Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                            if Qout(I,J)>=Qoutmax(jj)
                                Qout(I,J)=Qoutmax(jj);
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                                end
                                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            end
                            
                        elseif Qin(nn+1,jj)>=RCstrn(jj,7) && Qin(nn+1,jj)<=RCstrn(jj,4)
                            if ZZ(I,J)>WLcrct(jj,3)
                                ZZ(I,J)=WLcrct(jj,3);
                                VZZ(I,J)=Vctrl(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                                else
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                                end
                                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            end
                            
                        else
                            if ZZ(I,J)>WLcrct(jj,1)
                                Qout(I,J)=RCstrn(jj,7);   
                                if nn==1
                                    VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                                else   
                                    VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                                end
                                ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            else
                                ZZ(I,J)=WLcrct(jj,1);
                                VZZ(I,J)=Vlm(jj);
                                if nn==1          
                                    Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                else
                                    Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                                end
                            end
                            Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                            Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                            if Qout(I,J)>=Qcstrn
                                Qout(I,J)=Qcstrn;
                            elseif Qout(I,J)<=0.1
                                Qout(I,J)=0.1;
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end  
                    else   
                        if ZZ(I,J)>WLcrct(jj,2)
                            ZZ(I,J)=WLcrct(jj,2);
                            VZZ(I,J)=Vn(jj);
                        end
                        if nn==1          
                            Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                        else
                            Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J)-Wsp9(I,nn))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                        end
                        
                        Qoutmax(jj)=interp1(hdI9,dIh9,ZZ(I,J));     
                        Qcstrn=min(RCstrn(jj,4),Qoutmax(jj));       
                        if Qout(I,J)>=Qcstrn
                            Qout(I,J)=Qcstrn;
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                            
                            
                        end
                    end   

                    
                    if ZZ(I,J)<=RCstrn(jj,2)   
                        Qout(I,J)=0.1;
                        if nn==1
                            VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                        else   
                            VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                        end
                        ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        if ZZ(I,J)<=RCstrn(jj,2)   
                            ZZ(I,J)=RCstrn(jj,2);
                            VZZ(I,J)=interp1(hws9,whs9,ZZ(I,J));
                            if nn==1              
                                Qout(I,J)=2*(VZcrnt(jj)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Rcrnt(2*jj);
                                
                            else
                                Qout(I,J)=2*(VZZ(I,J-1)-VZZ(I,J))/DT+Qin(nn,jj)+Qin(nn+1,jj)-Qout(I,J-1);
                            end
                            if Qout(I,J)<=0.1  
                                Qout(I,J)=0.1;Wsp9(I,nn)=0;
                            else
                                Wsp9(I,nn)=DT*(0.5*Qout(I,J)+0.5*Qout(I,J-1)-0.1);    
                                
                                Qout(I,J)=Qout(I,J)-2*Wsp9(I,nn)/DT;  
                                
                                
                                
                                
                                
                            end
                            if nn==1
                                VZZ(I,J)=VZcrnt(jj)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Rcrnt(2*jj)+Qout(I,J))*DT-Wsp9(I,nn);    
                            else
                                VZZ(I,J)=VZZ(I,J-1)+0.5*(Qin(nn,jj)+Qin(nn+1,jj))*DT-0.5*(Qout(I,J)+Qout(I,J-1))*DT-Wsp9(I,nn);
                            end
                            ZZ(I,J)=interp1(whs9,hws9,VZZ(I,J));
                        end
                    end
                    
                    if Qout(I,J)<=RCstrn(jj, 3)   
                        Qfa(I,J)=0;
                    elseif Qout(I,J)>=RCstrn(jj, 8)
                        Qfa(I,J)=RCstrn(jj, 8);
                    else
                        Qfa(I,J)=Qout(I,J);
                    end
                    Qspls(I,J)=Qout(I,J)-Qfa(I,J);     
                    if ZZ(I,J)>=RCstrn(jj,1)       
                        Navrg(I,J)=Kf*Qfa(I,J)*(ZZ(I,J)-RCstrn(jj,6));
                        if Navrg(I,J)>RCstrn(jj,5)            
                            Navrg(I,J)=RCstrn(jj,5);
                        end
                    else
                        Navrg(I,J)=0;             
                    end
                    Enrg(jj)= Enrg(jj)+Navrg(I,J)*DT/3600;
                    if nn==3       
                        VWtr(jj)=0.5*(VZZ(I,J)-VZcrnt(jj)+Wsp9(I,1)+Wsp9(I,2)+Wsp9(I,3))+0.541*Enrg(jj)/10000;
                    end
                end
                
                
                
                
                
                
            end    
            
            
            for nn=1:Ni
                if Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))
                    Wsp4(I,nn)=Wsp8(I,nn)+Wsp9(I,nn);   
                    Wsp3(I,nn)=0;Wsp5(I,nn)=0;Wsp6(I,nn)=0;
                elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))
                    Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                    Wsp5(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn)); 
                    Wsp3(I,nn)=0;Wsp6(I,nn)=0;
                elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn)) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)
                    Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                    Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                    Wsp6(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn));
                    Wsp3(I,nn)=0;
                elseif Wsp8(I,nn)+Wsp9(I,nn)>=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn) && Wsp8(I,nn)+Wsp9(I,nn)<=min(30,Da-Wsp1(I,nn))+min(35,Dc-Wsp20(I,nn))+De-Wsp14(I,nn)+Db-Wsp2(I,nn)+0.0000001
                    Wsp4(I,nn)=min(30,Da-Wsp1(I,nn));   
                    Wsp5(I,nn)=min(35,Dc-Wsp20(I,nn));
                    Wsp6(I,nn)=De-Wsp14(I,nn);
                    Wsp3(I,nn)=Wsp8(I,nn)+Wsp9(I,nn)-min(30,Da-Wsp1(I,nn))-min(35,Dc-Wsp20(I,nn))-De+Wsp14(I,nn);
                else
                    msgbox('sth.was wrong in line 1978')
                end   
            end
            Pwr(I)= Enrg(2)+Enrg(3)+Enrg(5)+Enrg(7)+Enrg(8)+Enrg(9);
            Vwr(I)= VWtr(1)+VWtr(2)+VWtr(3)+VWtr(4)+VWtr(5)+VWtr(6)+VWtr(7)+VWtr(8)+VWtr(9);
            Wsp(I,:)=[Wsp1(I,:) Wsp2(I,:) Wsp3(I,:) Wsp4(I,:) Wsp5(I,:) Wsp6(I,:) Wsp7(I,:) Wsp8(I,:)...
                Wsp9(I,:) Wsp10(I,:) Wsp11(I,:) Wsp12(I,:) Wsp13(I,:) Wsp14(I,:) Wsp15(I,:) Wsp16(I,:)...
                Wsp17(I,:) Wsp18(I,:) Wsp19(I,:) Wsp20(I,:) Wsp21(I,:) Wsp22(I,:) Wsp23(I,:)];
            Vrb(I,:)=[Qout(I,:) Wsp(I,:)];   
            
            
            
            
            
            
        end
        lmt=0;
    end

    
    

    A=[Vrb Vwr Indx];  
    clmnmb=numel(A(1, :))-1;
    B=sortrows(A,clmnmb);     
    Vrb= B(:,1:clmnmb-1);
    Vwr = B(:,clmnmb);
    
    FtFct(kk)=Vwr(M);    
end
Idm= B(M,clmnmb+1);
RR=(1:Itrnmb);
TT=1:clmnmb;
TT1=1:36;
Qqin=[Qin(1:4,1)' Qin(1:4,2)' Qin(1:4,3)' Qin(1:4,4)' Qin(1:4,5)' Qin(1:4,6)' Qin(1:4,7)' Qin(1:4,8)' Qin(1:4,9)'];
Qqo=[Rcrnt(2) B(M,1:3) Rcrnt(4) B(M,4:6) Rcrnt(6) B(M,7:9) Rcrnt(8) B(M,10:12) Rcrnt(10)...
    B(M,13:15) Rcrnt(12) B(M,16:18) Rcrnt(14) B(M,19:21) Rcrnt(16) B(M,22:24) Rcrnt(18) B(M,25:27)];
Z=[Rcrnt(1) ZZ(Idm,1:3) Rcrnt(3) ZZ(Idm,4:6) Rcrnt(5) ZZ(Idm,7:9) Rcrnt(7) ZZ(Idm,10:12) Rcrnt(9)...
    ZZ(Idm,13:15) Rcrnt(11) ZZ(Idm,16:18) Rcrnt(13) ZZ(Idm,19:21) Rcrnt(15) ZZ(Idm,22:24)  Rcrnt(17) ZZ(Idm,25:27)];
V=[VZcrnt(1) VZZ(Idm,1:3) VZcrnt(2) VZZ(Idm,4:6) VZcrnt(3) VZZ(Idm,7:9) VZcrnt(4) VZZ(Idm,10:12) VZcrnt(5)...
    VZZ(Idm,13:15) VZcrnt(6) VZZ(Idm,16:18) VZcrnt(7) VZZ(Idm,19:21) VZcrnt(8) VZZ(Idm,22:24) VZcrnt(9) VZZ(Idm,25:27)];
ku=1;
for chu=1:35
    mo=chu+1;
    day=mod(chu,4);
    if day==0
        ku=ku+1;
    else
        Vchu(ku,day)=(Qqo(chu)+Qqo(mo))/2*DT;
    end
end
Zyc=[ZZ(Idm,1:3);ZZ(Idm,4:6);ZZ(Idm,7:9);ZZ(Idm,10:12);ZZ(Idm,13:15);ZZ(Idm,16:18);ZZ(Idm,19:21);ZZ(Idm,22:24);ZZ(Idm,25:27)];
Vyc=[VZZ(Idm,1:3);VZZ(Idm,4:6);VZZ(Idm,7:9);VZZ(Idm,10:12);VZZ(Idm,13:15);VZZ(Idm,16:18);VZZ(Idm,19:21);VZZ(Idm,22:24);VZZ(Idm,25:27)];
sp1=SP1*ones(1,3);
WSP=Wsp1(Idm,:)+Wsp2(Idm,:)+Wsp7(Idm,:)+Wsp8(Idm,:)+Wsp10(Idm,:)+Wsp11(Idm,:)+Wsp13(Idm,:)+Wsp16(Idm,:)+Wsp17(Idm,:)+Wsp20(Idm,:)+Wsp19(Idm,:)+Wsp9(Idm,:)+Wsp23(Idm,:)+sp1;
XYWSP=0.5*(Wsp1(Idm,:)+Wsp2(Idm,:)+Wsp8(Idm,:)+Wsp10(Idm,:)+Wsp11(Idm,:)+Wsp13(Idm,:)+Wsp16(Idm,:)+Wsp17(Idm,:)+Wsp20(Idm,:)+Wsp19(Idm,:)+Wsp9(Idm,:)+sp1)+0.16*Wsp7(Idm,:)+2.14*Wsp23(Idm,:);
QFA=Qfa(Idm,:)*86400;
WFA=[QFA(1:3);QFA(4:6);QFA(7:9);QFA(10:12);QFA(13:15);QFA(16:18);QFA(19:21);QFA(22:24);QFA(25:27)];
PWR=Pwr(M);
Result=[TT;B(:,1:clmnmb)];
Result1=[RR;FtFct']';
Result2=[TT1;Qqin;Qqo;Z;V]';
Result3=Vchu;   
Result4=Zyc;    
Result5=Vyc;    
Result6=WSP;    
Result7=WFA;    
Result9=PWR;    
Result10=XYWSP; 
AQD1=aqd(xlsFilePath4,Result5);
Dtinput=xlsread(xlsFilePath4,'input');
GSBZL=sum(WSP);
gsbzl1=sum(Dtinput(1,1:13))*3;
GSBZ=GSBZL/gsbzl1;


zhongjian=[Result2(1:4,4) Result2(1:4,3) Result2(5:8,4) Result2(5:8,3) Result2(9:12,4) Result2(9:12,3) Result2(13:16,4) Result2(13:16,3) Result2(17:20,4) Result2(17:20,3) ... 
    Result2(21:24,4) Result2(21:24,3) Result2(25:28,4) Result2(25:28,3) Result2(29:32,4) Result2(29:32,3) Result2(33:36,4) Result2(33:36,3)];




[type, sheets] = xlsfinfo(xlsFilePath1); 
xlswrite(xlsFilePath1, Result, 1, 'A2');
xlswrite(xlsFilePath1, Result1, 2, 'A2');
xlswrite(xlsFilePath1, Result2, 3, 'A2');
xlswrite(xlsFilePath1, Result3, 4, 'A2');
xlswrite(xlsFilePath1, Result4, 5, 'A2');
xlswrite(xlsFilePath1, Result5, 6, 'A2');
xlswrite(xlsFilePath1, Result6, 7, 'A2');
xlswrite(xlsFilePath1, Result7, 8, 'A2');
xlswrite(xlsFilePath1, Result8, 9, 'A2');
xlswrite(xlsFilePath1, Result9, 10, 'A2');
xlswrite(xlsFilePath1, AQD1, 11, 'A2');

xlswrite(xlsFilePath1, GSBZ, 12, 'A2');

