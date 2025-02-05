function PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_ttest()
% perform anova statistical test to compare the firing rate change between
% control and stim trials

    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];

    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']);
    end

    condNum = length(PyrStim1.FRProfile1);

    for cond = 1:condNum

        % compare good non-stim and stim trials rise neurons
        PyrRiseTTest.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad1(PyrRise.FRProfileMean{cond},PyrRise.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials rise neurons
        PyrRiseTTest.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad1(PyrRise.FRProfileMeanStim{cond},PyrRise.FRProfileMeanStimCtrl{cond});

        % compare good non-stim and stim trials down neurons
        PyrDownTTest.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad1(PyrDown.FRProfileMean{cond},PyrDown.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials down neurons
        PyrDownTTest.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad1(PyrDown.FRProfileMeanStim{cond},PyrDown.FRProfileMeanStimCtrl{cond});

        % compare good non-stim and stim trials other neurons
        PyrOtherTTest.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad1(PyrOther.FRProfileMean{cond},PyrOther.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials other neurons
        PyrOtherTTest.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad1(PyrOther.FRProfileMeanStim{cond},PyrOther.FRProfileMeanStimCtrl{cond});
    end
    
    save([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrlTTest.mat'],'PyrRiseTTest','PyrDownTTest','PyrOtherTTest');
end
 
 function FRProfileMeanStatC = accumMeanPVStimStatGoodBad1(FRProfileMean,FRProfileMeanBad)
     
    [~,FRProfileMeanStatC.pRSAll] = ttest2(FRProfileMean.meanAvgFRProfileAll,...
                    FRProfileMeanBad.meanAvgFRProfileAll); % added on 10/28/2023
                
    [~,FRProfileMeanStatC.pRSBLAll] = ttest2(FRProfileMean.meanAvgFRProfileBaseline,...
                    FRProfileMeanBad.meanAvgFRProfileBaseline);
                                
    [~,FRProfileMeanStatC.pRSBefRunAll] = ttest2(FRProfileMean.meanAvgFRProfileBefRun,...
                FRProfileMeanBad.meanAvgFRProfileBefRun);

    [~,FRProfileMeanStatC.pRS3to5All] = ttest2(FRProfileMean.meanAvgFRProfile3to5,...
                FRProfileMeanBad.meanAvgFRProfile3to5);
            
    [~,FRProfileMeanStatC.pRS3to4All] = ttest2(FRProfileMean.meanAvgFRProfile3to4,...
                FRProfileMeanBad.meanAvgFRProfile3to4);

    [~,FRProfileMeanStatC.pRS0to1All] = ttest2(FRProfileMean.meanAvgFRProfile0to1,...
                FRProfileMeanBad.meanAvgFRProfile0to1);
            
    [~,FRProfileMeanStatC.pRS0to1stAll] = ttest2(FRProfileMean.meanAvgFRProfile0to1st,...
                FRProfileMeanBad.meanAvgFRProfile0to1st);

    [~,FRProfileMeanStatC.pRS1to3All] = ttest2(FRProfileMean.meanAvgFRProfile1to3,...
                FRProfileMeanBad.meanAvgFRProfile1to3);
            
    [~,FRProfileMeanStatC.pRS0to3All] = ttest2(FRProfileMean.meanAvgFRProfile0to3,...
                FRProfileMeanBad.meanAvgFRProfile0to3);
            
    [~,FRProfileMeanStatC.pRS0to2All] = ttest2(FRProfileMean.meanAvgFRProfile0to2,...
                FRProfileMeanBad.meanAvgFRProfile0to2); % added on 1/6/2024
            
    close all;
            
 end