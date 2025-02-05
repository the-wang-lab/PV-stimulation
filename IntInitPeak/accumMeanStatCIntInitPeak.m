function FRProfileMeanStatC = accumMeanStatCIntInitPeak(FRProfileMean,idxC,nNeuWithField)
    
    numC = max(idxC);
    for i = 1:numC
        idxCI = idxC == i;
        indCurCField = idxC == i & nNeuWithField >= 2;
        indCurCNoField = idxC == i & nNeuWithField < 1;
        FRProfileMeanStatC.pRS0to1VsBL(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(idxCI),...
                    FRProfileMean.meanAvgFRProfile0to1(idxCI));
        FRProfileMeanStatC.pRS0to1VsBLField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                    FRProfileMean.meanAvgFRProfile0to1(indCurCField));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRS0to1VsBLNoField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                        FRProfileMean.meanAvgFRProfile0to1(indCurCNoField));    
        else
            FRProfileMeanStatC.pRS0to1VsBLNoField(i) = -1;
        end
                            
        FRProfileMeanStatC.pRSBefRunVsBL(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(idxCI),...
                    FRProfileMean.meanAvgFRProfileBefRun(idxCI));
        FRProfileMeanStatC.pRSBefRunVsBLField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                    FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRSBefRunVsBLNoField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                    FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));
        else
            FRProfileMeanStatC.pRSBefRunVsBLNoField(i) = -1;
        end
                
        FRProfileMeanStatC.pRS1to5VsBL(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(idxCI),...
                    FRProfileMean.meanAvgFRProfile1to5(idxCI));
        FRProfileMeanStatC.pRS1to5VsBLField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCField));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRS1to5VsBLNoField(i) = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCNoField));
        else
            FRProfileMeanStatC.pRS1to5VsBLNoField(i) = -1;
        end
                
        FRProfileMeanStatC.pRS0to1VsBefRun(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(idxCI),...
                    FRProfileMean.meanAvgFRProfileBefRun(idxCI));
        FRProfileMeanStatC.pRS0to1VsBefRunField(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                    FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
        if(sum(indCurCNoField) > 0)        
            FRProfileMeanStatC.pRS0to1VsBefRunNoField(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                    FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));
        else
            FRProfileMeanStatC.pRS0to1VsBefRunNoField(i) = -1;
        end
                
        FRProfileMeanStatC.pRS1to5Vs0to1(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(idxCI),...
                    FRProfileMean.meanAvgFRProfile1to5(idxCI));
        FRProfileMeanStatC.pRS1to5Vs0to1Field(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCField));
        if(sum(indCurCNoField) > 0) 
            FRProfileMeanStatC.pRS1to5Vs0to1NoField(i) = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCNoField));
        else
            FRProfileMeanStatC.pRS1to5Vs0to1NoField(i) = -1;
        end
                
        FRProfileMeanStatC.pRS1to5VsBefRun(i) = ranksum(FRProfileMean.meanAvgFRProfileBefRun(idxCI),...
                    FRProfileMean.meanAvgFRProfile1to5(idxCI));
        FRProfileMeanStatC.pRS1to5VsBefRunField(i) = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCField));
        if(sum(indCurCNoField) > 0) 
            FRProfileMeanStatC.pRS1to5VsBefRunNoField(i) = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField),...
                    FRProfileMean.meanAvgFRProfile1to5(indCurCNoField));
        else
            FRProfileMeanStatC.pRS1to5VsBefRunNoField(i) = -1;
        end        
                
        FRProfileMeanStatC.pTTPercChange0to1VsBL(i) = ttest(FRProfileMean.percChange0to1VsBL(idxCI));
        if(sum(indCurCNoField) > 0) 
            FRProfileMeanStatC.pRSPercChange0to1VsBLFieldVsNoField(i) = ...
                ranksum(FRProfileMean.percChange0to1VsBL(indCurCField),...
                FRProfileMean.percChange0to1VsBL(indCurCNoField));
        else
            FRProfileMeanStatC.pRSPercChange0to1VsBLFieldVsNoField(i) = -1;
        end  
        
        FRProfileMeanStatC.pTTPercChangeBefRunVsBL(i) = ttest(FRProfileMean.percChangeBefRunVsBL(idxCI));
        if(sum(indCurCNoField) > 0) 
            FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldVsNoField(i) = ...
                ranksum(FRProfileMean.percChangeBefRunVsBL(indCurCField),...
                FRProfileMean.percChangeBefRunVsBL(indCurCNoField));
        else
            FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldVsNoField(i) = -1;
        end
        
        FRProfileMeanStatC.pTTPercChange0to1VsBefRun(i) = ttest(FRProfileMean.percChange0to1VsBefRun(idxCI));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRSPercChange0to1VsBefRunFieldVsNoField(i) = ...
                ranksum(FRProfileMean.percChange0to1VsBefRun(indCurCField),...
                FRProfileMean.percChange0to1VsBefRun(indCurCNoField));
        else
            FRProfileMeanStatC.pRSPercChange0to1VsBefRunFieldVsNoField(i) = -1;
        end
        
        FRProfileMeanStatC.pTTPercChange0to1Vs1to5(i) = ttest(FRProfileMean.percChange0to1Vs1to5(idxCI));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRSPercChange0to1Vs1to5FieldVsNoField(i) = ...
                ranksum(FRProfileMean.percChange0to1Vs1to5(indCurCField),...
                FRProfileMean.percChange0to1Vs1to5(indCurCNoField));
        else
            FRProfileMeanStatC.pRSPercChange0to1Vs1to5FieldVsNoField(i) = -1;
        end
        
        FRProfileMeanStatC.pTTPercChangeBefRunVs1to5(i) = ttest(FRProfileMean.percChangeBefRunVs1to5(idxCI));
        if(sum(indCurCNoField) > 0)
            FRProfileMeanStatC.pRSPercChangeBefRunVs1to5FieldVsNoField(i) = ...
                ranksum(FRProfileMean.percChangeBefRunVs1to5(indCurCField),...
                FRProfileMean.percChangeBefRunVs1to5(indCurCNoField));
        else
            FRProfileMeanStatC.pRSPercChangeBefRunVs1to5FieldVsNoField(i) = -1;
        end
    end
end