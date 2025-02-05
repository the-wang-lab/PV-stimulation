function InitAll = PyrIntInitPeakByTypeAll(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                modInt1NoCue,modInt1AL,modInt1PL,minNumTr,minNumTrBad)

    if(taskSel == 1)   
        InitAll.task = [modPyr1NoCue.task modPyr1AL.task modPyr1PL.task];
        InitAll.indRec = [modPyr1NoCue.indRec modPyr1AL.indRec modPyr1PL.indRec];
        InitAll.indNeu = [modPyr1NoCue.indNeu modPyr1AL.indNeu modPyr1PL.indNeu];
        InitAll.idxC2 = [modPyr1NoCue.idxC2 modPyr1AL.idxC2 modPyr1PL.idxC2];
        InitAll.avgFRProfile = [modPyr1NoCue.avgFRProfileGoodAll; modPyr1AL.avgFRProfileGoodAll; modPyr1PL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBad = [modPyr1NoCue.avgFRProfileBadAll; modPyr1AL.avgFRProfileBadAll; modPyr1PL.avgFRProfileBadAll];
        InitAll.relDepthNeuHDef = [modPyr1NoCue.relDepthNeuHDef modPyr1AL.relDepthNeuHDef modPyr1PL.relDepthNeuHDef];
        InitAll.isNeuWithFieldAligned = [modPyr1NoCue.isNeuWithFieldAligned modPyr1AL.isNeuWithFieldAligned...
            modPyr1PL.isNeuWithFieldAligned];
        InitAll.numTrGood = [modPyr1NoCue.numTrGood modPyr1AL.numTrGood...
            modPyr1PL.numTrGood];
        InitAll.numTrBad = [modPyr1NoCue.numTrBad modPyr1AL.numTrBad...
            modPyr1PL.numTrBad];
        
        InitAll.taskInt = [modInt1NoCue.task modInt1AL.task modInt1PL.task];
        InitAll.indRecInt = [modInt1NoCue.indRec modInt1AL.indRec modInt1PL.indRec];
        InitAll.indNeuInt = [modInt1NoCue.indNeu modInt1AL.indNeu modInt1PL.indNeu];
        InitAll.idxC2Int = [modInt1NoCue.idxC2 modInt1AL.idxC2 modInt1PL.idxC2];
        InitAll.avgFRProfileInt = [modInt1NoCue.avgFRProfileGoodAll; modInt1AL.avgFRProfileGoodAll; modInt1PL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBadInt = [modInt1NoCue.avgFRProfileBadAll; modInt1AL.avgFRProfileBadAll; modInt1PL.avgFRProfileBadAll];
        InitAll.numTrGoodInt = [modInt1NoCue.numTrGood modInt1AL.numTrGood...
            modInt1PL.numTrGood];
        InitAll.numTrBadInt = [modInt1NoCue.numTrBad modInt1AL.numTrBad...
            modInt1PL.numTrBad];
    elseif(taskSel == 2)
        InitAll.task = [modPyr1AL.task modPyr1PL.task];
        InitAll.indRec = [modPyr1AL.indRec modPyr1PL.indRec];
        InitAll.indNeu = [modPyr1AL.indNeu modPyr1PL.indNeu];
        InitAll.idxC2 = [modPyr1AL.idxC2 modPyr1PL.idxC2];
        InitAll.avgFRProfile = [modPyr1AL.avgFRProfileGoodAll; modPyr1PL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBad = [modPyr1AL.avgFRProfileBadAll; modPyr1PL.avgFRProfileBadAll];
        InitAll.relDepthNeuHDef = [modPyr1AL.relDepthNeuHDef modPyr1PL.relDepthNeuHDef];
        InitAll.isNeuWithFieldAligned = [modPyr1AL.isNeuWithFieldAligned...
            modPyr1PL.isNeuWithFieldAligned];
        InitAll.numTrGood = [modPyr1AL.numTrGood...
            modPyr1PL.numTrGood];
        InitAll.numTrBad = [modPyr1AL.numTrBad...
            modPyr1PL.numTrBad];
        
        InitAll.taskInt = [modInt1AL.task modInt1PL.task];
        InitAll.indRecInt = [modInt1AL.indRec modInt1PL.indRec];
        InitAll.indNeuInt = [modInt1AL.indNeu modInt1PL.indNeu];
        InitAll.idxC2Int = [modInt1AL.idxC2 modInt1PL.idxC2];
        InitAll.avgFRProfileInt = [modInt1AL.avgFRProfileGoodAll; modInt1PL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBadInt = [modInt1AL.avgFRProfileBadAll; modInt1PL.avgFRProfileBadAll];
        InitAll.numTrGoodInt = [modInt1AL.numTrGood...
            modInt1PL.numTrGood];
        InitAll.numTrBadInt = [modInt1AL.numTrBad...
            modInt1PL.numTrBad];
    else
        InitAll.task = [modPyr1AL.task];
        InitAll.indRec = [modPyr1AL.indRec];
        InitAll.indNeu = [modPyr1AL.indNeu];
        InitAll.idxC2 = [modPyr1AL.idxC2];
        InitAll.avgFRProfile = [modPyr1AL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBad = [modPyr1AL.avgFRProfileBadAll];
        InitAll.relDepthNeuHDef = [modPyr1AL.relDepthNeuHDef];
        InitAll.isNeuWithFieldAligned = [modPyr1AL.isNeuWithFieldAligned];
        InitAll.numTrGood = [modPyr1AL.numTrGood];
        InitAll.numTrBad = [modPyr1AL.numTrBad];
        
        InitAll.taskInt = [modInt1AL.task];
        InitAll.indRecInt = [modInt1AL.indRec];
        InitAll.indNeuInt = [modInt1AL.indNeu];
        InitAll.idxC2Int = [modInt1AL.idxC2];
        InitAll.avgFRProfileInt = [modInt1AL.avgFRProfileGoodAll];
        InitAll.avgFRProfileBadInt = [modInt1AL.avgFRProfileBadAll];
        InitAll.numTrGoodInt = [modInt1AL.numTrGood];
        InitAll.numTrBadInt = [modInt1AL.numTrBad];
    end
    
    InitAll.goodNeu = find(InitAll.numTrGood >= minNumTr & InitAll.numTrBad >= minNumTrBad);
    InitAll.goodNeuInt = find(InitAll.numTrGoodInt >= minNumTr & InitAll.numTrBadInt >= minNumTrBad);
    
    %% normalization
    indTmp = modPyr1NoCue.timeStepRun >=-1 & modPyr1NoCue.timeStepRun <= 4 ;
    InitAll.avgFRProfileNorm = zeros(size(InitAll.avgFRProfile,1),size(InitAll.avgFRProfile,2));
    for i = 1:size(InitAll.avgFRProfile,1)
        if(max(InitAll.avgFRProfile(i,:)) ~= 0)
            InitAll.avgFRProfileNorm(i,:) = InitAll.avgFRProfile(i,:)/max(InitAll.avgFRProfile(i,:));
        end
    end
    n = 0;

    InitAll.avgFRProfileNormBad = zeros(size(InitAll.avgFRProfileBad,1),size(InitAll.avgFRProfileBad,2));
    for i = 1:size(InitAll.avgFRProfileBad,1)
        if(max(InitAll.avgFRProfileBad(i,:)) ~= 0 && sum(isnan(InitAll.avgFRProfileBad(i,:))) == 0)
            InitAll.avgFRProfileNormBad(i,:) = InitAll.avgFRProfileBad(i,:)/max(InitAll.avgFRProfileBad(i,:));
        end
    end
    
    InitAll.avgFRProfileNormInt = zeros(size(InitAll.avgFRProfileInt,1),size(InitAll.avgFRProfileInt,2));
    for i = 1:size(InitAll.avgFRProfileInt,1)
        if(max(InitAll.avgFRProfileInt(i,:)) ~= 0)
            InitAll.avgFRProfileNormInt(i,:) = InitAll.avgFRProfileInt(i,:)/max(InitAll.avgFRProfileInt(i,:));
        end
    end

    InitAll.avgFRProfileNormBadInt = zeros(size(InitAll.avgFRProfileBadInt,1),size(InitAll.avgFRProfileBadInt,2));
    for i = 1:size(InitAll.avgFRProfileBadInt,1)
        if(max(InitAll.avgFRProfileBadInt(i,:)) ~= 0 && sum(isnan(InitAll.avgFRProfileBad(i,:))) == 0)
            InitAll.avgFRProfileNormBadInt(i,:) = InitAll.avgFRProfileBadInt(i,:)/max(InitAll.avgFRProfileBadInt(i,:));
        end
    end
end