function InterneuronPropAllRec(onlyRun)

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal = 'Z:\Yingxue\Draft\PV\interneuron\';
    
    GlobalConstFq;
    
    if(exist([pathAnal 'autoCorrIntAllRec.mat']))
        load([pathAnal 'autoCorrIntAllRec.mat']);
    end

    if(exist('autoCorrIntNoCue') == 0)
        %% interneurons in no cue passive task
        disp('No cue')
        autoCorrIntNoCue = accumInterneurons(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,minFRInt,1,methodTheta,onlyRun);

        %% interneurons in active licking task
        disp('Active licking')
        autoCorrIntAL = accumInterneurons(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,minFRInt,2,methodTheta,onlyRun);

        %% interneurons in passive licking task with start cues
        disp('Passive licking')
        autoCorrIntPL = accumInterneurons(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFRInt,3,methodTheta,onlyRun);

        autoCorrIntAll.ccgVal = [autoCorrIntNoCue.ccgVal;autoCorrIntAL.ccgVal;autoCorrIntPL.ccgVal];
        autoCorrIntAll.peakTo40ms = [autoCorrIntNoCue.peakTo40ms,autoCorrIntAL.peakTo40ms,autoCorrIntPL.peakTo40ms];
        autoCorrIntAll.mean = [autoCorrIntNoCue.mean,autoCorrIntAL.mean,autoCorrIntPL.mean];
        autoCorrIntAll.refract = [autoCorrIntNoCue.refract,autoCorrIntAL.refract,autoCorrIntPL.refract];
        autoCorrIntAll.burstInd = [autoCorrIntNoCue.burstInd,autoCorrIntAL.burstInd,autoCorrIntPL.burstInd];
        autoCorrIntAll.peakTime = [autoCorrIntNoCue.peakTime,autoCorrIntAL.peakTime,autoCorrIntPL.peakTime];

        autoCorrIntAll.phaseMeanDire = [autoCorrIntNoCue.phaseMeanDire,autoCorrIntAL.phaseMeanDire,autoCorrIntPL.phaseMeanDire]; 
        autoCorrIntAll.thetaModHist = [autoCorrIntNoCue.thetaModHist,autoCorrIntAL.thetaModHist,autoCorrIntPL.thetaModHist]; 
        autoCorrIntAll.maxPhaseArr = [autoCorrIntNoCue.maxPhaseArr,autoCorrIntAL.maxPhaseArr,autoCorrIntPL.maxPhaseArr]; 
        autoCorrIntAll.minPhaseArr = [autoCorrIntNoCue.minPhaseArr,autoCorrIntAL.minPhaseArr,autoCorrIntPL.minPhaseArr]; 
        autoCorrIntAll.maxPhaseOArr = [autoCorrIntNoCue.maxPhaseOArr,autoCorrIntAL.maxPhaseOArr,autoCorrIntPL.maxPhaseOArr]; 
        autoCorrIntAll.minPhaseOArr = [autoCorrIntNoCue.minPhaseOArr,autoCorrIntAL.minPhaseOArr,autoCorrIntPL.minPhaseOArr]; 
        autoCorrIntAll.histPhaseFil = [autoCorrIntNoCue.histPhaseFil;autoCorrIntAL.histPhaseFil;autoCorrIntPL.histPhaseFil];
        autoCorrIntAll.histPhase = [autoCorrIntNoCue.histPhase;autoCorrIntAL.histPhase;autoCorrIntPL.histPhase];

        autoCorrIntAll.isSpikeHighAmp = [autoCorrIntNoCue.isSpikeHighAmp,autoCorrIntAL.isSpikeHighAmp,autoCorrIntPL.isSpikeHighAmp];
        autoCorrIntAll.isSpikeHighAmp200 = [autoCorrIntNoCue.isSpikeHighAmp200,autoCorrIntAL.isSpikeHighAmp200,autoCorrIntPL.isSpikeHighAmp200];
        autoCorrIntAll.relDepthNeuHDef = [autoCorrIntNoCue.relDepthNeuHDef,autoCorrIntAL.relDepthNeuHDef,autoCorrIntPL.relDepthNeuHDef];      

        autoCorrIntAll.task = [autoCorrIntNoCue.task,autoCorrIntAL.task,autoCorrIntPL.task];
        autoCorrIntAll.indRec = [autoCorrIntNoCue.indRec,autoCorrIntAL.indRec,autoCorrIntPL.indRec];
        autoCorrIntAll.indNeu = [autoCorrIntNoCue.indNeu,autoCorrIntAL.indNeu,autoCorrIntPL.indNeu];

        RecordingListTagging;
        autoCorrIntTag = accumInterneuronsTag(listRecordingsTaggingPath,...
            listRecordingsTaggingFileName,listRecordingsTaggingMazeSess,...
            minFRInt,listRecordingsTaggingTask,...
            listRecordingsTaggingIndRec,listRecordingsTaggingCellType,...
            methodTheta,onlyRun);
        
        if(exist([pathAnal 'autoCorrIntAllRec.mat']))
            save([pathAnal 'autoCorrIntAllRec.mat'],'autoCorrIntNoCue','autoCorrIntAL',...
                'autoCorrIntPL','autoCorrIntTag','autoCorrIntAll','-append');
        else
            save([pathAnal 'autoCorrIntAllRec.mat'],'autoCorrIntNoCue','autoCorrIntAL',...
                'autoCorrIntPL','autoCorrIntTag','autoCorrIntAll');
        end
    
        [autoCorrIntAll.idxC,autoCorrIntAll.klust] = kmeansInterneurons(autoCorrIntAll);

        [autoCorrIntAll.idxC1,autoCorrIntAll.klust1,...
            autoCorrIntAll.scorekm11,autoCorrIntAll.explainedkm11,...
            autoCorrIntAll.scorekm12,autoCorrIntAll.explainedkm12...
            ] = kmeansInterneurons1(autoCorrIntAll);

        [autoCorrIntAll.idxC2,autoCorrIntAll.klust2,...
            autoCorrIntAll.scorekm21,autoCorrIntAll.explainedkm21,...
            autoCorrIntAll.scorekm22,autoCorrIntAll.explainedkm22...
            ] = kmeansInterneurons2(autoCorrIntAll);

        [autoCorrIntAll.idxC3,autoCorrIntAll.klust3,...
            autoCorrIntAll.scorekm31,autoCorrIntAll.explainedkm31,...
            autoCorrIntAll.scorekm32,autoCorrIntAll.explainedkm32...
            ] = kmeansInterneurons3(autoCorrIntAll);

    %     [autoCorrIntAll.idxC3,autoCorrIntAll.klust3,...
    %         autoCorrIntAll.TSNE1,autoCorrIntAll.TSNE2...
    %         ] = kmeansInterneurons3(autoCorrIntAll);

        autoCorrIntAll.relDepthNeuHDefC1 = [];
        autoCorrIntAll.relDepthNeuHDefMean = zeros(1,length(unique(autoCorrIntAll.idxC1)));
        for i = 1:max(autoCorrIntAll.idxC1)
            idxCurC = autoCorrIntAll.idxC1 == i;
            autoCorrIntAll.relDepthNeuHDefC1{i} = autoCorrIntAll.relDepthNeuHDef(idxCurC);
            autoCorrIntAll.relDepthNeuHDefMean1(i) = mean(autoCorrIntAll.relDepthNeuHDefC1{i});
        end

        autoCorrIntAll.relDepthNeuHDefC2 = [];
        autoCorrIntAll.relDepthNeuHDefMean = zeros(1,length(unique(autoCorrIntAll.idxC2)));
        for i = 1:max(autoCorrIntAll.idxC2)
            idxCurC = autoCorrIntAll.idxC2 == i;
            autoCorrIntAll.relDepthNeuHDefC2{i} = autoCorrIntAll.relDepthNeuHDef(idxCurC);
            autoCorrIntAll.relDepthNeuHDefMean2(i) = mean(autoCorrIntAll.relDepthNeuHDefC2{i});
        end

        autoCorrIntAll.relDepthNeuHDefC3 = [];
        autoCorrIntAll.relDepthNeuHDefMean = zeros(1,length(unique(autoCorrIntAll.idxC3)));
        for i = 1:max(autoCorrIntAll.idxC3)
            idxCurC = autoCorrIntAll.idxC3 == i;
            autoCorrIntAll.relDepthNeuHDefC3{i} = autoCorrIntAll.relDepthNeuHDef(idxCurC);
            autoCorrIntAll.relDepthNeuHDefMean3(i) = mean(autoCorrIntAll.relDepthNeuHDefC3{i});
        end

        autoCorrIntTag.idxC = zeros(1,length(autoCorrIntTag.task));
        autoCorrIntTag.idxC1 = zeros(1,length(autoCorrIntTag.task));
        autoCorrIntTag.idxC2 = zeros(1,length(autoCorrIntTag.task));
        autoCorrIntTag.idxC3 = zeros(1,length(autoCorrIntTag.task));
    %     autoCorrIntTag.TSNE1 = ...
    %         zeros(length(autoCorrIntTag.task),size(autoCorrIntAll.TSNE1,2));
    %     autoCorrIntTag.TSNE2 = ...
    %         zeros(length(autoCorrIntTag.task),size(autoCorrIntAll.TSNE2,2));
        for i = 1:length(autoCorrIntTag.task)
            indNeu = autoCorrIntAll.task == autoCorrIntTag.task(i) &...
                autoCorrIntAll.indRec == autoCorrIntTag.indRec(i) &...
                autoCorrIntAll.indNeu == autoCorrIntTag.indNeu(i);
            autoCorrIntTag.idxC(i) = autoCorrIntAll.idxC(indNeu);
            autoCorrIntTag.idxC1(i) = autoCorrIntAll.idxC1(indNeu);
            autoCorrIntTag.idxC2(i) = autoCorrIntAll.idxC2(indNeu);
            autoCorrIntTag.idxC3(i) = autoCorrIntAll.idxC3(indNeu);
            autoCorrIntTag.scorekm11(i,:) = autoCorrIntAll.scorekm11(indNeu,:);
            autoCorrIntTag.scorekm12(i,:) = autoCorrIntAll.scorekm12(indNeu,:);
            autoCorrIntTag.scorekm21(i,:) = autoCorrIntAll.scorekm21(indNeu,:);
            autoCorrIntTag.scorekm22(i,:) = autoCorrIntAll.scorekm22(indNeu,:);
            autoCorrIntTag.scorekm31(i,:) = autoCorrIntAll.scorekm31(indNeu,:);
            autoCorrIntTag.scorekm32(i,:) = autoCorrIntAll.scorekm32(indNeu,:);
    %         autoCorrIntTag.TSNE1(i,:) = autoCorrIntAll.TSNE1(indNeu,:);
    %         autoCorrIntTag.TSNE2(i,:) = autoCorrIntAll.TSNE2(indNeu,:);
        end

        if(exist([pathAnal 'autoCorrIntAllRec.mat']))
            save([pathAnal 'autoCorrIntAllRec.mat'],'autoCorrIntNoCue','autoCorrIntAL',...
                'autoCorrIntPL','autoCorrIntTag','autoCorrIntAll','-append');
        else
            save([pathAnal 'autoCorrIntAllRec.mat'],'autoCorrIntNoCue','autoCorrIntAL',...
                'autoCorrIntPL','autoCorrIntTag','autoCorrIntAll');
        end
    end
    
    plotClusterPCA(pathAnal,autoCorrIntAll,autoCorrIntTag);
    
    idxTagPV = autoCorrIntTag.cellType == 1;
    plotKmeanResult(autoCorrIntAll,autoCorrIntTag,idxTagPV,'All Interneurons','PV',pathAnal);
    idxTagSST = autoCorrIntTag.cellType == 2;
    plotKmeanResult(autoCorrIntAll,autoCorrIntTag,idxTagSST,'All Interneurons','SST',pathAnal);
    
    cluPV = [3 4];
    cluSST = [2 4];
    plotClusterTagged(pathAnal,autoCorrIntAll,autoCorrIntTag,cluPV,cluSST);
    
    save([pathAnal 'autoCorrIntAllRec.mat'],'cluPV','cluSST','-append');
    
    %% plot figures
