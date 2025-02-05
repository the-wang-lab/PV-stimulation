function plotPVSSTPutativeCells()

    pathAnal = 'Z:\Yingxue\Draft\PV\Interneuron\';
    if(exist([pathAnal 'autoCorrIntAllRec.mat']))
        load([pathAnal 'autoCorrIntAllRec.mat']);
        load([pathAnal 'initPeakIntAllRec.mat'],'modInt1NoCue','modInt1AL','modInt1PL');
    end
    
    posPhase = 2.5:5:1080;
    indPhase = find(posPhase>= 360); 
    indPhaseOneCycle = find(posPhase>= 360 & posPhase < 720);
    
    avgFRProfile = [modInt1NoCue.avgFRProfileGood; modInt1AL.avgFRProfileGood; modInt1PL.avgFRProfileGood];
    indRecInt = [modInt1NoCue.indRecGood modInt1AL.indRecGood modInt1PL.indRecGood];
    indNeuInt = [modInt1NoCue.indNeuGood modInt1AL.indNeuGood modInt1PL.indNeuGood];
    taskInt = [modInt1NoCue.taskGood modInt1AL.taskGood modInt1PL.taskGood];
    
    indNeuGood = zeros(1,length(indRecInt));
    for i = 1:length(indRecInt)
        ind = find(autoCorrIntAll.indRec == indRecInt(i) & autoCorrIntAll.indNeu == indNeuInt(i)...
            & autoCorrIntAll.task == taskInt(i));
        indNeuGood(i) = ind; 
    end
    % SST
    cluSST1 = [2];
    indTmp1 = find(autoCorrIntAll.idxC2(indNeuGood) == cluSST1 & autoCorrIntAll.task(indNeuGood)' ~= 1);
    indTmp = indNeuGood(indTmp1);
    peakTime = autoCorrIntAll.peakTime(indTmp);
    [~,indPeakTime] = sort(peakTime);
    SSTCCGVal = autoCorrIntAll.ccgVal(indTmp,:);
    SSTCCGVal = SSTCCGVal(indPeakTime,:);
    meanSSTCCGPeakTime = mean(peakTime);
    semSSTCCGPeakTime = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(SSTCCGVal,1)
        SSTCCGVal(i,:) = SSTCCGVal(i,:)/max(SSTCCGVal(i,:));
    end
    SSTHistPhaseFil = autoCorrIntAll.histPhaseFil(indTmp,indPhase);
    SSTHistPhaseFil = SSTHistPhaseFil(indPeakTime,:);
    [~,SSTMaxPhase] = max(SSTHistPhaseFil(:,indPhaseOneCycle),[],2);
    SSTMaxPhase = posPhase(SSTMaxPhase);
    meanSSTMaxPhase = mean(SSTMaxPhase);
    semSSTMaxPhase = std(SSTMaxPhase)/sqrt(length(SSTMaxPhase));
    for i = 1:size(SSTHistPhaseFil,1)
        SSTHistPhaseFil(i,:) = SSTHistPhaseFil(i,:)/max(SSTHistPhaseFil(i,:));
        
    end
    
    idxTagSST1 = autoCorrIntTag.cellType == 2 & autoCorrIntTag.idxC2 == cluSST1;
    peakTime = autoCorrIntTag.peakTime(idxTagSST1);
    indRec = autoCorrIntTag.indRec(idxTagSST1);
    indNeu = autoCorrIntTag.indNeu(idxTagSST1);
    indSST = [];
    indSSTGood = [];
    for i = 1:length(indRec)
        ind = find(autoCorrIntAll.indNeu(indNeuGood) == indNeu(i) & autoCorrIntAll.indRec(indNeuGood) == indRec(i) ...
            & autoCorrIntAll.task(indNeuGood) == 2);
        indSSTGood = [indSSTGood ind];
        indSST = [indSST indNeuGood(ind)];
    end
    [~,indPeakTime] = sort(peakTime);
    SSTCCGValTag = autoCorrIntTag.ccgVal(idxTagSST1,:);
    SSTCCGValTag = SSTCCGValTag(indPeakTime,:);
    meanSSTCCGPeakTimeTag = mean(peakTime);
    semSSTCCGPeakTimeTag = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(SSTCCGValTag,1)
        SSTCCGValTag(i,:) = SSTCCGValTag(i,:)/max(SSTCCGValTag(i,:));
    end
    SSTHistPhaseFilTag = autoCorrIntAll.histPhaseFil(indSST,indPhase);
    SSTHistPhaseFilTag = SSTHistPhaseFilTag(indPeakTime,:);
    [~,SSTMaxPhaseTag] = max(SSTHistPhaseFilTag(:,indPhaseOneCycle),[],2);
    SSTMaxPhaseTag = posPhase(SSTMaxPhaseTag);
    meanSSTMaxPhaseTag = mean(SSTMaxPhaseTag);
    semSSTMaxPhaseTag = std(SSTMaxPhaseTag)/sqrt(length(SSTMaxPhaseTag));
    for i = 1:size(SSTHistPhaseFilTag,1)
        SSTHistPhaseFilTag(i,:) = SSTHistPhaseFilTag(i,:)/max(SSTHistPhaseFilTag(i,:));
    end
    
    p = randperm(size(SSTCCGVal,1));
    p = sort(p(1:15));
    plotCCG(-50:50,SSTCCGVal,'Putative SST',[num2str(meanSSTCCGPeakTime) '+/-' num2str(semSSTCCGPeakTime)],...
        pathAnal,['putativeSSTCCG' num2str(cluSST1)]);
    plotCCG(-50:50,SSTCCGValTag,'Tagged SST',[num2str(meanSSTCCGPeakTimeTag) '+/-' num2str(semSSTCCGPeakTimeTag)],...
        pathAnal,['taggedSSTCCG'  num2str(cluSST1)]);
    plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFil,'Putative SST',...
        [num2str(meanSSTMaxPhase) '+/-' num2str(semSSTMaxPhase)],pathAnal,['putativeSSTHistPhase' num2str(cluSST1)]);
    plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFilTag,'Tagged SST',...
        [num2str(meanSSTMaxPhaseTag) '+/-' num2str(semSSTMaxPhaseTag)],pathAnal,['taggedSSTHistPhase'  num2str(cluSST1)]);
    
