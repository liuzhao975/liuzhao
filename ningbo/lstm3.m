
 today = datetime('today', 'Format', 'yyyy/MM/dd')
 
 
 
 
 futureDates = today + caldays(1:3)
 for i = 1:3  
    datestr(futureDates(i), 'yyyy/MM/dd');  
 end
 futureDates=string(futureDates)
 futureDatesStr=vertcat(futureDates{:})
 targetFile = xlsFilePath0;
 targetSheet = 'sheet1';  
 targetTable = readtable(targetFile, 'Sheet', targetSheet);
 dateColumn2 = datetime(targetTable.(1),'InputFormat', 'yyyy/MM/dd')
 dateColumn2.Format = 'yyyy/MM/dd'
 matchingRow2 = find(dateColumn2 == today);
 row = matchingRow2+1
 col = 1
 cellPos = sprintf('%s%d', char('A' + col - 1), row);
 writematrix(futureDatesStr, targetFile, 'Sheet', targetSheet, 'Range', cellPos);
 for t = 2:1:10 
   
    today = datetime('today', 'Format', 'yyyy-MM-dd') 
    sourceFile = xlsFilePath0;
    sourceSheet = 'sheet3';
    sourceTable = readtable(sourceFile, 'Sheet', sourceSheet);
    dateColumn = datetime(sourceTable.(1), 'InputFormat', 'yyyy/MM/dd');
    dateColumn.Format = 'yyyy-MM-dd'
    dataColumn = sourceTable.(t);  
 
    matchingRow = find(dateColumn == today);
    realdata=dataColumn(matchingRow)
    targetFile = xlsFilePath0;
    targetSheet = 'sheet1'; 
    targetTable = readtable(targetFile, 'Sheet', targetSheet);
    dateColumn2 = datetime(targetTable.(1),'InputFormat', 'yyyy/MM/dd')
    dateColumn2.Format = 'yyyy-MM-dd'
    matchingRow2 = find(dateColumn2 == today);
    row = matchingRow2
    col = t
    cellPos = sprintf('%s%d', char('A' + col - 1), row);
    writematrix(realdata, targetFile, 'Sheet', targetSheet, 'Range', cellPos);
end
     for j = 1:1:9
    data=xlsread(xlsFilePath0,"Sheet1");
    data=data(:,j)
    data=rmmissing(data)
    
    numTimeStepsTrain = floor(0.97*numel(data));
    dataTrain = data(1 : numTimeStepsTrain+1);
    dataTest = data(numTimeStepsTrain+1 : end);
    mu = mean(dataTrain);
    sig = std(dataTrain);
    dataTrainStandardized = (dataTrain - mu) / sig;
    XTrain = dataTrainStandardized(1:end-1)';
    YTrain = dataTrainStandardized(2:end)';
    numFeatures = 1;
    numResponses = 1;
    numHiddenUnits = 250;
    layers = [sequenceInputLayer(numFeatures)
              lstmLayer(numHiddenUnits)
              fullyConnectedLayer(numResponses)
              regressionLayer];
     options = trainingOptions('adam', ...
          'MaxEpochs', 200, ...
          'GradientThreshold', 1, ...
          'InitialLearnRate', 0.001, ...
          'LearnRateSchedule', 'piecewise', ...
          'LearnRateDropPeriod', 175, ...
          'LearnRateDropFactor', 0.001, ...
          'Verbose', 1, ... 
          'Plots', 'none')
     net = trainNetwork(XTrain,YTrain,layers,options);
     dataTestStandardized = (dataTest - mu) / sig;
     XTest = dataTestStandardized(1 : end-1)';
     net = predictAndUpdateState(net, XTrain);
     [net, YPred] = predictAndUpdateState(net, YTrain(end));
     pre_step=3
     net=resetState(net)        
     for i =2:pre_step
     [net, YPred(:, i)] = predictAndUpdateState(net, YPred(:, i-1), 'ExecutionEnvironment', 'cpu');
     end
     YPred = sig*YPred + mu;
    YPred = YPred'*10000/86400;
     
     [~,textdate]=xlsread(xlsFilePath0,'sheet2')
     crtdate = datetime('now','TimeZone','local','Format','yyyy/MM/dd');%'d-MMM-y HH:mm:ss Z'
     str2=':';
     dtstr=datevec(crtdate);
     dtstr(4:6)=0;   
     
     Date=datevec(datestr(textdate(2:end,1),'mmmm dd, yyyy'),'mmmm dd, yyyy');
     Dindx=find(ismember(Date,dtstr,'rows'));
     x_Rdrng2=num2str(Dindx+1)
     if j==1
          x_Rdrng2=['B',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==2
          x_Rdrng2=['C',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred    ,"sheet2",x_Rdrng2)
     elseif j==3 
          x_Rdrng2=['D',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==4
          x_Rdrng2=['E',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==5
          x_Rdrng2=['F',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==6
          x_Rdrng2=['G',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==7 
          x_Rdrng2=['H',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     elseif j==8
          x_Rdrng2=['I',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     else 
         x_Rdrng2=['J',x_Rdrng2];
          xlswrite(xlsFilePath0,YPred,"sheet2",x_Rdrng2)
     end
 
sheet2_data = xlsread(xlsFilePath0, 'Sheet2');
yuce = sheet2_data(1:3, 1:9); 
Result8=yuce';
for j = 1:9
    data = xlsread(xlsFilePath0,"Sheet1");
    data = data(:,j);
    data = rmmissing(data);
    jichu(j) = data(end);
end
[~,textdate] = xlsread(xlsFilePath3,'Qin');
Date=datevec(datestr(textdate,'mmmm dd, yyyy'),'mmmm dd, yyyy');
Dindx=find(ismember(Date,dtstr,'rows'));
x_Rdrng2=num2str(Dindx+1);
x_Rdrng2=['B',x_Rdrng2];
xlswrite(xlsFilePath3,yuce,'Qin',x_Rdrng2);
sourceFile = xlsFilePath0;
sourceSheet = 'Sheet1';
sourceTable = readtable(sourceFile, 'Sheet', sourceSheet);
dateColumn = datetime(sourceTable.(1), 'InputFormat', 'yyyy/MM/dd');
matchingRow = find(dateColumn == today);
startRow = matchingRow + 1;
cellPos = sprintf('%s%d', char('A' + col - 1- 8), startRow);
writematrix(yuce, targetFile, 'Sheet', targetSheet, 'Range', cellPos);
     close all hidden
     end
