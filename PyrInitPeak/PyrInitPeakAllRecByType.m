function init = PyrInitPeakAllRecByType(modPyr1NoCue,modPyr1AL,modPyr1PL,taskSel,methodKMean)
% accumulate the data from different types of recordings
% this function is called by PyrInitPeakAllRec.m

    if(taskSel == 1)
        init.task = [modPyr1NoCue.task modPyr1AL.task modPyr1PL.task];
        init.taskGood = [modPyr1NoCue.taskGood modPyr1AL.taskGood modPyr1PL.taskGood];
        init.taskBad = [modPyr1NoCue.taskBad modPyr1AL.taskBad modPyr1PL.taskBad];
        init.indRec = [modPyr1NoCue.indRec modPyr1AL.indRec modPyr1PL.indRec];
        init.indRecGood = [modPyr1NoCue.indRecGood modPyr1AL.indRecGood modPyr1PL.indRecGood];
        init.indRecBad = [modPyr1NoCue.indRecBad modPyr1AL.indRecBad modPyr1PL.indRecBad];
        init.indNeu = [modPyr1NoCue.indNeu modPyr1AL.indNeu modPyr1PL.indNeu];
        init.indNeuGood = [modPyr1NoCue.indNeuGood modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
        init.indNeuBad = [modPyr1NoCue.indNeuBad modPyr1AL.indNeuBad modPyr1PL.indNeuBad];
        init.relDepthNeuHDef = [modPyr1NoCue.relDepthNeuHDef modPyr1AL.relDepthNeuHDef modPyr1PL.relDepthNeuHDef];
        init.relDepthNeuHDefGood = [modPyr1NoCue.relDepthNeuHDefGood modPyr1AL.relDepthNeuHDefGood ...
            modPyr1PL.relDepthNeuHDefGood];
        init.isNeuWithField = [modPyr1NoCue.isNeuWithField modPyr1AL.isNeuWithField modPyr1PL.isNeuWithField];
        init.isNeuWithFieldGood = [modPyr1NoCue.isNeuWithFieldGood modPyr1AL.isNeuWithFieldGood modPyr1PL.isNeuWithFieldGood];
        init.nNeuWithField = [modPyr1NoCue.nNeuWithField modPyr1AL.nNeuWithField modPyr1PL.nNeuWithField];
        init.nNeuWithFieldGood = [modPyr1NoCue.nNeuWithFieldGood modPyr1AL.nNeuWithFieldGood modPyr1PL.nNeuWithFieldGood];
        init.isNeuWithFieldAligned = [modPyr1NoCue.isNeuWithFieldAligned modPyr1AL.isNeuWithFieldAligned...
            modPyr1PL.isNeuWithFieldAligned];
        init.isNeuWithFieldAlignedGood = [modPyr1NoCue.isNeuWithFieldAlignedGood modPyr1AL.isNeuWithFieldAlignedGood...
            modPyr1PL.isNeuWithFieldAlignedGood];
        init.nNeuWithFieldAligned = [modPyr1NoCue.nNeuWithFieldAligned modPyr1AL.nNeuWithFieldAligned...
            modPyr1PL.nNeuWithFieldAligned];
        init.nNeuWithFieldAlignedGood = [modPyr1NoCue.nNeuWithFieldAlignedGood modPyr1AL.nNeuWithFieldAlignedGood...
            modPyr1PL.nNeuWithFieldAlignedGood];
        init.avgFRProfile = [modPyr1NoCue.avgFRProfile; modPyr1AL.avgFRProfile; modPyr1PL.avgFRProfile];
        init.avgFRProfileGoodAll = [modPyr1NoCue.avgFRProfileGoodAll; modPyr1AL.avgFRProfileGoodAll; modPyr1PL.avgFRProfileGoodAll];
        init.avgFRProfileBadAll = [modPyr1NoCue.avgFRProfileBadAll; modPyr1AL.avgFRProfileBadAll; modPyr1PL.avgFRProfileBadAll];
        init.numTr = [modPyr1NoCue.numTr modPyr1AL.numTr modPyr1PL.numTr];
        init.numTrGood = [modPyr1NoCue.numTrGood modPyr1AL.numTrGood modPyr1PL.numTrGood];
        init.numTrBad = [modPyr1NoCue.numTrBad modPyr1AL.numTrBad modPyr1PL.numTrBad];
        init.avgFRProfileGood = [modPyr1NoCue.avgFRProfileGood; modPyr1AL.avgFRProfileGood; modPyr1PL.avgFRProfileGood];
        init.avgFRProfileBad = [modPyr1NoCue.avgFRProfileBad; modPyr1AL.avgFRProfileBad; modPyr1PL.avgFRProfileBad];
        
        if(methodKMean == 1)
            init.idxC = [modPyr1NoCue.idxC1 modPyr1AL.idxC1 modPyr1PL.idxC1];
            init.idxCGood = [modPyr1NoCue.idxC1Good modPyr1AL.idxC1Good modPyr1PL.idxC1Good];
            init.idxCBad = [modPyr1NoCue.idxC1Bad modPyr1AL.idxC1Bad modPyr1PL.idxC1Bad];
        elseif(methodKMean == 2)
            init.idxC = [modPyr1NoCue.idxC2 modPyr1AL.idxC2 modPyr1PL.idxC2];
            init.idxCGood = [modPyr1NoCue.idxC2Good modPyr1AL.idxC2Good modPyr1PL.idxC2Good];
            init.idxCBad = [modPyr1NoCue.idxC2Bad modPyr1AL.idxC2Bad modPyr1PL.idxC2Bad];
        elseif(methodKMean == 3)
            init.idxC = [modPyr1NoCue.idxC3 modPyr1AL.idxC3 modPyr1PL.idxC3];
            init.idxCGood = [modPyr1NoCue.idxC3Good modPyr1AL.idxC3Good modPyr1PL.idxC3Good];
            init.idxCBad = [modPyr1NoCue.idxC3Bad modPyr1AL.idxC3Bad modPyr1PL.idxC3Bad];
        end
    elseif(taskSel == 2)
        init.task = [modPyr1AL.task modPyr1PL.task];
        init.taskGood = [modPyr1AL.taskGood modPyr1PL.taskGood];
        init.taskBad = [modPyr1AL.taskBad modPyr1PL.taskBad];
        init.indRec = [modPyr1AL.indRec modPyr1PL.indRec];
        init.indRecGood = [modPyr1AL.indRecGood modPyr1PL.indRecGood];
        init.indRecBad = [modPyr1AL.indRecBad modPyr1PL.indRecBad];
        init.indNeu = [modPyr1AL.indNeu modPyr1PL.indNeu];
        init.indNeuGood = [modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
        init.indNeuBad = [modPyr1AL.indNeuBad modPyr1PL.indNeuBad];
        init.relDepthNeuHDef = [modPyr1AL.relDepthNeuHDef modPyr1PL.relDepthNeuHDef];
        init.relDepthNeuHDefGood = [modPyr1AL.relDepthNeuHDefGood ...
            modPyr1PL.relDepthNeuHDefGood];
        init.isNeuWithField = [modPyr1AL.isNeuWithField modPyr1PL.isNeuWithField];
        init.isNeuWithFieldGood = [modPyr1AL.isNeuWithFieldGood modPyr1PL.isNeuWithFieldGood];
        init.nNeuWithField = [modPyr1AL.nNeuWithField modPyr1PL.nNeuWithField];
        init.nNeuWithFieldGood = [modPyr1AL.nNeuWithFieldGood modPyr1PL.nNeuWithFieldGood];
        init.isNeuWithFieldAligned = [modPyr1AL.isNeuWithFieldAligned...
            modPyr1PL.isNeuWithFieldAligned];
        init.isNeuWithFieldAlignedGood = [modPyr1AL.isNeuWithFieldAlignedGood...
            modPyr1PL.isNeuWithFieldAlignedGood];
        init.nNeuWithFieldAligned = [modPyr1AL.nNeuWithFieldAligned...
            modPyr1PL.nNeuWithFieldAligned];
        init.nNeuWithFieldAlignedGood = [modPyr1AL.nNeuWithFieldAlignedGood...
            modPyr1PL.nNeuWithFieldAlignedGood];
        init.avgFRProfile = [modPyr1AL.avgFRProfile; modPyr1PL.avgFRProfile];
        init.avgFRProfileGoodAll = [modPyr1AL.avgFRProfileGoodAll; modPyr1PL.avgFRProfileGoodAll];
        init.avgFRProfileBadAll = [modPyr1AL.avgFRProfileBadAll; modPyr1PL.avgFRProfileBadAll];
        init.numTr = [modPyr1AL.numTr modPyr1PL.numTr];
        init.numTrGood = [modPyr1AL.numTrGood modPyr1PL.numTrGood];
        init.numTrBad = [modPyr1AL.numTrBad modPyr1PL.numTrBad];
        init.avgFRProfileGood = [modPyr1AL.avgFRProfileGood; modPyr1PL.avgFRProfileGood];
        init.avgFRProfileBad = [modPyr1AL.avgFRProfileBad; modPyr1PL.avgFRProfileBad];
        
        if(methodKMean == 1)
            init.idxC = [modPyr1AL.idxC1 modPyr1PL.idxC1];
            init.idxCGood = [modPyr1AL.idxC1Good modPyr1PL.idxC1Good];
            init.idxCBad = [modPyr1AL.idxC1Bad modPyr1PL.idxC1Bad];
        elseif(methodKMean == 2)
            init.idxC = [modPyr1AL.idxC2 modPyr1PL.idxC2];
            init.idxCGood = [modPyr1AL.idxC2Good modPyr1PL.idxC2Good];
            init.idxCBad = [modPyr1AL.idxC2Bad modPyr1PL.idxC2Bad];
        elseif(methodKMean == 3)
            init.idxC = [modPyr1AL.idxC3 modPyr1PL.idxC3];
            init.idxCGood = [modPyr1AL.idxC3Good modPyr1PL.idxC3Good];
            init.idxCBad = [modPyr1AL.idxC3Bad modPyr1PL.idxC3Bad];
        end
    else
        init.task = modPyr1AL.task;
        init.taskGood = modPyr1AL.taskGood;
        init.taskBad = modPyr1AL.taskBad;
        init.indRec = modPyr1AL.indRec;
        init.indRecGood = modPyr1AL.indRecGood;
        init.indRecBad = modPyr1AL.indRecBad;
        init.indNeu = modPyr1AL.indNeu;
        init.indNeuGood = modPyr1AL.indNeuGood;
        init.indNeuBad = modPyr1AL.indNeuBad;
        init.relDepthNeuHDef = modPyr1AL.relDepthNeuHDef;
        init.relDepthNeuHDefGood = modPyr1AL.relDepthNeuHDefGood;
        init.isNeuWithField = modPyr1AL.isNeuWithField;
        init.isNeuWithFieldGood = modPyr1AL.isNeuWithFieldGood;
        init.nNeuWithField = modPyr1AL.nNeuWithField;
        init.nNeuWithFieldGood = modPyr1AL.nNeuWithFieldGood;
        init.isNeuWithFieldAligned = modPyr1AL.isNeuWithFieldAligned;
        init.isNeuWithFieldAlignedGood = modPyr1AL.isNeuWithFieldAlignedGood;
        init.nNeuWithFieldAligned = modPyr1AL.nNeuWithFieldAligned;
        init.nNeuWithFieldAlignedGood = modPyr1AL.nNeuWithFieldAlignedGood;
        init.avgFRProfile = modPyr1AL.avgFRProfile; 
        init.avgFRProfileGoodAll = modPyr1AL.avgFRProfileGoodAll;
        init.avgFRProfileBadAll = modPyr1AL.avgFRProfileBadAll;
        init.numTr = modPyr1AL.numTr;
        init.numTrGood = modPyr1AL.numTrGood;
        init.numTrBad = modPyr1AL.numTrBad;
        init.avgFRProfileGood = modPyr1AL.avgFRProfileGood; 
        init.avgFRProfileBad = modPyr1AL.avgFRProfileBad;
        
        if(methodKMean == 1)
            init.idxC = modPyr1AL.idxC1; 
            init.idxCGood = modPyr1AL.idxC1Good;
            init.idxCBad = modPyr1AL.idxC1Bad;
        elseif(methodKMean == 2)
            init.idxC = modPyr1AL.idxC2;
            init.idxCGood = modPyr1AL.idxC2Good;
            init.idxCBad = modPyr1AL.idxC2Bad;
        elseif(methodKMean == 3)
            init.idxC = modPyr1AL.idxC3;
            init.idxCGood = modPyr1AL.idxC3Good;
            init.idxCBad = modPyr1AL.idxC3Bad;
        end
    end     
            
    init.avgFRProfileNorm = zeros(size(init.avgFRProfile,1),size(init.avgFRProfile,2));
    for i = 1:size(init.avgFRProfile,1)
        if(max(init.avgFRProfile(i,:)) ~= 0)
            init.avgFRProfileNorm(i,:) = init.avgFRProfile(i,:)/max(init.avgFRProfile(i,:));
        end
    end
    init.avgFRProfileGoodAllNorm = zeros(size(init.avgFRProfileGoodAll,1),size(init.avgFRProfileGoodAll,2));
    for i = 1:size(init.avgFRProfileGoodAll,1)
        if(max(init.avgFRProfileGoodAll(i,:)) ~= 0)
            init.avgFRProfileGoodAllNorm(i,:) = init.avgFRProfileGoodAll(i,:)/max(init.avgFRProfileGoodAll(i,:));
        end
    end
    init.avgFRProfileBadAllNorm = zeros(size(init.avgFRProfileBadAll,1),size(init.avgFRProfileBadAll,2));
    for i = 1:size(init.avgFRProfileBadAll,1)
        if(max(init.avgFRProfileBadAll(i,:)) ~= 0)
            init.avgFRProfileBadAllNorm(i,:) = init.avgFRProfileBadAll(i,:)/max(init.avgFRProfileBadAll(i,:));
        end
    end
    init.avgFRProfileNormGood = zeros(size(init.avgFRProfileGood,1),size(init.avgFRProfileGood,2));
    for i = 1:size(init.avgFRProfileGood,1)
        if(max(init.avgFRProfileGood(i,:)) ~= 0)
            init.avgFRProfileNormGood(i,:) = init.avgFRProfileGood(i,:)/max(init.avgFRProfileGood(i,:));
        end
    end
    init.avgFRProfileNormBad = zeros(size(init.avgFRProfileBad,1),size(init.avgFRProfileBad,2));
    for i = 1:size(init.avgFRProfileBad,1)
        if(max(init.avgFRProfileBad(i,:)) ~= 0)
            init.avgFRProfileNormBad(i,:) = init.avgFRProfileBad(i,:)/max(init.avgFRProfileBad(i,:));
        end
    end