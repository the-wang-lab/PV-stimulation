function behAlignedMean = accumMeanBehTimeGoodBad(behAlignedNoCue,behAlignedAL,behAlignedPL,task)
% behavior for good vs bad trials
% this function is called by PyrBehAlignedAllRec.m

    if(task == 1)
        
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
       
    elseif(task == 2)
        
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
        
    else
        
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
        
    end
   
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