function [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = IntInitPeakPVStimFRProfile(modInt1AL,methodKMean,pulseMethod)

    avgFRProfile = modInt1AL.avgFRProfile; 
    avgFRProfileStim = modInt1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modInt1AL.avgFRProfileStimCtrl;
    
    if(methodKMean == 1)
        idxC = modInt1AL.idxC1; 
    elseif(methodKMean == 2)
        idxC = modInt1AL.idxC2;
    elseif(methodKMean == 3)
        idxC = modInt1AL.idxC3;
    end
    
    FRProfileMeanAll = accumMeanPVStim(avgFRProfile,modInt1AL.timeStepRun);
    
    pm3StimLoc{1} = unique(modInt1AL.stimLocPerRec(modInt1AL.pulseMethPerRec == 3 ...
        & modInt1AL.actOrInactPerRec == 1)); 
    pm3StimLoc{2} = unique(modInt1AL.stimLocPerRec(modInt1AL.pulseMethPerRec == 3 ...
        & modInt1AL.actOrInactPerRec == 2));
    
    cond = 0;
    for i = 1: 2
        for j = 1:length(pulseMethod{i})
            if(pulseMethod{i}(j) == 3)
                stimLocs = pm3StimLoc{i};
            else
                stimLocs = 0;
            end
            for m = 1:length(stimLocs)  
                cond = cond+1;
                ind = find(modInt1AL.actOrInact == i & modInt1AL.pulseMeth == pulseMethod{i}(j)...
                    & modInt1AL.stimLoc == stimLocs(m));
                FRProfile{cond}.actOrInact = i;
                FRProfile{cond}.pulseMethod = pulseMethod{i}(j);
                FRProfile{cond}.stimLoc = stimLocs(m);
                FRProfile{cond}.ind = ind;
                FRProfile{cond}.indRec = modInt1AL.indRec(ind);
                FRProfile{cond}.indNeu = modInt1AL.indNeu(ind);

                FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(ind,:),modInt1AL.timeStepRun);

                FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(ind,:),modInt1AL.timeStepRun);

                FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(ind,:),modInt1AL.timeStepRun);

                % compare good non-stim and stim trials
                FRProfileMeanStatGoodNonStimVsStim{cond} = accumMeanPVStimStatCGoodBad(FRProfileMean{cond},FRProfileMeanStim{cond},idxC(ind),idxC(ind));

                % compare stim ctrl and stim trials
                FRProfileMeanStatStimCtrlVsStim{cond} = accumMeanPVStimStatCGoodBad(FRProfileMean{cond},FRProfileMeanStimCtrl{cond},idxC(ind),idxC(ind));
            end
        end
    end
    
    