function IntIntInitPeakPVStimCtrlSelRec(methodKMean)
% compare Pyramidal neurons and PV interneurons on their initial peak
%% select neuron that do not have significant difference in baseline firing rate between ctrl and stim ctrl trials
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\InterneuronPVStimALCtrlSel\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\InterneuronPVStimALCtrl\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakIntAllRecStimCtrlTr.mat']))
        load([pathAnal 'initPeakIntAllRecStimCtrlTr.mat']);
    end
    if(exist([pathAnal 'initPeakIntAllRecStimCtrlTr_km2.mat']))
        load([pathAnal 'initPeakIntAllRecStimCtrlTr_km2.mat']);
    end
    
    if(exist([pathAnal0 'initPeakIntIntAllRecStimCtrlTr.mat']))
        load([pathAnal0 'initPeakIntIntAllRecStimCtrlTr.mat']);
    end
    
    if(exist(pathAnal0) == 0)
        mkdir(pathAnal0);
    end
    if(~exist('IntStim'))
        flagIntStim = 0;
    else
        flagIntStim = 1;
    end
    
%     %% exclude certain recordings
%     recExcl = []; %[43 80];
%     ind = ~ismember(modInt1AL.indRec, recExcl);

    ind = modInt1AL.pRSMeanFRNonStimVsStimCtrlBL >= 0.01 & ...
        modInt1AL.pKSMeanFRNonStimVsStimCtrlBL >= 0.01;
    modInt1AL.actOrInact = modInt1AL.actOrInact(ind); % is it activation or inactivation
    modInt1AL.indRec = modInt1AL.indRec(ind); % recording index
    modInt1AL.indNeu = modInt1AL.indNeu(ind); % neuron indices trials
    modInt1AL.pulseMeth = modInt1AL.pulseMeth(ind); % pulse method
    modInt1AL.stimLoc = modInt1AL.stimLoc(ind); % stimulation location on the track
    modInt1AL.avgFRProfile = modInt1AL.avgFRProfile(ind,:); % average firing rate profile good trials
    modInt1AL.avgFRProfileStim = modInt1AL.avgFRProfileStim(ind,:); % average firing rate profile stim trials
    modInt1AL.avgFRProfileStimCtrl = modInt1AL.avgFRProfileStimCtrl(ind,:); % average firing rate profile stim ctrl trials
    
