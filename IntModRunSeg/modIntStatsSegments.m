function modIntStatsField = modIntStatsSegments(mod)
    idxC = mod.idxC;
    for i = 1:max(idxC)
        %% befRun s vs 3-4 s
        modIntStatsField.pWWPhaseMeanDireCBefRunvs3to4(i) = circ_wwtest(mod.phaseMeanDireBefRun(idxC == i)',mod.phaseMeanDire3to4(idxC == i)');
        modIntStatsField.pKPhaseMeanDireCBefRunvs3to4(i) = circ_ktest(mod.phaseMeanDireBefRun(idxC == i)',mod.phaseMeanDire3to4(idxC == i)');
        modIntStatsField.pWWMaxPhaseCBefRunvs3to4(i) = circ_wwtest(mod.maxPhaseArrBefRun(idxC == i)'/180*pi,mod.maxPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pKMaxPhaseCBefRunvs3to4(i) = circ_ktest(mod.maxPhaseArrBefRun(idxC == i)'/180*pi,mod.maxPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pWWMinPhaseCBefRunvs3to4(i) = circ_wwtest(mod.minPhaseArrBefRun(idxC == i)'/180*pi,mod.minPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pKMinPhaseCBefRunvs3to4(i) = circ_ktest(mod.minPhaseArrBefRun(idxC == i)'/180*pi,mod.minPhaseArr3to4(idxC == i)'/180*pi);

        modIntStatsField.pRSThetaModHistCBefRunvs3to4(i) = ranksum(mod.thetaModHistBefRun(idxC == i),mod.thetaModHist3to4(idxC == i));
        
        modIntStatsField.pRSPhaseMeanResultantLenCBefRunvs3to4(i) = ranksum(mod.phaseMeanResultantLenBefRun(idxC == i),mod.phaseMeanResultantLen3to4(idxC == i));

        %% 0-1 s vs 3-4 s
        modIntStatsField.pWWPhaseMeanDireC0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDire0to1(idxC == i)',mod.phaseMeanDire3to4(idxC == i)');
        modIntStatsField.pKPhaseMeanDireC0to1vs3to4(i) = circ_ktest(mod.phaseMeanDire0to1(idxC == i)',mod.phaseMeanDire3to4(idxC == i)');
        modIntStatsField.pWWPhaseMeanDireHC0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxC == i)',mod.phaseMeanDireH3to4(idxC == i)');
        modIntStatsField.pKPhaseMeanDireHC0to1vs3to4(i) = circ_ktest(mod.phaseMeanDireH0to1(idxC == i)',mod.phaseMeanDireH3to4(idxC == i)');
        modIntStatsField.pWWMaxPhaseC0to1vs3to4(i) = circ_wwtest(mod.maxPhaseArr0to1(idxC == i)'/180*pi,mod.maxPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pKMaxPhaseC0to1vs3to4(i) = circ_ktest(mod.maxPhaseArr0to1(idxC == i)'/180*pi,mod.maxPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pWWMinPhaseC0to1vs3to4(i) = circ_wwtest(mod.minPhaseArr0to1(idxC == i)'/180*pi,mod.minPhaseArr3to4(idxC == i)'/180*pi);
        modIntStatsField.pKMinPhaseC0to1vs3to4(i) = circ_ktest(mod.minPhaseArr0to1(idxC == i)'/180*pi,mod.minPhaseArr3to4(idxC == i)'/180*pi);

        modIntStatsField.pRSThetaModHistC0to1vs3to4(i) = ranksum(mod.thetaModHist0to1(idxC == i),mod.thetaModHist3to4(idxC == i));
        modIntStatsField.pRSThetaModHistHC0to1vs3to4(i) = ranksum(mod.thetaModHistH0to1(idxC == i),mod.thetaModHistH3to4(idxC == i));

        modIntStatsField.pRSPhaseMeanResultantLenC0to1vs3to4(i) = ranksum(mod.phaseMeanResultantLen0to1(idxC == i),mod.phaseMeanResultantLen3to4(idxC == i));

        %% 0-1 s vs 3-5 s
        modIntStatsField.pWWPhaseMeanDireC0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDire0to1(idxC == i)',mod.phaseMeanDire3to5(idxC == i)');
        modIntStatsField.pKPhaseMeanDireC0to1vs3to5(i) = circ_ktest(mod.phaseMeanDire0to1(idxC == i)',mod.phaseMeanDire3to5(idxC == i)');
        modIntStatsField.pWWPhaseMeanDireHC0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxC == i)',mod.phaseMeanDireH3to5(idxC == i)');
        modIntStatsField.pKPhaseMeanDireHC0to1vs3to5(i) = circ_ktest(mod.phaseMeanDireH0to1(idxC == i)',mod.phaseMeanDireH3to5(idxC == i)');
        modIntStatsField.pWWMaxPhaseC0to1vs3to5(i) = circ_wwtest(mod.maxPhaseArr0to1(idxC == i)'/180*pi,mod.maxPhaseArr3to5(idxC == i)'/180*pi);
        modIntStatsField.pKMaxPhaseC0to1vs3to5(i) = circ_ktest(mod.maxPhaseArr0to1(idxC == i)'/180*pi,mod.maxPhaseArr3to5(idxC == i)'/180*pi);
        modIntStatsField.pWWMinPhaseC0to1vs3to5(i) = circ_wwtest(mod.minPhaseArr0to1(idxC == i)'/180*pi,mod.minPhaseArr3to5(idxC == i)'/180*pi);
        modIntStatsField.pKMinPhaseC0to1vs3to5(i) = circ_ktest(mod.minPhaseArr0to1(idxC == i)'/180*pi,mod.minPhaseArr3to5(idxC == i)'/180*pi);

        modIntStatsField.pRSThetaModHistC0to1vs3to5(i) = ranksum(mod.thetaModHist0to1(idxC == i),mod.thetaModHist3to5(idxC == i));
        modIntStatsField.pRSThetaModHistHC0to1vs3to5(i) = ranksum(mod.thetaModHistH0to1(idxC == i),mod.thetaModHistH3to5(idxC == i));

        modIntStatsField.pRSPhaseMeanResultantLenC0to1vs3to5(i) = ranksum(mod.phaseMeanResultantLen0to1(idxC == i),mod.phaseMeanResultantLen3to5(idxC == i));

        %% befRun s vs 3-4 s field recordings
        idxCField = mod.nNeuWithField > 1 & idxC == i;
        modIntStatsField.pWWPhaseMeanDireCFieldBefRunvs3to4(i) = circ_wwtest(mod.phaseMeanDireBefRun(idxCField)',mod.phaseMeanDire3to4(idxCField)');
        modIntStatsField.pKPhaseMeanDireCFieldBefRunvs3to4(i) = circ_ktest(mod.phaseMeanDireBefRun(idxCField)',mod.phaseMeanDire3to4(idxCField)');
        modIntStatsField.pWWMaxPhaseCFieldBefRunvs3to4(i) = circ_wwtest(mod.maxPhaseArrBefRun(idxCField)'/180*pi,mod.maxPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pKMaxPhaseCFieldBefRunvs3to4(i) = circ_ktest(mod.maxPhaseArrBefRun(idxCField)'/180*pi,mod.maxPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pWWMinPhaseCFieldBefRunvs3to4(i) = circ_wwtest(mod.minPhaseArrBefRun(idxCField)'/180*pi,mod.minPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pKMinPhaseCFieldBefRunvs3to4(i) = circ_ktest(mod.minPhaseArrBefRun(idxCField)'/180*pi,mod.minPhaseArr3to4(idxCField)'/180*pi);

        modIntStatsField.pRSThetaModHistCFieldBefRunvs3to4(i) = ranksum(mod.thetaModHistBefRun(idxCField),mod.thetaModHist3to4(idxCField));
        
        modIntStatsField.pRSPhaseMeanResultantLenCFieldBefRunvs3to4(i) = ranksum(mod.phaseMeanResultantLenBefRun(idxCField),mod.phaseMeanResultantLen3to4(idxCField));

        %% 0-1 s vs 3-4 s field recordings
        modIntStatsField.pWWPhaseMeanDireCField0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDire0to1(idxCField)',mod.phaseMeanDire3to4(idxCField)');
        modIntStatsField.pKPhaseMeanDireCField0to1vs3to4(i) = circ_ktest(mod.phaseMeanDire0to1(idxCField)',mod.phaseMeanDire3to4(idxCField)');
        modIntStatsField.pWWPhaseMeanDireHCField0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxCField)',mod.phaseMeanDireH3to4(idxCField)');
        modIntStatsField.pKPhaseMeanDireHCField0to1vs3to4(i) = circ_ktest(mod.phaseMeanDireH0to1(idxCField)',mod.phaseMeanDireH3to4(idxCField)');
        modIntStatsField.pWWMaxPhaseCField0to1vs3to4(i) = circ_wwtest(mod.maxPhaseArr0to1(idxCField)'/180*pi,mod.maxPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pKMaxPhaseCField0to1vs3to4(i) = circ_ktest(mod.maxPhaseArr0to1(idxCField)'/180*pi,mod.maxPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pWWMinPhaseCField0to1vs3to4(i) = circ_wwtest(mod.minPhaseArr0to1(idxCField)'/180*pi,mod.minPhaseArr3to4(idxCField)'/180*pi);
        modIntStatsField.pKMinPhaseCField0to1vs3to4(i) = circ_ktest(mod.minPhaseArr0to1(idxCField)'/180*pi,mod.minPhaseArr3to4(idxCField)'/180*pi);

        modIntStatsField.pRSThetaModHistCField0to1vs3to4(i) = ranksum(mod.thetaModHist0to1(idxCField),mod.thetaModHist3to4(idxCField));
        modIntStatsField.pRSThetaModHistHCField0to1vs3to4(i) = ranksum(mod.thetaModHistH0to1(idxCField),mod.thetaModHistH3to4(idxCField));

        modIntStatsField.pRSPhaseMeanResultantLenCField0to1vs3to4(i) = ranksum(mod.phaseMeanResultantLen0to1(idxCField),mod.phaseMeanResultantLen3to4(idxCField));

        %% 0-1 s vs 3-5 s field recordings
        modIntStatsField.pWWPhaseMeanDireCField0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDire0to1(idxCField)',mod.phaseMeanDire3to5(idxCField)');
        modIntStatsField.pKPhaseMeanDireCField0to1vs3to5(i) = circ_ktest(mod.phaseMeanDire0to1(idxCField)',mod.phaseMeanDire3to5(idxCField)');
        modIntStatsField.pWWPhaseMeanDireHCField0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxCField)',mod.phaseMeanDireH3to5(idxCField)');
        modIntStatsField.pKPhaseMeanDireHCField0to1vs3to5(i) = circ_ktest(mod.phaseMeanDireH0to1(idxCField)',mod.phaseMeanDireH3to5(idxCField)');
        modIntStatsField.pWWMaxPhaseCField0to1vs3to5(i) = circ_wwtest(mod.maxPhaseArr0to1(idxCField)'/180*pi,mod.maxPhaseArr3to5(idxCField)'/180*pi);
        modIntStatsField.pKMaxPhaseCField0to1vs3to5(i) = circ_ktest(mod.maxPhaseArr0to1(idxCField)'/180*pi,mod.maxPhaseArr3to5(idxCField)'/180*pi);
        modIntStatsField.pWWMinPhaseCField0to1vs3to5(i) = circ_wwtest(mod.minPhaseArr0to1(idxCField)'/180*pi,mod.minPhaseArr3to5(idxCField)'/180*pi);
        modIntStatsField.pKMinPhaseCField0to1vs3to5(i) = circ_ktest(mod.minPhaseArr0to1(idxCField)'/180*pi,mod.minPhaseArr3to5(idxCField)'/180*pi);

        modIntStatsField.pRSThetaModHistCField0to1vs3to5(i) = ranksum(mod.thetaModHist0to1(idxCField),mod.thetaModHist3to5(idxCField));
        modIntStatsField.pRSThetaModHistHCField0to1vs3to5(i) = ranksum(mod.thetaModHistH0to1(idxCField),mod.thetaModHistH3to5(idxCField));

        modIntStatsField.pRSPhaseMeanResultantLenCField0to1vs3to5(i) = ranksum(mod.phaseMeanResultantLen0to1(idxCField),mod.phaseMeanResultantLen3to5(idxCField));

        %% 0-1 s vs 3-4 s no field recordings
        idxCNoField = mod.nNeuWithField < 1 & idxC == i;
        modIntStatsField.pWWPhaseMeanDireCNoField0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDire0to1(idxCNoField)',mod.phaseMeanDire3to4(idxCNoField)');
        modIntStatsField.pKPhaseMeanDireCNoField0to1vs3to4(i) = circ_ktest(mod.phaseMeanDire0to1(idxCNoField)',mod.phaseMeanDire3to4(idxCNoField)');
        modIntStatsField.pWWPhaseMeanDireHCNoField0to1vs3to4(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxCNoField)',mod.phaseMeanDireH3to4(idxCNoField)');
        modIntStatsField.pKPhaseMeanDireHCNoField0to1vs3to4(i) = circ_ktest(mod.phaseMeanDireH0to1(idxCNoField)',mod.phaseMeanDireH3to4(idxCNoField)');
        modIntStatsField.pWWMaxPhaseCNoField0to1vs3to4(i) = circ_wwtest(mod.maxPhaseArr0to1(idxCNoField)'/180*pi,mod.maxPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseCNoField0to1vs3to4(i) = circ_ktest(mod.maxPhaseArr0to1(idxCNoField)'/180*pi,mod.maxPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseCNoField0to1vs3to4(i) = circ_wwtest(mod.minPhaseArr0to1(idxCNoField)'/180*pi,mod.minPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseCNoField0to1vs3to4(i) = circ_ktest(mod.minPhaseArr0to1(idxCNoField)'/180*pi,mod.minPhaseArr3to4(idxCNoField)'/180*pi);

        modIntStatsField.pRSThetaModHistCNoField0to1vs3to4(i) = ranksum(mod.thetaModHist0to1(idxCNoField),mod.thetaModHist3to4(idxCNoField));
        modIntStatsField.pRSThetaModHistHCNoField0to1vs3to4(i) = ranksum(mod.thetaModHistH0to1(idxCNoField),mod.thetaModHistH3to4(idxCNoField));

        modIntStatsField.pRSPhaseMeanResultantLenCNoField0to1vs3to4(i) = ranksum(mod.phaseMeanResultantLen0to1(idxCNoField),mod.phaseMeanResultantLen3to4(idxCNoField));

        %% 0-1 s vs 3-5 s no field recordings
        modIntStatsField.pWWPhaseMeanDireCNoField0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDire0to1(idxCNoField)',mod.phaseMeanDire3to5(idxCNoField)');
        modIntStatsField.pKPhaseMeanDireCNoField0to1vs3to5(i) = circ_ktest(mod.phaseMeanDire0to1(idxCNoField)',mod.phaseMeanDire3to5(idxCNoField)');
        modIntStatsField.pWWPhaseMeanDireHCNoField0to1vs3to5(i) = circ_wwtest(mod.phaseMeanDireH0to1(idxCNoField)',mod.phaseMeanDireH3to5(idxCNoField)');
        modIntStatsField.pKPhaseMeanDireHCNoField0to1vs3to5(i) = circ_ktest(mod.phaseMeanDireH0to1(idxCNoField)',mod.phaseMeanDireH3to5(idxCNoField)');
        modIntStatsField.pWWMaxPhaseCNoField0to1vs3to5(i) = circ_wwtest(mod.maxPhaseArr0to1(idxCNoField)'/180*pi,mod.maxPhaseArr3to5(idxCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseCNoField0to1vs3to5(i) = circ_ktest(mod.maxPhaseArr0to1(idxCNoField)'/180*pi,mod.maxPhaseArr3to5(idxCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseCNoField0to1vs3to5(i) = circ_wwtest(mod.minPhaseArr0to1(idxCNoField)'/180*pi,mod.minPhaseArr3to5(idxCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseCNoField0to1vs3to5(i) = circ_ktest(mod.minPhaseArr0to1(idxCNoField)'/180*pi,mod.minPhaseArr3to5(idxCNoField)'/180*pi);

        modIntStatsField.pRSThetaModHistCNoField0to1vs3to5(i) = ranksum(mod.thetaModHist0to1(idxCNoField),mod.thetaModHist3to5(idxCNoField));
        modIntStatsField.pRSThetaModHistHCNoField0to1vs3to5(i) = ranksum(mod.thetaModHistH0to1(idxCNoField),mod.thetaModHistH3to5(idxCNoField));

        modIntStatsField.pRSPhaseMeanResultantLenCNoField0to1vs3to5(i) = ranksum(mod.phaseMeanResultantLen0to1(idxCNoField),mod.phaseMeanResultantLen3to5(idxCNoField));

        %% befRun s vs 3-4 s no field recordings
        modIntStatsField.pWWPhaseMeanDireCNoFieldBefRunvs3to4(i) = circ_wwtest(mod.phaseMeanDireBefRun(idxCNoField)',mod.phaseMeanDire3to4(idxCNoField)');
        modIntStatsField.pKPhaseMeanDireCNoFieldBefRunvs3to4(i) = circ_ktest(mod.phaseMeanDireBefRun(idxCNoField)',mod.phaseMeanDire3to4(idxCNoField)');
        modIntStatsField.pWWMaxPhaseCNoFieldBefRunvs3to4(i) = circ_wwtest(mod.maxPhaseArrBefRun(idxCNoField)'/180*pi,mod.maxPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pKMaxPhaseCNoFieldBefRunvs3to4(i) = circ_ktest(mod.maxPhaseArrBefRun(idxCNoField)'/180*pi,mod.maxPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pWWMinPhaseCNoFieldBefRunvs3to4(i) = circ_wwtest(mod.minPhaseArrBefRun(idxCNoField)'/180*pi,mod.minPhaseArr3to4(idxCNoField)'/180*pi);
        modIntStatsField.pKMinPhaseCNoFieldBefRunvs3to4(i) = circ_ktest(mod.minPhaseArrBefRun(idxCNoField)'/180*pi,mod.minPhaseArr3to4(idxCNoField)'/180*pi);

        modIntStatsField.pRSThetaModHistCNoFieldBefRunvs3to4(i) = ranksum(mod.thetaModHistBefRun(idxCNoField),mod.thetaModHist3to4(idxCNoField));
        
        modIntStatsField.pRSPhaseMeanResultantLenCNoFieldBefRunvs3to4(i) = ranksum(mod.phaseMeanResultantLenBefRun(idxCNoField),mod.phaseMeanResultantLen3to4(idxCNoField));

    end
end