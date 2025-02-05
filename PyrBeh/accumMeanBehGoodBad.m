function behAlignedMean = accumMeanBehGoodBad(behAlignedNoCue,behAlignedAL,behAlignedPL,task)
% behavior for good vs bad trials
% this function is called by PyrBehAlignedAllRec.m

    if(task == 1)
        %% perc. good trials in nonstim session, added on 9/14/2022
        behAlignedMean.percGoodNonStim = [behAlignedNoCue.percGoodNonStim,...
            behAlignedAL.percGoodNonStim,...
            behAlignedPL.percGoodNonStim];
        
        %% added on 6/9/2022
        behAlignedMean.meanTotStopLenTPerRecNonStimGood = ...
            [behAlignedNoCue.meanTotStopLenTNonStimGoodPerRec;...
            behAlignedAL.meanTotStopLenTNonStimGoodPerRec;...
            behAlignedPL.meanTotStopLenTNonStimGoodPerRec];
        behAlignedMean.meanTotStopLenTPerRecNonStimBad = ...
            [behAlignedNoCue.meanTotStopLenTNonStimBadPerRec;...
            behAlignedAL.meanTotStopLenTNonStimBadPerRec;...
            behAlignedPL.meanTotStopLenTNonStimBadPerRec];        
        GoodStopTTmp = [behAlignedNoCue.totStopLenTNonStimGoodPerRec ...
            behAlignedAL.totStopLenTNonStimGoodPerRec ...
            behAlignedPL.totStopLenTNonStimGoodPerRec];
        BadStopTTmp = [behAlignedNoCue.totStopLenTNonStimBadPerRec ...
            behAlignedAL.totStopLenTNonStimBadPerRec ...
            behAlignedPL.totStopLenTNonStimBadPerRec];
        %%
        
        behAlignedMean.meanLickPerRecNonStimGood = ...
            [behAlignedNoCue.meanLickNonStimGoodPerRec;...
            behAlignedAL.meanLickNonStimGoodPerRec;...
            behAlignedPL.meanLickNonStimGoodPerRec];
        behAlignedMean.meanLickPerRecNonStimBad = ...
            [behAlignedNoCue.meanLickNonStimBadPerRec;...
            behAlignedAL.meanLickNonStimBadPerRec;...
            behAlignedPL.meanLickNonStimBadPerRec];        
        GoodTmp = [behAlignedNoCue.lickTraceNonStimGoodPerRec ...
            behAlignedAL.lickTraceNonStimGoodPerRec ...
            behAlignedPL.lickTraceNonStimGoodPerRec];
        BadTmp = [behAlignedNoCue.lickTraceNonStimBadPerRec ...
            behAlignedAL.lickTraceNonStimBadPerRec ...
            behAlignedPL.lickTraceNonStimBadPerRec];
        
        behAlignedMean.meanSpeedPerRecNonStimGood = ...
            [behAlignedNoCue.meanSpeedNonStimGoodPerRec;...
            behAlignedAL.meanSpeedNonStimGoodPerRec;...
            behAlignedPL.meanSpeedNonStimGoodPerRec];
        behAlignedMean.meanSpeedPerRecNonStimBad = ...
            [behAlignedNoCue.meanSpeedNonStimBadPerRec;...
            behAlignedAL.meanSpeedNonStimBadPerRec;...
            behAlignedPL.meanSpeedNonStimBadPerRec];        
        GoodSpeedTmp = [behAlignedNoCue.speedTraceNonStimGoodPerRec ...
            behAlignedAL.speedTraceNonStimGoodPerRec ...
            behAlignedPL.speedTraceNonStimGoodPerRec];
        BadSpeedTmp = [behAlignedNoCue.speedTraceNonStimBadPerRec ...
            behAlignedAL.speedTraceNonStimBadPerRec ...
            behAlignedPL.speedTraceNonStimBadPerRec]; 
        
        %% added on 7/1/2022
        behAlignedMean.percRewardedNonStim = [...
            behAlignedNoCue.percRewardedNonStimPerRec...
            behAlignedAL.percRewardedNonStimPerRec...
            behAlignedPL.percRewardedNonStimPerRec];
        
        behAlignedMean.percRewardedNonStimGood = [...
            behAlignedNoCue.percRewardedNonStimGoodPerRec...
            behAlignedAL.percRewardedNonStimGoodPerRec...
            behAlignedPL.percRewardedNonStimGoodPerRec];
        
        behAlignedMean.percRewardedNonStimBad = [...
            behAlignedNoCue.percRewardedNonStimBadPerRec...
            behAlignedAL.percRewardedNonStimBadPerRec...
            behAlignedPL.percRewardedNonStimBadPerRec];
    elseif(task == 2)
        %% perc. good trials in nonstim session, added on 9/14/2022
        behAlignedMean.percGoodNonStim = [...
            behAlignedAL.percGoodNonStim,...
            behAlignedPL.percGoodNonStim];
        
        %% added on 6/9/2022
        behAlignedMean.meanTotStopLenTPerRecNonStimGood = ...
            [behAlignedAL.meanTotStopLenTNonStimGoodPerRec;...
            behAlignedPL.meanTotStopLenTNonStimGoodPerRec];
        behAlignedMean.meanTotStopLenTPerRecNonStimBad = ...
            [behAlignedAL.meanTotStopLenTNonStimBadPerRec;...
            behAlignedPL.meanTotStopLenTNonStimBadPerRec];        
        GoodStopTTmp = [behAlignedAL.totStopLenTNonStimGoodPerRec ...
            behAlignedPL.totStopLenTNonStimGoodPerRec];
        BadStopTTmp = [behAlignedAL.totStopLenTNonStimBadPerRec ...
            behAlignedPL.totStopLenTNonStimBadPerRec];
        %%
        
        behAlignedMean.meanLickPerRecNonStimGood = ...
            [behAlignedAL.meanLickNonStimGoodPerRec;...
            behAlignedPL.meanLickNonStimGoodPerRec];
        behAlignedMean.meanLickPerRecNonStimBad = ...
            [behAlignedAL.meanLickNonStimBadPerRec;...
            behAlignedPL.meanLickNonStimBadPerRec];        
        GoodTmp = [behAlignedAL.lickTraceNonStimGoodPerRec ...
            behAlignedPL.lickTraceNonStimGoodPerRec];   
        BadTmp = [behAlignedAL.lickTraceNonStimBadPerRec ...
            behAlignedPL.lickTraceNonStimBadPerRec];
        
        behAlignedMean.meanSpeedPerRecNonStimGood = ...
            [behAlignedAL.meanSpeedNonStimGoodPerRec;...
            behAlignedPL.meanSpeedNonStimGoodPerRec];
        behAlignedMean.meanSpeedPerRecNonStimBad = ...
            [behAlignedAL.meanSpeedNonStimBadPerRec;...
            behAlignedPL.meanSpeedNonStimBadPerRec];        
        GoodSpeedTmp = [behAlignedAL.speedTraceNonStimGoodPerRec ...
            behAlignedPL.speedTraceNonStimGoodPerRec];
        BadSpeedTmp = [behAlignedAL.speedTraceNonStimBadPerRec ...
            behAlignedPL.speedTraceNonStimBadPerRec]; 
        
        %% added on 7/1/2022
        behAlignedMean.percRewardedNonStim = [...
            behAlignedAL.percRewardedNonStimPerRec...
            behAlignedPL.percRewardedNonStimPerRec];
        
        behAlignedMean.percRewardedNonStimGood = [...
            behAlignedAL.percRewardedNonStimGoodPerRec...
            behAlignedPL.percRewardedNonStimGoodPerRec];
        
        behAlignedMean.percRewardedNonStimBad = [...
            behAlignedAL.percRewardedNonStimBadPerRec...
            behAlignedPL.percRewardedNonStimBadPerRec];
    else
        %% perc. good trials in nonstim session, added on 9/14/2022
        behAlignedMean.percGoodNonStim = ...
            behAlignedAL.percGoodNonStim;
                
        %% added on 6/9/2022
        behAlignedMean.meanTotStopLenTPerRecNonStimGood = ...
            behAlignedAL.meanTotStopLenTNonStimGoodPerRec;
        behAlignedMean.meanTotStopLenTPerRecNonStimBad = ...
            behAlignedAL.meanTotStopLenTNonStimBadPerRec;        
        GoodStopTTmp = behAlignedAL.totStopLenTNonStimGoodPerRec;
        BadStopTTmp = behAlignedAL.totStopLenTNonStimBadPerRec;
        %%
        
        behAlignedMean.meanLickPerRecNonStimGood = ...
            behAlignedAL.meanLickNonStimGoodPerRec;
        behAlignedMean.meanLickPerRecNonStimBad = ...
            behAlignedAL.meanLickNonStimBadPerRec;
        GoodTmp = behAlignedAL.lickTraceNonStimGoodPerRec; 
        BadTmp = behAlignedAL.lickTraceNonStimBadPerRec;
        
        behAlignedMean.meanSpeedPerRecNonStimGood = ...
            behAlignedAL.meanSpeedNonStimGoodPerRec;
        behAlignedMean.meanSpeedPerRecNonStimBad = ...
            behAlignedAL.meanSpeedNonStimBadPerRec;       
        GoodSpeedTmp = behAlignedAL.speedTraceNonStimGoodPerRec;
        BadSpeedTmp = behAlignedAL.speedTraceNonStimBadPerRec; 
        
        %% added on 7/1/2022
        behAlignedMean.percRewardedNonStim = ...
            behAlignedAL.percRewardedNonStimPerRec;
        
        behAlignedMean.percRewardedNonStimGood = ...
            behAlignedAL.percRewardedNonStimGoodPerRec;
        
        behAlignedMean.percRewardedNonStimBad = ...
            behAlignedAL.percRewardedNonStimBadPerRec;
    end
    
    % perc. good trials in non-stim trials
    behAlignedMean.meanPercGoodNonStim = ...
        mean(behAlignedMean.percGoodNonStim);
    behAlignedMean.semPercGoodNonStim = ...
        std(behAlignedMean.percGoodNonStim)/...
        sqrt(length(behAlignedMean.percGoodNonStim));
        
    %% added on 6/9/2022
    behAlignedMean.totStopLenTNonStimGoodPerRec = [];
    for i = 1:length(GoodTmp)
        behAlignedMean.totStopLenTNonStimGoodPerRec = [...
            behAlignedMean.totStopLenTNonStimGoodPerRec; ...
            GoodStopTTmp{i}'];
    end  
    behAlignedMean.totStopLenTNonStimBadPerRec = [];
    for i = 1:length(BadTmp)
        behAlignedMean.totStopLenTNonStimBadPerRec = [...
            behAlignedMean.totStopLenTNonStimBadPerRec; ...
            BadStopTTmp{i}'];
    end  
    behAlignedMean.meanTotStopLenTNonStimGoodPerRec = ...
        mean(behAlignedMean.totStopLenTNonStimGoodPerRec);
    behAlignedMean.semTotStopLenTNonStimGoodPerRec = ...
        std(behAlignedMean.totStopLenTNonStimGoodPerRec)/...
        sqrt(length(behAlignedMean.totStopLenTNonStimGoodPerRec)); 
    behAlignedMean.meanTotStopLenTNonStimBadPerRec = ...
        mean(behAlignedMean.totStopLenTNonStimBadPerRec);
    behAlignedMean.semTotStopLenTNonStimBadPerRec = ...
        std(behAlignedMean.totStopLenTNonStimBadPerRec)/...
        sqrt(size(behAlignedMean.totStopLenTNonStimBadPerRec,1));
        
    %%
    behAlignedMean.lickTraceNonStimGoodPerRec = [];
    for i = 1:length(GoodTmp)
        behAlignedMean.lickTraceNonStimGoodPerRec = [...
            behAlignedMean.lickTraceNonStimGoodPerRec; ...
            GoodTmp{i}];
    end  
    behAlignedMean.lickTraceNonStimBadPerRec = [];
    for i = 1:length(BadTmp)
        behAlignedMean.lickTraceNonStimBadPerRec = [...
            behAlignedMean.lickTraceNonStimBadPerRec; ...
            BadTmp{i}];
    end  
    behAlignedMean.meanLickTraceNonStimGoodPerRec = ...
        mean(behAlignedMean.lickTraceNonStimGoodPerRec);
    behAlignedMean.semLickTraceNonStimGoodPerRec = ...
        std(behAlignedMean.lickTraceNonStimGoodPerRec)/...
        sqrt(size(behAlignedMean.lickTraceNonStimGoodPerRec,1)); 
    behAlignedMean.meanLickTraceNonStimBadPerRec = ...
        mean(behAlignedMean.lickTraceNonStimBadPerRec);
    behAlignedMean.semLickTraceNonStimBadPerRec = ...
        std(behAlignedMean.lickTraceNonStimBadPerRec)/...
        sqrt(size(behAlignedMean.lickTraceNonStimBadPerRec,1));
    
    behAlignedMean.speedTraceNonStimGoodPerRec = [];
    for i = 1:length(GoodSpeedTmp)
        behAlignedMean.speedTraceNonStimGoodPerRec = [...
            behAlignedMean.speedTraceNonStimGoodPerRec; ...
            GoodSpeedTmp{i}];
    end
    behAlignedMean.speedTraceNonStimBadPerRec = [];
    for i = 1:length(BadSpeedTmp)
        behAlignedMean.speedTraceNonStimBadPerRec = [...
            behAlignedMean.speedTraceNonStimBadPerRec; ...
            BadSpeedTmp{i}];
    end    
    behAlignedMean.meanSpeedTraceNonStimGoodPerRec = ...
        mean(behAlignedMean.speedTraceNonStimGoodPerRec);
    behAlignedMean.semSpeedTraceNonStimGoodPerRec = ...
        std(behAlignedMean.speedTraceNonStimGoodPerRec)/...
        sqrt(size(behAlignedMean.speedTraceNonStimGoodPerRec,1));
    behAlignedMean.meanSpeedTraceNonStimBadPerRec = ...
        mean(behAlignedMean.speedTraceNonStimBadPerRec);
    behAlignedMean.semSpeedTraceNonStimBadPerRec = ...
        std(behAlignedMean.speedTraceNonStimBadPerRec)/...
        sqrt(size(behAlignedMean.speedTraceNonStimBadPerRec,1));
    
end