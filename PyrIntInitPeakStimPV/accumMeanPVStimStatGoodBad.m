function FRProfileMeanStatC = accumMeanPVStimStatGoodBad(FRProfileMean,FRProfileMeanBad)
       
    FRProfileMeanStatC.pRSAll = ranksum(FRProfileMean.meanAvgFRProfileAll,...
                    FRProfileMeanBad.meanAvgFRProfileAll); % added on 10/28/2023
                
    FRProfileMeanStatC.pRSBLAll = ranksum(FRProfileMean.meanAvgFRProfileBaseline,...
                    FRProfileMeanBad.meanAvgFRProfileBaseline);
                                
    FRProfileMeanStatC.pRSBefRunAll = ranksum(FRProfileMean.meanAvgFRProfileBefRun,...
                FRProfileMeanBad.meanAvgFRProfileBefRun);

    FRProfileMeanStatC.pRS3to5All = ranksum(FRProfileMean.meanAvgFRProfile3to5,...
                FRProfileMeanBad.meanAvgFRProfile3to5);
            
    FRProfileMeanStatC.pRS3to4All = ranksum(FRProfileMean.meanAvgFRProfile3to4,...
                FRProfileMeanBad.meanAvgFRProfile3to4);

    FRProfileMeanStatC.pRS0to1All = ranksum(FRProfileMean.meanAvgFRProfile0to1,...
                FRProfileMeanBad.meanAvgFRProfile0to1);
            
    FRProfileMeanStatC.pRS0to1stAll = ranksum(FRProfileMean.meanAvgFRProfile0to1st,...
                FRProfileMeanBad.meanAvgFRProfile0to1st);

    FRProfileMeanStatC.pRS1to3All = ranksum(FRProfileMean.meanAvgFRProfile1to3,...
                FRProfileMeanBad.meanAvgFRProfile1to3);
            
    FRProfileMeanStatC.pRS0to3All = ranksum(FRProfileMean.meanAvgFRProfile0to3,...
                FRProfileMeanBad.meanAvgFRProfile0to3);
            
    FRProfileMeanStatC.pRS0to2All = ranksum(FRProfileMean.meanAvgFRProfile0to2,...
                FRProfileMeanBad.meanAvgFRProfile0to2); % added on 1/6/2024
            
    FRProfileMeanStatC.pSignRAll = signrank(FRProfileMean.meanAvgFRProfileAll,...
                    FRProfileMeanBad.meanAvgFRProfileAll); % added on 10/28/2023
                
    FRProfileMeanStatC.pSignRBLAll = signrank(FRProfileMean.meanAvgFRProfileBaseline,...
                    FRProfileMeanBad.meanAvgFRProfileBaseline);
                                
    FRProfileMeanStatC.pSignRBefRunAll = signrank(FRProfileMean.meanAvgFRProfileBefRun,...
                FRProfileMeanBad.meanAvgFRProfileBefRun);

    FRProfileMeanStatC.pSignR3to5All = signrank(FRProfileMean.meanAvgFRProfile3to5,...
                FRProfileMeanBad.meanAvgFRProfile3to5);
            
    FRProfileMeanStatC.pSignR3to4All = signrank(FRProfileMean.meanAvgFRProfile3to4,...
                FRProfileMeanBad.meanAvgFRProfile3to4);

    FRProfileMeanStatC.pSignR0to1All = signrank(FRProfileMean.meanAvgFRProfile0to1,...
                FRProfileMeanBad.meanAvgFRProfile0to1);
            
    FRProfileMeanStatC.pSignR0to1stAll = signrank(FRProfileMean.meanAvgFRProfile0to1st,...
                FRProfileMeanBad.meanAvgFRProfile0to1st);

    FRProfileMeanStatC.pSignR1to3All = signrank(FRProfileMean.meanAvgFRProfile1to3,...
                FRProfileMeanBad.meanAvgFRProfile1to3);
            
    FRProfileMeanStatC.pSignR0to3All = signrank(FRProfileMean.meanAvgFRProfile0to3,...
                FRProfileMeanBad.meanAvgFRProfile0to3);
            
    FRProfileMeanStatC.pSignR0to2All = signrank(FRProfileMean.meanAvgFRProfile0to2,...
                FRProfileMeanBad.meanAvgFRProfile0to2); % added on 1/6/2024

    % perc change from 0.5-1.5 s to baseline
    FRProfileMeanStatC.pRSPercChange0to1VsBLAll = ranksum(FRProfileMean.percChange0to1VsBL,...
                FRProfileMeanBad.percChange0to1VsBL);

    % perc change -1.5- -0.5 s to baseline
    FRProfileMeanStatC.pRSPercChangeBefRunVsBLAll = ranksum(FRProfileMean.percChangeBefRunVsBL,...
                FRProfileMeanBad.percChangeBefRunVsBL);

    % perc change 0.5-1.5 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pRSPercChangeBefRunVs0to1All = ranksum(FRProfileMean.percChangeBefRunVs0to1,...
                FRProfileMeanBad.percChangeBefRunVs0to1);
            
    % perc change 1.5-3 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pRSPercChangeBefRunVs1to3All = ranksum(FRProfileMean.percChangeBefRunVs1to3,...
                FRProfileMeanBad.percChangeBefRunVs1to3);
            
    % perc change 1.5-3 s to 0.5-1.5 s 
    FRProfileMeanStatC.pRSPercChange0to1Vs1to3All = ranksum(FRProfileMean.percChange0to1Vs1to3,...
                FRProfileMeanBad.percChange0to1Vs1to3);

    % perc change from 0.5-1.5 s to 3-5s
    FRProfileMeanStatC.pRSPercChange0to1Vs3to5All = ranksum(FRProfileMean.percChange0to1Vs3to5,...
                FRProfileMeanBad.percChange0to1Vs3to5);

    % perc change -1.5- -0.5 s to 3-5s
    FRProfileMeanStatC.pRSPercChangeBefRunVs3to5All = ranksum(FRProfileMean.percChangeBefRunVs3to5,...
                FRProfileMeanBad.percChangeBefRunVs3to5);
            
    %% relative change
    % relative change from 0.5-1.5 s to baseline
    FRProfileMeanStatC.pRSRelChange0to1VsBLAll = ranksum(FRProfileMean.relChange0to1VsBL,...
                FRProfileMeanBad.relChange0to1VsBL);

    % relative change -1.5- -0.5 s to baseline
    FRProfileMeanStatC.pRSRelChangeBefRunVsBLAll = ranksum(FRProfileMean.relChangeBefRunVsBL,...
                FRProfileMeanBad.relChangeBefRunVsBL);

    % relative change 0.5-1.5 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pRSRelChangeBefRunVs0to1All = ranksum(FRProfileMean.relChangeBefRunVs0to1,...
                FRProfileMeanBad.relChangeBefRunVs0to1);
            
    % relative change 1.5-3 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pRSRelChangeBefRunVs1to3All = ranksum(FRProfileMean.relChangeBefRunVs1to3,...
                FRProfileMeanBad.relChangeBefRunVs1to3);
            
    % relative change 1.5-3 s to 0.5-1.5 s 
    FRProfileMeanStatC.pRSRelChange0to1Vs1to3All = ranksum(FRProfileMean.relChange0to1Vs1to3,...
                FRProfileMeanBad.relChange0to1Vs1to3);

    % relative change from 0.5-1.5 s to 3-5s
    FRProfileMeanStatC.pRSRelChange0to1Vs3to5All = ranksum(FRProfileMean.relChange0to1Vs3to5,...
                FRProfileMeanBad.relChange0to1Vs3to5);

    % relative change -1.5- -0.5 s to 3-5s
    FRProfileMeanStatC.pRSRelChangeBefRunVs3to5All = ranksum(FRProfileMean.relChangeBefRunVs3to5,...
                FRProfileMeanBad.relChangeBefRunVs3to5);
            
    %% sign rank
    % relative change from 0.5-1.5 s to baseline
    FRProfileMeanStatC.pSignRRelChange0to1VsBLAll = signrank(FRProfileMean.relChange0to1VsBL,...
                FRProfileMeanBad.relChange0to1VsBL);

    % relative change -1.5- -0.5 s to baseline
    FRProfileMeanStatC.pSignRRelChangeBefRunVsBLAll = signrank(FRProfileMean.relChangeBefRunVsBL,...
                FRProfileMeanBad.relChangeBefRunVsBL);

    % relative change 0.5-1.5 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pSignRRelChangeBefRunVs0to1All = signrank(FRProfileMean.relChangeBefRunVs0to1,...
                FRProfileMeanBad.relChangeBefRunVs0to1);
            
    % relative change 1.5-3 s to -1.5- -0.5 s 
    FRProfileMeanStatC.pSignRRelChangeBefRunVs1to3All = signrank(FRProfileMean.relChangeBefRunVs1to3,...
                FRProfileMeanBad.relChangeBefRunVs1to3);
            
    % relative change 1.5-3 s to 0.5-1.5 s 
    FRProfileMeanStatC.pSignRRelChange0to1Vs1to3All = signrank(FRProfileMean.relChange0to1Vs1to3,...
                FRProfileMeanBad.relChange0to1Vs1to3);

    % relative change from 0.5-1.5 s to 3-5s
    FRProfileMeanStatC.pSignRRelChange0to1Vs3to5All = signrank(FRProfileMean.relChange0to1Vs3to5,...
                FRProfileMeanBad.relChange0to1Vs3to5);

    % relative change -1.5- -0.5 s to 3-5s
    FRProfileMeanStatC.pSignRRelChangeBefRunVs3to5All = signrank(FRProfileMean.relChangeBefRunVs3to5,...
                FRProfileMeanBad.relChangeBefRunVs3to5);
end