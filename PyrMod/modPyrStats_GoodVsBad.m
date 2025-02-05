function modPyrStatsGoodVsBad = modPyrStats_GoodVsBad(modGood,modBad)
% Compare the statistical difference between good vs bad trials
% This function is called by PyrModAllRec_GoodTr.m

    modPyrStatsGoodVsBad = [];
    indNeuGood = ~isnan(modGood.phaseMeanDire);
    indNeuBad = ~isnan(modBad.phaseMeanDire);
    
    modPyrStatsGoodVsBad.isNeuWithField = [sum(modGood.isNeuWithField(indNeuGood)),sum(modBad.isNeuWithField(indNeuBad))];

    modPyrStatsGoodVsBad.mFR = [mean(modGood.mFR(indNeuGood)),mean(modBad.mFR(indNeuBad))];
    modPyrStatsGoodVsBad.meanInstFR = [mean(modGood.meanInstFR(indNeuGood)),mean(modBad.meanInstFR(indNeuBad))];

    modPyrStatsGoodVsBad.meanDiffNeuronLFPFreq = [mean(modGood.diffNeuronLFPFreq(indNeuGood)),mean(modBad.diffNeuronLFPFreq(indNeuBad))];

    indGoodBurst = modGood.fractBurst > 0;
    indBadBurst = modBad.fractBurst > 0;
    modPyrStatsGoodVsBad.meanBurstMeanDire = [circ_mean(modGood.burstMeanDire(indGoodBurst)'),circ_mean(modBad.burstMeanDire(indBadBurst)')];
    modPyrStatsGoodVsBad.meanNonBurstMeanDire = [circ_mean(modGood.nonBurstMeanDire(indNeuGood)'),circ_mean(modBad.nonBurstMeanDire(indNeuBad)')];     
    modPyrStatsGoodVsBad.meanBurstMeanDireStart = [circ_mean(modGood.burstMeanDireStart(indGoodBurst)'),circ_mean(modBad.burstMeanDireStart(indBadBurst)')];
    modPyrStatsGoodVsBad.meanFractBurst = [mean(modGood.fractBurst(indNeuGood)),mean(modBad.fractBurst(indNeuBad))];
    modPyrStatsGoodVsBad.meanNumSpPerBurstMean = [mean(modGood.numSpPerBurstMean(indGoodBurst)),...
        mean(modBad.numSpPerBurstMean(indBadBurst))];

    modPyrStatsGoodVsBad.meanPhaseMeanDire = [circ_mean(modGood.phaseMeanDire(indNeuGood)'),circ_mean(modBad.phaseMeanDire(indNeuBad)')];
    modPyrStatsGoodVsBad.meanPhaseMeanDireH = [circ_mean(modGood.phaseMeanDireH(indNeuGood)'),circ_mean(modBad.phaseMeanDireH(indNeuBad)')];
    modPyrStatsGoodVsBad.meanMaxPhase = [circ_mean(modGood.maxPhaseArr(indNeuGood)'/180*pi),circ_mean(modBad.maxPhaseArr(indNeuBad)'/180*pi)];
    modPyrStatsGoodVsBad.meanMaxPhaseH = [circ_mean(modGood.maxPhaseArrH(indNeuGood)'/180*pi),circ_mean(modBad.maxPhaseArrH(indNeuBad)'/180*pi)];
    modPyrStatsGoodVsBad.meanminPhase = [circ_mean(modGood.minPhaseArr(indNeuGood)'/180*pi),circ_mean(modBad.minPhaseArr(indNeuBad)'/180*pi)];
    modPyrStatsGoodVsBad.meanminPhaseH = [circ_mean(modGood.minPhaseArrH(indNeuGood)'/180*pi),circ_mean(modBad.minPhaseArrH(indNeuBad)'/180*pi)];
    modPyrStatsGoodVsBad.meanPhaseDiff = [mean(modGood.phaseDiff(indNeuGood)),mean(modBad.phaseDiff(indNeuBad))];
    modPyrStatsGoodVsBad.meanPhaseDiffH = [mean(modGood.phaseDiffH(indNeuGood)),mean(modBad.phaseDiffH(indNeuBad))];
    modPyrStatsGoodVsBad.meanThetaModHist = [mean(modGood.thetaModHist(indNeuGood)),mean(modBad.thetaModHist(indNeuBad))];
    modPyrStatsGoodVsBad.meanThetaModHistH = [mean(modGood.thetaModHistH(indNeuGood)),mean(modBad.thetaModHistH(indNeuBad))];

    modPyrStatsGoodVsBad.meanThetaModFreq3 = [mean(modGood.thetaModFreq3(indNeuGood)),mean(modBad.thetaModFreq3(indNeuBad))];
    modPyrStatsGoodVsBad.meanThetaAsym3 = [mean(modGood.thetaAsym3(indNeuGood)),mean(modBad.thetaAsym3(indNeuBad))];
    modPyrStatsGoodVsBad.meanThetaModInd3 = [mean(modGood.thetaModInd3(~isnan(modGood.thetaModInd3))),mean(modBad.thetaModInd3(~isnan(modBad.thetaModInd3)))];
    modPyrStatsGoodVsBad.meanThetaModInd = [mean(modGood.thetaModInd(~isnan(modGood.thetaModInd))),mean(modBad.thetaModInd(~isnan(modBad.thetaModInd)))];
    
    modPyrStatsGoodVsBad.meanCorrDist = [mean(modGood.meanCorrDist(indNeuGood)), mean(modBad.meanCorrDist(indNeuBad))];
    indGoodNZ = ~isnan(modGood.meanCorrDistNZ);
    indBadNZ = ~isnan(modBad.meanCorrDistNZ);
    modPyrStatsGoodVsBad.meanCorrDistNZ = [mean(modGood.meanCorrDistNZ(indGoodNZ)) mean(modBad.meanCorrDistNZ(indBadNZ))];
    modPyrStatsGoodVsBad.adaptSpatialInfo = [mean(modGood.adaptSpatialInfo(indGoodNZ)) mean(modBad.adaptSpatialInfo(indBadNZ))];
    modPyrStatsGoodVsBad.spatialInfo = [mean(modGood.spatialInfo(indGoodNZ)) mean(modBad.spatialInfo(indBadNZ))]; % added on 7/22/2022
    modPyrStatsGoodVsBad.sparsity = [mean(modGood.sparsity(indGoodNZ)) mean(modBad.sparsity(indBadNZ))];

    modPyrStatsGoodVsBad.pRSDiffNeuronLFPFreq = ranksum(modGood.diffNeuronLFPFreq(indNeuGood),modBad.diffNeuronLFPFreq(indNeuBad));

    modPyrStatsGoodVsBad.pRSMFR = ranksum(modGood.mFR(indNeuGood),modBad.mFR(indNeuBad));
    modPyrStatsGoodVsBad.pRSMeanInstFR = ranksum(modGood.meanInstFR(indNeuGood),modBad.meanInstFR(indNeuBad));

    modPyrStatsGoodVsBad.pKBurstMeanDire = circ_ktest(modGood.burstMeanDire(indGoodBurst)',modBad.burstMeanDire(indBadBurst)');
    modPyrStatsGoodVsBad.pKNonBurstMeanDire = circ_ktest(modGood.nonBurstMeanDire(indNeuGood)',modBad.nonBurstMeanDire(indNeuBad)');
    modPyrStatsGoodVsBad.pKBurstMeanDireStart = circ_ktest(modGood.burstMeanDireStart(indGoodBurst)',modBad.burstMeanDireStart(indBadBurst)');

    modPyrStatsGoodVsBad.pWWBurstMeanDire = circ_wwtest(modGood.burstMeanDire(indGoodBurst)',modBad.burstMeanDire(indBadBurst)');
    modPyrStatsGoodVsBad.pWWNonBurstMeanDire = circ_wwtest(modGood.nonBurstMeanDire(indNeuGood)',modBad.nonBurstMeanDire(indNeuBad)');
    modPyrStatsGoodVsBad.pWWBurstMeanDireStart = circ_wwtest(modGood.burstMeanDireStart(indGoodBurst)',modBad.burstMeanDireStart(indBadBurst)');

    modPyrStatsGoodVsBad.pRSBurstMeanResultantLen = ranksum(modGood.burstMeanResultantLen(indGoodBurst),modBad.burstMeanResultantLen(indBadBurst));
    modPyrStatsGoodVsBad.pRSPhaseMeanResultantLen = ranksum(modGood.phaseMeanResultantLen(indNeuGood),modBad.phaseMeanResultantLen(indNeuBad));
    
    modPyrStatsGoodVsBad.pRSFractBurst = ranksum(modGood.fractBurst(indNeuGood),modBad.fractBurst(indNeuBad));        
    modPyrStatsGoodVsBad.pRSNumSpPerBurstMean = ranksum(modGood.numSpPerBurstMean(indGoodBurst),...
            modBad.numSpPerBurstMean(indBadBurst));

    modPyrStatsGoodVsBad.pWWBurstThetaDiff = circ_wwtest(modGood.burstThetaDiff(indGoodBurst),...
            modBad.burstThetaDiff(indBadBurst));
    modPyrStatsGoodVsBad.pKBurstThetaDiff = circ_ktest(modGood.burstThetaDiff(indGoodBurst),...
            modBad.burstThetaDiff(indBadBurst));

    modPyrStatsGoodVsBad.pKPhaseMeanDire = circ_ktest(modGood.phaseMeanDire(indNeuGood)',modBad.phaseMeanDire(indNeuBad)');
    modPyrStatsGoodVsBad.pKPhaseMeanDireH = circ_ktest(modGood.phaseMeanDireH(indNeuGood)',modBad.phaseMeanDireH(indNeuBad)');
    modPyrStatsGoodVsBad.pKMaxPhase = circ_ktest(modGood.maxPhaseArr(indNeuGood)'/180*pi,modBad.maxPhaseArr(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pKMaxPhaseH = circ_ktest(modGood.maxPhaseArrH(indNeuGood)'/180*pi,modBad.maxPhaseArrH(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pKMinPhase = circ_ktest(modGood.minPhaseArr(indNeuGood)'/180*pi,modBad.minPhaseArr(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pKMinPhaseH = circ_ktest(modGood.minPhaseArrH(indNeuGood)'/180*pi,modBad.minPhaseArrH(indNeuBad)'/180*pi);

    modPyrStatsGoodVsBad.pWWPhaseMeanDire = circ_wwtest(modGood.phaseMeanDire(indNeuGood)',modBad.phaseMeanDire(indNeuBad)');
    modPyrStatsGoodVsBad.pWWPhaseMeanDireH = circ_wwtest(modGood.phaseMeanDireH(indNeuGood)',modBad.phaseMeanDireH(indNeuBad)');
    modPyrStatsGoodVsBad.pWWMaxPhase = circ_wwtest(modGood.maxPhaseArr(indNeuGood)'/180*pi,modBad.maxPhaseArr(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pWWMaxPhaseH = circ_wwtest(modGood.maxPhaseArrH(indNeuGood)'/180*pi,modBad.maxPhaseArrH(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pWWMinPhase = circ_wwtest(modGood.minPhaseArr(indNeuGood)'/180*pi,modBad.minPhaseArr(indNeuBad)'/180*pi);
    modPyrStatsGoodVsBad.pWWMinPhaseH = circ_wwtest(modGood.minPhaseArrH(indNeuGood)'/180*pi,modBad.minPhaseArrH(indNeuBad)'/180*pi);

    modPyrStatsGoodVsBad.pRSPhaseDiff = ranksum(modGood.phaseDiff(indNeuGood),modBad.phaseDiff(indNeuBad));
    modPyrStatsGoodVsBad.pRSPhaseDiffH = ranksum(modGood.phaseDiffH(indNeuGood),modBad.phaseDiffH(indNeuBad));
    modPyrStatsGoodVsBad.pRSThetaModHist = ranksum(modGood.thetaModHist(indNeuGood),modBad.thetaModHist(indNeuBad));
    modPyrStatsGoodVsBad.pRSThetaModHistH = ranksum(modGood.thetaModHistH(indNeuGood),modBad.thetaModHistH(indNeuBad));

    modPyrStatsGoodVsBad.pRSThetaModFreq3 = ranksum(modGood.thetaModFreq3(indNeuGood),modBad.thetaModFreq3(indNeuBad));
    modPyrStatsGoodVsBad.pRSThetaAsym3 = ranksum(modGood.thetaAsym3(indNeuGood),modBad.thetaAsym3(indNeuBad));  
    modPyrStatsGoodVsBad.pRSThetaModInd3 = ranksum(modGood.thetaModInd3(indNeuGood),modBad.thetaModInd3(indNeuBad));
    modPyrStatsGoodVsBad.pRSThetaModInd = ranksum(modGood.thetaModInd(indNeuGood),modBad.thetaModInd(indNeuBad));
    
    modPyrStatsGoodVsBad.pRSMeanCorrDist = ranksum(modGood.meanCorrDist(indNeuGood), modBad.meanCorrDist(indNeuBad));
    modPyrStatsGoodVsBad.pRSMeanCorrDistNZ = ranksum(modGood.meanCorrDistNZ(indGoodNZ),modBad.meanCorrDistNZ(indBadNZ));
    modPyrStatsGoodVsBad.pRSAdaptSpatialInfo = ranksum(modGood.adaptSpatialInfo(indGoodNZ),modBad.adaptSpatialInfo(indBadNZ));
    modPyrStatsGoodVsBad.pRSSpatialInfo = ranksum(modGood.spatialInfo(indGoodNZ),modBad.spatialInfo(indBadNZ)); % added on 7/22/2022
    modPyrStatsGoodVsBad.pRSSparsity = ranksum(modGood.sparsity(indGoodNZ),modBad.sparsity(indBadNZ));
    
    modPyrStatsGoodVsBad.pRFieldWidthC = ranksum(modGood.fieldWidth(modGood.isNeuWithField == 1),...
        modBad.fieldWidth(modBad.isNeuWithField == 1));
    modPyrStatsGoodVsBad.pRIndStartFieldC = ranksum(modGood.indStartField(modGood.isNeuWithField == 1),...
        modBad.indStartField( modBad.isNeuWithField == 1));
    modPyrStatsGoodVsBad.pRIndPeakFieldC = ranksum(modGood.indPeakField(modGood.isNeuWithField == 1),...
        modBad.indPeakField( modBad.isNeuWithField == 1));
    
    modPyrStatsGoodVsBad.pRPercTrackStartFieldC = ranksum(modGood.percTrackStartField(modGood.isNeuWithField == 1),...
        modBad.percTrackStartField(modBad.isNeuWithField == 1));
    modPyrStatsGoodVsBad.pRPercTrackPeakFieldC = ranksum(modGood.percTrackPeakField(modGood.isNeuWithField == 1),...
        modBad.percTrackPeakField(modBad.isNeuWithField == 1));
    modPyrStatsGoodVsBad.pRPercTrackEndFieldC = ranksum(modGood.percTrackEndField(modGood.isNeuWithField == 1),...
        modBad.percTrackEndField(modBad.isNeuWithField == 1));

end
