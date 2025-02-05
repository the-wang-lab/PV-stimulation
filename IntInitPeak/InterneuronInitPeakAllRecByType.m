function modInt1 = InterneuronInitPeakAllRecByType(modInt1NoCue,modInt1AL,modInt1PL,taskSel,methodKMean)
%% accumulate the data from different types of recordings
% this function is called by InterneuronInitPeakAllRec.m

    if(taskSel == 1) 
        modInt1.task = [modInt1NoCue.task modInt1AL.task modInt1PL.task];
        modInt1.taskGood = [modInt1NoCue.taskGood modInt1AL.taskGood modInt1PL.taskGood];
        modInt1.taskBad = [modInt1NoCue.taskBad modInt1AL.taskBad modInt1PL.taskBad];
        modInt1.indRec = [modInt1NoCue.indRec modInt1AL.indRec modInt1PL.indRec];
        modInt1.indRecGood = [modInt1NoCue.indRecGood modInt1AL.indRecGood modInt1PL.indRecGood];
        modInt1.indRecBad = [modInt1NoCue.indRecBad modInt1AL.indRecBad modInt1PL.indRecBad];
        modInt1.indNeu = [modInt1NoCue.indNeu modInt1AL.indNeu modInt1PL.indNeu];
        modInt1.indNeuGood = [modInt1NoCue.indNeuGood modInt1AL.indNeuGood modInt1PL.indNeuGood];
        modInt1.indNeuBad = [modInt1NoCue.indNeuBad modInt1AL.indNeuBad modInt1PL.indNeuBad];
        if(methodKMean == 1)
            modInt1.idxC = [modInt1NoCue.idxC1 modInt1AL.idxC1 modInt1PL.idxC1];
            modInt1.idxCGood = [modInt1NoCue.idxC1Good modInt1AL.idxC1Good modInt1PL.idxC1Good];
            modInt1.idxCBad = [modInt1NoCue.idxC1Bad modInt1AL.idxC1Bad modInt1PL.idxC1Bad];
        elseif(methodKMean == 2)
            modInt1.idxC = [modInt1NoCue.idxC2 modInt1AL.idxC2 modInt1PL.idxC2];
            modInt1.idxCGood = [modInt1NoCue.idxC2Good modInt1AL.idxC2Good modInt1PL.idxC2Good];
            modInt1.idxCBad = [modInt1NoCue.idxC2Bad modInt1AL.idxC2Bad modInt1PL.idxC2Bad];
        elseif(methodKMean == 3)
            modInt1.idxC = [modInt1NoCue.idxC3 modInt1AL.idxC3 modInt1PL.idxC3];
            modInt1.idxCGood = [modInt1NoCue.idxC3Good modInt1AL.idxC3Good modInt1PL.idxC3Good];
            modInt1.idxCBad = [modInt1NoCue.idxC3Bad modInt1AL.idxC3Bad modInt1PL.idxC3Bad];
        end
        modInt1.nNeuWithField = [modInt1NoCue.nNeuWithField modInt1AL.nNeuWithField modInt1PL.nNeuWithField];
        modInt1.nNeuWithFieldAligned = [modInt1NoCue.nNeuWithFieldAligned modInt1AL.nNeuWithFieldAligned modInt1PL.nNeuWithFieldAligned];
        modInt1.nNeuWithFieldGood = [modInt1NoCue.nNeuWithFieldGood modInt1AL.nNeuWithFieldGood modInt1PL.nNeuWithFieldGood];
        modInt1.nNeuWithFieldAlignedGood = [modInt1NoCue.nNeuWithFieldAlignedGood modInt1AL.nNeuWithFieldAlignedGood modInt1PL.nNeuWithFieldAlignedGood];
        modInt1.avgFRProfile = [modInt1NoCue.avgFRProfile; modInt1AL.avgFRProfile; modInt1PL.avgFRProfile];
        modInt1.avgFRProfileGood = [modInt1NoCue.avgFRProfileGood; modInt1AL.avgFRProfileGood; modInt1PL.avgFRProfileGood];
        modInt1.avgFRProfileBad = [modInt1NoCue.avgFRProfileBad; modInt1AL.avgFRProfileBad; modInt1PL.avgFRProfileBad];
    elseif(taskSel == 2)
        modInt1.task = [modInt1AL.task modInt1PL.task];
        modInt1.taskGood = [modInt1AL.taskGood modInt1PL.taskGood];
        modInt1.taskBad = [modInt1AL.taskBad modInt1PL.taskBad];
        modInt1.indRec = [modInt1AL.indRec modInt1PL.indRec];
        modInt1.indRecGood = [modInt1AL.indRecGood modInt1PL.indRecGood];
        modInt1.indRecBad = [modInt1AL.indRecBad modInt1PL.indRecBad];
        modInt1.indNeu = [modInt1AL.indNeu modInt1PL.indNeu];
        modInt1.indNeuGood = [modInt1AL.indNeuGood modInt1PL.indNeuGood];
        modInt1.indNeuBad = [modInt1AL.indNeuBad modInt1PL.indNeuBad];
        if(methodKMean == 1)
            modInt1.idxC = [modInt1AL.idxC1 modInt1PL.idxC1];
            modInt1.idxCGood = [modInt1AL.idxC1Good modInt1PL.idxC1Good];
            modInt1.idxCBad = [modInt1AL.idxC1Bad modInt1PL.idxC1Bad];
        elseif(methodKMean == 2)
            modInt1.idxC = [modInt1AL.idxC2 modInt1PL.idxC2];
            modInt1.idxCGood = [modInt1AL.idxC2Good modInt1PL.idxC2Good];
            modInt1.idxCBad = [modInt1AL.idxC2Bad modInt1PL.idxC2Bad];
        elseif(methodKMean == 3)
            modInt1.idxC = [modInt1AL.idxC3 modInt1PL.idxC3];
            modInt1.idxCGood = [modInt1AL.idxC3Good modInt1PL.idxC3Good];
            modInt1.idxCBad = [modInt1AL.idxC3Bad modInt1PL.idxC3Bad];
        end
        modInt1.nNeuWithField = [modInt1AL.nNeuWithField modInt1PL.nNeuWithField];
        modInt1.nNeuWithFieldAligned = [modInt1AL.nNeuWithFieldAligned modInt1PL.nNeuWithFieldAligned];
        modInt1.nNeuWithFieldGood = [modInt1AL.nNeuWithFieldGood modInt1PL.nNeuWithFieldGood];
        modInt1.nNeuWithFieldAlignedGood = [modInt1AL.nNeuWithFieldAlignedGood modInt1PL.nNeuWithFieldAlignedGood];
        modInt1.avgFRProfile =[modInt1AL.avgFRProfile;  modInt1PL.avgFRProfile];
        modInt1.avgFRProfileGood = [modInt1AL.avgFRProfileGood; modInt1PL.avgFRProfileGood];
        modInt1.avgFRProfileBad = [modInt1AL.avgFRProfileBad; modInt1PL.avgFRProfileBad];
    else
        modInt1.task = modInt1AL.task;
        modInt1.taskGood = modInt1AL.taskGood;
        modInt1.taskBad = modInt1AL.taskBad;
        modInt1.indRec = modInt1AL.indRec;
        modInt1.indRecGood = modInt1AL.indRecGood;
        modInt1.indRecBad = modInt1AL.indRecBad;
        modInt1.indNeu = modInt1AL.indNeu;
        modInt1.indNeuGood = modInt1AL.indNeuGood;
        modInt1.indNeuBad = modInt1AL.indNeuBad;
        if(methodKMean == 1)
            modInt1.idxC = modInt1AL.idxC1;
            modInt1.idxCGood = modInt1AL.idxC1Good;
            modInt1.idxCBad = modInt1AL.idxC1Bad;
        elseif(methodKMean == 2)
            modInt1.idxC = modInt1AL.idxC2;
            modInt1.idxCGood = modInt1AL.idxC2Good;
            modInt1.idxCBad = modInt1AL.idxC2Bad;
        elseif(methodKMean == 3)
            modInt1.idxC = modInt1AL.idxC3;
            modInt1.idxCGood = modInt1AL.idxC3Good;
            modInt1.idxCBad = modInt1AL.idxC3Bad;
        end
        modInt1.nNeuWithField = modInt1AL.nNeuWithField;
        modInt1.nNeuWithFieldAligned = modInt1AL.nNeuWithFieldAligned;
        modInt1.nNeuWithFieldGood = modInt1AL.nNeuWithFieldGood;
        modInt1.nNeuWithFieldAlignedGood = modInt1AL.nNeuWithFieldAlignedGood;
        modInt1.avgFRProfile = modInt1AL.avgFRProfile;
        modInt1.avgFRProfileGood = modInt1AL.avgFRProfileGood;
        modInt1.avgFRProfileBad = modInt1AL.avgFRProfileBad;
    end
    modInt1.avgFRProfileNorm = zeros(size(modInt1.avgFRProfile,1),size(modInt1.avgFRProfile,2));
    modInt1.avgFRProfileNormGood = zeros(size(modInt1.avgFRProfileGood,1),size(modInt1.avgFRProfileGood,2));
    modInt1.avgFRProfileNormBad = zeros(size(modInt1.avgFRProfileBad,1),size(modInt1.avgFRProfileBad,2));
    for i = 1:size(modInt1.avgFRProfile,1)
        if(max(modInt1.avgFRProfile(i,:)) ~= 0)
            modInt1.avgFRProfileNorm(i,:) = modInt1.avgFRProfile(i,:)/max(modInt1.avgFRProfile(i,:));
        end
    end
    for i = 1:size(modInt1.avgFRProfileGood,1)
        if(max(modInt1.avgFRProfileGood(i,:)) ~= 0)
            modInt1.avgFRProfileNormGood(i,:) = modInt1.avgFRProfileGood(i,:)/max(modInt1.avgFRProfileGood(i,:));
        end
    end
    for i = 1:size(modInt1.avgFRProfileBad,1)
        if(max(modInt1.avgFRProfileBad(i,:)) ~= 0)
            modInt1.avgFRProfileNormBad(i,:) = modInt1.avgFRProfileBad(i,:)/max(modInt1.avgFRProfileBad(i,:));
        end
    end