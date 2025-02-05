function [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = PyrInitPeakPVStimFRProfile(modPyr1AL,methodKMean,pulseMethod)

    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl;
    
    if(methodKMean == 1)
        idxC = modPyr1AL.idxC1; 
    elseif(methodKMean == 2)
        idxC = modPyr1AL.idxC2;
    elseif(methodKMean == 3)
        idxC = modPyr1AL.idxC3;
    end
    
    FRProfileMeanAll = accumMeanPVStim(avgFRProfile,modPyr1AL.timeStepRun);
    
    pm3StimLoc{1} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
        & modPyr1AL.actOrInactPerRec == 1)); 
    pm3StimLoc{2} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
        & modPyr1AL.actOrInactPerRec == 2));
    
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
                ind = find(modPyr1AL.actOrInact == i & modPyr1AL.pulseMeth == pulseMethod{i}(j)...
                    & modPyr1AL.stimLoc == stimLocs(m));
                FRProfile{cond}.actOrInact = i;
                FRProfile{cond}.pulseMethod = pulseMethod{i}(j);
                FRProfile{cond}.stimLoc = stimLocs(m);
                FRProfile{cond}.ind = ind;
                FRProfile{cond}.indRec = modPyr1AL.indRec(ind);
                FRProfile{cond}.indNeu = modPyr1AL.indNeu(ind);

                FRProfile{cond}.isNeuWithFieldAligned = modPyr1AL.isNeuWithFieldAligned(ind);
                FRProfile{cond}.isNeuWithFieldAlignedGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim(ind);
                FRProfile{cond}.isNeuWithFieldAlignedStim = modPyr1AL.isNeuWithFieldAlignedStim(ind);
                FRProfile{cond}.isNeuWithFieldAlignedStimCtrl = modPyr1AL.isNeuWithFieldAlignedStimCtrl(ind);

                FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(ind,:),modPyr1AL.timeStepRun);

                FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(ind,:),modPyr1AL.timeStepRun);

                FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(ind,:),modPyr1AL.timeStepRun);

                % compare good non-stim and stim trials
                FRProfileMeanStatGoodNonStimVsStim{cond} = accumMeanPVStimStatCGoodBad(FRProfileMean{cond},FRProfileMeanStim{cond},idxC(ind),idxC(ind));

                % compare stim ctrl and stim trials
                FRProfileMeanStatStimCtrlVsStim{cond} = accumMeanPVStimStatCGoodBad(FRProfileMean{cond},FRProfileMeanStimCtrl{cond},idxC(ind),idxC(ind));
            end
        end
    end
    
    