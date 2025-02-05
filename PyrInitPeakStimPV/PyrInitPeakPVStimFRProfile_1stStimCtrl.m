function [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMean1stStimCtrl,FRProfileMean2ndStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStat1stStimCtrlVsGoodNonStim,FRProfileMeanStat2ndStimCtrlVsGoodNonStim,...
        FRProfileMeanStat1stStimCtrlVsStim,FRProfileMeanStat2ndStimCtrlVsStim] = PyrInitPeakPVStimFRProfile_1stStimCtrl(modPyr1AL,methodKMean,pulseMethod)

    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfile1stStimCtrl = modPyr1AL.avgFRProfile1stStimCtrl;
    avgFRProfile2ndStimCtrl = modPyr1AL.avgFRProfile2ndStimCtrl;
    
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

                FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(ind,:),modPyr1AL.timeStepRun);

                FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(ind,:),modPyr1AL.timeStepRun);

                FRProfileMean1stStimCtrl{cond} = accumMeanPVStim(avgFRProfile1stStimCtrl(ind,:),modPyr1AL.timeStepRun);
                
                FRProfileMean2ndStimCtrl{cond} = accumMeanPVStim(avgFRProfile2ndStimCtrl(ind,:),modPyr1AL.timeStepRun);

                % compare good non-stim and stim trials
                FRProfileMeanStatGoodNonStimVsStim{cond} = accumMeanPVStimStatCGoodBad_1stStimCtrl(FRProfileMean{cond},FRProfileMeanStim{cond});

                % compare 1st stim ctrl and ctrl trials
                FRProfileMeanStat1stStimCtrlVsGoodNonStim{cond} = accumMeanPVStimStatCGoodBad_1stStimCtrl(FRProfileMean{cond},FRProfileMean1stStimCtrl{cond});
                
                % compare 2nd stim ctrl and ctrl trials
                FRProfileMeanStat2ndStimCtrlVsGoodNonStim{cond} = accumMeanPVStimStatCGoodBad_1stStimCtrl(FRProfileMean{cond},FRProfileMean2ndStimCtrl{cond});
                
                % compare 1st stim ctrl and stim trials
                FRProfileMeanStat1stStimCtrlVsStim{cond} = accumMeanPVStimStatCGoodBad_1stStimCtrl(FRProfileMeanStim{cond},FRProfileMean1stStimCtrl{cond});
                
                % compare 2nd stim ctrl and stim trials
                FRProfileMeanStat2ndStimCtrlVsStim{cond} = accumMeanPVStimStatCGoodBad_1stStimCtrl(FRProfileMeanStim{cond},FRProfileMean2ndStimCtrl{cond});
            end
        end
    end
    
    