%     %% peak time vs. burst index
%     plotComp(autoCorrIntNoCue.peakTime,autoCorrIntNoCue.burstInd,...
%         'PL-NoCue peak time (ms)','PL-NoCue burst index');
%     
%     plotComp(autoCorrIntAL.peakTime,autoCorrIntAL.burstInd,...
%         'AL peak time (ms)','AL burst index');
%     
%     plotComp(autoCorrIntPL.peakTime,autoCorrIntPL.burstInd,...
%         'PL peak time (ms)','PL burst index');
%     
%     %% peak time vs. peak to 40 ms mean
%     plotComp(autoCorrIntNoCue.peakTime,autoCorrIntNoCue.peakTo40ms,...
%         'PL-NoCue peak time (ms)','PL-NoCue peak to 40-50 ms');
%     
%     plotComp(autoCorrIntAL.peakTime,autoCorrIntAL.peakTo40ms,...
%         'AL peak time (ms)','AL peak to 40-50 ms');
%     
%     plotComp(autoCorrIntPL.peakTime,autoCorrIntPL.peakTo40ms,...
%         'PL peak time (ms)','PL peak to 40-50 ms');
%     
%     %% peak time vs. peak to 40 ms mean
%     plotComp(autoCorrIntNoCue.peakTime,autoCorrIntNoCue.peakToMean,...
%         'PL-NoCue peak time (ms)','PL-NoCue peak to mean');
%     
%     plotComp(autoCorrIntAL.peakTime,autoCorrIntAL.peakToMean,...
%         'AL peak time (ms)','AL peak to mean');
%     
%     plotComp(autoCorrIntPL.peakTime,autoCorrIntPL.peakToMean,...
%         'PL peak time (ms)','PL peak to mean');
%     
%     %% refractory vs. peak to 40 ms mea
%     plotComp(autoCorrIntNoCue.refract,autoCorrIntNoCue.burstInd,...
%         'PL-NoCue refractory (ms)','PL-NoCue burst index');
%     
%     plotComp(autoCorrIntAL.refract,autoCorrIntAL.burstInd,...
%         'AL refractory (ms)','AL burst index');
%     
%     plotComp(autoCorrIntPL.refract,autoCorrIntPL.burstInd,...
%         'PL refractory (ms)','PL burst index');
    
    %% refractory vs. peak time
    plotComp(autoCorrIntAL.refract,autoCorrIntAL.peakTime,...
        'AL refractory (ms)','AL peak time (ms)');
