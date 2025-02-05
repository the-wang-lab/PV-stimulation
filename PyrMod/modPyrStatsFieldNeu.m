function modPyrStatsFieldF = modPyrStatsFieldNeu(mod)
% statistics for field vs no field neurons for each cluster
% this function is called by PyrModAllRec.m
    
    modPyrStatsFieldF = [];
    idxC = mod.idxC;
    for i = 1:max(idxC)        
        indCurCField = idxC == i & mod.isNeuWithField == 1;
        indCurCNoField = idxC == i & mod.isNeuWithField == 0;
        indCurCFieldBurst = idxC == i & mod.isNeuWithField == 1 & mod.fractBurst > 0;
        indCurCNoFieldBurst = idxC == i & mod.isNeuWithField == 0 & mod.fractBurst > 0;
        modPyrStatsFieldF.indCurCField{i} = indCurCField;
        modPyrStatsFieldF.indCurCNoField{i} = indCurCNoField;
        modPyrStatsFieldF.indCurCFieldBurst{i} = indCurCFieldBurst;
        modPyrStatsFieldF.indCurCNoFieldBurst{i} = indCurCNoFieldBurst;
        modPyrStatsFieldF.fieldWidthCFRec{i} = mod.fieldWidth(indCurCField);
        modPyrStatsFieldF.indPeakFieldFRec{i} = mod.indPeakField(indCurCField);
        modPyrStatsFieldF.indStartFieldFRec{i} = mod.indStartField(indCurCField);
        modPyrStatsFieldF.percTrackStartField{i} = mod.percTrackStartField(indCurCField);
        modPyrStatsFieldF.percTrackPeakField{i} = mod.percTrackPeakField(indCurCField);
        modPyrStatsFieldF.skewness{i} = (mod.indPeakField(indCurCField) - mod.indStartField(indCurCField) + 1)./mod.fieldWidth(indCurCField);
      
        modPyrStatsFieldF.meanDiffNeuronLFPFreq(i,:) = [mean(mod.diffNeuronLFPFreq(indCurCField)),mean(mod.diffNeuronLFPFreq(indCurCNoField))];
        modPyrStatsFieldF.meanRelDepthNeuHDef(i,:) = [mean(mod.relDepthNeuHDef(indCurCField)),...
                            mean(mod.relDepthNeuHDef(indCurCNoField))];
          
        modPyrStatsFieldF.meanPhaseMeanDire(i,:) = [circ_mean(mod.phaseMeanDire(indCurCField)'),circ_mean(mod.phaseMeanDire(indCurCNoField)')];
        modPyrStatsFieldF.meanBurstMeanDire(i,:) = [circ_mean(mod.burstMeanDire(indCurCFieldBurst)'),circ_mean(mod.burstMeanDire(indCurCNoFieldBurst)')];  
        modPyrStatsFieldF.meanNonBurstMeanDire(i,:) = [circ_mean(mod.nonBurstMeanDire(indCurCField)'),circ_mean(mod.nonBurstMeanDire(indCurCNoField)')]; 
        modPyrStatsFieldF.meanBurstMeanDireStart(i,:) = [circ_mean(mod.burstMeanDireStart(indCurCFieldBurst)'),circ_mean(mod.burstMeanDireStart(indCurCNoFieldBurst)')];  
        modPyrStatsFieldF.meanFractBurst(i,:) = [mean(mod.fractBurst(indCurCField)),mean(mod.fractBurst(indCurCNoField))];
        modPyrStatsFieldF.meanNumSpPerBurstMean(i,:) = [mean(mod.numSpPerBurstMean(indCurCField)),mean(mod.numSpPerBurstMean(indCurCNoField))];
        modPyrStatsFieldF.meanBurstMeanResultantLen(i,:) = [mean(mod.burstMeanResultantLen(indCurCFieldBurst)),mean(mod.burstMeanResultantLen(indCurCNoFieldBurst))];
        modPyrStatsFieldF.meanPhaseMeanResultantLen(i,:) = [mean(mod.phaseMeanResultantLen(indCurCField)),mean(mod.phaseMeanResultantLen(indCurCNoField))];
            
        modPyrStatsFieldF.meanThetaModHist(i,:) = [mean(mod.thetaModHist(indCurCField)),mean(mod.thetaModHist(indCurCNoField))];
        modPyrStatsFieldF.meanThetaModHistH(i,:) = [mean(mod.thetaModHistH(indCurCField)),mean(mod.thetaModHistH(indCurCNoField))];
        modPyrStatsFieldF.meanThetaModFreq3(i,:) = [mean(mod.thetaModFreq3(indCurCField)),mean(mod.thetaModFreq3(indCurCNoField))];
        modPyrStatsFieldF.meanThetaAsym3(i,:) = [mean(mod.thetaAsym3(indCurCField)),mean(mod.thetaAsym3(indCurCNoField))];
        
        modPyrStatsFieldF.pRSDiffNeuronLFPFreq(i,:) = ranksum(mod.diffNeuronLFPFreq(indCurCField),mod.diffNeuronLFPFreq(indCurCNoField));
        modPyrStatsFieldF.pRSRelDepthNeuHDef(i) = ranksum(mod.relDepthNeuHDef(indCurCField),...
                            mod.relDepthNeuHDef(indCurCNoField));
        modPyrStatsFieldF.pKWRelDepthNeuHDef(i) = kruskalwallis([mod.relDepthNeuHDef(indCurCField),...
                            mod.relDepthNeuHDef(indCurCNoField)],...
                            [ones(1,sum(indCurCField)),2*ones(1,sum(indCurCNoField))]);
        
        modPyrStatsFieldF.pRSThetaModHist(i) = ranksum(mod.thetaModHist(indCurCField),mod.thetaModHist(indCurCNoField));
        modPyrStatsFieldF.pRSThetaModHistH(i) = ranksum(mod.thetaModHistH(indCurCField),mod.thetaModHistH(indCurCNoField));
        modPyrStatsFieldF.pRSThetaModFreq3(i) = ranksum(mod.thetaModFreq3(indCurCField),mod.thetaModFreq3(indCurCNoField));
        modPyrStatsFieldF.pRSThetaAsym3(i) = ranksum(mod.thetaAsym3(indCurCField),mod.thetaAsym3(indCurCNoField));
    
        modPyrStatsFieldF.pKPhaseMeanDire(i) = circ_ktest(mod.phaseMeanDire(indCurCField)',mod.phaseMeanDire(indCurCNoField)');
        modPyrStatsFieldF.pKBurstMeanDire(i) = circ_ktest(mod.burstMeanDire(indCurCFieldBurst)',mod.burstMeanDire(indCurCNoFieldBurst)'); 
        modPyrStatsFieldF.pKNonBurstMeanDire(i) = circ_ktest(mod.nonBurstMeanDire(indCurCField)',mod.nonBurstMeanDire(indCurCNoField)'); 
        modPyrStatsFieldF.pKBurstMeanDireStart(i) = circ_ktest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.burstMeanDireStart(indCurCNoFieldBurst)'); 
        modPyrStatsFieldF.pWWPhaseMeanDire(i) = circ_wwtest(mod.phaseMeanDire(indCurCField)',mod.phaseMeanDire(indCurCNoField)');
        modPyrStatsFieldF.pWWBurstMeanDire(i) = circ_wwtest(mod.burstMeanDire(indCurCFieldBurst)',mod.burstMeanDire(indCurCNoFieldBurst)'); 
        modPyrStatsFieldF.pWWNonBurstMeanDire(i) = circ_wwtest(mod.nonBurstMeanDire(indCurCField)',mod.nonBurstMeanDire(indCurCNoField)');
        modPyrStatsFieldF.pWWBurstMeanDireStart(i) = circ_wwtest(mod.burstMeanDireStart(indCurCFieldBurst)',mod.burstMeanDireStart(indCurCNoFieldBurst)'); 
        modPyrStatsFieldF.pMEDBurstVsThetaMeanDire(i) = circ_medtest(mod.burstMeanDire(indCurCFieldBurst)'- mod.phaseMeanDire(indCurCFieldBurst)',0);  
        modPyrStatsFieldF.pMEDNonBurstVsThetaMeanDire(i) = circ_medtest(mod.nonBurstMeanDire(indCurCField)'- mod.phaseMeanDire(indCurCField)',0);    
        modPyrStatsFieldF.pRSBurstMeanResultantLen(i) = ranksum(mod.burstMeanResultantLen(indCurCFieldBurst),mod.burstMeanResultantLen(indCurCNoFieldBurst));
        modPyrStatsFieldF.pRSPhaseMeanResultantLen(i) = ranksum(mod.phaseMeanResultantLen(indCurCField),mod.phaseMeanResultantLen(indCurCNoField));
        
        modPyrStatsFieldF.pWWBurstThetaDiff(i) = circ_wwtest(mod.burstThetaDiff(indCurCFieldBurst),...
                mod.burstThetaDiff(indCurCNoFieldBurst));
        modPyrStatsFieldF.pKBurstThetaDiff(i) = circ_ktest(mod.burstThetaDiff(indCurCFieldBurst),...
                mod.burstThetaDiff(indCurCNoFieldBurst));
    
        modPyrStatsFieldF.pRSMeanFractBurst(i) = ranksum(mod.fractBurst(indCurCField),mod.fractBurst(indCurCNoField));
        modPyrStatsFieldF.pRSNumSpPerBurstMean(i) = ranksum(mod.numSpPerBurstMean(indCurCField),mod.numSpPerBurstMean(indCurCNoField));
    end
    modPyrStatsFieldF.pRSFieldWidthC = ranksum(modPyrStatsFieldF.fieldWidthCFRec{1},modPyrStatsFieldF.fieldWidthCFRec{2});
    modPyrStatsFieldF.pRSIndPeakFieldFRec = ranksum(modPyrStatsFieldF.indPeakFieldFRec{1},modPyrStatsFieldF.indPeakFieldFRec{2});
    modPyrStatsFieldF.pRSSkewnessC = ranksum(modPyrStatsFieldF.skewness{1},modPyrStatsFieldF.skewness{2});
    modPyrStatsFieldF.pRSThetaModFreq3C = ranksum(mod.thetaModFreq3(modPyrStatsFieldF.indCurCField{1}),...
                mod.thetaModFreq3(modPyrStatsFieldF.indCurCField{2}));
    modPyrStatsFieldF.pRSPercTrackStartFieldC = ranksum(modPyrStatsFieldF.percTrackStartField{1},...
                modPyrStatsFieldF.percTrackStartField{2});
    modPyrStatsFieldF.pRSPercTrackPeakFieldC = ranksum(modPyrStatsFieldF.percTrackPeakField{1},...
                modPyrStatsFieldF.percTrackPeakField{2});
end
