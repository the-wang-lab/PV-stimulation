function modIntStatsField = modIntStatsFieldRec(modInt,autoCorrIntAll)
%% calculate statistics for recordings with vs without fields
% this function is called by InterneuronModAllRec.m

    modIntStatsField = [];
    for i = 1:max(modInt.idxC)
        indCurCField = modInt.idxC == i & modInt.nNeuWithField >= 2;
        indCurCNoField = modInt.idxC == i & modInt.nNeuWithField < 1;
        modIntStatsField.meanPeakTo40ms(i,:) = [mean(autoCorrIntAll.peakTo40ms(indCurCField)),mean(autoCorrIntAll.peakTo40ms(indCurCNoField))];
        modIntStatsField.meanPeakTime(i,:) = [mean(autoCorrIntAll.peakTime(indCurCField)),mean(autoCorrIntAll.peakTime(indCurCNoField))];
        
        indCurCFieldBurst = modInt.idxC == i & modInt.nNeuWithField >= 2 & modInt.fractBurst > 0;
        indCurCNoFieldBurst = modInt.idxC == i & modInt.nNeuWithField < 1 & modInt.fractBurst > 0;
        modIntStatsField.meanBurstMeanDire(i,:) = [circ_mean(modInt.burstMeanDire(indCurCFieldBurst)'),circ_mean(modInt.burstMeanDire(indCurCNoFieldBurst)')];
        modIntStatsField.meanNonBurstMeanDire(i,:) = [circ_mean(modInt.nonBurstMeanDire(indCurCFieldBurst)'),circ_mean(modInt.nonBurstMeanDire(indCurCNoFieldBurst)')];        
        modIntStatsField.meanBurstMeanDireStart(i,:) = [circ_mean(modInt.burstMeanDireStart(indCurCFieldBurst)'),circ_mean(modInt.burstMeanDireStart(indCurCNoFieldBurst)')];
        modIntStatsField.meanFractBurst(i,:) = [mean(modInt.fractBurst(indCurCField)),mean(modInt.fractBurst(indCurCNoField))];
        nonZeroF = modInt.numSpPerBurstMean(indCurCField);
        nonZeroF = nonZeroF(nonZeroF > 0);
        nonZeroNoF = modInt.numSpPerBurstMean(indCurCNoField);
        nonZeroNoF = nonZeroNoF(nonZeroNoF > 0);
        modIntStatsField.meanNumSpPerBurstMean(i,:) = [mean(nonZeroF),mean(nonZeroNoF)];
        
        modIntStatsField.meanPhaseMeanDire(i,:) = [circ_mean(modInt.phaseMeanDire(indCurCField)'),circ_mean(modInt.phaseMeanDire(indCurCNoField)')];
        modIntStatsField.meanPhaseMeanDireH(i,:) = [circ_mean(modInt.phaseMeanDireH(indCurCField)'),circ_mean(modInt.phaseMeanDireH(indCurCNoField)')];
        modIntStatsField.meanMaxPhase(i,:) = [circ_mean(modInt.maxPhaseArr(indCurCField)'/180*pi),circ_mean(modInt.maxPhaseArr(indCurCNoField)'/180*pi)];
        modIntStatsField.meanMaxPhaseH(i,:) = [circ_mean(modInt.maxPhaseArrH(indCurCField)'/180*pi),circ_mean(modInt.maxPhaseArrH(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhase(i,:) = [circ_mean(modInt.minPhaseArr(indCurCField)'/180*pi),circ_mean(modInt.minPhaseArr(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhaseH(i,:) = [circ_mean(modInt.minPhaseArrH(indCurCField)'/180*pi),circ_mean(modInt.minPhaseArrH(indCurCNoField)'/180*pi)];
        modIntStatsField.meanPhaseDiff(i,:) = [mean(modInt.phaseDiff(indCurCField)),mean(modInt.phaseDiff(indCurCNoField))];
        modIntStatsField.meanPhaseDiffH(i,:) = [mean(modInt.phaseDiffH(indCurCField)),mean(modInt.phaseDiffH(indCurCNoField))];
        modIntStatsField.meanThetaModHist(i,:) = [mean(modInt.thetaModHist(indCurCField)),mean(modInt.thetaModHist(indCurCNoField))];
        modIntStatsField.meanThetaModHistH(i,:) = [mean(modInt.thetaModHistH(indCurCField)),mean(modInt.thetaModHistH(indCurCNoField))];
        
        modIntStatsField.meanThetaModFreq3(i,:) = [mean(modInt.thetaModFreq3(indCurCField)),mean(modInt.thetaModFreq3(indCurCNoField))];
        modIntStatsField.meanThetaAsym3(i,:) = [mean(modInt.thetaAsym3(indCurCField)),mean(modInt.thetaAsym3(indCurCNoField))];
        modIntStatsField.meanThetaModInd3(i,:) = [mean(modInt.thetaModInd3(indCurCField)),mean(modInt.thetaModInd3(indCurCNoField))];
        modIntStatsField.meanThetaModInd(i,:) = [mean(modInt.thetaModInd(indCurCField)),mean(modInt.thetaModInd(indCurCNoField))];
        
        modIntStatsField.pRSPeakTo40ms(i) = ranksum(autoCorrIntAll.peakTo40ms(indCurCField),autoCorrIntAll.peakTo40ms(indCurCNoField));
        modIntStatsField.pRSPeakTime(i) = ranksum(autoCorrIntAll.peakTime(indCurCField),autoCorrIntAll.peakTime(indCurCNoField));
        
        modIntStatsField.pWWBurstMeanDire(i) = circ_wwtest(modInt.burstMeanDire(indCurCField)',modInt.burstMeanDire(indCurCNoField)');
        modIntStatsField.pWWNonBurstMeanDire(i) = circ_wwtest(modInt.nonBurstMeanDire(indCurCField)',modInt.nonBurstMeanDire(indCurCNoField)');
        modIntStatsField.pWWBurstMeanDireStart(i) = circ_wwtest(modInt.burstMeanDireStart(indCurCFieldBurst)',modInt.burstMeanDireStart(indCurCNoFieldBurst)');
        modIntStatsField.pRSFractBurst(i) = ranksum(modInt.fractBurst(indCurCField),modInt.fractBurst(indCurCNoField));
        modIntStatsField.pRSNumSpPerBurstMean(i) = ranksum(nonZeroF,nonZeroNoF);
        
        modIntStatsField.pKBurstMeanDire(i) = circ_ktest(modInt.burstMeanDire(indCurCField)',modInt.burstMeanDire(indCurCNoField)');
        modIntStatsField.pKNonBurstMeanDire(i) = circ_ktest(modInt.nonBurstMeanDire(indCurCField)',modInt.nonBurstMeanDire(indCurCNoField)');
        modIntStatsField.pKBurstMeanDireStart(i) = circ_ktest(modInt.burstMeanDireStart(indCurCFieldBurst)',modInt.burstMeanDireStart(indCurCNoFieldBurst)');
        
        modIntStatsField.pWWPhaseMeanDire(i) = circ_wwtest(modInt.phaseMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCNoField)');
        modIntStatsField.pWWPhaseMeanDireH(i) = circ_wwtest(modInt.phaseMeanDireH(indCurCField)',modInt.phaseMeanDireH(indCurCNoField)');
        modIntStatsField.pWWMaxPhase(i) = circ_wwtest(modInt.maxPhaseArr(indCurCField)'/180*pi,modInt.maxPhaseArr(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMaxPhaseH(i) = circ_wwtest(modInt.maxPhaseArrH(indCurCField)'/180*pi,modInt.maxPhaseArrH(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhase(i) = circ_wwtest(modInt.minPhaseArr(indCurCField)'/180*pi,modInt.minPhaseArr(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseH(i) = circ_wwtest(modInt.minPhaseArrH(indCurCField)'/180*pi,modInt.minPhaseArrH(indCurCNoField)'/180*pi);
        
        modIntStatsField.pKPhaseMeanDire(i) = circ_ktest(modInt.phaseMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCNoField)');
        modIntStatsField.pKPhaseMeanDireH(i) = circ_ktest(modInt.phaseMeanDireH(indCurCField)',modInt.phaseMeanDireH(indCurCNoField)');
        modIntStatsField.pKMaxPhase(i) = circ_ktest(modInt.maxPhaseArr(indCurCField)'/180*pi,modInt.maxPhaseArr(indCurCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseH(i) = circ_ktest(modInt.maxPhaseArrH(indCurCField)'/180*pi,modInt.maxPhaseArrH(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhase(i) = circ_ktest(modInt.minPhaseArr(indCurCField)'/180*pi,modInt.minPhaseArr(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseH(i) = circ_ktest(modInt.minPhaseArrH(indCurCField)'/180*pi,modInt.minPhaseArrH(indCurCNoField)'/180*pi);
        
        modIntStatsField.pRSPhaseDiff(i) = ranksum(modInt.phaseDiff(indCurCField),modInt.phaseDiff(indCurCNoField));
        modIntStatsField.pRSPhaseDiffH(i) = ranksum(modInt.phaseDiffH(indCurCField),modInt.phaseDiffH(indCurCNoField));
        modIntStatsField.pRSThetaModHist(i) = ranksum(modInt.thetaModHist(indCurCField),modInt.thetaModHist(indCurCNoField));
        modIntStatsField.pRSThetaModHistH(i) = ranksum(modInt.thetaModHistH(indCurCField),modInt.thetaModHistH(indCurCNoField));
        
        modIntStatsField.pRSThetaModFreq3(i) = ranksum(modInt.thetaModFreq3(indCurCField),modInt.thetaModFreq3(indCurCNoField));
        modIntStatsField.pRSThetaAsym3(i) = ranksum(modInt.thetaAsym3(indCurCField),modInt.thetaAsym3(indCurCNoField));  
        modIntStatsField.pRSThetaModInd3(i) = ranksum(modInt.thetaModInd3(indCurCField),modInt.thetaModInd3(indCurCNoField));
        modIntStatsField.pRSThetaModInd(i) = ranksum(modInt.thetaModInd(indCurCField),modInt.thetaModInd(indCurCNoField));
        
        modIntStatsField.pWWBurstVsNonBurstMeanDire(i) = circ_wwtest(modInt.burstMeanDire(indCurCField)',modInt.nonBurstMeanDire(indCurCField)');
        modIntStatsField.pWWBurstVsThetaMeanDire(i) = circ_wwtest(modInt.burstMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCField)');
        modIntStatsField.pWWNonBurstVsThetaMeanDire(i) = circ_wwtest(modInt.nonBurstMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCField)');
        modIntStatsField.pWWBurstStartVsThetaMeanDire(i) = circ_wwtest(modInt.burstMeanDireStart(indCurCFieldBurst)',modInt.phaseMeanDire(indCurCField)');
        
        modIntStatsField.pKBurstVsNonBurstMeanDire(i) = circ_ktest(modInt.burstMeanDire(indCurCField)',modInt.nonBurstMeanDire(indCurCField)');
        modIntStatsField.pKBurstVsThetaMeanDire(i) = circ_ktest(modInt.burstMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCField)');
        modIntStatsField.pKNonBurstVsThetaMeanDire(i) = circ_ktest(modInt.nonBurstMeanDire(indCurCField)',modInt.phaseMeanDire(indCurCField)');
        modIntStatsField.pKBurstStartVsThetaMeanDire(i) = circ_ktest(modInt.burstMeanDireStart(indCurCFieldBurst)',modInt.phaseMeanDire(indCurCField)');
    end
    