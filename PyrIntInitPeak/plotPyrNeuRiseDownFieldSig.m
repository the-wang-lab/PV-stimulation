function plotPyrNeuRiseDownFieldSig(pathAnal,timeStepRun,InitAll,...
            isNeuWithFieldAligned,FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,xlabels)
    
    %% order pyramidal neurons with field based on the peak firing rate after 0
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNorm(InitAll.isNeuWithFieldAligned == 1,:),['FR (Hz)'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuField'],...
            pathAnal,[],5,[],[])
     
    indNeuField = find(InitAll.isNeuWithFieldAligned == 1);
    indIndFieldGood = [];
    indFieldBad = [];
    indFieldGood = [];
    for i = 1:length(indNeuField)
        indTmp = find(InitAll.taskBad == InitAll.task(indNeuField(i)) & ...
            InitAll.indRecBad == InitAll.indRec(indNeuField(i)) & ...
            InitAll.indNeuBad == InitAll.indNeu(indNeuField(i)));
        if(~isempty(indTmp))
            indIndFieldGood = [indIndFieldGood; i];
            indFieldBad = [indFieldBad; indTmp];
            indFieldGood = [indFieldGood; indNeuField(i)];
        end
    end
    indTmp = timeStepRun > 0;
    [~,indMax] = max(InitAll.avgFRProfileNorm(indFieldGood,indTmp)');
    [~,indOrd] = sort(indMax,'descend');
    plotIndFRProfileProvOrder(timeStepRun,...
            InitAll.avgFRProfileNormBad(indFieldBad,:),['FR (Hz) Bad (good order)'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuFieldBad_GoodOrder'],...
            pathAnal,indOrd);
    plotIndFRProfileProvOrder(timeStepRun,...
            InitAll.avgFRProfileNorm(indFieldGood,:),['FR (Hz) (good order)'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuField_BadSelGoodOrder'],...
            pathAnal,indOrd);    
    
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNormBad(InitAll.isNeuWithFieldAlignedBad == 1,:),['FR (Hz) Bad'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuFieldBad'],...
            pathAnal,[],5,[],[])
        
    %% order pyramidal neurons with field based on before and after run FR ratio  
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNorm(InitAll.isNeuWithFieldAligned == 1,:),['FR (Hz)'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuField'],...
            pathAnal,[],4,FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio
        
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNormBad(InitAll.isNeuWithFieldAlignedBad == 1,:),['FR (Hz) Bad'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuFieldBad'],...
            pathAnal,[],4,FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio
    
    %% average profile good vs bad trials
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(isNeuWithFieldAligned.idxRise,:),...
            InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxRiseBadBad,:),...
            ['FR PyrRise Good/Bad Field'],...
            ['Pyr_FRProfilePyrFieldRiseGoodBad'],...
            pathAnal,[0 4],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(isNeuWithFieldAligned.idxDown,:),...
            InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxDownBadBad,:),...
            ['FR PyrDown Good/Bad Field'],...
            ['Pyr_FRProfilePyrFieldDownGoodBad'],...
            pathAnal,[0 4],xlabels)
        
    % added on 7/9/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(isNeuWithFieldAligned.idxOther,:),...
            InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxOtherBadBad,:),...
            ['FR PyrOther Good/Bad Field'],...
            ['Pyr_FRProfilePyrFieldOtherGoodBad'],...
            pathAnal,[0 4],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(isNeuWithFieldAligned.idxRise,:),...
            InitAll.avgFRProfileNormBad(isNeuWithFieldAligned.idxRiseBadBad,:),...
            ['FR Norm PyrRise Good/Bad Field'],...
            ['Pyr_FRProfileNormPyrFieldRiseGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(isNeuWithFieldAligned.idxDown,:),...
            InitAll.avgFRProfileNormBad(isNeuWithFieldAligned.idxDownBadBad,:),...
            ['FR Norm PyrDown Good/Bad Field'],...
            ['Pyr_FRProfileNormPyrFieldDownGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
    % added on 7/9/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(isNeuWithFieldAligned.idxOther,:),...
            InitAll.avgFRProfileNormBad(isNeuWithFieldAligned.idxOtherBadBad,:),...
            ['FR Norm PyrOther Good/Bad Field'],...
            ['Pyr_FRProfileNormPyrFieldOtherGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
        
    % added normalized using z-score
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(isNeuWithFieldAligned.idxRise,:),...
            InitAll.avgFRProfileNormZBad(isNeuWithFieldAligned.idxRiseBadBad,:),...
            ['FR NormZ PyrRise Good/Bad Field'],...
            ['Pyr_FRProfileNormZPyrFieldRiseGoodBad'],...
            pathAnal,[-0.5 3],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(isNeuWithFieldAligned.idxDown,:),...
            InitAll.avgFRProfileNormZBad(isNeuWithFieldAligned.idxDownBadBad,:),...
            ['FR NormZ PyrDown Good/Bad Field'],...
            ['Pyr_FRProfileNormZPyrFieldDownGoodBad'],...
            pathAnal,[-0.5 3],xlabels)
        
    % added on 7/9/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(isNeuWithFieldAligned.idxOther,:),...
            InitAll.avgFRProfileNormZBad(isNeuWithFieldAligned.idxOtherBadBad,:),...
            ['FR NormZ PyrOther Good/Bad Field'],...
            ['Pyr_FRProfileNormZPyrFieldOtherGoodBad'],...
            pathAnal,[-0.5 3],xlabels)
        
    %% FR Change before run vs 0to1s
%     barPlotWithStat1(1:2,...
%             [mean(FRProfileMeanPyr.RiseField.percChangeBefRunVs0to1),...
%             mean(FRProfileMeanPyr.RiseFieldBad.percChangeBefRunVs0to1)],...
%             [std(FRProfileMeanPyr.RiseField.percChangeBefRunVs0to1)...
%                 /sqrt(length(FRProfileMeanPyr.RiseField.percChangeBefRunVs0to1)),...
%             std(FRProfileMeanPyr.RiseFieldBad.percChangeBefRunVs0to1)...
%                 /sqrt(length(FRProfileMeanPyr.RiseFieldBad.percChangeBefRunVs0to1))],...
%             [],...
%             ['average FR change BefRun/0to1s G/B Rise Field'],...
%             '', FRProfileMeanPyrStat.RiseFieldGoodBad.pRSPercChangeBefRunVs0to1All,...
%             ['Pyr_FRChangeBefRun-0to1RiseGoodBadField'],...
%             pathAnal,colorSel,xlabels);
%         
%     barPlotWithStat1(1:2,...
%             [mean(FRProfileMeanPyr.DownField.percChangeBefRunVs0to1),...
%             mean(FRProfileMeanPyr.DownFieldBad.percChangeBefRunVs0to1)],...
%             [std(FRProfileMeanPyr.DownField.percChangeBefRunVs0to1)...
%                 /sqrt(length(FRProfileMeanPyr.DownField.percChangeBefRunVs0to1)),...
%             std(FRProfileMeanPyr.DownFieldBad.percChangeBefRunVs0to1)...
%                 /sqrt(length(FRProfileMeanPyr.DownFieldBad.percChangeBefRunVs0to1))],...
%             [],...
%             ['average FR change BefRun/0to1s G/B Down Field'],...
%             '', FRProfileMeanPyrStat.DownFieldGoodBad.pRSPercChangeBefRunVs0to1All,...
%             ['Pyr_FRChangeBefRun-0to1DownGoodBadField'],...
%             pathAnal,colorSel,xlabels);
        
    %% FR rel Change before run vs 0to1s
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.RiseField.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.RiseFieldBad.relChangeBefRunVs0to1)],...
            [std(FRProfileMeanPyr.RiseField.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.RiseField.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.RiseFieldBad.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.RiseFieldBad.relChangeBefRunVs0to1))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Rise Field'],...
            '', FRProfileMeanPyrStat.RiseFieldGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1RiseGoodBadField'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.DownField.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.DownFieldBad.relChangeBefRunVs0to1)],...
            [std(FRProfileMeanPyr.DownField.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.DownField.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.DownFieldBad.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.DownFieldBad.relChangeBefRunVs0to1))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Down Field'],...
            '', FRProfileMeanPyrStat.DownFieldGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1DownGoodBadField'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
   
    % added on 7/9/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.OtherField.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.OtherFieldBad.relChangeBefRunVs0to1)],...
            [std(FRProfileMeanPyr.OtherField.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.OtherField.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.OtherFieldBad.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.OtherFieldBad.relChangeBefRunVs0to1))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Other Field'],...
            '', FRProfileMeanPyrStat.OtherFieldGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1OtherGoodBadField'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
   
    %% FR between -1 to 4s    
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.RiseField.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.RiseField.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.RiseField.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Rise Field'],...
            '', FRProfileMeanPyrStat.RiseFieldGoodBad.pRSAll,...
            ['Pyr_FRAllRiseGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.DownField.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.DownField.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.DownField.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Down Field'],...
            '', FRProfileMeanPyrStat.DownFieldGoodBad.pRSAll,...
            ['Pyr_FRAllDownGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    % added on 7/9/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.OtherField.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.OtherField.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.OtherField.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Other Field'],...
            '', FRProfileMeanPyrStat.OtherFieldGoodBad.pRSAll,...
            ['Pyr_FRAllOtherGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
            
    %% FR before run
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.RiseField.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.RiseField.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.RiseField.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Rise Field'],...
            '', FRProfileMeanPyrStat.RiseFieldGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunRiseGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.DownField.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.DownField.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.DownField.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Down Field'],...
            '', FRProfileMeanPyrStat.DownFieldGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunDownGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    % added on 7/9/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.OtherField.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.OtherField.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.OtherField.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Other Field'],...
            '', FRProfileMeanPyrStat.OtherFieldGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunOtherGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    %% FR 0 to 1s
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.RiseField.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.RiseField.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.RiseField.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.RiseFieldBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Rise Field'],...
            '', FRProfileMeanPyrStat.RiseFieldGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sRiseGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.DownField.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.DownField.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.DownField.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.DownFieldBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Down Field'],...
            '', FRProfileMeanPyrStat.DownFieldGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sDownGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
        
    % added on 7/9/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.OtherField.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.OtherField.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.OtherField.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.OtherFieldBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Other Field'],...
            '', FRProfileMeanPyrStat.OtherFieldGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sOtherGoodBadField'],...
            pathAnal,colorSel,xlabels,[0 4]);
end