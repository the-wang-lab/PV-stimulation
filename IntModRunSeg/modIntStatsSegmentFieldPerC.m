function modIntStatsField = modIntStatsSegmentFieldPerC(mod)
    modIntStatsField = [];
    idxC = mod.idxC;
    for i = 1:max(idxC)
        indCurCField = idxC == i & mod.nNeuWithField > 1;
        indCurCNoField = idxC == i & mod.nNeuWithField < 1;
        modIntStatsField.indCurCField{i} = indCurCField;
        modIntStatsField.indCurCNoField{i} = indCurCNoField;
        
        %% before run
        modIntStatsField.meanPhaseMeanDireBefRun(i,:) = [circ_mean(mod.phaseMeanDireBefRun(indCurCField)'),circ_mean(mod.phaseMeanDireBefRun(indCurCNoField)')];
        modIntStatsField.meanMaxPhaseBefRun(i,:) = [circ_mean(mod.maxPhaseArrBefRun(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArrBefRun(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhaseBefRun(i,:) = [circ_mean(mod.minPhaseArrBefRun(indCurCField)'/180*pi),circ_mean(mod.minPhaseArrBefRun(indCurCNoField)'/180*pi)];
        modIntStatsField.meanThetaModHistBefRun(i,:) = [mean(mod.thetaModHistBefRun(indCurCField)),mean(mod.thetaModHistBefRun(indCurCNoField))];
        modIntStatsField.meanPhaseMeanResultantLenBefRun(i,:) = [mean(mod.phaseMeanResultantLenBefRun(indCurCField)),mean(mod.phaseMeanResultantLenBefRun(indCurCNoField))];
        
        modIntStatsField.pKPhaseMeanDireBefRun(i) = circ_ktest(mod.phaseMeanDireBefRun(indCurCField)',mod.phaseMeanDireBefRun(indCurCNoField)');
        modIntStatsField.pKMaxPhaseBefRun(i) = circ_ktest(mod.maxPhaseArrBefRun(indCurCField)'/180*pi,mod.maxPhaseArrBefRun(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseBefRun(i) = circ_ktest(mod.minPhaseArrBefRun(indCurCField)'/180*pi,mod.minPhaseArrBefRun(indCurCNoField)'/180*pi);
        
        modIntStatsField.pWWPhaseMeanDireBefRun(i) = circ_wwtest(mod.phaseMeanDireBefRun(indCurCField)',mod.phaseMeanDireBefRun(indCurCNoField)');
        modIntStatsField.pWWMaxPhaseBefRun(i) = circ_wwtest(mod.maxPhaseArrBefRun(indCurCField)'/180*pi,mod.maxPhaseArrBefRun(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseBefRun(i) = circ_wwtest(mod.minPhaseArrBefRun(indCurCField)'/180*pi,mod.minPhaseArrBefRun(indCurCNoField)'/180*pi);
        
        modIntStatsField.pRSThetaModHistBefRun(i) = ranksum(mod.thetaModHistBefRun(indCurCField),mod.thetaModHistBefRun(indCurCNoField));
        
        modIntStatsField.pRSPhaseMeanResultantLenBefRun(i) = ranksum(mod.phaseMeanResultantLenBefRun(indCurCField),mod.phaseMeanResultantLenBefRun(indCurCNoField));
        
        %% 0-1s
        modIntStatsField.meanPhaseMeanDire0to1(i,:) = [circ_mean(mod.phaseMeanDire0to1(indCurCField)'),circ_mean(mod.phaseMeanDire0to1(indCurCNoField)')];
        modIntStatsField.meanPhaseMeanDireH0to1(i,:) = [circ_mean(mod.phaseMeanDireH0to1(indCurCField)'),circ_mean(mod.phaseMeanDireH0to1(indCurCNoField)')];
        modIntStatsField.meanMaxPhase0to1(i,:) = [circ_mean(mod.maxPhaseArr0to1(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArr0to1(indCurCNoField)'/180*pi)];
        modIntStatsField.meanMaxPhaseH0to1(i,:) = [circ_mean(mod.maxPhaseArrH0to1(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArrH0to1(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhase0to1(i,:) = [circ_mean(mod.minPhaseArr0to1(indCurCField)'/180*pi),circ_mean(mod.minPhaseArr0to1(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhaseH0to1(i,:) = [circ_mean(mod.minPhaseArrH0to1(indCurCField)'/180*pi),circ_mean(mod.minPhaseArrH0to1(indCurCNoField)'/180*pi)];
        modIntStatsField.meanThetaModHist0to1(i,:) = [mean(mod.thetaModHist0to1(indCurCField)),mean(mod.thetaModHist0to1(indCurCNoField))];
        modIntStatsField.meanThetaModHistH0to1(i,:) = [mean(mod.thetaModHistH0to1(indCurCField)),mean(mod.thetaModHistH0to1(indCurCNoField))];       
        modIntStatsField.meanPhaseMeanResultantLen0to1(i,:) = [mean(mod.phaseMeanResultantLen0to1(indCurCField)),mean(mod.phaseMeanResultantLen0to1(indCurCNoField))];
        
        modIntStatsField.pKPhaseMeanDire0to1(i) = circ_ktest(mod.phaseMeanDire0to1(indCurCField)',mod.phaseMeanDire0to1(indCurCNoField)');
        modIntStatsField.pKPhaseMeanDireH0to1(i) = circ_ktest(mod.phaseMeanDireH0to1(indCurCField)',mod.phaseMeanDireH0to1(indCurCNoField)');
        modIntStatsField.pKMaxPhase0to1(i) = circ_ktest(mod.maxPhaseArr0to1(indCurCField)'/180*pi,mod.maxPhaseArr0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseH0to1(i) = circ_ktest(mod.maxPhaseArrH0to1(indCurCField)'/180*pi,mod.maxPhaseArrH0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhase0to1(i) = circ_ktest(mod.minPhaseArr0to1(indCurCField)'/180*pi,mod.minPhaseArr0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseH0to1(i) = circ_ktest(mod.minPhaseArrH0to1(indCurCField)'/180*pi,mod.minPhaseArrH0to1(indCurCNoField)'/180*pi);
        
        modIntStatsField.pWWPhaseMeanDire0to1(i) = circ_wwtest(mod.phaseMeanDire0to1(indCurCField)',mod.phaseMeanDire0to1(indCurCNoField)');
        modIntStatsField.pWWPhaseMeanDireH0to1(i) = circ_wwtest(mod.phaseMeanDireH0to1(indCurCField)',mod.phaseMeanDireH0to1(indCurCNoField)');
        modIntStatsField.pWWMaxPhase0to1(i) = circ_wwtest(mod.maxPhaseArr0to1(indCurCField)'/180*pi,mod.maxPhaseArr0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMaxPhaseH0to1(i) = circ_wwtest(mod.maxPhaseArrH0to1(indCurCField)'/180*pi,mod.maxPhaseArrH0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhase0to1(i) = circ_wwtest(mod.minPhaseArr0to1(indCurCField)'/180*pi,mod.minPhaseArr0to1(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseH0to1(i) = circ_wwtest(mod.minPhaseArrH0to1(indCurCField)'/180*pi,mod.minPhaseArrH0to1(indCurCNoField)'/180*pi);
        
        modIntStatsField.pRSThetaModHist0to1(i) = ranksum(mod.thetaModHist0to1(indCurCField),mod.thetaModHist0to1(indCurCNoField));
        modIntStatsField.pRSThetaModHistH0to1(i) = ranksum(mod.thetaModHistH0to1(indCurCField),mod.thetaModHistH0to1(indCurCNoField));
        
        modIntStatsField.pRSPhaseMeanResultantLen0to1(i) = ranksum(mod.phaseMeanResultantLen0to1(indCurCField),mod.phaseMeanResultantLen0to1(indCurCNoField));
        
        %% 3-5s
        modIntStatsField.meanPhaseMeanDire3to5(i,:) = [circ_mean(mod.phaseMeanDire3to5(indCurCField)'),circ_mean(mod.phaseMeanDire3to5(indCurCNoField)')];
        modIntStatsField.meanPhaseMeanDireH3to5(i,:) = [circ_mean(mod.phaseMeanDireH3to5(indCurCField)'),circ_mean(mod.phaseMeanDireH3to5(indCurCNoField)')];
        modIntStatsField.meanMaxPhase3to5(i,:) = [circ_mean(mod.maxPhaseArr3to5(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArr3to5(indCurCNoField)'/180*pi)];
        modIntStatsField.meanMaxPhaseH3to5(i,:) = [circ_mean(mod.maxPhaseArrH3to5(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArrH3to5(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhase3to5(i,:) = [circ_mean(mod.minPhaseArr3to5(indCurCField)'/180*pi),circ_mean(mod.minPhaseArr3to5(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhaseH3to5(i,:) = [circ_mean(mod.minPhaseArrH3to5(indCurCField)'/180*pi),circ_mean(mod.minPhaseArrH3to5(indCurCNoField)'/180*pi)];
        modIntStatsField.meanThetaModHist3to5(i,:) = [mean(mod.thetaModHist3to5(indCurCField)),mean(mod.thetaModHist3to5(indCurCNoField))];
        modIntStatsField.meanThetaModHistH3to5(i,:) = [mean(mod.thetaModHistH3to5(indCurCField)),mean(mod.thetaModHistH3to5(indCurCNoField))];       
        modIntStatsField.meanPhaseMeanResultantLen3to5(i,:) = [mean(mod.phaseMeanResultantLen3to5(indCurCField)),mean(mod.phaseMeanResultantLen3to5(indCurCNoField))];
        
        modIntStatsField.pKPhaseMeanDire3to5(i) = circ_ktest(mod.phaseMeanDire3to5(indCurCField)',mod.phaseMeanDire3to5(indCurCNoField)');
        modIntStatsField.pKPhaseMeanDireH3to5(i) = circ_ktest(mod.phaseMeanDireH3to5(indCurCField)',mod.phaseMeanDireH3to5(indCurCNoField)');
        modIntStatsField.pKMaxPhase3to5(i) = circ_ktest(mod.maxPhaseArr3to5(indCurCField)'/180*pi,mod.maxPhaseArr3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseH3to5(i) = circ_ktest(mod.maxPhaseArrH3to5(indCurCField)'/180*pi,mod.maxPhaseArrH3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhase3to5(i) = circ_ktest(mod.minPhaseArr3to5(indCurCField)'/180*pi,mod.minPhaseArr3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseH3to5(i) = circ_ktest(mod.minPhaseArrH3to5(indCurCField)'/180*pi,mod.minPhaseArrH3to5(indCurCNoField)'/180*pi);
        
        modIntStatsField.pWWPhaseMeanDire3to5(i) = circ_wwtest(mod.phaseMeanDire3to5(indCurCField)',mod.phaseMeanDire3to5(indCurCNoField)');
        modIntStatsField.pWWPhaseMeanDireH3to5(i) = circ_wwtest(mod.phaseMeanDireH3to5(indCurCField)',mod.phaseMeanDireH3to5(indCurCNoField)');
        modIntStatsField.pWWMaxPhase3to5(i) = circ_wwtest(mod.maxPhaseArr3to5(indCurCField)'/180*pi,mod.maxPhaseArr3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMaxPhaseH3to5(i) = circ_wwtest(mod.maxPhaseArrH3to5(indCurCField)'/180*pi,mod.maxPhaseArrH3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhase3to5(i) = circ_wwtest(mod.minPhaseArr3to5(indCurCField)'/180*pi,mod.minPhaseArr3to5(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseH3to5(i) = circ_wwtest(mod.minPhaseArrH3to5(indCurCField)'/180*pi,mod.minPhaseArrH3to5(indCurCNoField)'/180*pi);
        
        modIntStatsField.pRSThetaModHist3to5(i) = ranksum(mod.thetaModHist3to5(indCurCField),mod.thetaModHist3to5(indCurCNoField));
        modIntStatsField.pRSThetaModHistH3to5(i) = ranksum(mod.thetaModHistH3to5(indCurCField),mod.thetaModHistH3to5(indCurCNoField));
        
        modIntStatsField.pRSPhaseMeanResultantLen3to5(i) = ranksum(mod.phaseMeanResultantLen3to5(indCurCField),mod.phaseMeanResultantLen3to5(indCurCNoField));
        
        %% 3-4s
        modIntStatsField.meanPhaseMeanDire3to4(i,:) = [circ_mean(mod.phaseMeanDire3to4(indCurCField)'),circ_mean(mod.phaseMeanDire3to4(indCurCNoField)')];
        modIntStatsField.meanPhaseMeanDireH3to4(i,:) = [circ_mean(mod.phaseMeanDireH3to4(indCurCField)'),circ_mean(mod.phaseMeanDireH3to4(indCurCNoField)')];
        modIntStatsField.meanMaxPhase3to4(i,:) = [circ_mean(mod.maxPhaseArr3to4(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArr3to4(indCurCNoField)'/180*pi)];
        modIntStatsField.meanMaxPhaseH3to4(i,:) = [circ_mean(mod.maxPhaseArrH3to4(indCurCField)'/180*pi),circ_mean(mod.maxPhaseArrH3to4(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhase3to4(i,:) = [circ_mean(mod.minPhaseArr3to4(indCurCField)'/180*pi),circ_mean(mod.minPhaseArr3to4(indCurCNoField)'/180*pi)];
        modIntStatsField.meanminPhaseH3to4(i,:) = [circ_mean(mod.minPhaseArrH3to4(indCurCField)'/180*pi),circ_mean(mod.minPhaseArrH3to4(indCurCNoField)'/180*pi)];
        modIntStatsField.meanThetaModHist3to4(i,:) = [mean(mod.thetaModHist3to4(indCurCField)),mean(mod.thetaModHist3to4(indCurCNoField))];
        modIntStatsField.meanThetaModHistH3to4(i,:) = [mean(mod.thetaModHistH3to4(indCurCField)),mean(mod.thetaModHistH3to4(indCurCNoField))];       
        modIntStatsField.meanPhaseMeanResultantLen3to4(i,:) = [mean(mod.phaseMeanResultantLen3to4(indCurCField)),mean(mod.phaseMeanResultantLen3to4(indCurCNoField))];
        
        modIntStatsField.pKPhaseMeanDire3to4(i) = circ_ktest(mod.phaseMeanDire3to4(indCurCField)',mod.phaseMeanDire3to4(indCurCNoField)');
        modIntStatsField.pKPhaseMeanDireH3to4(i) = circ_ktest(mod.phaseMeanDireH3to4(indCurCField)',mod.phaseMeanDireH3to4(indCurCNoField)');
        modIntStatsField.pKMaxPhase3to4(i) = circ_ktest(mod.maxPhaseArr3to4(indCurCField)'/180*pi,mod.maxPhaseArr3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseH3to4(i) = circ_ktest(mod.maxPhaseArrH3to4(indCurCField)'/180*pi,mod.maxPhaseArrH3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhase3to4(i) = circ_ktest(mod.minPhaseArr3to4(indCurCField)'/180*pi,mod.minPhaseArr3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseH3to4(i) = circ_ktest(mod.minPhaseArrH3to4(indCurCField)'/180*pi,mod.minPhaseArrH3to4(indCurCNoField)'/180*pi);
        
        modIntStatsField.pWWPhaseMeanDire3to4(i) = circ_wwtest(mod.phaseMeanDire3to4(indCurCField)',mod.phaseMeanDire3to4(indCurCNoField)');
        modIntStatsField.pWWPhaseMeanDireH3to4(i) = circ_wwtest(mod.phaseMeanDireH3to4(indCurCField)',mod.phaseMeanDireH3to4(indCurCNoField)');
        modIntStatsField.pWWMaxPhase3to4(i) = circ_wwtest(mod.maxPhaseArr3to4(indCurCField)'/180*pi,mod.maxPhaseArr3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMaxPhaseH3to4(i) = circ_wwtest(mod.maxPhaseArrH3to4(indCurCField)'/180*pi,mod.maxPhaseArrH3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhase3to4(i) = circ_wwtest(mod.minPhaseArr3to4(indCurCField)'/180*pi,mod.minPhaseArr3to4(indCurCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseH3to4(i) = circ_wwtest(mod.minPhaseArrH3to4(indCurCField)'/180*pi,mod.minPhaseArrH3to4(indCurCNoField)'/180*pi);
        
        modIntStatsField.pRSThetaModHist3to4(i) = ranksum(mod.thetaModHist3to4(indCurCField),mod.thetaModHist3to4(indCurCNoField));
        modIntStatsField.pRSThetaModHistH3to4(i) = ranksum(mod.thetaModHistH3to4(indCurCField),mod.thetaModHistH3to4(indCurCNoField));
        
        modIntStatsField.pRSPhaseMeanResultantLen3to4(i) = ranksum(mod.phaseMeanResultantLen3to4(indCurCField),mod.phaseMeanResultantLen3to4(indCurCNoField));
        
    end
end