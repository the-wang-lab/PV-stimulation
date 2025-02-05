function FRProfileMeanStatC = accumMeanStatCGoodBadIntInitPeak(FRProfileMean,FRProfileMeanBad,idxC,idxCBad)
    
    numC = max(idxC);
    for i = 1:numC
        idxCI = idxC == i;
        idxCIBad = idxCBad == i;
        FRProfileMeanStatC.pRSBL(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(idxCI),...
                    FRProfileMeanBad.meanAvgFRProfileBaseline(idxCIBad));
                                
        FRProfileMeanStatC.pRSBefRun(i) = ranksum(FRProfileMean.meanAvgFRProfileBefRun(idxCI),...
                    FRProfileMeanBad.meanAvgFRProfileBefRun(idxCIBad));
               
        FRProfileMeanStatC.pRS1to5(i) = ranksum(FRProfileMean.meanAvgFRProfile1to5(idxCI),...
                    FRProfileMeanBad.meanAvgFRProfile1to5(idxCIBad));
               
        FRProfileMeanStatC.pRS0to1(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(idxCI),...
                    FRProfileMeanBad.meanAvgFRProfile0to1(idxCIBad));
                
        % perc change from 0-1 s to baseline
        FRProfileMeanStatC.pRSPercChange0to1VsBL(i) = ranksum(FRProfileMean.percChange0to1VsBL(idxCI),...
                    FRProfileMeanBad.percChange0to1VsBL(idxCIBad));

        % perc change -1- -0.5 s to baseline
        FRProfileMeanStatC.pRSPercChangeBefRunVsBL(i) = ranksum(FRProfileMean.percChangeBefRunVsBL(idxCI),...
                    FRProfileMeanBad.percChangeBefRunVsBL(idxCIBad));

        % perc change 0-1 s to -1- -0.5 s 
        FRProfileMeanStatC.pRSPercChange0to1VsBefRun(i) = ranksum(FRProfileMean.percChange0to1VsBefRun(idxCI),...
                    FRProfileMeanBad.percChange0to1VsBefRun(idxCIBad));

        % perc change from 0-1 s to 1-5s
        FRProfileMeanStatC.pRSPercChange0to1Vs1to5(i) = ranksum(FRProfileMean.percChange0to1Vs1to5(idxCI),...
                    FRProfileMeanBad.percChange0to1Vs1to5(idxCIBad));

        % perc change -1- -0.5 s to 1-5s
        FRProfileMeanStatC.pRSPercChangeBefRunVs1to5(i) = ranksum(FRProfileMean.percChangeBefRunVs1to5(idxCI),...
                    FRProfileMeanBad.percChangeBefRunVs1to5(idxCIBad));
        
    end
end