%     plotCCG(-50:50,SSTCCGVal(1:20,:),'Putative SST',pathAnal,['putativeSSTCCG' num2str(cluSST1)]);
%     plotCCG(-50:50,SSTCCGValTag(1:5,:),'Tagged SST',pathAnal,['taggedSSTCCG'  num2str(cluSST1)]);
%     plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFil(1:20,:),'Putative SST',pathAnal,['putativeSSTHistPhase' num2str(cluSST1)]);
%     plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFilTag(1:5,:),'Tagged SST',pathAnal,['taggedSSTHistPhase'  num2str(cluSST1)]);
    
    ind = find(modInt1NoCue.timeStepRun == -1);
    for i = 1:size(avgFRProfile,1)
        avgFRProfileNorm(i,:) = avgFRProfile(i,:)/max(avgFRProfile(i,:));
    end
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1,ind:end),['C' num2str(cluSST1) ' FR (Hz)'],...
        ['Int_FRProfilePutativeSSTC' num2str(cluSST1)],...
        pathAnal,[0.4 0.9])
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indSSTGood,ind:end),['Tagged C' num2str(cluSST1) ' FR (Hz)'],...
        ['Int_FRProfileTaggedSSTC' num2str(cluSST1)],...
        pathAnal,[0.4 1])
    plotAvgFRProfileCmp(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1,ind:end),avgFRProfileNorm(indSSTGood,ind:end),...
        ['C' num2str(cluSST1) ' FR (Hz)'],...
        ['Int_FRProfilePutativeTaggedSSTC' num2str(cluSST1)],...
        pathAnal,[])
    
    %% SST
    cluSST2 = [4];
    indTmp1 = find(autoCorrIntAll.idxC2(indNeuGood) == cluSST2 & autoCorrIntAll.task(indNeuGood)' ~= 1);
    indTmp = indNeuGood(indTmp1);
    peakTime = autoCorrIntAll.peakTime(indTmp);
    [~,indPeakTime] = sort(peakTime);
    SSTCCGVal = autoCorrIntAll.ccgVal(indTmp,:);
    SSTCCGVal = SSTCCGVal(indPeakTime,:);
    meanSSTCCGPeakTime = mean(peakTime);
    semSSTCCGPeakTime = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(SSTCCGVal,1)
        SSTCCGVal(i,:) = SSTCCGVal(i,:)/max(SSTCCGVal(i,:));
    end
    SSTHistPhaseFil = autoCorrIntAll.histPhaseFil(indTmp,indPhase);
    SSTHistPhaseFil = SSTHistPhaseFil(indPeakTime,:);
    [~,SSTMaxPhase] = max(SSTHistPhaseFil(:,indPhaseOneCycle),[],2);
    SSTMaxPhase = posPhase(SSTMaxPhase);
    meanSSTMaxPhase = mean(SSTMaxPhase);
    semSSTMaxPhase = std(SSTMaxPhase)/sqrt(length(SSTMaxPhase));
    for i = 1:size(SSTHistPhaseFil,1)
        SSTHistPhaseFil(i,:) = SSTHistPhaseFil(i,:)/max(SSTHistPhaseFil(i,:));
    end
    
    idxTagSST1 = autoCorrIntTag.cellType == 2 & autoCorrIntTag.idxC2 == cluSST2;
    peakTime = autoCorrIntTag.peakTime(idxTagSST1);
    indRec = autoCorrIntTag.indRec(idxTagSST1);
    indNeu = autoCorrIntTag.indNeu(idxTagSST1);
    indSST = [];
    indSSTGood = [];
    for i = 1:length(indRec)
        ind = find(autoCorrIntAll.indNeu(indNeuGood) == indNeu(i) & autoCorrIntAll.indRec(indNeuGood) == indRec(i) ...
            & autoCorrIntAll.task(indNeuGood) == 2);
        indSSTGood = [indSSTGood ind];
        indSST = [indSST indNeuGood(ind)];
    end
    [~,indPeakTime] = sort(peakTime);
    SSTCCGValTag = autoCorrIntTag.ccgVal(idxTagSST1,:);
    SSTCCGValTag = SSTCCGValTag(indPeakTime,:);
    meanSSTCCGPeakTimeTag = mean(peakTime);
    semSSTCCGPeakTimeTag = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(SSTCCGValTag,1)
        SSTCCGValTag(i,:) = SSTCCGValTag(i,:)/max(SSTCCGValTag(i,:));
    end
    SSTHistPhaseFilTag = autoCorrIntAll.histPhaseFil(indSST,indPhase);
    SSTHistPhaseFilTag = SSTHistPhaseFilTag(indPeakTime,:);
    [~,SSTMaxPhaseTag] = max(SSTHistPhaseFilTag(:,indPhaseOneCycle),[],2);
    SSTMaxPhaseTag = posPhase(SSTMaxPhaseTag);
    meanSSTMaxPhaseTag = mean(SSTMaxPhaseTag);
    semSSTMaxPhaseTag = std(SSTMaxPhaseTag)/sqrt(length(SSTMaxPhaseTag));
    for i = 1:size(SSTHistPhaseFilTag,1)
        SSTHistPhaseFilTag(i,:) = SSTHistPhaseFilTag(i,:)/max(SSTHistPhaseFilTag(i,:));
    end
    
    p = randperm(size(SSTCCGVal,1));
    p = sort(p(1:15));
    plotCCG(-50:50,SSTCCGVal(:,:),'Putative SST',[num2str(meanSSTCCGPeakTime) '+/-' num2str(semSSTCCGPeakTime)],...
        pathAnal,['putativeSSTCCG' num2str(cluSST2)])
    plotCCG(-50:50,SSTCCGValTag(:,:),'Tagged SST',[num2str(meanSSTCCGPeakTimeTag) '+/-' num2str(semSSTCCGPeakTimeTag)],...
        pathAnal,['taggedSSTCCG' num2str(cluSST2)])
    plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFil(:,:),'Putative SST',...
        [num2str(meanSSTMaxPhase) '+/-' num2str(semSSTMaxPhase)],pathAnal,['putativeSSTHistPhase' num2str(cluSST2)])
    plotHistPhase(posPhase(indPhase)-360,SSTHistPhaseFilTag(:,:),'Tagged SST',...
        [num2str(meanSSTMaxPhaseTag) '+/-' num2str(semSSTMaxPhaseTag)],pathAnal,['taggedSSTHistPhase' num2str(cluSST2)])
    
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1(1:end),ind:end),['C' num2str(cluSST2) ' FR (Hz)'],...
        ['Int_FRProfilePutativeSSTC' num2str(cluSST2)],...
        pathAnal,[])
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indSSTGood,ind:end),['Tagged C' num2str(cluSST2) ' FR (Hz)'],...
        ['Int_FRProfileTaggedSSTC' num2str(cluSST2)],...
        pathAnal,[])
    
        
    %% PV
    cluPV1 = [3];
    indTmp1 = find(autoCorrIntAll.idxC2(indNeuGood) == cluPV1 & autoCorrIntAll.task(indNeuGood)' ~= 1);
    indTmp = indNeuGood(indTmp1);
    peakTime = autoCorrIntAll.peakTime(indTmp);
    [~,indPeakTime] = sort(peakTime);
    PVCCGVal = autoCorrIntAll.ccgVal(indTmp,:);
    PVCCGVal = PVCCGVal(indPeakTime,:);
    meanPVCCGPeakTime = mean(peakTime);
    semPVCCGPeakTime = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(PVCCGVal,1)
        PVCCGVal(i,:) = PVCCGVal(i,:)/max(PVCCGVal(i,:));
    end
    PVHistPhaseFil = autoCorrIntAll.histPhaseFil(indTmp,indPhase);
    PVHistPhaseFil = PVHistPhaseFil(indPeakTime,:);
    [~,PVMaxPhase] = max(PVHistPhaseFil(:,indPhaseOneCycle),[],2);
    PVMaxPhase = posPhase(PVMaxPhase);
    meanPVMaxPhase = mean(PVMaxPhase);
    semPVMaxPhase = std(PVMaxPhase)/sqrt(length(PVMaxPhase));
    for i = 1:size(PVHistPhaseFil,1)
        PVHistPhaseFil(i,:) = PVHistPhaseFil(i,:)/max(PVHistPhaseFil(i,:));
        
    end    
    
    idxTagPV1 = autoCorrIntTag.cellType == 1 & autoCorrIntTag.idxC2 == cluPV1;
    peakTime = autoCorrIntTag.peakTime(idxTagPV1);
    indRec = autoCorrIntTag.indRec(idxTagPV1);
    indNeu = autoCorrIntTag.indNeu(idxTagPV1);
    indPV = [];
    indPVGood = [];
    for i = 1:length(indRec)
        ind = find(autoCorrIntAll.indNeu(indNeuGood) == indNeu(i) & autoCorrIntAll.indRec(indNeuGood) == indRec(i) ...
            & autoCorrIntAll.task(indNeuGood) == 2);
        indPVGood = [indPVGood ind];
        indPV = [indPV indNeuGood(ind)];
    end
    [~,indPeakTime] = sort(peakTime);
    PVCCGValTag = autoCorrIntTag.ccgVal(idxTagPV1,:);
    PVCCGValTag = PVCCGValTag(indPeakTime,:);
    meanPVCCGPeakTimeTag = mean(peakTime);
    semPVCCGPeakTimeTag = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(PVCCGValTag,1)
        PVCCGValTag(i,:) = PVCCGValTag(i,:)/max(PVCCGValTag(i,:));
    end
    PVHistPhaseFilTag = autoCorrIntAll.histPhaseFil(indPV,indPhase);
    PVHistPhaseFilTag = PVHistPhaseFilTag(indPeakTime,:);
    [~,PVMaxPhaseTag] = max(PVHistPhaseFilTag(:,indPhaseOneCycle),[],2);
    PVMaxPhaseTag = posPhase(PVMaxPhaseTag);
    meanPVMaxPhaseTag = mean(PVMaxPhaseTag);
    semPVMaxPhaseTag = std(PVMaxPhaseTag)/sqrt(length(PVMaxPhaseTag));
    for i = 1:size(PVHistPhaseFilTag,1)
        PVHistPhaseFilTag(i,:) = PVHistPhaseFilTag(i,:)/max(PVHistPhaseFilTag(i,:));
    end
    p = randperm(size(PVCCGVal,1));
    p = sort(p(1:15));
    plotCCG(-50:50,PVCCGVal(:,:),'Putative PV',[num2str(meanPVCCGPeakTime) '+/-' num2str(semPVCCGPeakTime)],...
        pathAnal,['putativePVCCG' num2str(cluPV1)]);
    plotCCG(-50:50,PVCCGValTag(:,:),'Tagged PV',[num2str(meanPVCCGPeakTimeTag) '+/-' num2str(semPVCCGPeakTimeTag)],...
        pathAnal,['taggedPVCCG' num2str(cluPV1)]);
    plotHistPhase(posPhase(indPhase)-360,PVHistPhaseFil(:,:),'Putative PV',...
        [num2str(meanPVMaxPhase) '+/-' num2str(semPVMaxPhase)],pathAnal,['putativePVHistPhase' num2str(cluPV1)]);
    plotHistPhase(posPhase(indPhase)-360,PVHistPhaseFilTag(:,:),'Tagged PV',...
        [num2str(meanPVMaxPhaseTag) '+/-' num2str(semPVMaxPhaseTag)],pathAnal,['taggedPVHistPhase' num2str(cluPV1)]);
    
    ind = find(modInt1NoCue.timeStepRun == -1);
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1(1:end),ind:end),['C' num2str(cluPV1) ' FR (Hz)'],...
        ['Int_FRProfilePutativePVC' num2str(cluPV1)],...
        pathAnal,[0.4 0.9])
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indPVGood,ind:end),['Tagged C' num2str(cluPV1) ' FR (Hz)'],...
        ['Int_FRProfileTaggedPVC' num2str(cluPV1)],...
        pathAnal,[0.4 1])
    plotAvgFRProfileCmp(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1,ind:end),avgFRProfileNorm(indPVGood,ind:end),...
        ['C' num2str(cluPV1) ' FR (Hz)'],...
        ['Int_FRProfilePutativeTaggedPVC' num2str(cluPV1)],...
        pathAnal,[])
    
    %% PV
    cluPV2 = [4];
    indTmp1 = find(autoCorrIntAll.idxC2(indNeuGood) == cluPV2 & autoCorrIntAll.task(indNeuGood)' ~= 1);
    indTmp = indNeuGood(indTmp1);
    peakTime = autoCorrIntAll.peakTime(indTmp);
    [~,indPeakTime] = sort(peakTime);
    PVCCGVal = autoCorrIntAll.ccgVal(indTmp,:);
    PVCCGVal = PVCCGVal(indPeakTime,:);
    meanPVCCGPeakTime = mean(peakTime);
    semPVCCGPeakTime = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(PVCCGVal,1)
        PVCCGVal(i,:) = PVCCGVal(i,:)/max(PVCCGVal(i,:));
    end
    PVHistPhaseFil = autoCorrIntAll.histPhaseFil(indTmp,indPhase);
    PVHistPhaseFil = PVHistPhaseFil(indPeakTime,:);
    [~,PVMaxPhase] = max(PVHistPhaseFil(:,indPhaseOneCycle),[],2);
    PVMaxPhase = posPhase(PVMaxPhase);
    meanPVMaxPhase = mean(PVMaxPhase);
    semPVMaxPhase = std(PVMaxPhase)/sqrt(length(PVMaxPhase));
    for i = 1:size(PVHistPhaseFil,1)
        PVHistPhaseFil(i,:) = PVHistPhaseFil(i,:)/max(PVHistPhaseFil(i,:));
    end
    
    idxTagPV1 = autoCorrIntTag.cellType == 1 & autoCorrIntTag.idxC2 == cluPV2;
    peakTime = autoCorrIntTag.peakTime(idxTagPV1);
    indRec = autoCorrIntTag.indRec(idxTagPV1);
    indNeu = autoCorrIntTag.indNeu(idxTagPV1);
    indPV = [];
    indPVGood = [];
    for i = 1:length(indRec)
        ind = find(autoCorrIntAll.indNeu(indNeuGood) == indNeu(i) & autoCorrIntAll.indRec(indNeuGood) == indRec(i) ...
            & autoCorrIntAll.task(indNeuGood) == 2);
        indPVGood = [indPVGood ind];
        indPV = [indPV indNeuGood(ind)];
    end
    [~,indPeakTime] = sort(peakTime);
    PVCCGValTag = autoCorrIntTag.ccgVal(idxTagPV1,:);
    PVCCGValTag = PVCCGValTag(indPeakTime,:);
    meanPVCCGPeakTimeTag = mean(peakTime);
    semPVCCGPeakTimeTag = std(peakTime)/sqrt(length(indTmp));
    for i = 1:size(PVCCGValTag,1)
        PVCCGValTag(i,:) = PVCCGValTag(i,:)/max(PVCCGValTag(i,:));
    end
    PVHistPhaseFilTag = autoCorrIntAll.histPhaseFil(indPV,indPhase);
    PVHistPhaseFilTag = PVHistPhaseFilTag(indPeakTime,:);
    [~,PVMaxPhaseTag] = max(PVHistPhaseFilTag(:,indPhaseOneCycle),[],2);
    PVMaxPhaseTag = posPhase(PVMaxPhaseTag);
    meanPVMaxPhaseTag = mean(PVMaxPhaseTag);
    semPVMaxPhaseTag = std(PVMaxPhaseTag)/sqrt(length(PVMaxPhaseTag));
    for i = 1:size(PVHistPhaseFilTag,1)
        PVHistPhaseFilTag(i,:) = PVHistPhaseFilTag(i,:)/max(PVHistPhaseFilTag(i,:));
    end
    p = randperm(size(PVCCGVal,1));
    p = sort(p(1:15));
    plotCCG(-50:50,PVCCGVal(:,:),'Putative PV',[num2str(meanPVCCGPeakTime) '+/-' num2str(semPVCCGPeakTime)],...
        pathAnal,['putativePVCCG' num2str(cluPV2)]);
    plotCCG(-50:50,PVCCGValTag(:,:),'Tagged PV',[num2str(meanPVCCGPeakTimeTag) '+/-' num2str(semPVCCGPeakTimeTag)],...
        pathAnal,['taggedPVCCG' num2str(cluPV2)]);
    plotHistPhase(posPhase(indPhase)-360,PVHistPhaseFil(:,:),'Putative PV',...
        [num2str(meanPVMaxPhase) '+/-' num2str(semPVMaxPhase)],pathAnal,['putativePVHistPhase' num2str(cluPV2)]);
    plotHistPhase(posPhase(indPhase)-360,PVHistPhaseFilTag(:,:),'Tagged PV',...
        [num2str(meanPVMaxPhaseTag) '+/-' num2str(semPVMaxPhaseTag)],pathAnal,['taggedPVHistPhase' num2str(cluPV2)]);
    
    ind = find(modInt1NoCue.timeStepRun == -2);
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indTmp1(1:end),ind:end),['C' num2str(cluPV2) ' FR (Hz)'],...
        ['Int_FRProfilePutativePVC' num2str(cluPV2)],...
        pathAnal,[])
    plotAvgFRProfile(modInt1NoCue.timeStepRun(ind:end),...
        avgFRProfileNorm(indPVGood,ind:end),['Tagged PV C' num2str(cluPV2) ' FR (Hz)'],...
        ['Int_FRProfileTaggedPVC' num2str(cluPV2)],...
        pathAnal,[])
    

   
