function PyrInitPeakAllRec(taskSel,methodKMean)
        
    if(nargin == 0)
        methodKMean = 2;
    end
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    GlobalConstFq;
    
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
    if(taskSel == 2 && exist('modPyr1NoCue') == 0)
        nNeuWithField = [modPyrNoCue.nNeuWithField modPyrAL.nNeuWithField modPyrPL.nNeuWithField];
        nNeuWithFieldAligned = [modAlignedPyrNoCue.nNeuWithField modAlignedPyrAL.nNeuWithField ...
            modAlignedPyrPL.nNeuWithField];
        isNeuWithField = [modPyrNoCue.isNeuWithField modPyrAL.isNeuWithField modPyrPL.isNeuWithField];
        isNeuWithFieldAligned = [modAlignedPyrNoCue.isNeuWithField modAlignedPyrAL.isNeuWithField ...
            modAlignedPyrPL.isNeuWithField];

        disp('No cue - peak firing rate')
        modPyr1NoCue = accumPyrInit(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,autoCorrPyrAll,...
            nNeuWithField,isNeuWithField,nNeuWithFieldAligned,isNeuWithFieldAligned,...
            minFR,maxFR,1,sampleFq);

        disp('Active licking - peak firing rate')
        modPyr1AL = accumPyrInit(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            nNeuWithField,isNeuWithField,nNeuWithFieldAligned,isNeuWithFieldAligned,...
            minFR,maxFR,2,sampleFq);

        disp('Passive licking - peak firing rate')
        modPyr1PL = accumPyrInit(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,autoCorrPyrAll,...
            nNeuWithField,isNeuWithField,nNeuWithFieldAligned,isNeuWithFieldAligned,...
            minFR,maxFR,3,sampleFq);

        save([pathAnal0 'initPeakPyrAllRec.mat'],'modPyr1NoCue','modPyr1AL','modPyr1PL','-v7.3'); 

        
        %% plot perc. of neurons with fields
        numField.NoCueIndRec = find(modPyr1NoCue.taskPerRecGood ~= 0);
        numField.NoCue = modPyr1NoCue.nNeuWithFieldPerRecGood(numField.NoCueIndRec);
        numField.NoCuePercNeu =  modPyr1NoCue.nNeuWithFieldPerRecGood(numField.NoCueIndRec)./...
             modPyr1NoCue.nNeuPerRecGood(numField.NoCueIndRec);
        numField.ALIndRec = find(modPyr1AL.taskPerRecGood ~= 0);
        numField.PLIndRec = find(modPyr1PL.taskPerRecGood ~= 0);
        numField.ALPL = [modPyr1AL.nNeuWithFieldPerRecGood(numField.ALIndRec),...
            modPyr1PL.nNeuWithFieldPerRecGood(numField.PLIndRec)];
        numField.ALPLPercNeu = [modPyr1AL.nNeuWithFieldPerRecGood(numField.ALIndRec)./...
            modPyr1AL.nNeuPerRecGood(numField.ALIndRec),...
            modPyr1PL.nNeuWithFieldPerRecGood(numField.PLIndRec)./...
            modPyr1PL.nNeuPerRecGood(numField.PLIndRec)];
        numField.pRSNumField = ranksum(numField.NoCue,numField.ALPL);
        numField.pRSPercField = ranksum(numField.NoCuePercNeu,numField.ALPLPercNeu);
        
        numField.AL = [modPyr1AL.nNeuWithFieldPerRecGood(numField.ALIndRec)];
        numField.ALPercNeu = [modPyr1AL.nNeuWithFieldPerRecGood(numField.ALIndRec)./...
            modPyr1AL.nNeuPerRecGood(numField.ALIndRec)];
        numField.pRSNumFieldAL = ranksum(numField.NoCue,numField.AL);
        numField.pRSPercFieldAL = ranksum(numField.NoCuePercNeu,numField.ALPercNeu);

        numFieldAligned.NoCueIndRec = find(modPyr1NoCue.taskPerRecGood ~= 0);
        numFieldAligned.NoCue = modPyr1NoCue.nNeuWithFieldAlignedPerRecGood(numFieldAligned.NoCueIndRec);
        numFieldAligned.NoCuePercNeu =  modPyr1NoCue.nNeuWithFieldAlignedPerRecGood(numFieldAligned.NoCueIndRec)./...
             modPyr1NoCue.nNeuPerRecGood(numFieldAligned.NoCueIndRec);
        numFieldAligned.ALIndRec = find(modPyr1AL.taskPerRecGood ~= 0);
        numFieldAligned.PLIndRec = find(modPyr1PL.taskPerRecGood ~= 0);
        numFieldAligned.ALPL = [modPyr1AL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.ALIndRec),...
            modPyr1PL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.PLIndRec)];
        numFieldAligned.ALPLPercNeu = [modPyr1AL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.ALIndRec)./...
            modPyr1AL.nNeuPerRecGood(numFieldAligned.ALIndRec),...
            modPyr1PL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.PLIndRec)./...
            modPyr1PL.nNeuPerRecGood(numFieldAligned.PLIndRec)];
        numFieldAligned.pRSNumField = ranksum(numFieldAligned.NoCue,numFieldAligned.ALPL);
        numFieldAligned.pRSPercField = ranksum(numFieldAligned.NoCuePercNeu,numFieldAligned.ALPLPercNeu);
        
        numFieldAligned.AL = [modPyr1AL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.ALIndRec)];
        numFieldAligned.ALPercNeu = [modPyr1AL.nNeuWithFieldAlignedPerRecGood(numFieldAligned.ALIndRec)./...
            modPyr1AL.nNeuPerRecGood(numFieldAligned.ALIndRec)];
        numFieldAligned.pRSNumFieldAL = ranksum(numFieldAligned.NoCue,numFieldAligned.AL);
        numFieldAligned.pRSPercFieldAL = ranksum(numFieldAligned.NoCuePercNeu,numFieldAligned.ALPercNeu);

        plotBars(numField.NoCue,numField.ALPL,[mean(numField.NoCue),mean(numField.ALPL)],...
            [std(numField.NoCue)/sqrt(length(numField.NoCue)),std(numField.ALPL)/sqrt(length(numField.ALPL))],...
            '','No. fields', ['p=' num2str(numField.pRSNumField)],pathAnal0,'NumFieldNoCueVsALPLGood')
        plotBars(numFieldAligned.NoCue,numFieldAligned.ALPL,[mean(numFieldAligned.NoCue),mean(numFieldAligned.ALPL)],...
            [std(numFieldAligned.NoCue)/sqrt(length(numFieldAligned.NoCue)),...
            std(numFieldAligned.ALPL)/sqrt(length(numFieldAligned.ALPL))],...
            '','No. fields (Aligned)', ['p=' num2str(numFieldAligned.pRSNumField)],pathAnal0,'NumFieldAlignedNoCueVsALPLGood')

        plotBars(numField.NoCuePercNeu,numField.ALPLPercNeu,[mean(numField.NoCuePercNeu),mean(numField.ALPLPercNeu)],...
            [std(numField.NoCuePercNeu)/sqrt(length(numField.NoCuePercNeu)),std(numField.ALPLPercNeu)/sqrt(length(numField.ALPLPercNeu))],...
            '','Perc. neurons with field', ['p=' num2str(numField.pRSPercField)],pathAnal0,'PercFieldNoCueVsALPLGood')
        plotBars(numFieldAligned.NoCuePercNeu,numFieldAligned.ALPLPercNeu,...
            [mean(numFieldAligned.NoCuePercNeu),mean(numFieldAligned.ALPLPercNeu)],...
            [std(numFieldAligned.NoCuePercNeu)/sqrt(length(numFieldAligned.NoCuePercNeu)),...
            std(numFieldAligned.ALPLPercNeu)/sqrt(length(numFieldAligned.ALPLPercNeu))],...
            '','Perc. neurons with field (Aligned)', ['p=' num2str(numFieldAligned.pRSPercField)],...
            pathAnal0,'PercFieldAlignedNoCueVsALPLGood')
        
        plotBars(numField.NoCue,numField.AL,[mean(numField.NoCue),mean(numField.AL)],...
            [std(numField.NoCue)/sqrt(length(numField.NoCue)),std(numField.AL)/sqrt(length(numField.AL))],...
            '','No. fields', ['p=' num2str(numField.pRSNumFieldAL)],pathAnal0,'NumFieldNoCueVsALGood')
        plotBars(numFieldAligned.NoCue,numFieldAligned.AL,[mean(numFieldAligned.NoCue),mean(numFieldAligned.AL)],...
            [std(numFieldAligned.NoCue)/sqrt(length(numFieldAligned.NoCue)),...
            std(numFieldAligned.AL)/sqrt(length(numFieldAligned.AL))],...
            '','No. fields (Aligned)', ['p=' num2str(numFieldAligned.pRSNumFieldAL)],pathAnal0,'NumFieldAlignedNoCueVsALGood')

        plotBars(numField.NoCuePercNeu,numField.ALPercNeu,[mean(numField.NoCuePercNeu),mean(numField.ALPercNeu)],...
            [std(numField.NoCuePercNeu)/sqrt(length(numField.NoCuePercNeu)),std(numField.ALPercNeu)/sqrt(length(numField.ALPercNeu))],...
            '','Perc. neurons with field', ['p=' num2str(numField.pRSPercFieldAL)],pathAnal0,'PercFieldNoCueVsALGood')
        plotBars(numFieldAligned.NoCuePercNeu,numFieldAligned.ALPercNeu,...
            [mean(numFieldAligned.NoCuePercNeu),mean(numFieldAligned.ALPercNeu)],...
            [std(numFieldAligned.NoCuePercNeu)/sqrt(length(numFieldAligned.NoCuePercNeu)),...
            std(numFieldAligned.ALPercNeu)/sqrt(length(numFieldAligned.ALPercNeu))],...
            '','Perc. neurons with field (Aligned)', ['p=' num2str(numFieldAligned.pRSPercFieldAL)],...
            pathAnal0,'PercFieldAlignedNoCueVsALGood')
        
        save([pathAnal0 'initPeakPyrAllRec.mat'],'numField','numFieldAligned','-append');
    end
    
    %% accumulate across different types of recordings
    init = PyrInitPeakAllRecByType(modPyr1NoCue,modPyr1AL,modPyr1PL,taskSel,methodKMean);
    
    %% calculate mean for each segment of averaged FR profile
    FRProfileMean = accumMean(init.avgFRProfile,modPyr1NoCue.timeStepRun);
    
    FRProfileMeanGood = accumMean(init.avgFRProfileGood,modPyr1NoCue.timeStepRun); % good trials only
    
    FRProfileMeanBad = accumMean(init.avgFRProfileBad,modPyr1NoCue.timeStepRun); % bad trials only
    
    %% compare the neurons with and without fields
    FRProfileMeanStat = accumMeanStat(FRProfileMean,init.nNeuWithField,init.isNeuWithField);
    
    %% compare the neurons with and without fields, aligned to run onset
    FRProfileMeanStatAligned = accumMeanStat(FRProfileMean,init.nNeuWithFieldAligned,init.isNeuWithFieldAligned);
    
    % compare within the same cluster recordings and neurons with/without
    % fields
    FRProfileMeanStatC = accumMeanStatC(FRProfileMean,init.idxC,init.nNeuWithField,init.isNeuWithField);
    
    FRProfileMeanStatCGood = accumMeanStatC(FRProfileMeanGood,init.idxCGood,init.nNeuWithFieldGood,init.isNeuWithFieldGood);
    
    % compare within the same cluster recordings and neurons with/without
    % fields (aligned)
    FRProfileMeanStatCAligned = accumMeanStatC(FRProfileMean,init.idxC,init.nNeuWithFieldAligned,init.isNeuWithFieldAligned);
    
    FRProfileMeanStatCAlignedGood = accumMeanStatC(FRProfileMeanGood,init.idxCGood,init.nNeuWithFieldAlignedGood,init.isNeuWithFieldAlignedGood);
    
    % compare the firing rate change to baseline, between C1 and C2
    FRProfileMeanStatC1C2 = accumMeanStatCCmp(FRProfileMean,init.idxC);
    
    FRProfileMeanStatC1C2Good = accumMeanStatCCmp(FRProfileMeanGood,init.idxCGood);
    
    % compare good and bad trials
    FRProfileMeanStatGoodBad = accumMeanStatCGoodBad(FRProfileMeanGood,FRProfileMeanBad,init.idxCGood,init.idxCBad);
    
    save([pathAnal 'initPeakPyrAllRec_km' num2str(methodKMean) '.mat'],'FRProfileMean','FRProfileMeanGood','FRProfileMeanBad',...
        'FRProfileMeanStat','FRProfileMeanStatAligned',...
        'FRProfileMeanStatC','FRProfileMeanStatCGood','FRProfileMeanStatCAligned',...
        'FRProfileMeanStatCAlignedGood','FRProfileMeanStatC1C2','FRProfileMeanStatC1C2Good','FRProfileMeanStatGoodBad'); 
    
    %% plot figures
    colorSel = 0;
    %% need to be changed depending on the clustering result
    if(methodKMean == 2)
        idxCTmp(1) = 2; % deep
        idxCTmp(2) = 1; % sup
    elseif(methodKMean == 3)
        idxCTmp(1) = 1; % deep
        idxCTmp(2) = 2; % superficial
    end
    
    %% for good trials
    plotPyrInitPeakClu(pathAnal,init.idxCGood,FRProfileMeanGood,FRProfileMeanStatCGood,colorSel,idxCTmp,'Good');
    
    %% fields two clusters
    plotPyrInitFieldRecPerClu(pathAnal,init.idxC,init.nNeuWithField,modPyr1NoCue.timeStepRun,...
        init.avgFRProfile,init.avgFRProfileNorm,FRProfileMean,FRProfileMeanStatC,colorSel,idxCTmp,'');
        
    plotPyrInitFieldPerClu(pathAnal,init.idxC,init.isNeuWithField,...
        modPyr1NoCue.timeStepRun,init.avgFRProfile,init.avgFRProfileNorm,...
        FRProfileMean,FRProfileMeanStatC,colorSel,idxCTmp,'');
    
    pause;
    close all;
    
    %% fields all cells
    plotPyrInitFieldRec(pathAnal,init.nNeuWithField,modPyr1NoCue.timeStepRun,...
        init.avgFRProfile,init.avgFRProfileNorm,FRProfileMean,FRProfileMeanStat,colorSel,'All');
        
    plotPyrInitField(pathAnal,init.isNeuWithField,...
        modPyr1NoCue.timeStepRun,init.avgFRProfile,init.avgFRProfileNorm,...
        FRProfileMean,FRProfileMeanStat,colorSel,'All');
       
    pause;
    close all;
    
    %% fields after aligned to run onset two clusters
    plotPyrInitFieldRecPerClu(pathAnal,init.idxC,init.nNeuWithFieldAligned,modPyr1NoCue.timeStepRun,...
        init.avgFRProfile,init.avgFRProfileNorm,FRProfileMean,FRProfileMeanStatCAligned,colorSel,idxCTmp,'Aligned');
    
    plotPyrInitFieldPerClu(pathAnal,init.idxC,init.isNeuWithFieldAligned,...
        modPyr1NoCue.timeStepRun,init.avgFRProfile,init.avgFRProfileNorm,...
        FRProfileMean,FRProfileMeanStatCAligned,colorSel,idxCTmp,'Aligned');
    %%
    
    %% fields after aligned to run onset all cells
    plotPyrInitFieldRec(pathAnal,init.nNeuWithFieldAligned,modPyr1NoCue.timeStepRun,...
        init.avgFRProfile,init.avgFRProfileNorm,FRProfileMean,FRProfileMeanStatAligned,colorSel,'AllAligned');
    
    plotPyrInitField(pathAnal,init.isNeuWithFieldAligned,...
        modPyr1NoCue.timeStepRun,init.avgFRProfile,init.avgFRProfileNorm,...
        FRProfileMean,FRProfileMeanStatAligned,colorSel,'AllAligned');
    %%
           
    pause;
    close all;
    
    plotPyrInitGoodBadTrPerClu(pathAnal,init.idxCGood,init.idxCBad,modPyr1NoCue.timeStepRun,...
        init.avgFRProfileGood,init.avgFRProfileBad,...
        init.avgFRProfileNormGood,init.avgFRProfileNormBad,FRProfileMeanGood,FRProfileMeanBad,...
        FRProfileMeanStatGoodBad,colorSel,idxCTmp);
    
    idxC1 = init.idxC == idxCTmp(1); %'Deep'
    idxC2 = init.idxC == idxCTmp(2); %'Sup'
    plotPyrInitCmpClu(pathAnal,idxC1,idxC2,modPyr1NoCue.timeStepRun,init.avgFRProfile,...
        init.avgFRProfileNorm,FRProfileMean,FRProfileMeanStatC1C2,colorSel);
    
    plotPyrInitGoodVsBadTr(pathAnal,modPyr1NoCue.timeStepRun,init.avgFRProfileGood,init.avgFRProfileBad,...
        init.avgFRProfileNormGood,init.avgFRProfileNormBad,FRProfileMeanGood,FRProfileMeanBad,FRProfileMeanStatGoodBad,colorSel);
    
    pause;
    close all;
end