end



function [idxInt,cInt] = gmInterneurons(autoCorr)
%     X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire'];
    X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire' autoCorr.thetaModHist']; % autoCorr.maxPhaseArr'];
    klist = [2:10];
    len = 500;
    options = statset('MaxIter',500);
    AIC = zeros(1,length(klist));
    GMModels = zeros(1,length(klist));
    for i = klist
        GMModels{i} = fitgmdist(X,i,'Options',options,'CovarianceType','diagonal');
        AIC(i) = GMModels{i}.AIC;
    end
    [minAIC,numC] = min(AIC);
    [~,optimalK] = max(binCount);
    optimalK = klist(optimalK);
    [idxInt,cInt,sumD] = kmeans(X,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
    
end

function [idxInt,cInt] = kmeansInterneurons(autoCorr)
%     X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire'];
    X = [normData1(autoCorr.peakTo40ms') ...
        normData1(autoCorr.refract') ...
        normData1(autoCorr.burstInd') ...
        1.5*normData1(autoCorr.peakTime') ... 1.5
        1.5*normData1(autoCorr.phaseMeanDire') ...
        normData1(autoCorr.thetaModHist') ...
        normData1(autoCorr.maxPhaseArr') ... 2
        normData1(autoCorr.minPhaseArr') ...
        normData1(autoCorr.relDepthNeuHDef')*2];
    klist = [6:10];
    len = 10;
    evaC = [];
    kn = zeros(len,1);
    for i = 1:len
        evaC{i} = evalclusters(X,'kmeans','CalinskiHarabasz','kList',klist);
        kn(i) = evaC{i}.OptimalK;
    end
    binCount = histc(kn,klist);
    [~,optimalK] = max(binCount);
    optimalK = klist(optimalK);
    [idxInt,cInt,sumD] = kmeans(X,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
    
end

function [idxInt,cInt,score1,explained1,score2,explained2] = kmeansInterneurons1(autoCorr)
%     X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire'];
    std1 = 1.5;
    paramT.gaussFilt = gaussFilter(12*std1, std1);
    lenGaussKernel = length(paramT.gaussFilt);
    normFactor = sum(paramT.gaussFilt);
    paramT.gaussFilt = paramT.gaussFilt./normFactor;
    
    [r,c] = size(autoCorr.ccgVal);
    X = zeros(r,c);
    for i = 1:r
        autocor = conv(autoCorr.ccgVal(i,:),paramT.gaussFilt);
        if(mod(lenGaussKernel,2) == 0)
            autocor = ...
                autocor(floor(lenGaussKernel/2)+1:...
                    (end-floor(lenGaussKernel/2))+1); 
        else
            autocor = ...
                autocor(floor(lenGaussKernel/2)+1:...
                    (end-floor(lenGaussKernel/2))); 
        end
        X(i,:) = normData(autocor);        
    end
    
    [coeff,score1,latent,ts,explained1] = pca(X);
    numComp = find(cumsum(explained1) > 99,1); %98
    scoreNorm = score1(:,1:numComp);
    scoreNorm = scoreNorm/max(abs(scoreNorm(:,1))); % normalization based on PC1
%     for i = 1:numComp
%         scoreNorm(:,i) = normData(scoreNorm(:,i));
%     end
    [r,c] = size(autoCorr.histPhaseFil);
    X1 = zeros(r,c);
    for i = 1:r
        X1(i,:) = normData(autoCorr.histPhaseFil(i,:));
    end
    [~,score2,latent2,ts2,explained2] = pca(X1);
    numComp2 = find(cumsum(explained2) > 99,1); %98
    scoreNorm2 = score2(:,1:numComp2);
    scoreNorm2 = scoreNorm2/max(abs(scoreNorm2(:,1))); % normalization based on PC1
%     for i = 1:numComp2
%         scoreNorm2(:,i) = normData(scoreNorm2(:,i));
%     end
%     XAll = [scoreNorm(:,1)*1.3 scoreNorm(:,2:end) scoreNorm2]; %1.5

    depth = autoCorr.relDepthNeuHDef/max(abs(autoCorr.relDepthNeuHDef));
    
    XAll = [scoreNorm scoreNorm2 depth'*2];
    klist = [6:10];
    len = 10;
    evaC = [];
    kn = zeros(len,1);
    for i = 1:len
        evaC{i} = evalclusters(XAll,'kmeans','CalinskiHarabasz','kList',klist);
        kn(i) = evaC{i}.OptimalK;
    end
    binCount = histc(kn,klist);
    [~,optimalK] = max(binCount);
    optimalK = klist(optimalK);
    [idxInt,cInt,sumD] = kmeans(XAll,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
    
end

function [idxInt,cInt,score,explained,score2,explained2] = kmeansInterneurons2(autoCorr)
    
    [r,c] = size(autoCorr.ccgVal);
    X = zeros(r,c);
    for i = 1:r
        X(i,:) = normData(autoCorr.ccgVal(i,:));
    end
    [coeff,score,latent,ts,explained] = pca(X);
    numComp = find(cumsum(explained) > 95,1);
    if(numComp > 30)
        numComp = 30;
    end
    scoreNorm = score(:,1:numComp);
    scoreNorm = scoreNorm/max(abs(scoreNorm(:,1))); % normalization based on PC1
    
    [r,c] = size(autoCorr.histPhase);
    X1 = zeros(r,c);
    for i = 1:r
        X1(i,:) = normData(autoCorr.histPhase(i,:));
    end
    [coeff2,score2,latent2,ts2,explained2] = pca(X1);
    numComp2 = find(cumsum(explained2) > 95,1);
    if(numComp2 > 30)
        numComp2 = 30;
    end
    scoreNorm2 = score2(:,1:numComp2);
    scoreNorm2 = scoreNorm2/max(abs(scoreNorm2(:,1))); % normalization based on PC1
  
    depth = autoCorr.relDepthNeuHDef/max(abs(autoCorr.relDepthNeuHDef));
%     peakTime = autoCorr.peakTime/max(abs(autoCorr.peakTime));

    XAll = [scoreNorm scoreNorm2 depth'*2]; %2
    klist = [6:10];
    len = 10;
    evaC = [];
    kn = zeros(len,1);
    for i = 1:len
        evaC{i} = evalclusters(XAll,'kmeans','CalinskiHarabasz','kList',klist);
        kn(i) = evaC{i}.OptimalK;
    end
    binCount = histc(kn,klist);
    [~,optimalK] = max(binCount);
    optimalK = klist(optimalK);
    [idxInt,cInt,sumD] = kmeans(XAll,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
    
end

% added by Yingxue on 2/23/2022
function [idxInt,cInt,score,explained,score2,explained2] = kmeansInterneurons3(autoCorr)
    
    
    X = zscore(autoCorr.ccgVal'); %% use zscore instead of normalization, because PCA only center the data, not normalizing it
    X = X';
       
    [coeff,score,latent,ts,explained] = pca(X);
    numComp = find(cumsum(explained) > 95,1);
    if(numComp > 30)
        numComp = 30;
    end
    scoreNorm = score(:,1:numComp);
    scoreNorm = scoreNorm/max(abs(scoreNorm(:,1))); % normalization based on PC1
    
    X1 = zscore(autoCorr.histPhase'); %% use zscore instead of normalization, because PCA only center the data, not normalizing it
    X1 = X1';
    
    [coeff2,score2,latent2,ts2,explained2] = pca(X1);
    numComp2 = find(cumsum(explained2) > 95,1);
    if(numComp2 > 30)
        numComp2 = 30;
    end
    scoreNorm2 = score2(:,1:numComp2);
    scoreNorm2 = scoreNorm2/max(abs(scoreNorm2(:,1))); % normalization based on PC1
  
    depth = autoCorr.relDepthNeuHDef/max(abs(autoCorr.relDepthNeuHDef));
%     peakTime = autoCorr.peakTime/max(abs(autoCorr.peakTime));

    XAll = [scoreNorm scoreNorm2 depth'*2]; %2
    klist = [6:10];
    len = 10;
    evaC = [];
    kn = zeros(len,1);
    for i = 1:len
        evaC{i} = evalclusters(XAll,'kmeans','CalinskiHarabasz','kList',klist);
        kn(i) = evaC{i}.OptimalK;
    end
    binCount = histc(kn,klist);
    [~,optimalK] = max(binCount);
    optimalK = klist(optimalK);
    [idxInt,cInt,sumD] = kmeans(XAll,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
    
end

% function [idxInt,cInt,Y,Y1] = kmeansInterneurons3(autoCorr)
%     X0 = [autoCorr.peakTo40ms'/max(abs(autoCorr.peakTo40ms))...
%         autoCorr.refract'/max(abs(autoCorr.refract))...
%         autoCorr.burstInd'/max(abs(autoCorr.burstInd))...
%         autoCorr.peakTime'/max(abs(autoCorr.peakTime))...
%         autoCorr.phaseMeanDire'/max(abs(autoCorr.phaseMeanDire))...
%         autoCorr.relDepthNeuHDef'/max(abs(autoCorr.relDepthNeuHDef))];
%     
%     [r,c] = size(autoCorr.ccgVal);
%     X = zeros(r,c);
%     for i = 1:r
%         X(i,:) = normData(autoCorr.ccgVal(i,:));
%     end
%     Y = tsne(X,'Algorithm','exact','Distance','cosine','NumDimensions',3);
%     for i = 1:size(Y,2)
%         Y(:,i) = Y(:,i)/max(abs(Y(:,i))); % normalization 
%     end
% %     Y = tsne(autoCorr.ccgVal,'Algorithm','exact','Distance','cosine','NumDimensions',3);
% %     plot3(Y(:,1),Y(:,2),Y(:,3),'.')
% %     gscatter(Y(:,1),Y(:,2),ones(r,1));
% 
%     [r,c] = size(autoCorr.histPhase);
%     X1 = zeros(r,c);
%     for i = 1:r
%         X1(i,:) = normData(autoCorr.histPhase(i,:));
%     end
%     Y1 = tsne(X1,'Algorithm','exact','Distance','cosine','NumDimensions',3);
%     for i = 1:size(Y1,2)
%         Y1(:,i) = Y1(:,i)/max(abs(Y1(:,i))); % normalization 
%     end
% %     plot3(Y1(:,1),Y1(:,2),Y1(:,3),'.')
% %     gscatter(Y1(:,1),Y1(:,2),ones(r,1));
%     
%     YAll = [Y Y1 X0(:,end)*2];
%     klist = [6:10];
%     len = 10;
%     evaC = [];
%     kn = zeros(len,1);
%     for i = 1:len
%         evaC{i} = evalclusters(YAll,'kmeans','CalinskiHarabasz','kList',klist);
%         kn(i) = evaC{i}.OptimalK;
%     end
%     binCount = histc(kn,klist);
%     [~,optimalK] = max(binCount);
%     optimalK = klist(optimalK);
%     [idxInt,cInt,sumD] = kmeans(YAll,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
%     
% end

% function [idxInt,cInt,score,explained,score2,explained2] = kmeansInterneurons2(autoCorr)
% 
%     std1 = 1.5;
%     paramT.gaussFilt = gaussFilter(12*std1, std1);
%     lenGaussKernel = length(paramT.gaussFilt);
%     normFactor = sum(paramT.gaussFilt);
%     paramT.gaussFilt = paramT.gaussFilt./normFactor;
%     
%     [r,c] = size(autoCorr.ccgVal);
%     X = zeros(r,c);
%     for i = 1:r
%         autocor = conv(autoCorr.ccgVal(i,:),paramT.gaussFilt);
%         if(mod(lenGaussKernel,2) == 0)
%             autocor = ...
%                 autocor(floor(lenGaussKernel/2)+1:...
%                     (end-floor(lenGaussKernel/2))+1); 
%         else
%             autocor = ...
%                 autocor(floor(lenGaussKernel/2)+1:...
%                     (end-floor(lenGaussKernel/2))); 
%         end     
%         X(i,:) = normData(autocor);     
%     end
%     
%     [coeff,score,latent,ts,explained] = pca(X);
%     numComp = find(cumsum(explained) > 99,1);
%     scoreNorm = score(:,1:numComp);
%     scoreNorm = scoreNorm/std(scoreNorm(:,1)); % normalization based on PC1
% %     for i = 1:numComp
% %         scoreNorm(:,i) = normData1(scoreNorm(:,i));
% %     end
% 
%     [r,c] = size(autoCorr.histPhaseFil);
%     X1 = zeros(r,c);
%     for i = 1:r
%         X1(i,:) = normData(autoCorr.histPhaseFil(i,:));
%     end
%     [coeff2,score2,latent2,ts2,explained2] = pca(X1);
%     numComp2 = find(cumsum(explained2) > 99,1);
%     scoreNorm2 = score2(:,1:numComp2);
%     scoreNorm2 = scoreNorm2/std(scoreNorm2(:,1)); % normalization based on PC1
% %     for i = 1:numComp2
% %         scoreNorm2(:,i) = normData1(scoreNorm2(:,i));
% %     end
%     XAll = [scoreNorm scoreNorm2]; %2
%     klist = [6:10];
%     len = 100;
%     evaC = [];
%     kn = zeros(len,1);
%     for i = 1:len
%         evaC{i} = evalclusters(XAll,'kmeans','CalinskiHarabasz','kList',klist);
%         kn(i) = evaC{i}.OptimalK;
%     end
%     binCount = histc(kn,klist);
%     [~,optimalK] = max(binCount);
%     optimalK = klist(optimalK);
%     [idxInt,cInt,sumD] = kmeans(XAll,optimalK,'MaxIter',5000,'Display','final','Replicates',100);
%     
% end

function result = normData(data)
    result = (data-min(data))/(max(data)-min(data));
end

function result = normData1(data)
    result = data/max(data);
end

function result = normData2(data)    
    result = data/std(data);
end
















