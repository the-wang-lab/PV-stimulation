function PyrIntInitPeakPVStimNonStim2ndStimCtrlSelSigChange1SelRec(methodKMean,p1,pdrift)
% compare Pyramidal neurons and PV interneurons on their initial peak
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSelSigP' num2str(p1) '-NoDriftSelRec\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSig\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']);
    end
    
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']);
    end
    
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl_km' num2str(methodKMean) '.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl_km' num2str(methodKMean) '.mat']);
    end
    
    GlobalConstFq;
    
    if(~exist(pathAnal0))
        mkdir(pathAnal0);
    end
    
    if(p1 == 99.5)
        r = 1;
    elseif(p1 == 99)
        r = 2;
    else
        r = 3;
    end

    %% added on 1/3/2024
    %     if(~isfield(modPyr1AL,'indDriftRec'))
%         %% detect recordings with significant drift
%         recDrift = [];
%         pKS = zeros(1,length(unique(modPyr1AL.indRec)));    
%         for i = unique(modPyr1AL.indRec)
%             meanCtrl = modPyr1AL.avgFRProfile(modPyr1AL.indRec == i,:);
%             meanCtrl = mean(meanCtrl,2);
% 
%             meanStim = modPyr1AL.avgFRProfileStimCtrl(modPyr1AL.indRec == i,:);
%             meanStim = mean(meanStim,2);
% 
%             pKS(i) = kruskalwallis(meanCtrl,meanStim);
%             if(pKS(i) < pdrift)
%                 recDrift = [recDrift i];
%             end
%         end
%         indDriftRec = ~ismember(modPyr1AL.indRec, recDrift);
%         modPyr1AL.recDrift = recDrift;
%         modPyr1AL.indDriftRec = indDriftRec;
%         modPyr1AL.pKSMeanFRCtrlVsStim = pKS;
%         save([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat'],'modPyr1AL'); 
%     end

    if(~isfield(modPyr1AL,'indDriftRec')) 
        %% detect recordings with significant drift
        recDrift = [];
        pRS = zeros(1,max(modPyr1AL.indRec));   
        indFRAll = find(modPyr1AL.timeStepRun >= -1 & modPyr1AL.timeStepRun < 4);
        for i = unique(modPyr1AL.indRec)
            meanCtrl = modPyr1AL.avgFRProfile(modPyr1AL.indRec == i,indFRAll);
            meanCtrl = mean(meanCtrl,2);

            meanStim = modPyr1AL.avgFRProfileStimCtrl(modPyr1AL.indRec == i,indFRAll);
            meanStim = mean(meanStim,2);

            pRS(i) = ranksum(meanCtrl,meanStim);
            if(pRS(i) < pdrift)
                recDrift = [recDrift i];
            end
        end
        indDriftRec = ~ismember(modPyr1AL.indRec, recDrift);
        modPyr1AL.recDrift = recDrift;
        modPyr1AL.indDriftRec = indDriftRec;
        modPyr1AL.pKSMeanFRCtrlVsStim = pRS;
        save([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat'],'modPyr1AL'); 
    end
    %%
        
    %% label recordings to be excluded
    indInclRec = ones(1,length(modPyr1AL.indRec));
    for i = 1:length(excludeRec)
        ind = modPyr1AL.indRec == excludeRec(i);
        indInclRec(ind) = 0;
    end

    ind = modPyr1AL.indDriftRec & indInclRec;
    modPyr1AL.actOrInact = modPyr1AL.actOrInact(ind); % is it activation or inactivation
    modPyr1AL.indRec = modPyr1AL.indRec(ind); % recording index
    modPyr1AL.indNeu = modPyr1AL.indNeu(ind); % neuron indices trials
    modPyr1AL.pulseMeth = modPyr1AL.pulseMeth(ind); % pulse method
    modPyr1AL.stimLoc = modPyr1AL.stimLoc(ind); % stimulation location on the track
    modPyr1AL.isNeuWithFieldAlignedGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim(ind); % whether this neuron has a field, good non-stim trials
    modPyr1AL.isNeuWithFieldAlignedStim = modPyr1AL.isNeuWithFieldAlignedStim(ind); % whether this neuron has a field, stim trials
    modPyr1AL.avgFRProfile = modPyr1AL.avgFRProfile(ind,:); % average firing rate profile good trials
    modPyr1AL.avgFRProfileStim = modPyr1AL.avgFRProfileStim(ind,:); % average firing rate profile stim trials
    modPyr1AL.avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl(ind,:); % average firing rate profile stim ctrl trials
    modPyr1AL.isPeakNeuArrAll = modPyr1AL.isPeakNeuArrAll(:,ind);
    modPyr1AL.pKSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pKSMeanFRNonStimVsStimCtrlBL(ind);
    modPyr1AL.pRSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pRSMeanFRNonStimVsStimCtrlBL(ind);
    modPyr1AL.pKSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pKSMeanFRNonStimVsStimCtrl0to1(ind);
    modPyr1AL.pRSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pRSMeanFRNonStimVsStimCtrl0to1(ind);
        
    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl;
    isFieldGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim;
    isFieldGoodNonStimAndStim = (modPyr1AL.isNeuWithFieldAlignedGoodNonStim | ...
        modPyr1AL.isNeuWithFieldAlignedStim);

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

%     if(~exist('PyrRise'))
%         mean0to1 = mean(avgFRProfile(:,FRProfileMeanAll.indFR0to1),2);
%         meanBefRun = mean(avgFRProfile(:,FRProfileMeanAll.indFRBefRun),2);
%         ratio0to1BefRun = mean0to1./meanBefRun;
%         [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
%         idxNan = isnan(ratio0to1BefRunOrd);
%         idxInf = isinf(ratio0to1BefRunOrd);
    %     idx = find(ratio0to1BefRunOrd < 1.25,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.8,1,'last');

    %     idx = find(ratio0to1BefRunOrd < 2,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.5,1,'last');

%         idx = find(ratio0to1BefRunOrd < 1.5,1);
%         idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');
%         
%         tsneEmbed(PyrStim.avgFRProfileNorm(indOrd,FRProfileMeanAll.indFRBefRun(1):FRProfileMeanAll.indFR0to1(end)),...
%             idx,idx1,pathAnal0,'tsneEmbedPyrRiseDown');

        %% neurons with FR increase around 0
        indOrdTmp = find(modPyr1AL.isPeakNeuArrAll(r,:) == 1);
        
        PyrRise.idxRise = indOrdTmp;
        PyrRise.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrRise.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrRise.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrRise.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrRise.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrRise.pKSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pKSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrRise.pRSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pRSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrRise.pKSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pKSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);
        PyrRise.pRSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pRSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);

        %% neurons with FR decrease around 0
        indOrdTmp = find(modPyr1AL.isPeakNeuArrAll(r,:) == -1);
        
        PyrDown.idxDown = indOrdTmp;
        PyrDown.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrDown.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrDown.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrDown.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrDown.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrDown.pKSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pKSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrDown.pRSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pRSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrDown.pKSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pKSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);
        PyrDown.pRSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pRSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);
        
        %% other neurons (added on 7/8/2022)
        indOrdTmp = find(modPyr1AL.isPeakNeuArrAll(r,:) == 0);
        PyrOther.idxOther = indOrdTmp;
        PyrOther.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrOther.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrOther.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrOther.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrOther.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrOther.pKSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pKSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrOther.pRSMeanFRNonStimVsStimCtrlBL = modPyr1AL.pRSMeanFRNonStimVsStimCtrlBL(indOrdTmp);
        PyrOther.pKSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pKSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);
        PyrOther.pRSMeanFRNonStimVsStimCtrl0to1 = modPyr1AL.pRSMeanFRNonStimVsStimCtrl0to1(indOrdTmp);

        pm3StimLoc{1} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
            & modPyr1AL.actOrInactPerRec == 1)); % stim location for inactivation
        pm3StimLoc{2} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
            & modPyr1AL.actOrInactPerRec == 2)); % stim location for activation
        % activation or inactivation
        cond = 0;
        for i = 1: 2
            % different pulse methods
            for j = 1:length(pulseMethod{i})
                if(pulseMethod{i}(j) == 3)
                    stimLocs = pm3StimLoc{i};
                else
                    stimLocs = 0;
                end
                for m = 1:length(stimLocs)  
                    cond = cond + 1;
                    ind = find(PyrRise.actOrInact == i & PyrRise.pulseMethod == pulseMethod{i}(j) ...
                            & PyrRise.stimLoc == stimLocs(m));
                    
                    PyrStim1.FRProfile1{cond}.actOrInact = i;
                    PyrStim1.FRProfile1{cond}.pulseMethod = pulseMethod{i}(j);
                    PyrStim1.FRProfile1{cond}.stimLoc = stimLocs(m);
                    PyrStim1.FRProfile1{cond}.indPyrRise = PyrRise.idxRise(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrRise = PyrRise.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrRise = PyrRise.indNeu(ind);

                    ind = find(PyrDown.actOrInact == i & PyrDown.pulseMethod == pulseMethod{i}(j) ...
                            & PyrDown.stimLoc == stimLocs(m));
                    
                    PyrStim1.FRProfile1{cond}.indPyrDown = PyrDown.idxDown(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrDown = PyrDown.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrDown = PyrDown.indNeu(ind);

                    %% added on 7/8/2022
                    ind = find(PyrOther.actOrInact == i & PyrOther.pulseMethod == pulseMethod{i}(j) ...
                            & PyrOther.stimLoc == stimLocs(m));
                    
                    PyrStim1.FRProfile1{cond}.indPyrOther = PyrOther.idxOther(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrOther = PyrOther.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrOther = PyrOther.indNeu(ind);

                    %%
                    ind = find(modPyr1AL.actOrInact == i & modPyr1AL.pulseMeth == pulseMethod{i}(j) ...
                            & modPyr1AL.stimLoc == stimLocs(m));
                    
                    PyrStim1.FRProfile1{cond}.ind = ind;
                    PyrStim1.FRProfile1{cond}.isField = isFieldGoodNonStim(ind);
                    PyrStim1.FRProfile1{cond}.isFieldComb = isFieldGoodNonStimAndStim(ind);
                    PyrStim1.FRProfile1{cond}.indField = ind(PyrStim1.FRProfile1{cond}.isField == 1);
                    PyrStim1.FRProfile1{cond}.indFieldComb = ind(PyrStim1.FRProfile1{cond}.isFieldComb ==1);

                    %% Pyramidal neurons
                    PyrStim1.FRProfileMean1{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStim1{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimCtrl1{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);

                    % compare good non-stim and stim trials
                    PyrStim1.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMean1{cond},PyrStim1.FRProfileMeanStim1{cond});
                    % compare good stim and stim ctrl trials
                    PyrStim1.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanStim1{cond},PyrStim1.FRProfileMeanStimCtrl1{cond});

                    %% Pyramidal neurons fields
                    PyrStim1.FRProfileMeanField1{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indField,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimField1{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indField,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimCtrlField1{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indField,:),modPyr1AL.timeStepRun);

                    % compare good non-stim and stim trials
                    PyrStim1.FRProfileMeanStatNonStimVsStimField{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanField1{cond},PyrStim1.FRProfileMeanStimField1{cond});
                    % compare good stim and stim ctrl trials
                    PyrStim1.FRProfileMeanStatStimVsStimCtrlField{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanStimField1{cond},PyrStim1.FRProfileMeanStimCtrlField1{cond});

                    PyrStim1.FRProfileMeanFieldComb{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indFieldComb,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimFieldComb{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indFieldComb,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimCtrlFieldComb{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indFieldComb,:),modPyr1AL.timeStepRun);

                    % compare good non-stim and stim trials
                    PyrStim1.FRProfileMeanStatNonStimVsStimFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanFieldComb{cond},PyrStim1.FRProfileMeanStimFieldComb{cond});
                    % compare good stim and stim ctrl trials
                    PyrStim1.FRProfileMeanStatStimVsStimCtrlFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanStimFieldComb{cond},PyrStim1.FRProfileMeanStimCtrlFieldComb{cond});

                    %% pyramidal neurons rise and down
                    PyrRise.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022
                    PyrRise.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022
                    PyrRise.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022

                    % compare good non-stim and stim trials rise neurons
                    PyrRise.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMean{cond},PyrRise.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials rise neurons
                    PyrRise.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanStim{cond},PyrRise.FRProfileMeanStimCtrl{cond});

                    % compare good non-stim and stim trials down neurons
                    PyrDown.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMean{cond},PyrDown.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials down neurons
                    PyrDown.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanStim{cond},PyrDown.FRProfileMeanStimCtrl{cond});

                    %% added on 7/8/2022
                    % compare good non-stim and stim trials other neurons
                    PyrOther.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMean{cond},PyrOther.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials other neurons
                    PyrOther.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanStim{cond},PyrOther.FRProfileMeanStimCtrl{cond});
                    
                    
                    %% is field or not
                    PyrRise.isNeuWithFieldAligned{cond}.isField = isFieldGoodNonStim(PyrStim1.FRProfile1{cond}.indPyrRise);
                    PyrRise.isNeuWithFieldAligned{cond}.isFieldComb = isFieldGoodNonStimAndStim(PyrStim1.FRProfile1{cond}.indPyrRise);
                    PyrDown.isNeuWithFieldAligned{cond}.isField = isFieldGoodNonStim(PyrStim1.FRProfile1{cond}.indPyrDown);
                    PyrDown.isNeuWithFieldAligned{cond}.isFieldComb = isFieldGoodNonStimAndStim(PyrStim1.FRProfile1{cond}.indPyrDown);
                    PyrOther.isNeuWithFieldAligned{cond}.isField = isFieldGoodNonStim(PyrStim1.FRProfile1{cond}.indPyrOther);
                    PyrOther.isNeuWithFieldAligned{cond}.isFieldComb = isFieldGoodNonStimAndStim(PyrStim1.FRProfile1{cond}.indPyrOther);

                    PyrRise.isNeuWithFieldAligned{cond}.numField = sum(PyrRise.isNeuWithFieldAligned{cond}.isField);
                    PyrRise.isNeuWithFieldAligned{cond}.numFieldComb = sum(PyrRise.isNeuWithFieldAligned{cond}.isFieldComb);
                    PyrDown.isNeuWithFieldAligned{cond}.numField = sum(PyrDown.isNeuWithFieldAligned{cond}.isField);
                    PyrDown.isNeuWithFieldAligned{cond}.numFieldComb = sum(PyrDown.isNeuWithFieldAligned{cond}.isFieldComb);
                    PyrOther.isNeuWithFieldAligned{cond}.numField = sum(PyrOther.isNeuWithFieldAligned{cond}.isField);
                    PyrOther.isNeuWithFieldAligned{cond}.numFieldComb = sum(PyrOther.isNeuWithFieldAligned{cond}.isFieldComb);

                    PyrRise.isNeuWithFieldAligned{cond}.idxRise = PyrStim1.FRProfile1{cond}.indPyrRise(PyrRise.isNeuWithFieldAligned{cond}.isField == 1);
                    PyrRise.isNeuWithFieldAligned{cond}.idxRiseComb = PyrStim1.FRProfile1{cond}.indPyrRise(PyrRise.isNeuWithFieldAligned{cond}.isFieldComb == 1);
                    PyrDown.isNeuWithFieldAligned{cond}.idxDown = PyrStim1.FRProfile1{cond}.indPyrDown(PyrDown.isNeuWithFieldAligned{cond}.isField == 1);            
                    PyrDown.isNeuWithFieldAligned{cond}.idxDownComb = PyrStim1.FRProfile1{cond}.indPyrDown(PyrDown.isNeuWithFieldAligned{cond}.isFieldComb == 1);
                    PyrOther.isNeuWithFieldAligned{cond}.idxOther = PyrStim1.FRProfile1{cond}.indPyrOther(PyrOther.isNeuWithFieldAligned{cond}.isField == 1);            
                    PyrOther.isNeuWithFieldAligned{cond}.idxOtherComb = PyrStim1.FRProfile1{cond}.indPyrOther(PyrOther.isNeuWithFieldAligned{cond}.isFieldComb == 1);
                    
                    %% fields from good non-stim trials
                    PyrRise.FRProfileMeanField{cond} = accumMeanPVStim(avgFRProfile(PyrRise.isNeuWithFieldAligned{cond}.idxRise,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanField{cond} = accumMeanPVStim(avgFRProfile(PyrDown.isNeuWithFieldAligned{cond}.idxDown,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanField{cond} = accumMeanPVStim(avgFRProfile(PyrOther.isNeuWithFieldAligned{cond}.idxOther,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022
                    PyrRise.FRProfileMeanFieldStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrRise.isNeuWithFieldAligned{cond}.idxRise,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanFieldStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrDown.isNeuWithFieldAligned{cond}.idxDown,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanFieldStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrOther.isNeuWithFieldAligned{cond}.idxOther,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022
                    PyrRise.FRProfileMeanFieldStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrRise.isNeuWithFieldAligned{cond}.idxRise,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanFieldStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrDown.isNeuWithFieldAligned{cond}.idxDown,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanFieldStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrOther.isNeuWithFieldAligned{cond}.idxOther,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022

                    % compare good non-stim and stim trials rise neurons
                    PyrRise.FRProfileMeanStatNonStimVsStimField{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanField{cond},PyrRise.FRProfileMeanFieldStim{cond});
                    % compare good stim and stim ctrl trials rise neurons
                    PyrRise.FRProfileMeanStatStimVsStimCtrlField{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanFieldStim{cond},PyrRise.FRProfileMeanFieldStimCtrl{cond});

                    % compare good non-stim and stim trials down neurons
                    PyrDown.FRProfileMeanStatNonStimVsStimField{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanField{cond},PyrDown.FRProfileMeanFieldStim{cond});
                    % compare good stim and stim ctrl trials down neurons
                    PyrDown.FRProfileMeanStatStimVsStimCtrlField{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanFieldStim{cond},PyrDown.FRProfileMeanFieldStimCtrl{cond});

                    %% added on 7/8/2022
                    % compare good non-stim and stim trials other neurons
                    PyrOther.FRProfileMeanStatNonStimVsStimField{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanField{cond},PyrOther.FRProfileMeanFieldStim{cond});
                    % compare good stim and stim ctrl trials other neurons
                    PyrOther.FRProfileMeanStatStimVsStimCtrlField{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanFieldStim{cond},PyrOther.FRProfileMeanFieldStimCtrl{cond});

                    %% combining the fields from good non-stim and stim trials
                    PyrRise.FRProfileMeanFieldComb{cond} = accumMeanPVStim(avgFRProfile(PyrRise.isNeuWithFieldAligned{cond}.idxRiseComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanFieldComb{cond} = accumMeanPVStim(avgFRProfile(PyrDown.isNeuWithFieldAligned{cond}.idxDownComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanFieldComb{cond} = accumMeanPVStim(avgFRProfile(PyrOther.isNeuWithFieldAligned{cond}.idxOtherComb,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022 
                    PyrRise.FRProfileMeanFieldCombStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrRise.isNeuWithFieldAligned{cond}.idxRiseComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanFieldCombStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrDown.isNeuWithFieldAligned{cond}.idxDownComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanFieldCombStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrOther.isNeuWithFieldAligned{cond}.idxOtherComb,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022 
                    PyrRise.FRProfileMeanFieldCombStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrRise.isNeuWithFieldAligned{cond}.idxRiseComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanFieldCombStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrDown.isNeuWithFieldAligned{cond}.idxDownComb,:),...
                        modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanFieldCombStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrOther.isNeuWithFieldAligned{cond}.idxOtherComb,:),...
                        modPyr1AL.timeStepRun); % added 7/8/2022 
                    
                    % compare good non-stim and stim trials rise neurons
                    PyrRise.FRProfileMeanStatNonStimVsStimFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanFieldComb{cond},PyrRise.FRProfileMeanFieldCombStim{cond});
                    % compare good stim and stim ctrl trials rise neurons
                    PyrRise.FRProfileMeanStatStimVsStimCtrlFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanFieldCombStim{cond},PyrRise.FRProfileMeanFieldCombStimCtrl{cond});

                    % compare good non-stim and stim trials down neurons
                    PyrDown.FRProfileMeanStatNonStimVsStimFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanFieldComb{cond},PyrDown.FRProfileMeanFieldCombStim{cond});
                    % compare good stim and stim ctrl trials down neurons
                    PyrDown.FRProfileMeanStatStimVsStimCtrlFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanFieldCombStim{cond},PyrDown.FRProfileMeanFieldCombStimCtrl{cond});
                    
                    %% added on 7/8/2022
                    % compare good non-stim and stim trials other neurons
                    PyrOther.FRProfileMeanStatNonStimVsStimFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanFieldComb{cond},PyrOther.FRProfileMeanFieldCombStim{cond});
                    % compare good stim and stim ctrl trials other neurons
                    PyrOther.FRProfileMeanStatStimVsStimCtrlFieldComb{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanFieldCombStim{cond},PyrOther.FRProfileMeanFieldCombStimCtrl{cond});
                end
            end
        end

        save([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1','PyrRise','PyrDown','PyrOther','-v7.3'); 
%     end
    
    
    plotPyrNeuStimUpDownAlone(pathAnal0,PyrStim1.FRProfileMean1,modPyr1AL,PyrStim,PyrStim1.FRProfile1);
    close all;
    
    plotPyrNeuWithFieldStim(pathAnal0,PyrStim1.FRProfileMean1,modPyr1AL,PyrStim,PyrStim1.FRProfile1);
    close all;

    plotPyrNeuWithFieldStimUpDown(pathAnal0,PyrStim1.FRProfileMean1,modPyr1AL,PyrStim,PyrStim1.FRProfile1,...
        PyrRise.isNeuWithFieldAligned,PyrDown.isNeuWithFieldAligned,PyrOther.isNeuWithFieldAligned);
    close all;

    plotPyrNeuStimUpDown(pathAnal0,PyrStim1.FRProfileMean1,modPyr1AL,PyrStim,PyrStim1.FRProfile1);
    close all;

    %% statistics
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMean1,PyrStim1.FRProfileMeanStim1,...
        PyrStim1.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanStimCtrl1,PyrStim1.FRProfileMeanStim1,...
        PyrStim1.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'StimCtrl',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanField1,PyrStim1.FRProfileMeanStimField1,...
        PyrStim1.FRProfileMeanStatNonStimVsStimField,[{'Nonstim'} {'Stim'}],'Field',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanStimCtrlField1,PyrStim1.FRProfileMeanStimField1,...
        PyrStim1.FRProfileMeanStatStimVsStimCtrlField,[{'StimCtrl'} {'Stim'}],'FieldStimCtrl',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanFieldComb,PyrStim1.FRProfileMeanStimFieldComb,...
        PyrStim1.FRProfileMeanStatNonStimVsStimFieldComb,[{'Nonstim'} {'Stim'}],'FieldComb',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanStimCtrlFieldComb,PyrStim1.FRProfileMeanStimFieldComb,...
        PyrStim1.FRProfileMeanStatStimVsStimCtrlFieldComb,[{'StimCtrl'} {'Stim'}],'FieldCombStimCtrl',1);
    close all;

    % pyr rise
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMean,PyrRise.FRProfileMeanStim,...
        PyrRise.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrRise',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMeanStimCtrl,PyrRise.FRProfileMeanStim,...
        PyrRise.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrRiseStimCtrl',0);
    close all;

%     plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrRise.FRProfileMean,PyrRise.FRProfileMeanStim,...
%         PyrRise.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrRiseBox');
%     close all;

    % pyr down
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMean,PyrDown.FRProfileMeanStim,...
        PyrDown.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrDown',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMeanStimCtrl,PyrDown.FRProfileMeanStim,...
        PyrDown.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrDownStimCtrl',0);
    close all;

%     plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrDown.FRProfileMean,PyrDown.FRProfileMeanStim,...
%         PyrDown.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrDownBox');
%     close all;

    % pyr other
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMean,PyrOther.FRProfileMeanStim,...
        PyrOther.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrOther',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMeanStimCtrl,PyrOther.FRProfileMeanStim,...
        PyrOther.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrOtherStimCtrl',0);
    close all;

%     plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrOther.FRProfileMean,PyrOther.FRProfileMeanStim,...
%         PyrOther.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrOtherBox');
%     close all;
    
    % pyr rise field
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMeanField,PyrRise.FRProfileMeanFieldStim,...
        PyrRise.FRProfileMeanStatNonStimVsStimField,[{'Nonstim'} {'Stim'}],'PyrRiseField',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMeanFieldComb,PyrRise.FRProfileMeanFieldCombStim,...
        PyrRise.FRProfileMeanStatNonStimVsStimFieldComb,[{'Nonstim'} {'Stim'}],'PyrRiseFieldComb',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMeanFieldCombStimCtrl,PyrRise.FRProfileMeanFieldCombStim,...
        PyrRise.FRProfileMeanStatStimVsStimCtrlFieldComb,[{'StimCtrl'} {'Stim'}],'PyrRiseFieldCombStimCtrl',1);
    close all;

    % pyr down field
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMeanField,PyrDown.FRProfileMeanFieldStim,...
        PyrDown.FRProfileMeanStatNonStimVsStimField,[{'Nonstim'} {'Stim'}],'PyrDownField',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMeanFieldComb,PyrDown.FRProfileMeanFieldCombStim,...
        PyrDown.FRProfileMeanStatNonStimVsStimFieldComb,[{'Nonstim'} {'Stim'}],'PyrDownFieldComb',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMeanFieldCombStimCtrl,PyrDown.FRProfileMeanFieldCombStim,...
        PyrDown.FRProfileMeanStatStimVsStimCtrlFieldComb,[{'StimCtrl'} {'Stim'}],'PyrDownFieldCombStimCtrl',1);
    close all;

    % pyr other field
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMeanField,PyrOther.FRProfileMeanFieldStim,...
        PyrOther.FRProfileMeanStatNonStimVsStimField,[{'Nonstim'} {'Stim'}],'PyrOtherField',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMeanFieldComb,PyrOther.FRProfileMeanFieldCombStim,...
        PyrOther.FRProfileMeanStatNonStimVsStimFieldComb,[{'Nonstim'} {'Stim'}],'PyrOtherFieldComb',1);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMeanFieldCombStimCtrl,PyrOther.FRProfileMeanFieldCombStim,...
        PyrOther.FRProfileMeanStatStimVsStimCtrlFieldComb,[{'StimCtrl'} {'Stim'}],'PyrOtherFieldCombStimCtrl',1);
    close all;
end







