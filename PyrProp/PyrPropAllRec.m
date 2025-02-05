function PyrPropAllRec(onlyRun)

    RecordingListPyrInt; % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal = 'Z:\Yingxue\Draft\TwoPyrPopulations\Pyramidal\';
    
    if(exist([pathAnal 'autoCorrPyrAllRec.mat']))
        load([pathAnal 'autoCorrPyrAllRec.mat']);
    end
    GlobalConstFq;
    
    if(exist('autoCorrPyrNoCue') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        autoCorrPyrNoCue = accumPyrNeurons(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun);

        %% Pyrs in active licking task
        disp('Active licking')
        autoCorrPyrAL = accumPyrNeurons(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun);
    %     [autoCorrPyrAL.idxC,autoCorrPyrAL.klust] = kmeansInterneurons(autoCorrPyrAL);

        %% Pyrs in passive licking task with start cues
        disp('Passive licking')
        autoCorrPyrPL = accumPyrNeurons(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun);

        autoCorrPyrAll.ccgVal = [autoCorrPyrNoCue.ccgVal;autoCorrPyrAL.ccgVal;autoCorrPyrPL.ccgVal];
        autoCorrPyrAll.peakTo40ms = [autoCorrPyrNoCue.peakTo40ms,autoCorrPyrAL.peakTo40ms,autoCorrPyrPL.peakTo40ms];
        autoCorrPyrAll.refract = [autoCorrPyrNoCue.refract,autoCorrPyrAL.refract,autoCorrPyrPL.refract];
        autoCorrPyrAll.burstInd = [autoCorrPyrNoCue.burstInd,autoCorrPyrAL.burstInd,autoCorrPyrPL.burstInd];
        autoCorrPyrAll.peakTime = [autoCorrPyrNoCue.peakTime,autoCorrPyrAL.peakTime,autoCorrPyrPL.peakTime];

        autoCorrPyrAll.phaseMeanDire = [autoCorrPyrNoCue.phaseMeanDire,autoCorrPyrAL.phaseMeanDire,autoCorrPyrPL.phaseMeanDire]; 
        autoCorrPyrAll.thetaModHist = [autoCorrPyrNoCue.thetaModHist,autoCorrPyrAL.thetaModHist,autoCorrPyrPL.thetaModHist]; 
        autoCorrPyrAll.maxPhaseArr = [autoCorrPyrNoCue.maxPhaseArr,autoCorrPyrAL.maxPhaseArr,autoCorrPyrPL.maxPhaseArr]; 
        autoCorrPyrAll.minPhaseArr = [autoCorrPyrNoCue.minPhaseArr,autoCorrPyrAL.minPhaseArr,autoCorrPyrPL.minPhaseArr]; 
        autoCorrPyrAll.maxPhaseOArr = [autoCorrPyrNoCue.maxPhaseOArr,autoCorrPyrAL.maxPhaseOArr,autoCorrPyrPL.maxPhaseOArr]; 
        autoCorrPyrAll.minPhaseOArr = [autoCorrPyrNoCue.minPhaseOArr,autoCorrPyrAL.minPhaseOArr,autoCorrPyrPL.minPhaseOArr]; 
        autoCorrPyrAll.histPhaseFil = [autoCorrPyrNoCue.histPhaseFil;autoCorrPyrAL.histPhaseFil;autoCorrPyrPL.histPhaseFil];
        autoCorrPyrAll.histPhase = [autoCorrPyrNoCue.histPhase;autoCorrPyrAL.histPhase;autoCorrPyrPL.histPhase];

        autoCorrPyrAll.isSpikeHighAmp = [autoCorrPyrNoCue.isSpikeHighAmp,autoCorrPyrAL.isSpikeHighAmp,autoCorrPyrPL.isSpikeHighAmp];
        autoCorrPyrAll.isSpikeHighAmp200 = [autoCorrPyrNoCue.isSpikeHighAmp200,autoCorrPyrAL.isSpikeHighAmp200,autoCorrPyrPL.isSpikeHighAmp200];
        autoCorrPyrAll.relDepthNeuHDef = [autoCorrPyrNoCue.relDepthNeuHDef,autoCorrPyrAL.relDepthNeuHDef,autoCorrPyrPL.relDepthNeuHDef];      

        autoCorrPyrAll.task = [autoCorrPyrNoCue.task,autoCorrPyrAL.task,autoCorrPyrPL.task];
        autoCorrPyrAll.indRec = [autoCorrPyrNoCue.indRec,autoCorrPyrAL.indRec,autoCorrPyrPL.indRec];
        autoCorrPyrAll.indNeu = [autoCorrPyrNoCue.indNeu,autoCorrPyrAL.indNeu,autoCorrPyrPL.indNeu];

        [autoCorrPyrAll.idxC,autoCorrPyrAll.klust] = kmeansInterneurons(autoCorrPyrAll);

        [autoCorrPyrAll.idxC1,autoCorrPyrAll.klust1,...
            autoCorrPyrAll.scorekm11,autoCorrPyrAll.explainedkm11,...
            autoCorrPyrAll.scorekm12,autoCorrPyrAll.explainedkm12...
            ] = kmeansInterneurons1(autoCorrPyrAll);

        [autoCorrPyrAll.idxC2,autoCorrPyrAll.klust2,...
             autoCorrPyrAll.scorekm21,autoCorrPyrAll.explainedkm21,...
            autoCorrPyrAll.scorekm22,autoCorrPyrAll.explainedkm22...
            ] = kmeansInterneurons2(autoCorrPyrAll);

        [autoCorrPyrAll.idxC4,autoCorrPyrAll.klust4,...
             autoCorrPyrAll.scorekm41,autoCorrPyrAll.explainedkm41,...
            autoCorrPyrAll.scorekm42,autoCorrPyrAll.explainedkm42...
            ] = kmeansInterneurons3(autoCorrPyrAll);

        for i = 1:max(autoCorrPyrAll.idxC)
            idxCurC = autoCorrPyrAll.idxC == i;
            autoCorrPyrAll.relDepthNeuHDefC{i} = autoCorrPyrAll.relDepthNeuHDef(idxCurC);
            autoCorrPyrAll.relDepthNeuHDefMean(i) = mean(autoCorrPyrAll.relDepthNeuHDefC{i});
        end
        autoCorrPyrAll.pRSRelDepthNeuHDefC = ranksum(autoCorrPyrAll.relDepthNeuHDefC{1},...
            autoCorrPyrAll.relDepthNeuHDefC{2});

        for i = 1:max(autoCorrPyrAll.idxC1)
            idxCurC = autoCorrPyrAll.idxC1 == i;
            autoCorrPyrAll.relDepthNeuHDefC1{i} = autoCorrPyrAll.relDepthNeuHDef(idxCurC);
            autoCorrPyrAll.relDepthNeuHDefMean1(i) = mean(autoCorrPyrAll.relDepthNeuHDefC1{i});
        end
        autoCorrPyrAll.pRSRelDepthNeuHDefC1 = ranksum(autoCorrPyrAll.relDepthNeuHDefC1{1},...
            autoCorrPyrAll.relDepthNeuHDefC1{2});

        for i = 1:max(autoCorrPyrAll.idxC2)
            idxCurC = autoCorrPyrAll.idxC2 == i;
            autoCorrPyrAll.relDepthNeuHDefC2{i} = autoCorrPyrAll.relDepthNeuHDef(idxCurC);
            autoCorrPyrAll.relDepthNeuHDefMean2(i) = mean(autoCorrPyrAll.relDepthNeuHDefC2{i});
        end
        autoCorrPyrAll.pRSRelDepthNeuHDefC2 = ranksum(autoCorrPyrAll.relDepthNeuHDefC2{1},...
            autoCorrPyrAll.relDepthNeuHDefC2{2});

        for i = 1:max(autoCorrPyrAll.idxC4)
            idxCurC = autoCorrPyrAll.idxC4 == i;
            autoCorrPyrAll.relDepthNeuHDefC4{i} = autoCorrPyrAll.relDepthNeuHDef(idxCurC);
            autoCorrPyrAll.relDepthNeuHDefMean4(i) = mean(autoCorrPyrAll.relDepthNeuHDefC4{i});
        end
        autoCorrPyrAll.pRSRelDepthNeuHDefC4 = ranksum(autoCorrPyrAll.relDepthNeuHDefC4{1},...
            autoCorrPyrAll.relDepthNeuHDefC4{2});

        if(exist([pathAnal 'autoCorrPyrAllRec.mat']))
            save([pathAnal 'autoCorrPyrAllRec.mat'],'autoCorrPyrNoCue','autoCorrPyrAL',...
                'autoCorrPyrPL','autoCorrPyrAll','-append');
        else
            save([pathAnal 'autoCorrPyrAllRec.mat'],'autoCorrPyrNoCue','autoCorrPyrAL',...
                'autoCorrPyrPL','autoCorrPyrAll');
        end
    end
    
    phaseM = autoCorrPyrAll.phaseMeanDire;
    autoCorrPyrAll.idxC3 = [];
    idx2 = (phaseM > pi/2) & (phaseM <= 3/2*pi);
    idx1 = ((phaseM >= 0) & (phaseM <= pi/2)) | (phaseM > 3/2*pi) & (phaseM <= 2*pi);
    autoCorrPyrAll.idxC3(idx2) = 2;
    autoCorrPyrAll.idxC3(idx1) = 1;
    for i = 1:max(autoCorrPyrAll.idxC3)
        idxCurC = autoCorrPyrAll.idxC3 == i;
        autoCorrPyrAll.relDepthNeuHDefC3{i} = autoCorrPyrAll.relDepthNeuHDef(idxCurC);
        autoCorrPyrAll.relDepthNeuHDefMean3(i) = mean(autoCorrPyrAll.relDepthNeuHDefC3{i});
    end
    autoCorrPyrAll.pRSRelDepthNeuHDefC3 = ranksum(autoCorrPyrAll.relDepthNeuHDefC3{1},...
        autoCorrPyrAll.relDepthNeuHDefC3{2});
    save([pathAnal 'autoCorrPyrAllRec.mat'],'autoCorrPyrAll','-append');
    
    plotCompCPCA(autoCorrPyrAll.scorekm11(:,1),autoCorrPyrAll.scorekm12(:,1),...
        autoCorrPyrAll.scorekm12(:,2),'PC1','PC2','PC3',autoCorrPyrAll.idxC1,...
        'PCA space');
    plotCompCPCA(autoCorrPyrAll.scorekm21(:,1),autoCorrPyrAll.scorekm22(:,1),...
        autoCorrPyrAll.scorekm22(:,2),'PC1','PC2','PC3',autoCorrPyrAll.idxC2,...
        'PCA space');
    plotCompCPCA(autoCorrPyrAll.scorekm41(:,1),autoCorrPyrAll.scorekm42(:,1),...
        autoCorrPyrAll.scorekm42(:,2),'PC1','PC2','PC3',autoCorrPyrAll.idxC4,...
        'PCA space');
    plotKmeanResult(autoCorrPyrAll,[],'All Pyramidal Neurons',pathAnal);
    

    %% refractory vs. peak time
    plotComp(autoCorrPyrAL.refract,autoCorrPyrAL.peakTime,...
        'AL refractory (ms)','AL peak time (ms)');
end


function [idxInt,cInt] = kmeansInterneurons(autoCorr)
%     X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire'];
    X = [normData(autoCorr.peakTo40ms') ...
        normData(autoCorr.refract') ...
        normData(autoCorr.burstInd') ...
        normData(autoCorr.peakTime') ... 
        normData(autoCorr.phaseMeanDire') ...
        normData(autoCorr.thetaModHist') ...
        normData(autoCorr.maxPhaseArr') ... 
        normData(autoCorr.minPhaseArr')...
        ];
    klist = [2:2];
    len = 100;
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

function [idxInt,cInt,score,explained,score2,explained2] = kmeansInterneurons1(autoCorr)
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
    
    [coeff,score,latent,ts,explained] = pca(X);
    numComp = find(cumsum(explained) > 99,1);
    scoreNorm = score(:,1:numComp);
    scoreNorm = scoreNorm/max(abs(scoreNorm(:,1))); % normalization based on PC1
%     for i = 1:numComp
%         scoreNorm(:,i) = normData(scoreNorm(:,i));
%     end
    
    [r,c] = size(autoCorr.histPhaseFil);
    X1 = zeros(r,c);
    for i = 1:r
        X1(i,:) = normData(autoCorr.histPhaseFil(i,:));
    end
    [coeff2,score2,latent2,ts2,explained2] = pca(X1);
    numComp2 = find(cumsum(explained2) > 99,1);
    scoreNorm2 = score2(:,1:numComp2);
    scoreNorm2 = scoreNorm2/max(abs(scoreNorm2(:,1))); % normalization based on PC1
%     for i = 1:numComp2
%         scoreNorm2(:,i) = normData(scoreNorm2(:,i));
%     end
    XAll = [scoreNorm scoreNorm2]; %1.5
    klist = [2:10];
    len = 100;
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
%     X = [autoCorr.peakTo40ms' autoCorr.refract' autoCorr.burstInd' autoCorr.peakTime' autoCorr.phaseMeanDire'];
    [r,c] = size(autoCorr.ccgVal);
    X = zeros(r,c);
    for i = 1:r
        X(i,:) = normData(autoCorr.ccgVal(i,:));
    end
    [coeff,score,latent,ts,explained] = pca(X);
    numComp = find(cumsum(explained) > 95,1);
%     if(numComp > 30)
%         numComp = 30;
%     end
    scoreNorm = score(:,1:numComp);
    scoreNorm = scoreNorm/max(abs(scoreNorm(:,1))); % normalization based on PC1

    [r,c] = size(autoCorr.histPhaseFil);
    X1 = zeros(r,c);
    for i = 1:r
        X1(i,:) = normData(autoCorr.histPhase(i,:));
    end
    [coeff2,score2,latent2,ts2,explained2] = pca(X1);
    numComp2 = find(cumsum(explained2) > 95,1);
%     if(numComp2 > 30)
%         numComp2 = 30;
%     end
    scoreNorm2 = score2(:,1:numComp2);
    scoreNorm2 = scoreNorm2/max(abs(scoreNorm2(:,1))); % normalization based on PC1

    XAll = [scoreNorm scoreNorm2]; %2
    klist = [2:10];
    len = 100;
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

function result = normData(data)
    result = (data-min(data))/(max(data)-min(data));
end

function plotKmeanResult(autoCorr,autoCorrTag,titleX,pathAnal)
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        [],[],...
        'refractory (ms)','burst index',autoCorr.idxC,titleX);  
    fileName1 = [pathAnal 'Pyr_RefrVsBurst'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        [],[],...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPeakTo40ms'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        [],[],...
        'peak time (ms)','phase mean dire',autoCorr.idxC,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPhaseMeanDire'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        [],[],...
        'peak time (ms)','min phase theta hist',autoCorr.idxC,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMinPhaseArr'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        [],[],...
        'peak time (ms)','max phase theta hist',autoCorr.idxC,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMaxPhaseArr'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC(isHighAmp),titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepth'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC,titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepthAllInt'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    
    %% klustering method 1
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        [],[],...
        'refractory (ms)','burst index',autoCorr.idxC1,titleX);  
    fileName1 = [pathAnal 'Pyr_RefrVsBurst1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        [],[],...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC1,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPeakTo40ms1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        [],[],...
        'peak time (ms)','phase mean dire',autoCorr.idxC1,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPhaseMeanDire1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        [],[],...
        'peak time (ms)','min phase theta hist',autoCorr.idxC1,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMinPhaseArr1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        [],[],...
        'peak time (ms)','max phase theta hist',autoCorr.idxC1,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMaxPhaseArr1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC1(isHighAmp),titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepth1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC1,titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepthAllInt1'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    %% klustering method 2
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        [],[],...
        'refractory (ms)','burst index',autoCorr.idxC2,titleX);  
    fileName1 = [pathAnal 'Pyr_RefrVsBurst2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        [],[],...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC2,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPeakTo40ms2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        [],[],...
        'peak time (ms)','phase mean dire',autoCorr.idxC2,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPhaseMeanDire2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        [],[],...
        'peak time (ms)','min phase theta hist',autoCorr.idxC2,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMinPhaseArr2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        [],[],...
        'peak time (ms)','max phase theta hist',autoCorr.idxC2,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMaxPhaseArr2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC2(isHighAmp),titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepth2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC2,titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepthAllInt2'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    %% klustering method 3
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        [],[],...
        'refractory (ms)','burst index',autoCorr.idxC3,titleX);  
    fileName1 = [pathAnal 'Pyr_RefrVsBurst3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        [],[],...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC3,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPeakTo40ms3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        [],[],...
        'peak time (ms)','phase mean dire',autoCorr.idxC3,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsPhaseMeanDire3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        [],[],...
        'peak time (ms)','min phase theta hist',autoCorr.idxC3,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMinPhaseArr3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        [],[],...
        'peak time (ms)','max phase theta hist',autoCorr.idxC3,titleX);
    fileName1 = [pathAnal 'Pyr_PeakTVsMaxPhaseArr3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC3(isHighAmp),titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepth3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        [],[],...
        'peak time (ms)','depth',autoCorr.idxC3,titleX); 
    fileName1 = [pathAnal 'Pyr_PeakTVsDepthAllInt3'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
end

function plotComp(x,y,xl,yl)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    h = plot(x,y,'o');
    set(h,'MarkerSize',6,'Color',[0.5 0.5 0.9]);
    maxX = max(x);
    maxY = max(y);
    minX = min(x);
    minY = min(y);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
end

function plotCompC(x,y,xt,yt,xl,yl,idx,ti)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [0.5 0.5 0.9;...
                0.9 0.5 0.5;...
                0.3 0.3 0.7;...
                0.7 0.3 0.3;...
                0.5 0.9 0.5;...
                0.2 0.5 0.8;...
                0.2 0.8 0.5;...
                0.8 0.5 0.2;...
                0.3 0.7 0.3];
    hold on;
    for i = 1:max(idx)
        indTmp = idx == i;
        disp(['Cluster' num2str(i) ' has ' num2str(sum(indTmp)) ' components']);
        h = plot(x(indTmp),y(indTmp),'.');
        set(h,'MarkerSize',8,'Color',colorArr(mod(i,6)+1,:));
    end
    h = plot(xt,yt,'k+');
    set(h,'MarkerSize',9);
    maxX = max(x);
    maxY = max(y);
    minX = min(x);
    minY = min(y);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    title(ti);
end

function plotCompCPCA(x,y,z,xl,yl,zl,idx,ti,xlimit,ylimit,zlimit)
    if(nargin == 8)
        xlimit = [];
        ylimit = [];
        zlimit = [];
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [...
                234 131 114;...
                163 207 98]/255;
    
    for i = 1:max(idx)
        indTmp = idx == i;
        disp(['Cluster' num2str(i) ' has ' num2str(sum(indTmp)) ' components']);
        h = plot3(x(indTmp),y(indTmp),z(indTmp),'.');
        set(h,'MarkerSize',11,'Color',colorArr(mod(i,2)+1,:));
        if(i == 1)
            hold on;
        end
    end
    if(isempty(xlimit))
        maxX = max(x);
        minX = min(x);        
    else
        maxX = xlimit(2);
        minX = xlimit(1);
    end
    if(isempty(ylimit))
        maxY = max(y);
        minY = min(y);        
    else
        maxY = ylimit(2);
        minY = ylimit(1);
    end
    if(isempty(zlimit))
        maxZ = max(z);
        minZ = min(z);        
    else
        maxZ = zlimit(2);
        minZ = zlimit(1);
    end
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    zlabel(zl)
    title(ti);
end