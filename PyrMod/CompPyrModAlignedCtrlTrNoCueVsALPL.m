function CompPyrModAlignedCtrlTrNoCueVsALPL()
%% compare No cue vs ALPL recordings for good trials over distance
%% run this after running PyrModAllRec_CtrlTr()

    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(exist([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat']))
        load([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat']);
    end
    
    noCueVsALPL.ALPLIsNeuWithField = [modPyr1AL_CtrlTr.isNeuWithFieldGood, modPyr1PL_CtrlTr.isNeuWithFieldGood];
    
    noCueVsALPL.noCueMeanCorrTRunNZ = modPyr1NoCue_CtrlTr.meanCorrTRunNZ;
    noCueVsALPL.noCueMeanCorrTRunNZ1 = noCueVsALPL.noCueMeanCorrTRunNZ...
        (~isnan(noCueVsALPL.noCueMeanCorrTRunNZ));
    noCueVsALPL.ALPLMeanCorrTRunNZ = [modPyr1AL_CtrlTr.meanCorrTRunNZ, modPyr1PL_CtrlTr.meanCorrTRunNZ];
    noCueVsALPL.ALPLMeanCorrTRunNZ1 = noCueVsALPL.ALPLMeanCorrTRunNZ...
        (~isnan(noCueVsALPL.ALPLMeanCorrTRunNZ));
    noCueVsALPL.pRSMeanCorrTRunNZ = ranksum(noCueVsALPL.noCueMeanCorrTRunNZ,...
        noCueVsALPL.ALPLMeanCorrTRunNZ); 
    noCueVsALPL.ALPLMeanCorrTRunNZField = noCueVsALPL.ALPLMeanCorrTRunNZ(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.noCueMeanCorrTRewNZ = modPyr1NoCue_CtrlTr.meanCorrTRewNZ;
    noCueVsALPL.noCueMeanCorrTRewNZ1 = noCueVsALPL.noCueMeanCorrTRewNZ...
        (~isnan(noCueVsALPL.noCueMeanCorrTRewNZ));
    noCueVsALPL.ALPLMeanCorrTRewNZ = [modPyr1AL_CtrlTr.meanCorrTRewNZ, modPyr1PL_CtrlTr.meanCorrTRewNZ];
    noCueVsALPL.ALPLMeanCorrTRewNZ1 = noCueVsALPL.ALPLMeanCorrTRewNZ...
        (~isnan(noCueVsALPL.ALPLMeanCorrTRewNZ));
    noCueVsALPL.pRSMeanCorrTRewNZ = ranksum(noCueVsALPL.noCueMeanCorrTRewNZ,...
        noCueVsALPL.ALPLMeanCorrTRewNZ);
    noCueVsALPL.ALPLMeanCorrTRewNZField = noCueVsALPL.ALPLMeanCorrTRewNZ(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.noCueMeanCorrTCueNZ = modPyr1NoCue_CtrlTr.meanCorrTCueNZ;
    noCueVsALPL.noCueMeanCorrTCueNZ1 = noCueVsALPL.noCueMeanCorrTCueNZ...
        (~isnan(noCueVsALPL.noCueMeanCorrTCueNZ));
    noCueVsALPL.ALPLMeanCorrTCueNZ = [modPyr1AL_CtrlTr.meanCorrTCueNZ, modPyr1PL_CtrlTr.meanCorrTCueNZ];
    noCueVsALPL.ALPLMeanCorrTCueNZ1 = noCueVsALPL.ALPLMeanCorrTCueNZ...
        (~isnan(noCueVsALPL.ALPLMeanCorrTCueNZ));
    noCueVsALPL.pRSMeanCorrTCueNZ = ranksum(noCueVsALPL.noCueMeanCorrTCueNZ,...
        noCueVsALPL.ALPLMeanCorrTCueNZ);
    noCueVsALPL.ALPLMeanCorrTCueNZField = noCueVsALPL.ALPLMeanCorrTCueNZ(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.pRSMeanCorrTRunRewNZ = ranksum(noCueVsALPL.ALPLMeanCorrTRunNZ,...
        noCueVsALPL.ALPLMeanCorrTRewNZ);
    noCueVsALPL.pRSMeanCorrTRunCueNZ = ranksum(noCueVsALPL.ALPLMeanCorrTRunNZ,...
        noCueVsALPL.ALPLMeanCorrTCueNZ);
    
    noCueVsALPL.pRSMeanCorrTRunRewNZField = ranksum(noCueVsALPL.ALPLMeanCorrTRunNZField,...
        noCueVsALPL.ALPLMeanCorrTRewNZField);
    noCueVsALPL.pRSMeanCorrTRunCueNZField = ranksum(noCueVsALPL.ALPLMeanCorrTRunNZField,...
        noCueVsALPL.ALPLMeanCorrTCueNZField);
    
    noCueVsALPL.noCueAdaptSpatialInfo = modPyr1NoCue_CtrlTr.adaptSpatialInfo;
    noCueVsALPL.noCueAdaptSpatialInfo1 = noCueVsALPL.noCueAdaptSpatialInfo...
        (~isnan(noCueVsALPL.noCueAdaptSpatialInfo));
    noCueVsALPL.ALPLAdaptSpatialInfo = [modPyr1AL_CtrlTr.adaptSpatialInfo, modPyr1PL_CtrlTr.adaptSpatialInfo];
    noCueVsALPL.ALPLAdaptSpatialInfo1 = noCueVsALPL.ALPLAdaptSpatialInfo...
        (~isnan(noCueVsALPL.ALPLAdaptSpatialInfo));
    noCueVsALPL.pRSAdaptSpatialInfo = ranksum(noCueVsALPL.noCueAdaptSpatialInfo,...
        noCueVsALPL.ALPLAdaptSpatialInfo);
    noCueVsALPL.ALPLAdaptSpatialInfoField = noCueVsALPL.ALPLAdaptSpatialInfo(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    % added on 7/21/2022
    noCueVsALPL.noCueSpatialInfo = modPyr1NoCue_CtrlTr.spatialInfo;
    noCueVsALPL.noCueSpatialInfo1 = noCueVsALPL.noCueSpatialInfo...
        (~isnan(noCueVsALPL.noCueSpatialInfo));
    noCueVsALPL.ALPLSpatialInfo = [modPyr1AL_CtrlTr.spatialInfo, modPyr1PL_CtrlTr.spatialInfo];
    noCueVsALPL.ALPLSpatialInfo1 = noCueVsALPL.ALPLSpatialInfo...
        (~isnan(noCueVsALPL.ALPLSpatialInfo));
    noCueVsALPL.pRSSpatialInfo = ranksum(noCueVsALPL.noCueSpatialInfo,...
        noCueVsALPL.ALPLSpatialInfo);
    noCueVsALPL.ALPLSpatialInfoField = noCueVsALPL.ALPLSpatialInfo(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.noCueSparsity = modPyr1NoCue_CtrlTr.sparsity;
    noCueVsALPL.noCueSparsity1 = noCueVsALPL.noCueSparsity...
        (~isnan(noCueVsALPL.noCueSparsity));
    noCueVsALPL.ALPLSparsity = [modPyr1AL_CtrlTr.sparsity, modPyr1PL_CtrlTr.sparsity];
    noCueVsALPL.ALPLSparsity1 = noCueVsALPL.ALPLSparsity...
        (~isnan(noCueVsALPL.ALPLSparsity));
    noCueVsALPL.pRSSparsity = ranksum(noCueVsALPL.noCueSparsity,...
        noCueVsALPL.ALPLSparsity);
    noCueVsALPL.ALPLSparsityField = noCueVsALPL.ALPLSparsity(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.noCueAdaptSpatialInfoCue = modPyr1NoCue_CtrlTr.adaptSpatialInfoCue;
    noCueVsALPL.noCueAdaptSpatialInfoCue1 = noCueVsALPL.noCueAdaptSpatialInfoCue...
        (~isnan(noCueVsALPL.noCueAdaptSpatialInfoCue));
    noCueVsALPL.ALPLAdaptSpatialInfoCue = [modPyr1AL_CtrlTr.adaptSpatialInfoCue, modPyr1PL_CtrlTr.adaptSpatialInfoCue];
    noCueVsALPL.ALPLAdaptSpatialInfoCue1 = noCueVsALPL.ALPLAdaptSpatialInfoCue...
        (~isnan(noCueVsALPL.ALPLAdaptSpatialInfoCue));
    noCueVsALPL.pRSAdaptSpatialInfoCue = ranksum(noCueVsALPL.noCueAdaptSpatialInfoCue,...
        noCueVsALPL.ALPLAdaptSpatialInfoCue);
    noCueVsALPL.ALPLAdaptSpatialInfoCueField = noCueVsALPL.ALPLAdaptSpatialInfoCue(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    % added on 7/22/2022
    noCueVsALPL.noCueSpatialInfoCue = modPyr1NoCue_CtrlTr.spatialInfoCue;
    noCueVsALPL.noCueSpatialInfoCue1 = noCueVsALPL.noCueSpatialInfoCue...
        (~isnan(noCueVsALPL.noCueSpatialInfoCue));
    noCueVsALPL.ALPLSpatialInfoCue = [modPyr1AL_CtrlTr.spatialInfoCue, modPyr1PL_CtrlTr.spatialInfoCue];
    noCueVsALPL.ALPLSpatialInfoCue1 = noCueVsALPL.ALPLSpatialInfoCue...
        (~isnan(noCueVsALPL.ALPLSpatialInfoCue));
    noCueVsALPL.pRSSpatialInfoCue = ranksum(noCueVsALPL.noCueSpatialInfoCue,...
        noCueVsALPL.ALPLSpatialInfoCue);
    noCueVsALPL.ALPLSpatialInfoCueField = noCueVsALPL.ALPLSpatialInfoCue(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.noCueSparsityCue = modPyr1NoCue_CtrlTr.sparsityCue;
    noCueVsALPL.noCueSparsityCue1 = noCueVsALPL.noCueSparsityCue...
        (~isnan(noCueVsALPL.noCueSparsityCue));
    noCueVsALPL.ALPLSparsityCue = [modPyr1AL_CtrlTr.sparsityCue, modPyr1PL_CtrlTr.sparsityCue];
    noCueVsALPL.ALPLSparsityCue1 = noCueVsALPL.ALPLSparsityCue...
        (~isnan(noCueVsALPL.ALPLSparsityCue));
    noCueVsALPL.pRSSparsityCue = ranksum(noCueVsALPL.noCueSparsityCue,...
        noCueVsALPL.ALPLSparsityCue);
    noCueVsALPL.ALPLSparsityCueField = noCueVsALPL.ALPLSparsityCue(noCueVsALPL.ALPLIsNeuWithField == 1);
    
    noCueVsALPL.pRSAdaptSpatialInfoRunCue = ranksum(noCueVsALPL.ALPLAdaptSpatialInfo,...
        noCueVsALPL.ALPLAdaptSpatialInfoCue);
    noCueVsALPL.pRSSpatialInfoRunCue = ranksum(noCueVsALPL.ALPLSpatialInfo,...
        noCueVsALPL.ALPLSpatialInfoCue); % added on 7/22/2022
    noCueVsALPL.pRSSparsityRunCue = ranksum(noCueVsALPL.ALPLSparsity,...
        noCueVsALPL.ALPLSparsityCue);
    
    noCueVsALPL.pRSAdaptSpatialInfoRunCueField = ranksum(noCueVsALPL.ALPLAdaptSpatialInfoField,...
        noCueVsALPL.ALPLAdaptSpatialInfoCueField);
    noCueVsALPL.pRSSpatialInfoRunCueField = ranksum(noCueVsALPL.ALPLSpatialInfoField,...
        noCueVsALPL.ALPLSpatialInfoCueField); % added on 7/22/2022
    noCueVsALPL.pRSSparsityRunCueField = ranksum(noCueVsALPL.ALPLSparsityField,...
        noCueVsALPL.ALPLSparsityCueField);
    
    colorSel = 1;
    % mean corr box plot
    plotBoxPlot(noCueVsALPL.noCueMeanCorrTRunNZ,...
            noCueVsALPL.ALPLMeanCorrTRunNZ,...
            ['Mean corr. T NZ (Run)'],...
            ['MeanCorrTRunNZNoCueVsALPLBox'],...
            pathAnal0,[-1 1],noCueVsALPL.pRSMeanCorrTRunNZ,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(noCueVsALPL.noCueMeanCorrTRewNZ,...
            noCueVsALPL.ALPLMeanCorrTRewNZ,...
            ['Mean corr. T NZ (Rew)'],...
            ['MeanCorrTRewNZNoCueVsALPLBox'],...
            pathAnal0,[-1 1],noCueVsALPL.pRSMeanCorrTRewNZ,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(noCueVsALPL.noCueMeanCorrTCueNZ,...
            noCueVsALPL.ALPLMeanCorrTCueNZ,...
            ['Mean corr. T NZ (Cue)'],...
            ['MeanCorrTCueNZNoCueVsALPLBox'],...
            pathAnal0,[-1 1],noCueVsALPL.pRSMeanCorrTCueNZ,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(noCueVsALPL.ALPLMeanCorrTRunNZ,...
            noCueVsALPL.ALPLMeanCorrTRewNZ,...
            ['Mean corr. T NZ (Run vs Rew)'],...
            ['MeanCorrTNZRunVsRewALPLBox'],...
            pathAnal0,[-1 1],noCueVsALPL.pRSMeanCorrTRunRewNZ,colorSel,[{'Run'} {'Rew'}]);
        
    plotBoxPlot(noCueVsALPL.ALPLMeanCorrTRunNZ,...
            noCueVsALPL.ALPLMeanCorrTCueNZ,...
            ['Mean corr. T NZ (Run vs Cue)'],...
            ['MeanCorrTNZRunVsCueALPLBox'],...
            pathAnal0,[-1 1],noCueVsALPL.pRSMeanCorrTRunCueNZ,colorSel,[{'Run'} {'Cue'}]);
   
    % mean corr
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueMeanCorrTRunNZ1),mean(noCueVsALPL.ALPLMeanCorrTRunNZ1)],...
            [std(noCueVsALPL.noCueMeanCorrTRunNZ1)/sqrt(length(noCueVsALPL.noCueMeanCorrTRunNZ1)),...
            std(noCueVsALPL.ALPLMeanCorrTRunNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRunNZ1))],...
            '','Mean corr. T NZ (Run)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRunNZ)],...
            pathAnal0,'MeanCorrRunTNZNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueMeanCorrTRewNZ1),mean(noCueVsALPL.ALPLMeanCorrTRewNZ1)],...
            [std(noCueVsALPL.noCueMeanCorrTRewNZ1)/sqrt(length(noCueVsALPL.noCueMeanCorrTRewNZ1)),...
            std(noCueVsALPL.ALPLMeanCorrTRewNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRewNZ1))],...
            '','Mean corr. T NZ (Rew)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRewNZ)],...
            pathAnal0,'MeanCorrRewTNZNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueMeanCorrTCueNZ1),mean(noCueVsALPL.ALPLMeanCorrTCueNZ1)],...
            [std(noCueVsALPL.noCueMeanCorrTCueNZ1)/sqrt(length(noCueVsALPL.noCueMeanCorrTCueNZ1)),...
            std(noCueVsALPL.ALPLMeanCorrTCueNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTCueNZ1))],...
            '','Mean corr. T NZ (Cue)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTCueNZ)],...
            pathAnal0,'MeanCorrCueTNZNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLMeanCorrTRunNZ1),mean(noCueVsALPL.ALPLMeanCorrTRewNZ1)],...
            [std(noCueVsALPL.ALPLMeanCorrTRunNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRunNZ1)),...
            std(noCueVsALPL.ALPLMeanCorrTRewNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRewNZ1))],...
            '','Mean corr. T NZ (Run vs Rew)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRunRewNZ)],...
            pathAnal0,'MeanCorrTNZRunVsRewALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLMeanCorrTRunNZ1),mean(noCueVsALPL.ALPLMeanCorrTCueNZ1)],...
            [std(noCueVsALPL.ALPLMeanCorrTRunNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRunNZ1)),...
            std(noCueVsALPL.ALPLMeanCorrTCueNZ1)/sqrt(length(noCueVsALPL.ALPLMeanCorrTCueNZ1))],...
            '','Mean corr. T NZ (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRunCueNZ)],...
            pathAnal0,'MeanCorrTNZRunVsCueALPLBar')
        
    % mean corr field
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLMeanCorrTRunNZField),mean(noCueVsALPL.ALPLMeanCorrTRewNZField)],...
            [std(noCueVsALPL.ALPLMeanCorrTRunNZField)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRunNZField)),...
            std(noCueVsALPL.ALPLMeanCorrTRewNZField)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRewNZField))],...
            '','Mean corr. T NZ Field (Run vs Rew)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRunRewNZField)],...
            pathAnal0,'MeanCorrTNZFieldRunVsRewALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLMeanCorrTRunNZField),mean(noCueVsALPL.ALPLMeanCorrTCueNZField)],...
            [std(noCueVsALPL.ALPLMeanCorrTRunNZField)/sqrt(length(noCueVsALPL.ALPLMeanCorrTRunNZField)),...
            std(noCueVsALPL.ALPLMeanCorrTCueNZField)/sqrt(length(noCueVsALPL.ALPLMeanCorrTCueNZField))],...
            '','Mean corr. T NZ Field (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSMeanCorrTRunCueNZField)],...
            pathAnal0,'MeanCorrTNZFieldRunVsCueALPLBar')
                
    %% adapted spatial information
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueAdaptSpatialInfo1),mean(noCueVsALPL.ALPLAdaptSpatialInfo1)],...
            [std(noCueVsALPL.noCueAdaptSpatialInfo1)/sqrt(length(noCueVsALPL.noCueAdaptSpatialInfo1)),...
            std(noCueVsALPL.ALPLAdaptSpatialInfo1)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfo1))],...
            '','Adapted spatial Info (Run)', ['p=' num2str(noCueVsALPL.pRSAdaptSpatialInfo)],...
            pathAnal0,'AdaptSpatialInfoRunNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueAdaptSpatialInfoCue1),mean(noCueVsALPL.ALPLAdaptSpatialInfoCue1)],...
            [std(noCueVsALPL.noCueAdaptSpatialInfoCue1)/sqrt(length(noCueVsALPL.noCueAdaptSpatialInfoCue1)),...
            std(noCueVsALPL.ALPLAdaptSpatialInfoCue1)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfoCue1))],...
            '','Adapted spatial Info (Cue)', ['p=' num2str(noCueVsALPL.pRSAdaptSpatialInfoCue)],...
            pathAnal0,'AdaptSpatialInfoRunNoCueVsALPLBar')
      
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLAdaptSpatialInfo1),mean(noCueVsALPL.ALPLAdaptSpatialInfoCue1)],...
            [std(noCueVsALPL.ALPLAdaptSpatialInfo1)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfo1)),...
            std(noCueVsALPL.ALPLAdaptSpatialInfoCue1)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfoCue1))],...
            '','AdaptSpatialInfo (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSAdaptSpatialInfoRunCue)],...
            pathAnal0,'AdaptSpatialInfoRunVsCueALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLAdaptSpatialInfoField),mean(noCueVsALPL.ALPLAdaptSpatialInfoCueField)],...
            [std(noCueVsALPL.ALPLAdaptSpatialInfoField)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfoField)),...
            std(noCueVsALPL.ALPLAdaptSpatialInfoCueField)/sqrt(length(noCueVsALPL.ALPLAdaptSpatialInfoCueField))],...
            '','AdaptSpatialInfoField (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSAdaptSpatialInfoRunCueField)],...
            pathAnal0,'AdaptSpatialInfoFieldRunVsCueALPLBar')
        
    %% spatial information, added on 7/21/2022
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueSpatialInfo1),mean(noCueVsALPL.ALPLSpatialInfo1)],...
            [std(noCueVsALPL.noCueSpatialInfo1)/sqrt(length(noCueVsALPL.noCueSpatialInfo1)),...
            std(noCueVsALPL.ALPLSpatialInfo1)/sqrt(length(noCueVsALPL.ALPLSpatialInfo1))],...
            '','Spatial Info (Run)', ['p=' num2str(noCueVsALPL.pRSSpatialInfo)],...
            pathAnal0,'SpatialInfoRunNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueSpatialInfoCue1),mean(noCueVsALPL.ALPLSpatialInfoCue1)],...
            [std(noCueVsALPL.noCueSpatialInfoCue1)/sqrt(length(noCueVsALPL.noCueSpatialInfoCue1)),...
            std(noCueVsALPL.ALPLSpatialInfoCue1)/sqrt(length(noCueVsALPL.ALPLSpatialInfoCue1))],...
            '','Spatial Info (Cue)', ['p=' num2str(noCueVsALPL.pRSSpatialInfoCue)],...
            pathAnal0,'SpatialInfoCueNoCueVsALPLBar')
      
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLSpatialInfo1),mean(noCueVsALPL.ALPLSpatialInfoCue1)],...
            [std(noCueVsALPL.ALPLSpatialInfo1)/sqrt(length(noCueVsALPL.ALPLSpatialInfo1)),...
            std(noCueVsALPL.ALPLSpatialInfoCue1)/sqrt(length(noCueVsALPL.ALPLSpatialInfoCue1))],...
            '','SpatialInfo (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSSpatialInfoRunCue)],...
            pathAnal0,'SpatialInfoRunVsCueALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLSpatialInfoField),mean(noCueVsALPL.ALPLSpatialInfoCueField)],...
            [std(noCueVsALPL.ALPLSpatialInfoField)/sqrt(length(noCueVsALPL.ALPLSpatialInfoField)),...
            std(noCueVsALPL.ALPLSpatialInfoCueField)/sqrt(length(noCueVsALPL.ALPLSpatialInfoCueField))],...
            '','SpatialInfoField (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSSpatialInfoRunCueField)],...
            pathAnal0,'SpatialInfoFieldRunVsCueALPLBar')
        
    %% sparsity
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueSparsity1),mean(noCueVsALPL.ALPLSparsity1)],...
            [std(noCueVsALPL.noCueSparsity1)/sqrt(length(noCueVsALPL.noCueSparsity1)),...
            std(noCueVsALPL.ALPLSparsity1)/sqrt(length(noCueVsALPL.ALPLSparsity1))],...
            '','Sparsity (Run)', ['p=' num2str(noCueVsALPL.pRSSparsity)],...
            pathAnal0,'SparsityRunNoCueVsALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.noCueSparsityCue1),mean(noCueVsALPL.ALPLSparsityCue1)],...
            [std(noCueVsALPL.noCueSparsityCue1)/sqrt(length(noCueVsALPL.noCueSparsityCue1)),...
            std(noCueVsALPL.ALPLSparsityCue1)/sqrt(length(noCueVsALPL.ALPLSparsityCue1))],...
            '','Sparsity (Cue)', ['p=' num2str(noCueVsALPL.pRSSparsityCue)],...
            pathAnal0,'SparsityCueNoCueVsALPLBar')
      
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLSparsity1),mean(noCueVsALPL.ALPLSparsityCue1)],...
            [std(noCueVsALPL.ALPLSparsity1)/sqrt(length(noCueVsALPL.ALPLSparsity1)),...
            std(noCueVsALPL.ALPLSparsityCue1)/sqrt(length(noCueVsALPL.ALPLSparsityCue1))],...
            '','Sparsity (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSSparsityRunCue)],...
            pathAnal0,'SparsityRunVsCueALPLBar')
        
    plotBarsOnly(...
        [mean(noCueVsALPL.ALPLSparsityField),mean(noCueVsALPL.ALPLSparsityCueField)],...
            [std(noCueVsALPL.ALPLSparsityField)/sqrt(length(noCueVsALPL.ALPLSparsityField)),...
            std(noCueVsALPL.ALPLSparsityCueField)/sqrt(length(noCueVsALPL.ALPLSparsityCueField))],...
            '','Sparsity Field (Run vs Cue)', ['p=' num2str(noCueVsALPL.pRSSparsityRunCueField)],...
            pathAnal0,'SparsityFieldRunVsCueALPLBar')
        
    save([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat'], 'noCueVsALPL', '-append');
end