%     ind1= ~ismember(modInt1AL.indRecPerRec,recExcl);
%     modInt1AL.indRecPerRec = modInt1AL.indRecPerRec(ind1);
%     modInt1AL.actOrInactPerRec = modInt1AL.actOrInactPerRec(ind1);
%     modInt1AL.pulseMethPerRec = modInt1AL.pulseMethPerRec(ind1);
%     modInt1AL.stimLocPerRec = modInt1AL.stimLocPerRec(ind1);

    IntStim.pulseMethod = modInt1AL.pulseMeth;
    IntStim.stimLoc = modInt1AL.stimLoc;
    IntStim.actOrInact = modInt1AL.actOrInact;
    IntStim.indRec = modInt1AL.indRec;
    IntStim.indNeu = modInt1AL.indNeu;
    
    avgFRProfile = modInt1AL.avgFRProfile; 
    avgFRProfileStim = modInt1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modInt1AL.avgFRProfileStimCtrl;

    IntStim.avgFRProfile = avgFRProfile;
    IntStim.avgFRProfileStim = avgFRProfileStim;
    IntStim.avgFRProfileStimCtrl = avgFRProfileStimCtrl;
    IntStim.avgFRProfileNorm = zeros(size(avgFRProfile,1),size(avgFRProfile,2));
    for i = 1:size(avgFRProfile,1)
        if(max(avgFRProfile(i,:)) ~= 0)
            IntStim.avgFRProfileNorm(i,:) = avgFRProfile(i,:)/max(avgFRProfile(i,:));
        end
    end
    IntStim.avgFRProfileNormStim = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfileStim(i,:)) ~= 0)
            IntStim.avgFRProfileNormStim(i,:) = avgFRProfileStim(i,:)/max(avgFRProfileStim(i,:));
        end
    end
    IntStim.avgFRProfileNormStimCtrl = zeros(size(avgFRProfileStimCtrl,1),size(avgFRProfileStimCtrl,2));
    for i = 1:size(avgFRProfileStimCtrl,1)
        if(max(avgFRProfileStimCtrl(i,:)) ~= 0)
            IntStim.avgFRProfileNormStimCtrl(i,:) = avgFRProfileStimCtrl(i,:)/max(avgFRProfileStimCtrl(i,:));
        end
    end
    IntStim.idxC2Int = modInt1AL.idxC2(ind);
    IntStim.indInt = ind;
    
    pm3StimLoc{1} = unique(modInt1AL.stimLocPerRec(modInt1AL.pulseMethPerRec == 3 ...
        & modInt1AL.actOrInactPerRec == 1)); % stim location for inactivation
    pm3StimLoc{2} = unique(modInt1AL.stimLocPerRec(modInt1AL.pulseMethPerRec == 3 ...
        & modInt1AL.actOrInactPerRec == 2)); % stim location for activation
    
    if(flagIntStim == 0)
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
                    ind = find(IntStim.actOrInact == i & IntStim.pulseMethod == pulseMethod{i}(j) ...
                        & IntStim.stimLoc == stimLocs(m));
                    IntStim.FRProfile1{cond}.actOrInact = i;
                    IntStim.FRProfile1{cond}.pulseMethod = pulseMethod{i}(j);
                    IntStim.FRProfile1{cond}.stimLoc = stimLocs(m);
                    IntStim.FRProfile1{cond}.ind = ind;
                    IntStim.FRProfile1{cond}.indRecInt = IntStim.indRec(ind);
                    IntStim.FRProfile1{cond}.indNeuInt = IntStim.indNeu(ind);

                    IntStim.FRProfileMean1{cond} = accumMeanPVStim(avgFRProfile(IntStim.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);
                    IntStim.FRProfileMeanStim1{cond} = accumMeanPVStim(avgFRProfileStim(IntStim.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);
                    IntStim.FRProfileMeanStimCtrl1{cond} = accumMeanPVStim(avgFRProfileStimCtrl(IntStim.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);

                    if(~isempty(IntStim.FRProfileMean1{cond}.meanAvgFRProfileAll))
                    % compare good non-stim and stim trials
                        IntStim.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(IntStim.FRProfileMean1{cond},IntStim.FRProfileMeanStim1{cond});
                        % compare good stim and stim ctrl trials
                        IntStim.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(IntStim.FRProfileMeanStim1{cond},IntStim.FRProfileMeanStimCtrl1{cond});
                    else
                        IntStim.FRProfileMeanStatNonStimVsStim{cond} = [];
                        IntStim.FRProfileMeanStatStimVsStimCtrl{cond} = [];
                    end
                end
            end
        end
        save([pathAnal0 'initPeakIntIntAllRecStimCtrlTr.mat'],'IntStim');
    
         %% Interneuron rise and down
        for inte = 1:max(IntStim.idxC2Int)
            idxCTmp = find(IntStim.idxC2Int == inte);
            mean0to1 = mean(avgFRProfile(idxCTmp,FRProfileMeanAll.indFR0to1),2);
            meanBefRun = mean(avgFRProfile(idxCTmp,FRProfileMeanAll.indFRBefRun),2);
            ratio0to1BefRun = mean0to1./meanBefRun;
            [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
            idxNan = isnan(ratio0to1BefRunOrd);
            idxInf = isinf(ratio0to1BefRunOrd);
        %     idx = find(ratio0to1BefRunOrd < 1.25,1);
        %     idx1 = find(ratio0to1BefRunOrd >= 0.8,1,'last');

        %     idx = find(ratio0to1BefRunOrd < 2,1);
        %     idx1 = find(ratio0to1BefRunOrd >= 0.5,1,'last');

            idx = find(ratio0to1BefRunOrd < 1.5,1);
            idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');


            %% neurons with FR increase around 0
            indOrdTmp = idxCTmp(indOrd(1:idx));
            idxNanTmp = idxNan(1:idx);
            idxInfTmp = idxInf(1:idx);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntRise{inte}.idxRise = indOrdTmp;
            IntRise{inte}.pulseMethod = modInt1AL.pulseMeth(indOrdTmp);
            IntRise{inte}.stimLoc = modInt1AL.stimLoc(indOrdTmp);
            IntRise{inte}.actOrInact = modInt1AL.actOrInact(indOrdTmp);
            IntRise{inte}.indRec = modInt1AL.indRec(indOrdTmp);
            IntRise{inte}.indNeu = modInt1AL.indNeu(indOrdTmp);

            %% neurons with FR decrease around 0
            indOrdTmp = idxCTmp(indOrd(idx1:end));
            idxNanTmp = idxNan(idx1:end);
            idxInfTmp = idxInf(idx1:end);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntDown{inte}.idxDown = indOrdTmp;
            IntDown{inte}.pulseMethod = modInt1AL.pulseMeth(indOrdTmp);
            IntDown{inte}.stimLoc = modInt1AL.stimLoc(indOrdTmp);
            IntDown{inte}.actOrInact = modInt1AL.actOrInact(indOrdTmp);
            IntDown{inte}.indRec = modInt1AL.indRec(indOrdTmp);
            IntDown{inte}.indNeu = modInt1AL.indNeu(indOrdTmp);

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
                        ind = find(IntRise{inte}.actOrInact == i & IntRise{inte}.pulseMethod == pulseMethod{i}(j) ...
                            & IntRise{inte}.stimLoc == stimLocs(m));
                        IntStim1{inte}.FRProfile1{cond}.actOrInact = i;
                        IntStim1{inte}.FRProfile1{cond}.pulseMethod = pulseMethod{i}(j);
                        IntStim1{inte}.FRProfile1{cond}.stimLoc = stimLocs(m);
                        IntStim1{inte}.FRProfile1{cond}.indIntRise = IntRise{inte}.idxRise(ind);
                        IntStim1{inte}.FRProfile1{cond}.indRecIntRise = IntRise{inte}.indRec(ind);
                        IntStim1{inte}.FRProfile1{cond}.indNeuIntRise = IntRise{inte}.indNeu(ind);
                        ind = find(IntDown{inte}.actOrInact == i & IntDown{inte}.pulseMethod == pulseMethod{i}(j) ...
                            & IntDown{inte}.stimLoc == stimLocs(m));
                        IntStim1{inte}.FRProfile1{cond}.indIntDown = IntDown{inte}.idxDown(ind);
                        IntStim1{inte}.FRProfile1{cond}.indRecIntDown = IntDown{inte}.indRec(ind);
                        IntStim1{inte}.FRProfile1{cond}.indNeuIntDown = IntDown{inte}.indNeu(ind);
                        
                        ind = find(modInt1AL.actOrInact == i & modInt1AL.pulseMeth == pulseMethod{i}(j) ...
                            & modInt1AL.stimLoc == stimLocs(m) & IntStim.idxC2Int == inte);
                        IntStim1{inte}.FRProfile1{cond}.ind = ind;
                       
                        %% Interneurons
                        IntStim1{inte}.FRProfileMean1{cond} = accumMeanPVStim(avgFRProfile(IntStim1{inte}.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);
                        IntStim1{inte}.FRProfileMeanStim1{cond} = accumMeanPVStim(avgFRProfileStim(IntStim1{inte}.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);
                        IntStim1{inte}.FRProfileMeanStimCtrl1{cond} = accumMeanPVStim(avgFRProfileStimCtrl(IntStim1{inte}.FRProfile1{cond}.ind,:),modInt1AL.timeStepRun);

                        if(~isempty(IntStim1{inte}.FRProfileMean1{cond}.meanAvgFRProfileAll))
                        % compare good non-stim and stim trials
                            IntStim1{inte}.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(IntStim1{inte}.FRProfileMean1{cond},IntStim1{inte}.FRProfileMeanStim1{cond});
                            % compare good stim and stim ctrl trials
                            IntStim1{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(IntStim1{inte}.FRProfileMeanStim1{cond},IntStim1{inte}.FRProfileMeanStimCtrl1{cond});
                        else
                            IntStim1{inte}.FRProfileMeanStatNonStimVsStim{cond} = [];
                            IntStim1{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = [];
                        end
                        
                        %% interneurons rise and down
                        IntRise{inte}.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(IntStim1{inte}.FRProfile1{cond}.indIntRise,:),modInt1AL.timeStepRun);
                        IntDown{inte}.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(IntStim1{inte}.FRProfile1{cond}.indIntDown,:),modInt1AL.timeStepRun);
                        IntRise{inte}.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(IntStim1{inte}.FRProfile1{cond}.indIntRise,:),modInt1AL.timeStepRun);
                        IntDown{inte}.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(IntStim1{inte}.FRProfile1{cond}.indIntDown,:),modInt1AL.timeStepRun);
                        IntRise{inte}.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(IntStim1{inte}.FRProfile1{cond}.indIntRise,:),modInt1AL.timeStepRun);
                        IntDown{inte}.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(IntStim1{inte}.FRProfile1{cond}.indIntDown,:),modInt1AL.timeStepRun);
                        
                        % compare good non-stim and stim trials rise neurons
                        if(~isempty(IntRise{inte}.FRProfileMean{cond}.meanAvgFRProfileAll))
                            IntRise{inte}.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(IntRise{inte}.FRProfileMean{cond},IntRise{inte}.FRProfileMeanStim{cond});
                            % compare good stim and stim ctrl trials rise neurons
                            IntRise{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(IntRise{inte}.FRProfileMeanStim{cond},IntRise{inte}.FRProfileMeanStimCtrl{cond});
                        else
                            IntRise{inte}.FRProfileMeanStatNonStimVsStim{cond} = [];
                            IntRise{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = [];
                        end
                        
                        if(~isempty(IntDown{inte}.FRProfileMean{cond}.meanAvgFRProfileAll))
                            % compare good non-stim and stim trials down neurons
                            IntDown{inte}.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(IntDown{inte}.FRProfileMean{cond},IntDown{inte}.FRProfileMeanStim{cond});
                            % compare good stim and stim ctrl trials down neurons
                            IntDown{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(IntDown{inte}.FRProfileMeanStim{cond},IntDown{inte}.FRProfileMeanStimCtrl{cond});
                        else
                            IntDown{inte}.FRProfileMeanStatNonStimVsStim{cond} = [];
                            IntDown{inte}.FRProfileMeanStatStimVsStimCtrl{cond} = [];
                        end
                    end
                end
            end            
        end
        save([pathAnal0 'initPeakIntIntAllRecStimCtrlTr.mat'],'IntStim1','IntRise','IntDown','-append'); 
    end
    
    %% interneurons separated by stim conditions
%     plotIntNeuStimIndNeu(pathAnal0,IntStim.FRProfileMean1,modInt1AL,IntStim,IntStim.FRProfile1);
    close all; 
    
    %% interneurons separated by stim conditions and clusters
    for i = 1:max(IntStim.idxC2Int)
        plotIntNeuStimUpDown(pathAnal0,IntStim1{i}.FRProfileMean1,modInt1AL,IntStim,IntStim1{i}.FRProfile1,i);
        close all;
    
%         %% statistics
%         plotIntNeuWithFieldStimStats(pathAnal0,IntStim1{i}.FRProfileMean1,IntStim1{i}.FRProfileMeanStim1,...
%             IntStim1{i}.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'',0,i);
%         close all;

%         plotIntNeuWithFieldStimStats(pathAnal0,IntStim1{i}.FRProfileMeanStimCtrl1,IntStim1{i}.FRProfileMeanStim1,...
%             IntStim1{i}.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'StimCtrl',0,i);
%         close all;

%         % int rise
%         plotIntNeuWithFieldStimStats(pathAnal0,IntRise{i}.FRProfileMean,IntRise{i}.FRProfileMeanStim,...
%             IntRise{i}.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'IntRise',0,i);
%         close all;

%         plotIntNeuWithFieldStimStats(pathAnal0,IntRise{i}.FRProfileMeanStimCtrl,IntRise{i}.FRProfileMeanStim,...
%             IntRise{i}.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'IntRiseStimCtrl',0,i);
%         close all;
    
%         % int down
%         plotIntNeuWithFieldStimStats(pathAnal0,IntDown.FRProfileMean,IntDown.FRProfileMeanStim,...
%             IntDown.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'IntDown',0,i);
%         close all;
% 
%         plotIntNeuWithFieldStimStats(pathAnal0,IntDown.FRProfileMeanStimCtrl,IntDown.FRProfileMeanStim,...
%             IntDown.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'IntDownStimCtrl',0,i);
%         close all;
    end
    
end







