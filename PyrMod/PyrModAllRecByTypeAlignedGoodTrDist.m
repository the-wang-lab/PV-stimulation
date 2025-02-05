function mod = PyrModAllRecByTypeAlignedGoodTrDist(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,modPyrNoCue,modPyrAL,modPyrPL,taskSel)
% accumulate the data from different types of recordings
% this function is called by PyrModAllRec_GoodTr.m

    if(taskSel == 1)
        mod.task = [autoCorrPyrNoCue.task autoCorrPyrAL.task autoCorrPyrPL.task];
        mod.indRec = [autoCorrPyrNoCue.indRec autoCorrPyrAL.indRec autoCorrPyrPL.indRec];
        mod.indNeu = [autoCorrPyrNoCue.indNeu autoCorrPyrAL.indNeu autoCorrPyrPL.indNeu];
        
        mod.meanCorrDistRun = [modPyrNoCue.meanCorrDistRun modPyrAL.meanCorrDistRun modPyrPL.meanCorrDistRun];
        mod.meanCorrDistRunNZ = [modPyrNoCue.meanCorrDistRunNZ modPyrAL.meanCorrDistRunNZ modPyrPL.meanCorrDistRunNZ];
        mod.meanCorrDistRew = [modPyrNoCue.meanCorrDistRew modPyrAL.meanCorrDistRew modPyrPL.meanCorrDistRew];
        mod.meanCorrDistRewNZ = [modPyrNoCue.meanCorrDistRewNZ modPyrAL.meanCorrDistRewNZ modPyrPL.meanCorrDistRewNZ];
        mod.meanCorrDistCue = [modPyrNoCue.meanCorrDistCue modPyrAL.meanCorrDistCue modPyrPL.meanCorrDistCue];
        mod.meanCorrDistCueNZ = [modPyrNoCue.meanCorrDistCueNZ modPyrAL.meanCorrDistCueNZ modPyrPL.meanCorrDistCueNZ];
        
    elseif(taskSel == 2)
        mod.task = [autoCorrPyrAL.task autoCorrPyrPL.task];
        mod.indRec = [autoCorrPyrAL.indRec autoCorrPyrPL.indRec];
        mod.indNeu = [autoCorrPyrAL.indNeu autoCorrPyrPL.indNeu];
        
        mod.meanCorrDistRun = [modPyrAL.meanCorrDistRun modPyrPL.meanCorrDistRun];
        mod.meanCorrDistRunNZ = [modPyrAL.meanCorrDistRunNZ modPyrPL.meanCorrDistRunNZ];
        mod.meanCorrDistRew = [modPyrAL.meanCorrDistRew modPyrPL.meanCorrDistRew];
        mod.meanCorrDistRewNZ = [modPyrAL.meanCorrDistRewNZ modPyrPL.meanCorrDistRewNZ];
        mod.meanCorrDistCue = [modPyrAL.meanCorrDistCue modPyrPL.meanCorrDistCue];
        mod.meanCorrDistCueNZ = [modPyrAL.meanCorrDistCueNZ modPyrPL.meanCorrDistCueNZ];
        
    else
        mod.task = autoCorrPyrAL.task;
        mod.indRec = autoCorrPyrAL.indRec;
        mod.indNeu = autoCorrPyrAL.indNeu;
        
        mod.meanCorrDistRun = modPyrAL.meanCorrDistRun;
        mod.meanCorrDistRunNZ = modPyrAL.meanCorrDistRunNZ;
        mod.meanCorrDistRew = modPyrAL.meanCorrDistRew;
        mod.meanCorrDistRewNZ = modPyrAL.meanCorrDistRewNZ;
        mod.meanCorrDistCue = modPyrAL.meanCorrDistCue;
        mod.meanCorrDistCueNZ = modPyrAL.meanCorrDistCueNZ;
        
    end
end

