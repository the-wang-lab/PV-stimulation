function FRProfileMeanStatC = accumMeanPVStimStatCGoodBad(FRProfileMean,FRProfileMeanBad,idxC,idxCBad)
    
    numC = max(idxC);
    for i = 1:numC
        idxCI = idxC == i;
        idxCIBad = idxCBad == i;
        if(sum(idxCI) ~= 0 && sum(idxCIBad) ~= 0)
            FRProfileMeanStatC.pRSBL(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(idxCI),...
                        FRProfileMeanBad.meanAvgFRProfileBaseline(idxCIBad));

            FRProfileMeanStatC.pRSBefRun(i) = ranksum(FRProfileMean.meanAvgFRProfileBefRun(idxCI),...
                        FRProfileMeanBad.meanAvgFRProfileBefRun(idxCIBad));

            FRProfileMeanStatC.pRS3to5(i) = ranksum(FRProfileMean.meanAvgFRProfile3to5(idxCI),...
                        FRProfileMeanBad.meanAvgFRProfile3to5(idxCIBad));

            FRProfileMeanStatC.pRS0to1(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(idxCI),...
                        FRProfileMeanBad.meanAvgFRProfile0to1(idxCIBad));

            % perc change from 0.5-1.5 s to baseline
            FRProfileMeanStatC.pRSPercChange0to1VsBL(i) = ranksum(FRProfileMean.percChange0to1VsBL(idxCI),...
                        FRProfileMeanBad.percChange0to1VsBL(idxCIBad));

            % perc change -1.5- -0.5 s to baseline
            FRProfileMeanStatC.pRSPercChangeBefRunVsBL(i) = ranksum(FRProfileMean.percChangeBefRunVsBL(idxCI),...
                        FRProfileMeanBad.percChangeBefRunVsBL(idxCIBad));

            % perc change 0.5-1.5 s to -1.5- -0.5 s 
            FRProfileMeanStatC.pRSPercChangeBefRunVs0to1(i) = ranksum(FRProfileMean.percChangeBefRunVs0to1(idxCI),...
                        FRProfileMeanBad.percChangeBefRunVs0to1(idxCIBad));

            % perc change from 0.5-1.5 s to 3-5s
            FRProfileMeanStatC.pRSPercChange0to1Vs3to5(i) = ranksum(FRProfileMean.percChange0to1Vs3to5(idxCI),...
                        FRProfileMeanBad.percChange0to1Vs3to5(idxCIBad));

            % perc change -1.5- -0.5 s to 3-5s
            FRProfileMeanStatC.pRSPercChangeBefRunVs3to5(i) = ranksum(FRProfileMean.percChangeBefRunVs3to5(idxCI),...
                        FRProfileMeanBad.percChangeBefRunVs3to5(idxCIBad));
        else
            FRProfileMeanStatC.pRSBL(i) = -1;

            FRProfileMeanStatC.pRSBefRun(i) = -1;

            FRProfileMeanStatC.pRS3to5(i) = -1;

            FRProfileMeanStatC.pRS0to1(i) = -1;

            % perc change from 0.5-1.5 s to baseline
            FRProfileMeanStatC.pRSPercChange0to1VsBL(i) = -1;

            % perc change -1.5- -0.5 s to baseline
            FRProfileMeanStatC.pRSPercChangeBefRunVsBL(i) = -1;

            % perc change 0.5-1.5 s to -1.5- -0.5 s 
            FRProfileMeanStatC.pRSPercChangeBefRunVs0to1(i) = -1;

            % perc change from 0.5-1.5 s to 3-5s
            FRProfileMeanStatC.pRSPercChange0to1Vs3to5(i) = -1;

            % perc change -1.5- -0.5 s to 3-5s
            FRProfileMeanStatC.pRSPercChangeBefRunVs3to5(i) = -1;
        end
        
    end
    
    FRProfileMeanStatC.pRSBLAll = ranksum(FRProfileMean.meanAvgFRProfileBaseline,...
                    FRProfileMeanBad.meanAvgFRProfileBaseline);
                                
    FRProfileMeanStatC.pRSBefRunAll = ranksum(FRProfileMean.meanAvgFRProfileBefRun,...
                FRProfileMeanBad.meanAvgFRProfileBefRun);

    FRProfileMeanStatC.pRS3to5All = ranksum(FRProfileMean.meanAvgFRProfile3to5,...
                FRProfileMeanBad.meanAvgFRProfile3to5);

    FRProfileMeanStatC.pRS0to1All = ranksum(FRProfileMean.meanAvgFRProfile0to1,...
                FRProfileMeanBad.meanAvgFRProfile0to1);

    % perc change from 0.5-1.5 s to baseline
    FRProfileMeanStatC.pRSPercChange0to1VsBLAll = ranksum(FRProfileMean.percChange0to1VsBL,...
                FRProfileMeanBad.percChange0to1VsBL);

    % perc change -1.5- -0.5 s to baseline
    FRProfileMeanStatC.pRSPercChangeBefRunVsBLAll = ranksum(FRProfileMean.percChangeBefRunVsBL,...
                FRProfileMeanBad.percChangeBefRunVsBL);

    % perc change 0.5-1.5 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pRSPercChangeBefRunVs0to1All = ranksum(FRProfileMean.percChangeBefRunVs0to1,...
                FRProfileMeanBad.percChangeBefRunVs0to1);

    % perc change from 0.5-1.5 s to 3-5s
    FRProfileMeanStatC.pRSPercChange0to1Vs3to5All = ranksum(FRProfileMean.percChange0to1Vs3to5,...
                FRProfileMeanBad.percChange0to1Vs3to5);

    % perc change -1.5- -0.5 s to 3-5s
    FRProfileMeanStatC.pRSPercChangeBefRunVs3to5All = ranksum(FRProfileMean.percChangeBefRunVs3to5,...
                FRProfileMeanBad.percChangeBefRunVs3to5);
end