end

function plotCCG(time,ccg,ylab,tit,path,fileName)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
        
    imagesc(time,1:size(ccg,1),ccg);
%     colormap jet
    xlabel('Time (ms)')
    ylabel(ylab)
    title(tit);
    fileName1 = [path fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

function plotHistPhase(phase,ccg,ylab,tit,path,fileName)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
        
    imagesc(phase,1:size(ccg,1),ccg);
%     colormap jet
    set(gca,'XTick',[0 180 360 540 720]);
    xlabel('Theta phase (deg.)')
    ylabel(ylab)
    title(tit);
    
    fileName1 = [path fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

function plotAvgFRProfile(timeStepRun,avgFRProfile,yl,fileName,pathAnal,ylimit)
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_area = [27 117 187]./255;    % Blue theme
    options.color_line = [ 39 169 225]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axis = timeStepRun;
    plot_areaerrorbar(avgFRProfile,options);
    hold on;
    h = plot([0 0],[0 1],'r-');
    set(h,'LineWidth',1)
    set(gca,'XLim',[timeStepRun(1) 3],'XTick',timeStepRun(1):1:4);
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[0 1]);
%         set(gca,'YLim',[min(mean(avgFRProfile)-std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*0.95 ...
%         max(mean(avgFRProfile)+std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*1.05]);
    end
    xlabel('Time (s)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end

function plotAvgFRProfileCmp(timeStepRun,avgFRProfilex,avgFRProfiley,yl,fileName,pathAnal,ylimit)
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
 
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = timeStepRun;
    options.x_axisY = timeStepRun;
    plot_areaerrorbarXY(avgFRProfilex, avgFRProfiley,...
        options);
    hold on;
    minX = min(mean(avgFRProfilex)-std(avgFRProfilex)/sqrt(size(avgFRProfilex,1)));
    minY = min(mean(avgFRProfiley)-std(avgFRProfiley)/sqrt(size(avgFRProfiley,1)));
    maxX = max(mean(avgFRProfilex)+std(avgFRProfilex)/sqrt(size(avgFRProfilex,1)));
    maxY = max(mean(avgFRProfiley)+std(avgFRProfiley)/sqrt(size(avgFRProfiley,1)));
    h = plot([0 0],[0 1],'r-');
    set(h,'LineWidth',1)
    set(gca,'XLim',[timeStepRun(1) 3],'XTick',timeStepRun(1):1:4,'YLim',[0 1]);
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[0.4 1]);
%         set(gca,'YLim',[min([minX minY])*0.95 ...
%         max([maxX maxY])*1.05]);
    end
    xlabel('Time (s)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end
