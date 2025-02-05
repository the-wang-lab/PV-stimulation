function modPyrStatsField = modPyrStatsFieldPerC(mod)
% For each pyramidal cluster, compare neurons in the recordings with fields vs.
% recordings without field
% This function is called by PyrModAllRec.m

    modPyrStatsField = [];
    idxC = mod.idxC;
    for i = 1:max(idxC)
        indCurCField = idxC == i & mod.nNeuWithField > 1;
        indCurCNoField = idxC == i & mod.nNeuWithField < 1;
        modPyrStatsField.indCurCField{i} = indCurCField;
        modPyrStatsField.indCurCNoField{i} = indCurCNoField;
        modPyrStatsField.isNeuWithField(i,:) = [sum(mod.isNeuWithField(indCurCField)),sum(mod.isNeuWithField(indCurCNoField))];
        
        modPyrStatsField.meanPeakTo40ms(i,:) = [mean(mod.peakTo40ms(indCurCField)),mean(mod.peakTo40ms(indCurCNoField))];
        modPyrStatsField.meanPeakTime(i,:) = [mean(mod.peakTime(indCurCField)),mean(mod.peakTime(indCurCNoField))];
        
        modPyrStatsField.mFR(i,:) = [mean(mod.mFR(indCurCField)),mean(mod.mFR(indCurCNoField))];
        modPyrStatsField.meanInstFR(i,:) = [mean(mod.meanInstFR(indCurCField)),mean(mod.meanInstFR(indCurCNoField))];
        
        modPyrStatsField.meanDiffNeuronLFPFreq(i,:) = [mean(mod.diffNeuronLFPFreq(indCurCField)),mean(mod.diffNeuronLFPFreq(indCurCNoField))];
                
        indCurCFieldBurst = idxC == i & mod.nNeuWithField > 1 & mod.fractBurst > 0;
        indCurCNoFieldBurst = idxC == i & mod.nNeuWithField <= 1 & mod.fractBurst > 0;
        modPyrStatsField.indCurCFieldBurst{i} = indCurCFieldBurst;
        modPyrStatsField.indCurCNoFieldBurst{i} = indCurCNoFieldBurst;
        modPyrStatsField.meanBurstMeanDire(i,:) = [circ_mean(mod.burstMeanDire(indCurCFieldBurst)'),circ_mean(mod.burstMeanDire(indCurCNoFieldBurst)')];
        modPyrStatsField.meanNonBurstMeanDire(i,:) = [circ_mean(mod.nonBurstMeanDire(indCurCField)'),circ_mean(mod.nonBurstMeanDire(indCurCNoField)')];     
        modPyrStatsField.meanBurstMeanDireStart(i,:) = [circ_mean(mod.burstMeanDireStart(indCurCFieldBurst)'),circ_mean(mod.burstMeanDireStart(indCurCNoFieldBurst)')];
        modPyrStatsField.meanFractBurst(i,:) = [mean(mod.fractBurst(indCurCField)),mean(mod.fractBurst(indCurCNoField))];
        nonZeroF = mod.numSpPerBurstMean(indCurCField);
        nonZeroF = nonZeroF(nonZeroF > 0);
        nonZeroNoF = mod.numSpPerBurstMean(indCurCNoField);
        nonZeroNoF = nonZeroNoF(nonZeroNoF > 0);
        modPyrStatsField.meanNumSpPerBurstMean(i,:) = [mean(nonZeroF),mean(nonZeroNoF)];
        
        modPyrStatsField.meanPhaseMeanDire(i,:) = [circ_mean(mod.phaseMeanDire(indCurCField)'),circ_mean(mod.phaseMeanDire(indCurCNoField)')];
        modPyrStatsField.meanPhaseMeanDireH(i,:) = [circ_mean(mod.phaseMeanDireH(indCurCField)'),circ_mean(mod.phaseMeanDireH(indCurCNoField)')];
        modPyrStatsField.meanMaxPhase(i,:) = [circ_mean(mod.maxPhaseArr(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArr(indCurCNoField)'/180*pi)];
        modPyrStatsField.meanMaxPhaseH(i,:) = [circ_mean(mod.maxPhaseArrH(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArrH(indCurCNoField)'/180*pi)];
        modPyrStatsField.meanminPhase(i,:) = [circ_mean(mod.minPhaseArr(indCurCField)'/180*pi),circ_mean(mod.minPhaseArr(indCurCNoField)'/180*pi)];
        modPyrStatsField.meanminPhaseH(i,:) = [circ_mean(mod.minPhaseArrH(indCurCField)'/180*pi),circ_mean(mod.minPhaseArrH(indCurCNoField)'/180*pi)];
        modPyrStatsField.meanPhaseDiff(i,:) = [mean(mod.phaseDiff(indCurCField)),mean(mod.phaseDiff(indCurCNoField))];
        modPyrStatsField.meanPhaseDiffH(i,:) = [mean(mod.phaseDiffH(indCurCField)),mean(mod.phaseDiffH(indCurCNoField))];
        modPyrStatsField.meanThetaModHist(i,:) = [mean(mod.thetaModHist(indCurCField)),mean(mod.thetaModHist(indCurCNoField))];
        modPyrStatsField.meanThetaModHistH(i,:) = [mean(mod.thetaModHistH(indCurCField)),mean(mod.thetaModHistH(indCurCNoField))];
        
        modPyrStatsField.meanThetaModFreq3(i,:) = [mean(mod.thetaModFreq3(indCurCField)),mean(mod.thetaModFreq3(indCurCNoField))];
        modPyrStatsField.meanThetaAsym3(i,:) = [mean(mod.thetaAsym3(indCurCField)),mean(mod.thetaAsym3(indCurCNoField))];
        modPyrStatsField.meanThetaModInd3(i,:) = [mean(mod.thetaModInd3(indCurCField)),mean(mod.thetaModInd3(indCurCNoField))];
        modPyrStatsField.meanThetaModInd(i,:) = [mean(mod.thetaModInd(indCurCField)),mean(mod.thetaModInd(indCurCNoField))];
        
        modPyrStatsField.pRSDiffNeuronLFPFreq(i) = ranksum(mod.diffNeuronLFPFreq(indCurCField),mod.diffNeuronLFPFreq(indCurCNoField));
        
        modPyrStatsField.pRSPeakTo40ms(i) = ranksum(mod.peakTo40ms(indCurCField),mod.peakTo40ms(indCurCNoField));
        modPyrStatsField.pRSPeakTime(i) = ranksum(mod.peakTime(indCurCField),mod.peakTime(indCurCNoField));
        modPyrStatsField.pRSRelDepthNeuHDef(i) = ranksum(mod.relDepthNeuHDef(indCurCField),...
                            mod.relDepthNeuHDef(indCurCNoField));
        modPyrStatsField.pKWRelDepthNeuHDef(i) = kruskalwallis([mod.relDepthNeuHDef(indCurCField),...
                            mod.relDepthNeuHDef(indCurCNoField)],...
                            [ones(1,sum(indCurCField)),2*ones(1,sum(indCurCNoField))]);
                        
        modPyrStatsField.pRSMFR(i) = ranksum(mod.mFR(indCurCField),mod.mFR(indCurCNoField));
        modPyrStatsField.pRSMeanInstFR(i) = ranksum(mod.meanInstFR(indCurCField),mod.meanInstFR(indCurCNoField));
        
        modPyrStatsField.pKBurstMeanDire(i) = circ_ktest(mod.burstMeanDire(indCurCFieldBurst)',mod.burstMeanDire(indCurCNoFieldBurst)');
        modPyrStatsField.pKNonBurstMeanDire(i) = circ_ktest(mod.nonBurstMeanDire(indCurCField)',mod.nonBurstMeanDire(indCurCNoField)');
        modPyrStatsField.pKBurstMeanDireStart(i) = circ_ktest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.burstMeanDireStart(indCurCNoFieldBurst)');
        
        modPyrStatsField.pWWBurstMeanDire(i) = circ_wwtest(mod.burstMeanDire(indCurCFieldBurst)',mod.burstMeanDire(indCurCNoFieldBurst)');
        modPyrStatsField.pWWNonBurstMeanDire(i) = circ_wwtest(mod.nonBurstMeanDire(indCurCField)',mod.nonBurstMeanDire(indCurCNoField)');
        modPyrStatsField.pWWBurstMeanDireStart(i) = circ_wwtest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.burstMeanDireStart(indCurCNoFieldBurst)');
        
        modPyrStatsField.pRSFractBurst(i) = ranksum(mod.fractBurst(indCurCField),mod.fractBurst(indCurCNoField));        
        modPyrStatsField.pRSNumSpPerBurstMean(i) = ranksum(nonZeroF,nonZeroNoF);
        
        modPyrStatsField.pWWBurstThetaDiff(i) = circ_wwtest(mod.burstThetaDiff(indCurCFieldBurst),...
                mod.burstThetaDiff(indCurCNoFieldBurst));
        modPyrStatsField.pKBurstThetaDiff(i) = circ_ktest(mod.burstThetaDiff(indCurCFieldBurst),...
                mod.burstThetaDiff(indCurCNoFieldBurst));
        
        modPyrStatsField.pKPhaseMeanDire(i) = circ_ktest(mod.phaseMeanDire(indCurCField)',mod.phaseMeanDire(indCurCNoField)');
        modPyrStatsField.pKPhaseMeanDireH(i) = circ_ktest(mod.phaseMeanDireH(indCurCField)',mod.phaseMeanDireH(indCurCNoField)');
        modPyrStatsField.pKMaxPhase(i) = circ_ktest(mod.maxPhaseArr(indCurCField)'/180*pi,mod.maxPhaseArr(indCurCNoField)'/180*pi);
        modPyrStatsField.pKMaxPhaseH(i) = circ_ktest(mod.maxPhaseArrH(indCurCField)'/180*pi,mod.maxPhaseArrH(indCurCNoField)'/180*pi);
        modPyrStatsField.pKMinPhase(i) = circ_ktest(mod.minPhaseArr(indCurCField)'/180*pi,mod.minPhaseArr(indCurCNoField)'/180*pi);
        modPyrStatsField.pKMinPhaseH(i) = circ_ktest(mod.minPhaseArrH(indCurCField)'/180*pi,mod.minPhaseArrH(indCurCNoField)'/180*pi);
        
        modPyrStatsField.pWWPhaseMeanDire(i) = circ_wwtest(mod.phaseMeanDire(indCurCField)',mod.phaseMeanDire(indCurCNoField)');
        modPyrStatsField.pWWPhaseMeanDireH(i) = circ_wwtest(mod.phaseMeanDireH(indCurCField)',mod.phaseMeanDireH(indCurCNoField)');
        modPyrStatsField.pWWMaxPhase(i) = circ_wwtest(mod.maxPhaseArr(indCurCField)'/180*pi,mod.maxPhaseArr(indCurCNoField)'/180*pi);
        modPyrStatsField.pWWMaxPhaseH(i) = circ_wwtest(mod.maxPhaseArrH(indCurCField)'/180*pi,mod.maxPhaseArrH(indCurCNoField)'/180*pi);
        modPyrStatsField.pWWMinPhase(i) = circ_wwtest(mod.minPhaseArr(indCurCField)'/180*pi,mod.minPhaseArr(indCurCNoField)'/180*pi);
        modPyrStatsField.pWWMinPhaseH(i) = circ_wwtest(mod.minPhaseArrH(indCurCField)'/180*pi,mod.minPhaseArrH(indCurCNoField)'/180*pi);
        
        modPyrStatsField.pRSPhaseDiff(i) = ranksum(mod.phaseDiff(indCurCField),mod.phaseDiff(indCurCNoField));
        modPyrStatsField.pRSPhaseDiffH(i) = ranksum(mod.phaseDiffH(indCurCField),mod.phaseDiffH(indCurCNoField));
        modPyrStatsField.pRSThetaModHist(i) = ranksum(mod.thetaModHist(indCurCField),mod.thetaModHist(indCurCNoField));
        modPyrStatsField.pRSThetaModHistH(i) = ranksum(mod.thetaModHistH(indCurCField),mod.thetaModHistH(indCurCNoField));
        
        modPyrStatsField.pRSThetaModFreq3(i) = ranksum(mod.thetaModFreq3(indCurCField),mod.thetaModFreq3(indCurCNoField));
        modPyrStatsField.pRSThetaAsym3(i) = ranksum(mod.thetaAsym3(indCurCField),mod.thetaAsym3(indCurCNoField));  
        modPyrStatsField.pRSThetaModInd3(i) = ranksum(mod.thetaModInd3(indCurCField),mod.thetaModInd3(indCurCNoField));
        modPyrStatsField.pRSThetaModInd(i) = ranksum(mod.thetaModInd(indCurCField),mod.thetaModInd(indCurCNoField));
        
        modPyrStatsField.pKBurstVsNonBurstMeanDire(i) = circ_ktest(mod.burstMeanDire(indCurCFieldBurst)',mod.nonBurstMeanDire(indCurCField)');
        modPyrStatsField.pKBurstVsThetaMeanDire(i) = circ_ktest(mod.burstMeanDire(indCurCFieldBurst)',mod.phaseMeanDire(indCurCField)');
        modPyrStatsField.pKNonBurstVsThetaMeanDire(i) = circ_ktest(mod.nonBurstMeanDire(indCurCField)',mod.phaseMeanDire(indCurCField)');
        modPyrStatsField.pKBurstStartVsThetaMeanDire(i) = circ_ktest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.phaseMeanDire(indCurCField)');
        
        modPyrStatsField.pWWBurstVsNonBurstMeanDire(i) = circ_wwtest(mod.burstMeanDire(indCurCFieldBurst)',mod.nonBurstMeanDire(indCurCField)');
        modPyrStatsField.pWWBurstVsThetaMeanDire(i) = circ_wwtest(mod.burstMeanDire(indCurCFieldBurst)',mod.phaseMeanDire(indCurCField)');
        modPyrStatsField.pWWNonBurstVsThetaMeanDire(i) = circ_wwtest(mod.nonBurstMeanDire(indCurCField)',mod.phaseMeanDire(indCurCField)');
        modPyrStatsField.pWWBurstStartVsThetaMeanDire(i) = circ_wwtest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.phaseMeanDire(indCurCField)');
    end
end
