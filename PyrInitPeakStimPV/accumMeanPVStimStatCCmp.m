function FRProfileMeanStatC = accumMeanPVStimStatCCmp(FRProfileMean,idxC)
    
    idxC1 = idxC == 1;
    idxC2 = idxC == 2;
        
    FRProfileMeanStatC.pRSPercChange0to1VsBLC = ...
        ranksum(FRProfileMean.percChange0to1VsBL(idxC1),...
        FRProfileMean.percChange0to1VsBL(idxC2));

    FRProfileMeanStatC.pRSPercChangeBefRunVsBLC = ...
        ranksum(FRProfileMean.percChangeBefRunVsBL(idxC1),...
        FRProfileMean.percChangeBefRunVsBL(idxC2));
    
    FRProfileMeanStatC.pRSPercChangeBefRunVs0to1C = ...
        ranksum(FRProfileMean.percChangeBefRunVs0to1(idxC1),...
        FRProfileMean.percChangeBefRunVs0to1(idxC2));

    FRProfileMeanStatC.pRSPercChange0to1Vs3to5C = ...
        ranksum(FRProfileMean.percChange0to1Vs3to5(idxC1),...
        FRProfileMean.percChange0to1Vs3to5(idxC2));

    FRProfileMeanStatC.pRSPercChangeBefRunVs3to5C = ...
        ranksum(FRProfileMean.percChangeBefRunVs3to5(idxC1),...
        FRProfileMean.percChangeBefRunVs3to5(idxC2));

end