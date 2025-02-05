function PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_NoF(methodKMean)
% compare Pyramidal neurons and PV interneurons on their initial peak, only
% include neurons without field
    
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    load([pathAnal 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1','PyrRise','PyrDown','PyrOther');
                    
    pathAnal1 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSig\' num2str(methodKMean) '\'];
    if(exist([pathAnal1 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']))
        load([pathAnal1 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']);
    end                  
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRecNoF\'];
    if(~exist(pathAnal0))
        mkdir(pathAnal0);
    end
    
    GlobalConstFq;
    
    %% label recordings to be excluded
    indInclRec = ones(1,length(modPyr1AL.indRec));
    for i = 1:length(excludeRec)
        ind = modPyr1AL.indRec == excludeRec(i);
        indInclRec(ind) = 0;
    end
    
    ind = modPyr1AL.indDriftRec & indInclRec;
    avgFRProfile = modPyr1AL.avgFRProfile(ind,:); % average firing rate profile good trials
    avgFRProfileStim = modPyr1AL.avgFRProfileStim(ind,:); % average firing rate profile stim trials
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl(ind,:); % average firing rate profile stim ctrl trials
    isFieldGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim(ind);
    
    PyrStim.avgFRProfile = avgFRProfile;
    PyrStim.avgFRProfileStim = avgFRProfileStim;
    PyrStim.avgFRProfileStimCtrl = avgFRProfileStimCtrl;
    PyrStim.avgFRProfileNorm = zeros(size(avgFRProfile,1),size(avgFRProfile,2));
    for i = 1:size(avgFRProfile,1)
        if(max(avgFRProfile(i,:)) ~= 0)
            PyrStim.avgFRProfileNorm(i,:) = avgFRProfile(i,:)/max(avgFRProfile(i,:));
        end
    end
    PyrStim.avgFRProfileNormStim = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfileStim(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStim(i,:) = avgFRProfileStim(i,:)/max(avgFRProfileStim(i,:));
        end
    end
    PyrStim.avgFRProfileNormStim1 = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfile(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStim1(i,:) = avgFRProfileStim(i,:)/max(avgFRProfile(i,:));
        end
    end
    PyrStim.avgFRProfileNormStimCtrl = zeros(size(avgFRProfileStimCtrl,1),size(avgFRProfileStimCtrl,2));
    for i = 1:size(avgFRProfileStimCtrl,1)
        if(max(avgFRProfileStimCtrl(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStimCtrl(i,:) = avgFRProfileStimCtrl(i,:)/max(avgFRProfileStimCtrl(i,:));
        end
    end
    
    %% PyrRise, PyrDown and PyrOther without field
    indTmp = ~ismember(PyrRise.idxRise,find(isFieldGoodNonStim == 1));
    PyrRiseNoF.idxRise = PyrRise.idxRise(indTmp);        
    PyrRiseNoF.pulseMethod = PyrRise.pulseMethod(indTmp);
    PyrRiseNoF.stimLoc = PyrRise.stimLoc(indTmp);
    PyrRiseNoF.actOrInact = PyrRise.actOrInact(indTmp);
    PyrRiseNoF.indRec = PyrRise.indRec(indTmp);
    PyrRiseNoF.indNeu = PyrRise.indNeu(indTmp);
    
    indTmp = ~ismember(PyrDown.idxDown,find(isFieldGoodNonStim == 1));
    PyrDownNoF.idxDown = PyrDown.idxDown(indTmp);        
    PyrDownNoF.pulseMethod = PyrDown.pulseMethod(indTmp);
    PyrDownNoF.stimLoc = PyrDown.stimLoc(indTmp);
    PyrDownNoF.actOrInact = PyrDown.actOrInact(indTmp);
    PyrDownNoF.indRec = PyrDown.indRec(indTmp);
    PyrDownNoF.indNeu = PyrDown.indNeu(indTmp);
    
    indTmp = ~ismember(PyrOther.idxOther,find(isFieldGoodNonStim == 1));
    PyrOtherNoF.idxOther = PyrOther.idxOther(indTmp);           
    PyrOtherNoF.pulseMethod = PyrOther.pulseMethod(indTmp);
    PyrOtherNoF.stimLoc = PyrOther.stimLoc(indTmp);
    PyrOtherNoF.actOrInact = PyrOther.actOrInact(indTmp);
    PyrOtherNoF.indRec = PyrOther.indRec(indTmp);
    PyrOtherNoF.indNeu = PyrOther.indNeu(indTmp);
    
    for cond = 1:length(PyrStim1.FRProfile1)
        
        ind = find(PyrRiseNoF.actOrInact == PyrStim1.FRProfile1{cond}.actOrInact & ...
            PyrRiseNoF.pulseMethod == PyrStim1.FRProfile1{cond}.pulseMethod & ...
            PyrRiseNoF.stimLoc == PyrStim1.FRProfile1{cond}.stimLoc);
        PyrStimNoF1.FRProfile1{cond}.actOrInact = PyrStim1.FRProfile1{cond}.actOrInact;
        PyrStimNoF1.FRProfile1{cond}.pulseMethod = PyrStim1.FRProfile1{cond}.pulseMethod;
        PyrStimNoF1.FRProfile1{cond}.stimLoc = PyrStim1.FRProfile1{cond}.stimLoc;
        PyrStimNoF1.FRProfile1{cond}.indPyrRise = PyrRiseNoF.idxRise(ind);
        PyrStimNoF1.FRProfile1{cond}.indRecPyrRise = PyrRiseNoF.indRec(ind);
        PyrStimNoF1.FRProfile1{cond}.indNeuPyrRise = PyrRiseNoF.indNeu(ind);
        
        ind = find(PyrDownNoF.actOrInact == PyrStim1.FRProfile1{cond}.actOrInact & ...
            PyrDownNoF.pulseMethod == PyrStim1.FRProfile1{cond}.pulseMethod & ...
            PyrDownNoF.stimLoc == PyrStim1.FRProfile1{cond}.stimLoc);
        PyrStimNoF1.FRProfile1{cond}.indPyrDown = PyrDownNoF.idxDown(ind);
        PyrStimNoF1.FRProfile1{cond}.indRecPyrDown = PyrDownNoF.indRec(ind);
        PyrStimNoF1.FRProfile1{cond}.indNeuPyrDown = PyrDownNoF.indNeu(ind);
        
        ind = find(PyrOtherNoF.actOrInact == PyrStim1.FRProfile1{cond}.actOrInact & ...
            PyrOtherNoF.pulseMethod == PyrStim1.FRProfile1{cond}.pulseMethod & ...
            PyrOtherNoF.stimLoc == PyrStim1.FRProfile1{cond}.stimLoc);
        PyrStimNoF1.FRProfile1{cond}.indPyrOther = PyrOtherNoF.idxOther(ind);
        PyrStimNoF1.FRProfile1{cond}.indRecPyrOther = PyrOtherNoF.indRec(ind);
        PyrStimNoF1.FRProfile1{cond}.indNeuPyrOther = PyrOtherNoF.indNeu(ind);
        
        
        %% pyramidal neurons rise and down
        PyrRiseNoF.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStimNoF1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
        PyrDownNoF.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStimNoF1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
        PyrOtherNoF.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStimNoF1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); 
        PyrRiseNoF.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStimNoF1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
        PyrDownNoF.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStimNoF1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
        PyrOtherNoF.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStimNoF1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); 
        PyrRiseNoF.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStimNoF1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
        PyrDownNoF.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStimNoF1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
        PyrOtherNoF.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStimNoF1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); 

        % compare good non-stim and stim trials rise neurons
        PyrRiseNoF.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrRiseNoF.FRProfileMean{cond},PyrRiseNoF.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials rise neurons
        PyrRiseNoF.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrRiseNoF.FRProfileMeanStim{cond},PyrRiseNoF.FRProfileMeanStimCtrl{cond});

        % compare good non-stim and stim trials down neurons
        PyrDownNoF.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrDownNoF.FRProfileMean{cond},PyrDownNoF.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials down neurons
        PyrDownNoF.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrDownNoF.FRProfileMeanStim{cond},PyrDownNoF.FRProfileMeanStimCtrl{cond});

        %% added on 7/8/2022
        % compare good non-stim and stim trials other neurons
        PyrOtherNoF.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrOtherNoF.FRProfileMean{cond},PyrOtherNoF.FRProfileMeanStim{cond});
        % compare good stim and stim ctrl trials other neurons
        PyrOtherNoF.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrOtherNoF.FRProfileMeanStim{cond},PyrOtherNoF.FRProfileMeanStimCtrl{cond});
    end
    
    save([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrRiseNoF','PyrDownNoF','PyrOtherNoF','PyrStimNoF1'); 
    
    plotPyrNeuStimUpDownAlone_NoF(pathAnal0,PyrRiseNoF.FRProfileMean,PyrDownNoF.FRProfileMean,modPyr1AL.timeStepRun,PyrStim,PyrStimNoF1.FRProfile1);
    close all;
    
    plotPyrNeuStimUpDown_NoF(pathAnal0,PyrRiseNoF.FRProfileMean,...
        modPyr1AL.timeStepRun, PyrStim, PyrStimNoF1.FRProfile1)
    close all;

    % pyr rise
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRiseNoF.FRProfileMean,PyrRiseNoF.FRProfileMeanStim,...
        PyrRiseNoF.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrRise',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRiseNoF.FRProfileMeanStimCtrl,PyrRiseNoF.FRProfileMeanStim,...
        PyrRiseNoF.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrRiseStimCtrl',0);
    close all;

    % pyr down
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDownNoF.FRProfileMean,PyrDownNoF.FRProfileMeanStim,...
        PyrDownNoF.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrDown',0);
    close all;
    
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDownNoF.FRProfileMeanStimCtrl,PyrDownNoF.FRProfileMeanStim,...
        PyrDownNoF.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrDownStimCtrl',0);
    close all;
   
    % pyr other
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOtherNoF.FRProfileMean,PyrOtherNoF.FRProfileMeanStim,...
        PyrOtherNoF.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrOther',0);
    close all;
    
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOtherNoF.FRProfileMeanStimCtrl,PyrOtherNoF.FRProfileMeanStim,...
        PyrOtherNoF.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrOtherStimCtrl',0);
    close all;
    
end