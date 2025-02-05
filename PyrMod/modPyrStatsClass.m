function modPyrStatsField = modPyrStatsClass(mod)
% compare neurons between the two clusters
% this function is called by PyrModAllRec.m

    idxC = mod.idxC;
    modPyrStatsField.pRSDiffNeuronLFPFreq = ranksum(mod.diffNeuronLFPFreq(idxC == 1),mod.diffNeuronLFPFreq(idxC == 2));
    nonZeroF1 = mod.numSpPerBurstMean(idxC == 1);
    nonZeroF1 = nonZeroF1(nonZeroF1 > 0);
    nonZeroF2 = mod.numSpPerBurstMean(idxC == 2);
    nonZeroF2 = nonZeroF2(nonZeroF2 > 0);
    modPyrStatsField.pRSNumSpPerBurstMeanC = ranksum(nonZeroF1,nonZeroF2);
    modPyrStatsField.pRSFractBurstC = ranksum(mod.fractBurst(idxC == 1),mod.fractBurst(idxC == 2));    
    
    modPyrStatsField.pWWBurstThetaDiffC = circ_wwtest(mod.burstThetaDiff(idxC == 1 & mod.fractBurst > 0),...
        mod.burstThetaDiff(idxC == 2 & mod.fractBurst > 0));
    modPyrStatsField.pKBurstThetaDiffC = circ_ktest(mod.burstThetaDiff(idxC == 1 & mod.fractBurst > 0),...
        mod.burstThetaDiff(idxC == 2 & mod.fractBurst > 0));
    
    modPyrStatsField.pWWPhaseMeanDireC = circ_wwtest(mod.phaseMeanDire(idxC == 1)',mod.phaseMeanDire(idxC == 2)');
    modPyrStatsField.pKPhaseMeanDireC = circ_ktest(mod.phaseMeanDire(idxC == 1)',mod.phaseMeanDire(idxC == 2)');
    modPyrStatsField.pWWPhaseMeanDireHC = circ_wwtest(mod.phaseMeanDireH(idxC == 1)',mod.phaseMeanDireH(idxC == 2)');
    modPyrStatsField.pKPhaseMeanDireHC = circ_ktest(mod.phaseMeanDireH(idxC == 1)',mod.phaseMeanDireH(idxC == 2)');
    modPyrStatsField.pWWMaxPhaseC = circ_wwtest(mod.maxPhaseArr(idxC == 1)'/180*pi,mod.maxPhaseArr(idxC == 2)'/180*pi);
    modPyrStatsField.pKMaxPhaseC = circ_ktest(mod.maxPhaseArr(idxC == 1)'/180*pi,mod.maxPhaseArr(idxC == 2)'/180*pi);
    modPyrStatsField.pWWMinPhaseC = circ_wwtest(mod.minPhaseArr(idxC == 1)'/180*pi,mod.minPhaseArr(idxC == 2)'/180*pi);
    modPyrStatsField.pKMinPhaseC = circ_ktest(mod.minPhaseArr(idxC == 1)'/180*pi,mod.minPhaseArr(idxC == 2)'/180*pi);
    modPyrStatsField.pWWburstMeanDireC = circ_wwtest(mod.burstMeanDire(idxC == 1 & mod.fractBurst > 0)',...
        mod.burstMeanDire(idxC == 2 & mod.fractBurst > 0)');
    modPyrStatsField.pKburstMeanDireC = circ_ktest(mod.burstMeanDire(idxC == 1 & mod.fractBurst > 0)',...
        mod.burstMeanDire(idxC == 2 & mod.fractBurst > 0)');
    modPyrStatsField.pWWburstMeanDireStartC = circ_wwtest(mod.burstMeanDireStart(idxC == 1 & mod.fractBurst > 0)',...
        mod.burstMeanDireStart(idxC == 2 & mod.fractBurst > 0)');
    modPyrStatsField.pKburstMeanDirStartC = circ_ktest(mod.burstMeanDireStart(idxC == 1 & mod.fractBurst > 0)',...
        mod.burstMeanDireStart(idxC == 2 & mod.fractBurst > 0)');
    modPyrStatsField.pRSBurstMeanResultantLenC = ranksum(mod.burstMeanResultantLen(idxC == 1),mod.burstMeanResultantLen(idxC == 2));
    modPyrStatsField.pRSPhaseMeanResultantLenC = ranksum(mod.phaseMeanResultantLen(idxC == 1),mod.phaseMeanResultantLen(idxC == 2));
    
    modPyrStatsField.pRSThetaModHistC = ranksum(mod.thetaModHist(idxC == 1),mod.thetaModHist(idxC == 2));
    modPyrStatsField.pRSThetaModHistHC = ranksum(mod.thetaModHistH(idxC == 1),mod.thetaModHistH(idxC == 2));
    modPyrStatsField.pRSThetaModFreq3C = ranksum(mod.thetaModFreq3(idxC == 1),mod.thetaModFreq3(idxC == 2));
    modPyrStatsField.pRSThetaAsym3C = ranksum(mod.thetaAsym3(idxC == 1),mod.thetaAsym3(idxC == 2));
    
    modPyrStatsField.pRSMFRC = ranksum(mod.mFR(idxC == 1),mod.mFR(idxC == 2));
    modPyrStatsField.pRSMeanInstFR = ranksum(mod.meanInstFR(idxC == 1),mod.meanInstFR(idxC == 2));
    
    modPyrStatsField.pRFieldWidthC = ranksum(mod.fieldWidth(idxC == 1 & mod.isNeuWithField == 1),...
        mod.fieldWidth(idxC == 2 & mod.isNeuWithField == 1));
    modPyrStatsField.pRIndStartFieldC = ranksum(mod.indStartField(idxC == 1 & mod.isNeuWithField == 1),...
        mod.indStartField(idxC == 2 & mod.isNeuWithField == 1));
    modPyrStatsField.pRIndPeakFieldC = ranksum(mod.indPeakField(idxC == 1 & mod.isNeuWithField == 1),...
        mod.indPeakField(idxC == 2 & mod.isNeuWithField == 1));
    
    modPyrStatsField.pRPercTrackStartFieldC = ranksum(mod.percTrackStartField(idxC == 1 & mod.isNeuWithField == 1),...
        mod.percTrackStartField(idxC == 2 & mod.isNeuWithField == 1));
    modPyrStatsField.pRPercTrackPeakFieldC = ranksum(mod.percTrackPeakField(idxC == 1 & mod.isNeuWithField == 1),...
        mod.percTrackPeakField(idxC == 2 & mod.isNeuWithField == 1));
    modPyrStatsField.pRPercTrackEndFieldC = ranksum(mod.percTrackEndField(idxC == 1 & mod.isNeuWithField == 1),...
        mod.percTrackEndField(idxC == 2 & mod.isNeuWithField == 1));
end
