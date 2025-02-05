function mod = PyrModAllRecByTypeAlignedGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,modPyrNoCue,modPyrAL,modPyrPL,autoCorrPyrAll,taskSel,methodKMean)
% accumulate the data from different types of recordings
% this function is called by PyrModAllRec_GoodTr.m

    if(taskSel == 1)
        mod.peakTo40ms = [autoCorrPyrNoCue.peakTo40ms autoCorrPyrAL.peakTo40ms autoCorrPyrPL.peakTo40ms];
        mod.peakTime = [autoCorrPyrNoCue.peakTime autoCorrPyrAL.peakTime autoCorrPyrPL.peakTime];
        mod.relDepthNeuHDef = [autoCorrPyrNoCue.relDepthNeuHDef autoCorrPyrAL.relDepthNeuHDef autoCorrPyrPL.relDepthNeuHDef];
        
        mod.task = [autoCorrPyrNoCue.task autoCorrPyrAL.task autoCorrPyrPL.task];
        mod.indRec = [autoCorrPyrNoCue.indRec autoCorrPyrAL.indRec autoCorrPyrPL.indRec];
        mod.indNeu = [autoCorrPyrNoCue.indNeu autoCorrPyrAL.indNeu autoCorrPyrPL.indNeu];
        mod.nNeuWithField = [modPyrNoCue.nNeuWithField modPyrAL.nNeuWithField modPyrPL.nNeuWithField];
        mod.isNeuWithField = [modPyrNoCue.isNeuWithField modPyrAL.isNeuWithField modPyrPL.isNeuWithField];
        mod.fieldWidth = [modPyrNoCue.fieldWidth modPyrAL.fieldWidth modPyrPL.fieldWidth];
        mod.indStartField = [modPyrNoCue.indStartField modPyrAL.indStartField modPyrPL.indStartField];
        mod.indPeakField = [modPyrNoCue.indPeakField modPyrAL.indPeakField modPyrPL.indPeakField];
        mod.percTrackStartField = [modPyrNoCue.indStartField./modPyrNoCue.trackLen...
            modPyrAL.indStartField./modPyrAL.trackLen modPyrPL.indStartField./modPyrPL.trackLen];
        mod.percTrackPeakField = [modPyrNoCue.indPeakField./modPyrNoCue.trackLen...
            modPyrAL.indPeakField./modPyrAL.trackLen modPyrPL.indPeakField./modPyrPL.trackLen];
        mod.percTrackEndField = [(modPyrNoCue.indStartField+modPyrNoCue.fieldWidth)./modPyrNoCue.trackLen...
            (modPyrAL.indStartField+modPyrAL.fieldWidth)./modPyrAL.trackLen ...
            (modPyrPL.indStartField+modPyrPL.fieldWidth)./modPyrPL.trackLen];
        
        mod.nNeuWithFieldCue = [modPyrNoCue.nNeuWithFieldCue modPyrAL.nNeuWithFieldCue modPyrPL.nNeuWithFieldCue];
        mod.isNeuWithFieldCue = [modPyrNoCue.isNeuWithFieldCue modPyrAL.isNeuWithFieldCue modPyrPL.isNeuWithFieldCue];
        mod.fieldWidthCue = [modPyrNoCue.fieldWidthCue modPyrAL.fieldWidthCue modPyrPL.fieldWidthCue];
        mod.indStartFieldCue = [modPyrNoCue.indStartFieldCue modPyrAL.indStartFieldCue modPyrPL.indStartFieldCue];
        mod.indPeakFieldCue = [modPyrNoCue.indPeakFieldCue modPyrAL.indPeakFieldCue modPyrPL.indPeakFieldCue];
        
        mod.mFR = [modPyrNoCue.mFR modPyrAL.mFR modPyrPL.mFR];
        mod.meanInstFR = [modPyrNoCue.meanInstFR modPyrAL.meanInstFR modPyrPL.meanInstFR];
        mod.meanInstFRCue = [modPyrNoCue.meanInstFRCue modPyrAL.meanInstFRCue modPyrPL.meanInstFRCue];

        mod.burstMeanResultantLen = [modPyrNoCue.burstMeanResultantLen modPyrAL.burstMeanResultantLen ...
                    modPyrPL.burstMeanResultantLen];
        mod.burstMeanDire = [modPyrNoCue.burstMeanDire modPyrAL.burstMeanDire modPyrPL.burstMeanDire];
        mod.nonBurstMeanDire = [modPyrNoCue.nonBurstMeanDire modPyrAL.nonBurstMeanDire modPyrPL.nonBurstMeanDire];
        mod.burstMeanDireStart = [modPyrNoCue.burstMeanDireStart modPyrAL.burstMeanDireStart modPyrPL.burstMeanDireStart];
        mod.numSpPerBurstMean = [modPyrNoCue.numSpPerBurstMean modPyrAL.numSpPerBurstMean modPyrPL.numSpPerBurstMean];
        mod.fractBurst = [modPyrNoCue.fractBurst modPyrAL.fractBurst modPyrPL.fractBurst];

        mod.thetaModHist = [modPyrNoCue.thetaModHist modPyrAL.thetaModHist modPyrPL.thetaModHist];
        mod.thetaModHistH = [modPyrNoCue.thetaModHistH modPyrAL.thetaModHistH modPyrPL.thetaModHistH];
        mod.phaseMeanDire = [modPyrNoCue.phaseMeanDire modPyrAL.phaseMeanDire modPyrPL.phaseMeanDire];
        mod.phaseMeanDireH = [modPyrNoCue.phaseMeanDireH modPyrAL.phaseMeanDireH modPyrPL.phaseMeanDireH];
        mod.maxPhaseArr = [modPyrNoCue.maxPhaseFil modPyrAL.maxPhaseFil modPyrPL.maxPhaseFil];
        mod.maxPhaseArrH = [modPyrNoCue.maxPhaseFilH modPyrAL.maxPhaseFilH modPyrPL.maxPhaseFilH];
        mod.minPhaseArr = [modPyrNoCue.minPhaseFil modPyrAL.minPhaseFil modPyrPL.minPhaseFil];
        mod.minPhaseArrH = [modPyrNoCue.minPhaseFilH modPyrAL.minPhaseFilH modPyrPL.minPhaseFilH];
        mod.phaseMeanResultantLen = [modPyrNoCue.phaseMeanResultantLen modPyrAL.phaseMeanResultantLen modPyrPL.phaseMeanResultantLen];

        phaseDiff = mod.maxPhaseArr - mod.minPhaseArr;
        phaseDiff(phaseDiff < 0) = phaseDiff(phaseDiff < 0) + 360;
        mod.phaseDiff = phaseDiff;
        phaseDiffH = mod.maxPhaseArrH - mod.minPhaseArrH;
        phaseDiffH(phaseDiffH < 0) = phaseDiffH(phaseDiffH < 0) + 360;
        mod.phaseDiffH = phaseDiffH;

        mod.diffNeuronLFPFreq = [modPyrNoCue.thetaModFreq3-modPyrNoCue.thetaFreqHMean...
                modPyrAL.thetaModFreq3-modPyrAL.thetaFreqHMean...
                modPyrPL.thetaModFreq3-modPyrPL.thetaFreqHMean];
        mod.thetaModFreq3 = [modPyrNoCue.thetaModFreq3 modPyrAL.thetaModFreq3 modPyrPL.thetaModFreq3];
        mod.thetaModInd3 = [modPyrNoCue.thetaModInd3 modPyrAL.thetaModInd3 modPyrPL.thetaModInd3];
        mod.thetaModInd = [modPyrNoCue.thetaModInd modPyrAL.thetaModInd modPyrPL.thetaModInd];   
        mod.thetaAsym3 = [modPyrNoCue.thetaAsym3 modPyrAL.thetaAsym3 modPyrPL.thetaAsym3];
        
        mod.meanCorrTRun = [modPyrNoCue.meanCorrTRun modPyrAL.meanCorrTRun modPyrPL.meanCorrTRun];
        mod.meanCorrTRunNZ = [modPyrNoCue.meanCorrTRunNZ modPyrAL.meanCorrTRunNZ modPyrPL.meanCorrTRunNZ];
        mod.meanCorrTRew = [modPyrNoCue.meanCorrTRew modPyrAL.meanCorrTRew modPyrPL.meanCorrTRew];
        mod.meanCorrTRewNZ = [modPyrNoCue.meanCorrTRewNZ modPyrAL.meanCorrTRewNZ modPyrPL.meanCorrTRewNZ];
        mod.meanCorrTCue = [modPyrNoCue.meanCorrTCue modPyrAL.meanCorrTCue modPyrPL.meanCorrTCue];
        mod.meanCorrTCueNZ = [modPyrNoCue.meanCorrTCueNZ modPyrAL.meanCorrTCueNZ modPyrPL.meanCorrTCueNZ];
        
        mod.adaptSpatialInfo = [modPyrNoCue.adaptSpatialInfo modPyrAL.adaptSpatialInfo modPyrPL.adaptSpatialInfo];
        mod.spatialInfo = [modPyrNoCue.spatialInfo modPyrAL.spatialInfo modPyrPL.spatialInfo];
        mod.sparsity = [modPyrNoCue.sparsity modPyrAL.sparsity modPyrPL.sparsity];

        if(methodKMean == 1)
            mod.idxC = [autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrNoCue.task(1))' ...
                autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrAL.task(1))' ...
                autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrPL.task(1))'];
        elseif(methodKMean == 2)
            mod.idxC = [autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrNoCue.task(1))' ...
                autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrAL.task(1))' ...
                autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrPL.task(1))'];
        elseif(methodKMean == 3)
            mod.idxC = [autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrNoCue.task(1)) ...
                autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrAL.task(1)) ...
                autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrPL.task(1))];
        end
        for i = 1:max(mod.idxC)
            idxCurC = mod.idxC == i;
            mod.relDepthNeuHDefC{i} = mod.relDepthNeuHDef(idxCurC);
            mod.relDepthNeuHDefMean(i) = mean(mod.relDepthNeuHDefC{i});
        end
        mod.pRSRelDepthNeuHDefC = ranksum(mod.relDepthNeuHDefC{1},...
            mod.relDepthNeuHDefC{2});
    elseif(taskSel == 2)
        mod.peakTo40ms = [autoCorrPyrAL.peakTo40ms autoCorrPyrPL.peakTo40ms];
        mod.peakTime = [autoCorrPyrAL.peakTime autoCorrPyrPL.peakTime];
        mod.relDepthNeuHDef = [autoCorrPyrAL.relDepthNeuHDef autoCorrPyrPL.relDepthNeuHDef];
        
        mod.task = [autoCorrPyrAL.task autoCorrPyrPL.task];
        mod.indRec = [autoCorrPyrAL.indRec autoCorrPyrPL.indRec];
        mod.indNeu = [autoCorrPyrAL.indNeu autoCorrPyrPL.indNeu];
        mod.nNeuWithField = [modPyrAL.nNeuWithField modPyrPL.nNeuWithField];
        mod.isNeuWithField = [modPyrAL.isNeuWithField modPyrPL.isNeuWithField];
        mod.fieldWidth = [modPyrAL.fieldWidth modPyrPL.fieldWidth];
        mod.indStartField = [modPyrAL.indStartField modPyrPL.indStartField];
        mod.indPeakField = [modPyrAL.indPeakField modPyrPL.indPeakField];
        mod.percTrackStartField = [modPyrAL.indStartField./modPyrAL.trackLen modPyrPL.indStartField./modPyrPL.trackLen];
        mod.percTrackPeakField = [modPyrAL.indPeakField./modPyrAL.trackLen modPyrPL.indPeakField./modPyrPL.trackLen];
        mod.percTrackEndField = [(modPyrAL.indStartField+modPyrAL.fieldWidth)./modPyrAL.trackLen ...
            (modPyrPL.indStartField+modPyrPL.fieldWidth)./modPyrPL.trackLen];
        
        mod.nNeuWithFieldCue = [modPyrAL.nNeuWithFieldCue modPyrPL.nNeuWithFieldCue];
        mod.isNeuWithFieldCue = [modPyrAL.isNeuWithFieldCue modPyrPL.isNeuWithFieldCue];
        mod.fieldWidthCue = [modPyrAL.fieldWidthCue modPyrPL.fieldWidthCue];
        mod.indStartFieldCue = [modPyrAL.indStartFieldCue modPyrPL.indStartFieldCue];
        mod.indPeakFieldCue = [modPyrAL.indPeakFieldCue modPyrPL.indPeakFieldCue];
        
        mod.mFR = [modPyrAL.mFR modPyrPL.mFR];
        mod.meanInstFR = [modPyrAL.meanInstFR modPyrPL.meanInstFR];
        mod.meanInstFRCue = [modPyrAL.meanInstFRCue modPyrPL.meanInstFRCue];
        
        mod.burstMeanResultantLen = [modPyrAL.burstMeanResultantLen ...
                    modPyrPL.burstMeanResultantLen];
        mod.burstMeanDire = [modPyrAL.burstMeanDire modPyrPL.burstMeanDire];
        mod.nonBurstMeanDire = [modPyrAL.nonBurstMeanDire modPyrPL.nonBurstMeanDire];
        mod.burstMeanDireStart = [modPyrAL.burstMeanDireStart modPyrPL.burstMeanDireStart];
        mod.numSpPerBurstMean = [modPyrAL.numSpPerBurstMean modPyrPL.numSpPerBurstMean];
        mod.fractBurst = [modPyrAL.fractBurst modPyrPL.fractBurst];

        mod.thetaModHist = [modPyrAL.thetaModHist modPyrPL.thetaModHist];
        mod.thetaModHistH = [modPyrAL.thetaModHistH modPyrPL.thetaModHistH];
        mod.phaseMeanDire = [modPyrAL.phaseMeanDire modPyrPL.phaseMeanDire];
        mod.phaseMeanDireH = [modPyrAL.phaseMeanDireH modPyrPL.phaseMeanDireH];
        mod.maxPhaseArr = [modPyrAL.maxPhaseFil modPyrPL.maxPhaseFil];
        mod.maxPhaseArrH = [modPyrAL.maxPhaseFilH modPyrPL.maxPhaseFilH];
        mod.minPhaseArr = [modPyrAL.minPhaseFil modPyrPL.minPhaseFil];
        mod.minPhaseArrH = [modPyrAL.minPhaseFilH modPyrPL.minPhaseFilH];
        mod.phaseMeanResultantLen = [modPyrAL.phaseMeanResultantLen modPyrPL.phaseMeanResultantLen];

        phaseDiff = mod.maxPhaseArr - mod.minPhaseArr;
        phaseDiff(phaseDiff < 0) = phaseDiff(phaseDiff < 0) + 360;
        mod.phaseDiff = phaseDiff;
        phaseDiffH = mod.maxPhaseArrH - mod.minPhaseArrH;
        phaseDiffH(phaseDiffH < 0) = phaseDiffH(phaseDiffH < 0) + 360;
        mod.phaseDiffH = phaseDiffH;

        mod.diffNeuronLFPFreq = [...
                modPyrAL.thetaModFreq3-modPyrAL.thetaFreqHMean...
                modPyrPL.thetaModFreq3-modPyrPL.thetaFreqHMean];
        mod.thetaModFreq3 = [modPyrAL.thetaModFreq3 modPyrPL.thetaModFreq3];
        mod.thetaModInd3 = [modPyrAL.thetaModInd3 modPyrPL.thetaModInd3];
        mod.thetaModInd = [modPyrAL.thetaModInd modPyrPL.thetaModInd];   
        mod.thetaAsym3 = [modPyrAL.thetaAsym3 modPyrPL.thetaAsym3];
        
        mod.meanCorrTRun = [modPyrAL.meanCorrTRun modPyrPL.meanCorrTRun];
        mod.meanCorrTRunNZ = [modPyrAL.meanCorrTRunNZ modPyrPL.meanCorrTRunNZ];
        mod.meanCorrTRew = [modPyrAL.meanCorrTRew modPyrPL.meanCorrTRew];
        mod.meanCorrTRewNZ = [modPyrAL.meanCorrTRewNZ modPyrPL.meanCorrTRewNZ];
        mod.meanCorrTCue = [modPyrAL.meanCorrTCue modPyrPL.meanCorrTCue];
        mod.meanCorrTCueNZ = [modPyrAL.meanCorrTCueNZ modPyrPL.meanCorrTCueNZ];
        
        mod.adaptSpatialInfo = [modPyrAL.adaptSpatialInfo modPyrPL.adaptSpatialInfo];
        mod.spatialInfo = [modPyrAL.spatialInfo modPyrPL.spatialInfo];
        mod.sparsity = [modPyrAL.sparsity modPyrPL.sparsity];

        if(methodKMean == 1)
            mod.idxC = [...
                autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrAL.task(1))' ...
                autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrPL.task(1))'];
        elseif(methodKMean == 2)
            mod.idxC = [...
                autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrAL.task(1))' ...
                autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrPL.task(1))'];
        elseif(methodKMean == 3)
            mod.idxC = [...
                autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrAL.task(1)) ...
                autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrPL.task(1))];
        end
        for i = 1:max(mod.idxC)
            idxCurC = mod.idxC == i;
            mod.relDepthNeuHDefC{i} = mod.relDepthNeuHDef(idxCurC);
            mod.relDepthNeuHDefMean(i) = mean(mod.relDepthNeuHDefC{i});
        end
        mod.pRSRelDepthNeuHDefC = ranksum(mod.relDepthNeuHDefC{1},...
            mod.relDepthNeuHDefC{2});
    else
        mod.peakTo40ms = autoCorrPyrAL.peakTo40ms;
        mod.peakTime = autoCorrPyrAL.peakTime;
        mod.relDepthNeuHDef = autoCorrPyrAL.relDepthNeuHDef;
        
        mod.task = autoCorrPyrAL.task;
        mod.indRec = autoCorrPyrAL.indRec;
        mod.indNeu = autoCorrPyrAL.indNeu;
        mod.nNeuWithField = modPyrAL.nNeuWithField;
        mod.isNeuWithField = modPyrAL.isNeuWithField;
        mod.fieldWidth = modPyrAL.fieldWidth;
        mod.indStartField = modPyrAL.indStartField;
        mod.indPeakField = modPyrAL.indPeakField;
        mod.percTrackStartField = modPyrAL.indStartField./modPyrAL.trackLen;
        mod.percTrackPeakField = modPyrAL.indPeakField./modPyrAL.trackLen;
        mod.percTrackEndField = (modPyrAL.indStartField+modPyrAL.fieldWidth)./modPyrAL.trackLen;
        
        mod.nNeuWithFieldCue = modPyrAL.nNeuWithFieldCue;
        mod.isNeuWithFieldCue = modPyrAL.isNeuWithFieldCue;
        mod.fieldWidthCue = modPyrAL.fieldWidthCue;
        mod.indStartFieldCue = modPyrAL.indStartFieldCue;
        mod.indPeakFieldCue = modPyrAL.indPeakFieldCue;
        
        mod.mFR = modPyrAL.mFR;
        mod.meanInstFR = modPyrAL.meanInstFR;
        mod.meanInstFRCue = modPyrAL.meanInstFRCue;
        
        mod.burstMeanResultantLen = modPyrAL.burstMeanResultantLen;
        mod.burstMeanDire = modPyrAL.burstMeanDire;
        mod.nonBurstMeanDire = modPyrAL.nonBurstMeanDire;
        mod.burstMeanDireStart = modPyrAL.burstMeanDireStart;
        mod.numSpPerBurstMean = modPyrAL.numSpPerBurstMean;
        mod.fractBurst = modPyrAL.fractBurst;

        mod.thetaModHist = modPyrAL.thetaModHist;
        mod.thetaModHistH = modPyrAL.thetaModHistH;
        mod.phaseMeanDire = modPyrAL.phaseMeanDire;
        mod.phaseMeanDireH = modPyrAL.phaseMeanDireH;
        mod.maxPhaseArr = modPyrAL.maxPhaseFil;
        mod.maxPhaseArrH = modPyrAL.maxPhaseFilH;
        mod.minPhaseArr = modPyrAL.minPhaseFil;
        mod.minPhaseArrH = modPyrAL.minPhaseFilH;
        mod.phaseMeanResultantLen = modPyrAL.phaseMeanResultantLen;

        phaseDiff = mod.maxPhaseArr - mod.minPhaseArr;
        phaseDiff(phaseDiff < 0) = phaseDiff(phaseDiff < 0) + 360;
        mod.phaseDiff = phaseDiff;
        phaseDiffH = mod.maxPhaseArrH - mod.minPhaseArrH;
        phaseDiffH(phaseDiffH < 0) = phaseDiffH(phaseDiffH < 0) + 360;
        mod.phaseDiffH = phaseDiffH;

        mod.diffNeuronLFPFreq = modPyrAL.thetaModFreq3-modPyrAL.thetaFreqHMean;
        mod.thetaModFreq3 = modPyrAL.thetaModFreq3;
        mod.thetaModInd3 = modPyrAL.thetaModInd3;
        mod.thetaModInd = modPyrAL.thetaModInd;   
        mod.thetaAsym3 = modPyrAL.thetaAsym3;
        
        mod.meanCorrTRun = modPyrAL.meanCorrTRun;
        mod.meanCorrTRunNZ = modPyrAL.meanCorrTRunNZ;
        mod.meanCorrTRew = modPyrAL.meanCorrTRew;
        mod.meanCorrTRewNZ = modPyrAL.meanCorrTRewNZ;
        mod.meanCorrTCue = modPyrAL.meanCorrTCue;
        mod.meanCorrTCueNZ = modPyrAL.meanCorrTCueNZ;
        
        mod.adaptSpatialInfo = modPyrAL.adaptSpatialInfo;
        mod.spatialInfo = modPyrAL.spatialInfo;
        mod.sparsity = modPyrAL.sparsity;
        
        if(methodKMean == 1)
            mod.idxC = autoCorrPyrAll.idxC1(autoCorrPyrAll.task == autoCorrPyrAL.task(1))';
        elseif(methodKMean == 2)
            mod.idxC = autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrAL.task(1))';
        elseif(methodKMean == 3)
            mod.idxC = autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrAL.task(1));
        end
        for i = 1:max(mod.idxC)
            idxCurC = mod.idxC == i;
            mod.relDepthNeuHDefC{i} = mod.relDepthNeuHDef(idxCurC);
            mod.relDepthNeuHDefMean(i) = mean(mod.relDepthNeuHDefC{i});
        end
        mod.pRSRelDepthNeuHDefC = ranksum(mod.relDepthNeuHDefC{1},...
            mod.relDepthNeuHDefC{2});
    end
    
    x = mod.burstMeanDire - mod.phaseMeanDire;    
    x(x < -pi) = x(x < -pi) + 2*pi;
    x(x > pi) = x(x > pi) - 2*pi;
    x((mod.fractBurst == 0)) = -100;
    mod.burstThetaDiff = x;
end

