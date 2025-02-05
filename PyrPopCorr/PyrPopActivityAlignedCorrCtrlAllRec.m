function PyrPopActivityAlignedCorrCtrlAllRec()

    pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalPopCorr\';
    
    load([pathAnal 'PyrPopActCorrCtrl.mat']);
    if(exist([pathAnal 'PyrPopActCorrCtrlAllRec.mat']))
        load([pathAnal 'PyrPopActCorrCtrlAllRec.mat']);
    end
    
    %% all the pyramidal neurons
    popCorrPyrALPL = PyrPopCorrAllRecByType(popCorrPyrNoCue,popCorrPyrAL,popCorrPyrPL,2);
   
    noCueVsALPL.pRSMeanNoStimGoodRun = ranksum(popCorrPyrNoCue.meanNoStimGoodRun,...
        popCorrPyrALPL.meanNoStimGoodRun);
    noCueVsALPL.pRSMeanNoStimGoodRew = ranksum(popCorrPyrNoCue.meanNoStimGoodRew,...
        popCorrPyrALPL.meanNoStimGoodRew);
    noCueVsALPL.pRSMeanNoStimGoodCue = ranksum(popCorrPyrNoCue.meanNoStimGoodCue,...
        popCorrPyrALPL.meanNoStimGoodCue);
    
    noCueVsALPL.pRSMeanNoStimBadRun = ranksum(popCorrPyrNoCue.meanNoStimBadRun,...
        popCorrPyrALPL.meanNoStimBadRun);
    noCueVsALPL.pRSMeanNoStimBadRew = ranksum(popCorrPyrNoCue.meanNoStimBadRew,...
        popCorrPyrALPL.meanNoStimBadRew);
    noCueVsALPL.pRSMeanNoStimBadCue = ranksum(popCorrPyrNoCue.meanNoStimBadCue,...
        popCorrPyrALPL.meanNoStimBadCue);
    
    noCueVsALPL.pRSMeanNoStimRun = ranksum(popCorrPyrNoCue.meanNoStimRun,...
        popCorrPyrALPL.meanNoStimRun);
    noCueVsALPL.pRSMeanNoStimRew = ranksum(popCorrPyrNoCue.meanNoStimRew,...
        popCorrPyrALPL.meanNoStimRew);
    noCueVsALPL.pRSMeanNoStimCue = ranksum(popCorrPyrNoCue.meanNoStimCue,...
        popCorrPyrALPL.meanNoStimCue);
    
    runVsCueALPL.pRSMeanNoStimGood = ranksum(popCorrPyrALPL.meanNoStimGoodRun,...
        popCorrPyrALPL.meanNoStimGoodCue);
    runVsCueALPL.pRSMeanNoStimBad = ranksum(popCorrPyrALPL.meanNoStimBadRun,...
        popCorrPyrALPL.meanNoStimBadCue);
    runVsCueALPL.pRSMeanNoStim = ranksum(popCorrPyrALPL.meanNoStimRun,...
        popCorrPyrALPL.meanNoStimCue);
    
    runVsRewALPL.pRSMeanNoStimGood = ranksum(popCorrPyrALPL.meanNoStimGoodRun,...
        popCorrPyrALPL.meanNoStimGoodRew);
    runVsRewALPL.pRSMeanNoStimBad = ranksum(popCorrPyrALPL.meanNoStimBadRun,...
        popCorrPyrALPL.meanNoStimBadRew);
    runVsRewALPL.pRSMeanNoStim = ranksum(popCorrPyrALPL.meanNoStimRun,...
        popCorrPyrALPL.meanNoStimRew);
    
    %% neurons with fields
    popCorrPyrFieldALPL = PyrPopCorrAllRecByTypeField(popCorrPyrFieldAL,popCorrPyrFieldPL);
      
    runVsCueFieldALPL.pRSMeanNoStimGood = ranksum(popCorrPyrFieldALPL.meanNoStimGoodRun,...
        popCorrPyrFieldALPL.meanNoStimGoodCue);
    runVsCueFieldALPL.pRSMeanNoStimBad = ranksum(popCorrPyrFieldALPL.meanNoStimBadRun,...
        popCorrPyrFieldALPL.meanNoStimBadCue);
    runVsCueFieldALPL.pRSMeanNoStim = ranksum(popCorrPyrFieldALPL.meanNoStimRun,...
        popCorrPyrFieldALPL.meanNoStimCue);
    
    runVsRewFieldALPL.pRSMeanNoStimGood = ranksum(popCorrPyrFieldALPL.meanNoStimGoodRun,...
        popCorrPyrFieldALPL.meanNoStimGoodRew);
    runVsRewFieldALPL.pRSMeanNoStimBad = ranksum(popCorrPyrFieldALPL.meanNoStimBadRun,...
        popCorrPyrFieldALPL.meanNoStimBadRew);
    runVsRewFieldALPL.pRSMeanNoStim = ranksum(popCorrPyrFieldALPL.meanNoStimRun,...
        popCorrPyrFieldALPL.meanNoStimRew);
    
    save([pathAnal,'PyrPopActCorrCtrlAllRec.mat'],'popCorrPyrALPL','noCueVsALPL',...
        'runVsCueALPL','runVsRewALPL','popCorrPyrFieldALPL',...
        'runVsCueFieldALPL','runVsRewFieldALPL');
    
    colorSel = 1;
    %% all the pyramidal neurons
    % mean pop corr box plot
    plotBoxPlot(popCorrPyrNoCue.meanNoStimRun,...
            popCorrPyrALPL.meanNoStimRun,...
            ['Mean pop corr. (Run)'],...
            ['MeanPopCorrRunNoCueVsALPLBox'],...
            pathAnal,[-1 1],noCueVsALPL.pRSMeanNoStimRun,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(popCorrPyrNoCue.meanNoStimRew,...
            popCorrPyrALPL.meanNoStimRew,...
            ['Mean pop corr. (Rew)'],...
            ['MeanPopCorrRewNoCueVsALPLBox'],...
            pathAnal,[-1 1],noCueVsALPL.pRSMeanNoStimRew,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(popCorrPyrNoCue.meanNoStimCue,...
            popCorrPyrALPL.meanNoStimCue,...
            ['Mean pop corr. (Cue)'],...
            ['MeanPopCorrCueNoCueVsALPLBox'],...
            pathAnal,[-1 1],noCueVsALPL.pRSMeanNoStimCue,colorSel,[{'NoCue'} {'ALPL'}]);
        
    plotBoxPlot(popCorrPyrALPL.meanNoStimRun,...
            popCorrPyrALPL.meanNoStimRew,...
            ['Mean pop corr. (Run vs Rew)'],...
            ['MeanPopCorrTNZRunVsRewALPLBox'],...
            pathAnal,[-1 1],runVsRewALPL.pRSMeanNoStim,colorSel,[{'Run'} {'Rew'}]);
        
    plotBoxPlot(popCorrPyrALPL.meanNoStimRun,...
            popCorrPyrALPL.meanNoStimCue,...
            ['Mean pop corr. (Run vs Cue)'],...
            ['MeanPopCorrTNZRunVsCueALPLBox'],...
            pathAnal,[-1 1],runVsCueALPL.pRSMeanNoStim,colorSel,[{'Run'} {'Cue'}]);
        
    % mean pop corr
    plotBars(popCorrPyrNoCue.meanNoStimRun,popCorrPyrALPL.meanNoStimRun,...
        [mean(popCorrPyrNoCue.meanNoStimRun),mean(popCorrPyrALPL.meanNoStimRun)],...
            [std(popCorrPyrNoCue.meanNoStimRun)/sqrt(length(popCorrPyrNoCue.meanNoStimRun)),...
            std(popCorrPyrALPL.meanNoStimRun)/sqrt(length(popCorrPyrALPL.meanNoStimRun))],...
            '','Mean pop corr. (Run)', ['p=' num2str(noCueVsALPL.pRSMeanNoStimRun)],...
            pathAnal,'MeanPopCorrRunNoCueVsALPLBar')
        
    plotBars(popCorrPyrNoCue.meanNoStimRew,popCorrPyrALPL.meanNoStimRew,...
        [mean(popCorrPyrNoCue.meanNoStimRew),mean(popCorrPyrALPL.meanNoStimRew)],...
            [std(popCorrPyrNoCue.meanNoStimRew)/sqrt(length(popCorrPyrNoCue.meanNoStimRew)),...
            std(popCorrPyrALPL.meanNoStimRew)/sqrt(length(popCorrPyrALPL.meanNoStimRew))],...
            '','Mean pop corr. (Rew)', ['p=' num2str(noCueVsALPL.pRSMeanNoStimRew)],...
            pathAnal,'MeanPopCorrRewNoCueVsALPLBar')
        
    plotBars(popCorrPyrNoCue.meanNoStimCue,popCorrPyrALPL.meanNoStimCue,...
        [mean(popCorrPyrNoCue.meanNoStimCue),mean(popCorrPyrALPL.meanNoStimCue)],...
            [std(popCorrPyrNoCue.meanNoStimCue)/sqrt(length(popCorrPyrNoCue.meanNoStimCue)),...
            std(popCorrPyrALPL.meanNoStimCue)/sqrt(length(popCorrPyrALPL.meanNoStimCue))],...
            '','Mean pop corr. (Cue)', ['p=' num2str(noCueVsALPL.pRSMeanNoStimCue)],...
            pathAnal,'MeanPopCorrCueNoCueVsALPLBar')
        
    plotBars(popCorrPyrALPL.meanNoStimRun,popCorrPyrALPL.meanNoStimRew,...
        [mean(popCorrPyrALPL.meanNoStimRun),mean(popCorrPyrALPL.meanNoStimRew)],...
            [std(popCorrPyrALPL.meanNoStimRun)/sqrt(length(popCorrPyrALPL.meanNoStimRun)),...
            std(popCorrPyrALPL.meanNoStimRew)/sqrt(length(popCorrPyrALPL.meanNoStimRew))],...
            '','Mean pop corr. (Run vs Rew)', ['p=' num2str(runVsRewALPL.pRSMeanNoStim)],...
            pathAnal,'MeanPopCorrTNZRunVsRewALPLBar')
        
    plotBars(popCorrPyrALPL.meanNoStimRun,popCorrPyrALPL.meanNoStimCue,...
        [mean(popCorrPyrALPL.meanNoStimRun),mean(popCorrPyrALPL.meanNoStimCue)],...
            [std(popCorrPyrALPL.meanNoStimRun)/sqrt(length(popCorrPyrALPL.meanNoStimRun)),...
            std(popCorrPyrALPL.meanNoStimCue)/sqrt(length(popCorrPyrALPL.meanNoStimCue))],...
            '','Mean pop corr. (Run vs Cue)', ['p=' num2str(runVsCueALPL.pRSMeanNoStim)],...
            pathAnal,'MeanPopCorrTNZRunVsCueALPLBar')
        
    %% neurons with fields
    % mean pop corr box plot
    plotBoxPlot(popCorrPyrFieldALPL.meanNoStimRun,...
            popCorrPyrFieldALPL.meanNoStimRew,...
            ['Mean pop corr. field (Run vs Rew)'],...
            ['MeanPopCorrTNZFieldRunVsRewALPLBox'],...
            pathAnal,[-1 1],runVsRewFieldALPL.pRSMeanNoStim,colorSel,[{'Run'} {'Rew'}]);
        
    plotBoxPlot(popCorrPyrFieldALPL.meanNoStimRun,...
            popCorrPyrFieldALPL.meanNoStimCue,...
            ['Mean pop corr. field (Run vs Cue)'],...
            ['MeanPopCorrTNZFieldRunVsCueALPLBox'],...
            pathAnal,[-1 1],runVsCueFieldALPL.pRSMeanNoStim,colorSel,[{'Run'} {'Cue'}]);
        
    % mean pop corr
    
    plotBars(popCorrPyrFieldALPL.meanNoStimRun,popCorrPyrFieldALPL.meanNoStimRew,...
        [mean(popCorrPyrFieldALPL.meanNoStimRun),mean(popCorrPyrFieldALPL.meanNoStimRew)],...
            [std(popCorrPyrFieldALPL.meanNoStimRun)/sqrt(length(popCorrPyrFieldALPL.meanNoStimRun)),...
            std(popCorrPyrFieldALPL.meanNoStimRew)/sqrt(length(popCorrPyrFieldALPL.meanNoStimRew))],...
            '','Mean pop corr. field (Run vs Rew)', ['p=' num2str(runVsRewFieldALPL.pRSMeanNoStim)],...
            pathAnal,'MeanPopCorrTNZFieldRunVsRewALPLBar')
        
    plotBars(popCorrPyrFieldALPL.meanNoStimRun,popCorrPyrFieldALPL.meanNoStimCue,...
        [mean(popCorrPyrFieldALPL.meanNoStimRun),mean(popCorrPyrFieldALPL.meanNoStimCue)],...
            [std(popCorrPyrFieldALPL.meanNoStimRun)/sqrt(length(popCorrPyrFieldALPL.meanNoStimRun)),...
            std(popCorrPyrFieldALPL.meanNoStimCue)/sqrt(length(popCorrPyrFieldALPL.meanNoStimCue))],...
            '','Mean pop corr. field (Run vs Cue)', ['p=' num2str(runVsCueFieldALPL.pRSMeanNoStim)],...
            pathAnal,'MeanPopCorrTNZFieldRunVsCueALPLBar')
end

function popCorrPyr = PyrPopCorrAllRecByType(popCorrPyrNoCue,popCorrPyrAL,popCorrPyrPL,taskSel)
    
    if(taskSel == 1)
        popCorrPyr.task = [popCorrPyrNoCue.task popCorrPyrAL.task popCorrPyrPL.task];
        popCorrPyr.indRec = [popCorrPyrNoCue.indRec popCorrPyrAL.indRec popCorrPyrPL.indRec];
        popCorrPyr.meanNoStimGoodRun = [popCorrPyrNoCue.meanNoStimGoodRun ...
            popCorrPyrAL.meanNoStimGoodRun popCorrPyrPL.meanNoStimGoodRun];
        popCorrPyr.meanNoStimBadRun = [popCorrPyrNoCue.meanNoStimBadRun ...
            popCorrPyrAL.meanNoStimBadRun popCorrPyrPL.meanNoStimBadRun];
        popCorrPyr.meanNoStimRun = [popCorrPyrNoCue.meanNoStimRun ...
            popCorrPyrAL.meanNoStimRun popCorrPyrPL.meanNoStimRun];
        
        popCorrPyr.meanNoStimGoodRew = [popCorrPyrNoCue.meanNoStimGoodRew ...
            popCorrPyrAL.meanNoStimGoodRew popCorrPyrPL.meanNoStimGoodRew];
        popCorrPyr.meanNoStimBadRew = [popCorrPyrNoCue.meanNoStimBadRew ...
            popCorrPyrAL.meanNoStimBadRew popCorrPyrPL.meanNoStimBadRew];
        popCorrPyr.meanNoStimRew = [popCorrPyrNoCue.meanNoStimRew ...
            popCorrPyrAL.meanNoStimRew popCorrPyrPL.meanNoStimRew];    
        
        popCorrPyr.meanNoStimGoodCue = [popCorrPyrNoCue.meanNoStimGoodCue ...
            popCorrPyrAL.meanNoStimGoodCue popCorrPyrPL.meanNoStimGoodCue];
        popCorrPyr.meanNoStimBadCue = [popCorrPyrNoCue.meanNoStimBadCue ...
            popCorrPyrAL.meanNoStimBadCue popCorrPyrPL.meanNoStimBadCue];
        popCorrPyr.meanNoStimCue = [popCorrPyrNoCue.meanNoStimCue ...
            popCorrPyrAL.meanNoStimCue popCorrPyrPL.meanNoStimCue];
    elseif(taskSel == 2)
        popCorrPyr.task = [popCorrPyrAL.task popCorrPyrPL.task];
        popCorrPyr.indRec = [popCorrPyrAL.indRec popCorrPyrPL.indRec];
        popCorrPyr.meanNoStimGoodRun = [ ...
            popCorrPyrAL.meanNoStimGoodRun popCorrPyrPL.meanNoStimGoodRun];
        popCorrPyr.meanNoStimBadRun = [ ...
            popCorrPyrAL.meanNoStimBadRun popCorrPyrPL.meanNoStimBadRun];
        popCorrPyr.meanNoStimRun = [ ...
            popCorrPyrAL.meanNoStimRun popCorrPyrPL.meanNoStimRun];
        
        popCorrPyr.meanNoStimGoodRew = [ ...
            popCorrPyrAL.meanNoStimGoodRew popCorrPyrPL.meanNoStimGoodRew];
        popCorrPyr.meanNoStimBadRew = [ ...
            popCorrPyrAL.meanNoStimBadRew popCorrPyrPL.meanNoStimBadRew];
        popCorrPyr.meanNoStimRew = [ ...
            popCorrPyrAL.meanNoStimRew popCorrPyrPL.meanNoStimRew];    
        
        popCorrPyr.meanNoStimGoodCue = [ ...
            popCorrPyrAL.meanNoStimGoodCue popCorrPyrPL.meanNoStimGoodCue];
        popCorrPyr.meanNoStimBadCue = [ ...
            popCorrPyrAL.meanNoStimBadCue popCorrPyrPL.meanNoStimBadCue];
        popCorrPyr.meanNoStimCue = [ ...
            popCorrPyrAL.meanNoStimCue popCorrPyrPL.meanNoStimCue];
    else
        popCorrPyr.task = [popCorrPyrAL.task];
        popCorrPyr.indRec = [popCorrPyrAL.indRec];
        popCorrPyr.meanNoStimGoodRun = [ ...
            popCorrPyrAL.meanNoStimGoodRun];
        popCorrPyr.meanNoStimBadRun = [ ...
            popCorrPyrAL.meanNoStimBadRun];
        popCorrPyr.meanNoStimRun = [ ...
            popCorrPyrAL.meanNoStimRun];
        
        popCorrPyr.meanNoStimGoodRew = [ ...
            popCorrPyrAL.meanNoStimGoodRew];
        popCorrPyr.meanNoStimBadRew = [ ...
            popCorrPyrAL.meanNoStimBadRew];
        popCorrPyr.meanNoStimRew = [ ...
            popCorrPyrAL.meanNoStimRew];    
        
        popCorrPyr.meanNoStimGoodCue = [ ...
            popCorrPyrAL.meanNoStimGoodCue];
        popCorrPyr.meanNoStimBadCue = [ ...
            popCorrPyrAL.meanNoStimBadCue];
        popCorrPyr.meanNoStimCue = [ ...
            popCorrPyrAL.meanNoStimCue];
    end
end

function popCorrPyr = PyrPopCorrAllRecByTypeField(popCorrPyrAL,popCorrPyrPL)
    
    popCorrPyr.task = [popCorrPyrAL.task(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.task(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.indRec = [popCorrPyrAL.indRec(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.indRec(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimGoodRun = [ ...
        popCorrPyrAL.meanNoStimGoodRun(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimGoodRun(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimBadRun = [ ...
        popCorrPyrAL.meanNoStimBadRun(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimBadRun(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimRun = [ ...
        popCorrPyrAL.meanNoStimRun(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimRun(popCorrPyrPL.popCorrExist == 1)];

    popCorrPyr.meanNoStimGoodRew = [ ...
        popCorrPyrAL.meanNoStimGoodRew(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimGoodRew(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimBadRew = [ ...
        popCorrPyrAL.meanNoStimBadRew(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimBadRew(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimRew = [ ...
        popCorrPyrAL.meanNoStimRew(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimRew(popCorrPyrPL.popCorrExist == 1)];    

    popCorrPyr.meanNoStimGoodCue = [ ...
        popCorrPyrAL.meanNoStimGoodCue(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimGoodCue(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimBadCue = [ ...
        popCorrPyrAL.meanNoStimBadCue(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimBadCue(popCorrPyrPL.popCorrExist == 1)];
    popCorrPyr.meanNoStimCue = [ ...
        popCorrPyrAL.meanNoStimCue(popCorrPyrAL.popCorrExist == 1) ...
        popCorrPyrPL.meanNoStimCue(popCorrPyrPL.popCorrExist == 1)];

end
    