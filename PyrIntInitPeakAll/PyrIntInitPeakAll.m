function PyrIntInitPeakAll(taskSel)
% compare Pyramidal neurons and PV interneurons on their initial peak (including all the recordings where the number of good trials >= minNumTr...
% regardless of the number of bad trials), If there is 0 bad trials, then
% avgProfile is a zero vector. This is good for comparing good and bad
% trials using color coded firing rate map, but not for calculating the
% firing rate change and comparing avgProfile. Use PyrIntInitPeak for that (where the neurons with >= minNumTr bad trials are considered)
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    pathAnalInt0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    if(exist([pathAnalInt0 'initPeakIntAllRec.mat']))
        load([pathAnalInt0 'initPeakIntAllRec.mat']);
    end
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    if(taskSel == 1) % including all the neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAll\';
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAllALPL\';
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAllAL\';
    end
    if(exist([pathAnal 'initPeakAllPyrIntAllRec.mat']))
        load([pathAnal 'initPeakAllPyrIntAllRec.mat']);
    end
    
    if(exist('InitAll') == 0)
        minNumTrBad = 0;
        minNumTr = 15; % should be the same as paramF.minNumTr used inFieldDetectionAligned
        InitAll = PyrIntInitPeakByTypeAll(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    modInt1NoCue,modInt1AL,modInt1PL,minNumTr,minNumTrBad);


        %% pyramidal rise and down
        mean0to1 = mean(InitAll.avgFRProfile(InitAll.goodNeu,FRProfileMean.indFR0to1),2);
        meanBefRun = mean(InitAll.avgFRProfile(InitAll.goodNeu,FRProfileMean.indFRBefRun),2);
        ratio0to1BefRun = mean0to1./meanBefRun;
        [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
        idxNan = isnan(ratio0to1BefRunOrd);
        idxInf = isinf(ratio0to1BefRunOrd);
    %     idx = find(ratio0to1BefRunOrd < 1.25,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.8,1,'last');

    %     idx = find(ratio0to1BefRunOrd < 2,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.5,1,'last');
    
        idx = find(ratio0to1BefRun >= 1.5);
        idx1 = find(ratio0to1BefRun <= 2/3);
        idx2 = find(ratio0to1BefRun > 2/3 & ratio0to1BefRun < 1.5);
        idxGood = find(~isnan(ratio0to1BefRun) & ~isinf(ratio0to1BefRun));
        idxR = intersect(idx,idxGood);
        idxD = intersect(idx1,idxGood);
        idxO = intersect(idx2,idxGood);
        tsneEmbed(InitAll.avgFRProfileNorm(InitAll.goodNeu([idxR',idxO',idxD']),FRProfileMean.indFRBefRun(1):FRProfileMean.indFR0to1(end)),...
            length(idxR),length(idxR)+length(idxO)+1,pathAnal,'tsneEmbedPyrRiseDown');

        idx = find(ratio0to1BefRunOrd < 1.5,1);
        idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');

        % neurons with FR increase around 0
        indOrdTmp = indOrd(1:idx);
        idxNanTmp = idxNan(1:idx);
        idxInfTmp = idxInf(1:idx);
        indOrdTmp = InitAll.goodNeu(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrRise.idxRise = indOrdTmp;
        PyrRise.task = InitAll.task(indOrdTmp);
        PyrRise.indRec = InitAll.indRec(indOrdTmp);
        PyrRise.indNeu = InitAll.indNeu(indOrdTmp);
        
        % neurons with FR decrease around 0
        indOrdTmp = indOrd(idx1:end);
        idxNanTmp = idxNan(idx1:end);
        idxInfTmp = idxInf(idx1:end);
        indOrdTmp = InitAll.goodNeu(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrDown.idxDown = indOrdTmp;
        PyrDown.task = InitAll.task(indOrdTmp);
        PyrDown.indRec = InitAll.indRec(indOrdTmp);
        PyrDown.indNeu = InitAll.indNeu(indOrdTmp);
                
        % added on 7/9/2022
        % neurons with FR decrease around 0
        indOrdTmp = indOrd(idx+1:idx1-1);
        idxNanTmp = idxNan(idx+1:idx1-1);
        idxInfTmp = idxInf(idx+1:idx1-1);
        indOrdTmp = InitAll.goodNeu(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrOther.idxOther = indOrdTmp;
        PyrOther.task = InitAll.task(indOrdTmp);
        PyrOther.indRec = InitAll.indRec(indOrdTmp);
        PyrOther.indNeu = InitAll.indNeu(indOrdTmp);

        %% Interneuron rise and down
        for i = 1:max(InitAll.idxC2Int)
            idxCTmp = find(InitAll.idxC2Int == i);
            idxCTmp = intersect(idxCTmp,InitAll.goodNeuInt);
            mean0to1Int = mean(InitAll.avgFRProfileInt(idxCTmp,FRProfileMean.indFR0to1),2);
            meanBefRunInt = mean(InitAll.avgFRProfileInt(idxCTmp,FRProfileMean.indFRBefRun),2);
            ratio0to1BefRunInt = mean0to1Int./meanBefRunInt;
            [ratio0to1BefRunIntOrd,indOrdInt] = sort(ratio0to1BefRunInt,'descend');
        %     idxInt = find(ratio0to1BefRunIntOrd < 1.25,1);
        %     idxInt1 = find(ratio0to1BefRunIntOrd >= 0.8,1,'last');

        %     idxInt = find(ratio0to1BefRunIntOrd < 2,1);
        %     idxInt1 = find(ratio0to1BefRunIntOrd >= 0.5,1,'last');

            idxNan = isnan(ratio0to1BefRunIntOrd);
            idxInf = isinf(ratio0to1BefRunIntOrd);
            idxInt = find(ratio0to1BefRunIntOrd < 1.5,1);
            idxInt1 = find(ratio0to1BefRunIntOrd >= 2/3,1,'last');

            %% neurons with FR increase around 0
            indOrdTmp = idxCTmp(indOrdInt(1:idxInt));
            idxNanTmp = idxNan(1:idxInt);
            idxInfTmp = idxInf(1:idxInt);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntRise.idxRise{i} = indOrdTmp;
            IntRise.task{i} = InitAll.taskInt(indOrdTmp);
            IntRise.indRec{i} = InitAll.indRecInt(indOrdTmp);
            IntRise.indNeu{i} = InitAll.indNeuInt(indOrdTmp);
            
            %% neurons with FR decrease around 0
            indOrdTmp = idxCTmp(indOrdInt(idxInt1:end));
            idxNanTmp = idxNan(idxInt1:end);
            idxInfTmp = idxInf(idxInt1:end);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntDown.idxDown{i} = indOrdTmp;
            IntDown.task{i} = InitAll.taskInt(indOrdTmp);
            IntDown.indRec{i} = InitAll.indRecInt(indOrdTmp);
            IntDown.indNeu{i} = InitAll.indNeuInt(indOrdTmp);
        end

        %% pyramidal neurons
        relDepthNeuHDefPyr.depthRise = InitAll.relDepthNeuHDef(PyrRise.idxRise);
        relDepthNeuHDefPyr.depthDown = InitAll.relDepthNeuHDef(PyrDown.idxDown);
        relDepthNeuHDefPyr.depthOther = InitAll.relDepthNeuHDef(PyrOther.idxOther);% added on 7/8/2022
        relDepthNeuHDefPyr.depthRiseMean = mean(relDepthNeuHDefPyr.depthRise);
        relDepthNeuHDefPyr.depthDownMean = mean(relDepthNeuHDefPyr.depthDown);
        relDepthNeuHDefPyr.depthOtherMean = mean(relDepthNeuHDefPyr.depthOther);% added on 7/8/2022
        relDepthNeuHDefPyr.depthRiseSem = std(relDepthNeuHDefPyr.depthRise)/...
                sqrt(length(relDepthNeuHDefPyr.depthRise));
        relDepthNeuHDefPyr.depthDownSem = std(relDepthNeuHDefPyr.depthDown)/...
                sqrt(length(relDepthNeuHDefPyr.depthDown));  
        relDepthNeuHDefPyr.depthOtherSem = std(relDepthNeuHDefPyr.depthOther)/...
                sqrt(length(relDepthNeuHDefPyr.depthOther));  % added on 7/8/2022
        relDepthNeuHDefPyr.pRSRelDepthNeuHDef = ranksum(relDepthNeuHDefPyr.depthRise,relDepthNeuHDefPyr.depthDown);
        relDepthNeuHDefPyr.pRSRelDepthNeuHDefRO = ranksum(relDepthNeuHDefPyr.depthRise,relDepthNeuHDefPyr.depthOther);% added on 7/8/2022
        relDepthNeuHDefPyr.pRSRelDepthNeuHDefDO = ranksum(relDepthNeuHDefPyr.depthDown,relDepthNeuHDefPyr.depthOther);% added on 7/8/2022

        %% for field
        isNeuWithFieldAligned.isFieldRise = InitAll.isNeuWithFieldAligned(PyrRise.idxRise);
        isNeuWithFieldAligned.isFieldDown = InitAll.isNeuWithFieldAligned(PyrDown.idxDown);
        isNeuWithFieldAligned.isFieldOther = InitAll.isNeuWithFieldAligned(PyrOther.idxOther); % added on 7/8/2022
        isNeuWithFieldAligned.numFieldRise = sum(isNeuWithFieldAligned.isFieldRise);
        isNeuWithFieldAligned.numFieldDown = sum(isNeuWithFieldAligned.isFieldDown);
        isNeuWithFieldAligned.numFieldOther = sum(isNeuWithFieldAligned.isFieldOther); % added on 7/8/2022
        isNeuWithFieldAligned.idxRise = PyrRise.idxRise(isNeuWithFieldAligned.isFieldRise == 1);
        isNeuWithFieldAligned.idxDown = PyrDown.idxDown(isNeuWithFieldAligned.isFieldDown == 1);
        isNeuWithFieldAligned.idxOther = PyrOther.idxOther(isNeuWithFieldAligned.isFieldOther == 1); % added on 7/8/2022
    
        FRProfileMeanPyr.RiseField = accumMeanPVStim(InitAll.avgFRProfile(isNeuWithFieldAligned.idxRise,:),...
            modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.DownField = accumMeanPVStim(InitAll.avgFRProfile(isNeuWithFieldAligned.idxDown,:),...
            modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.OtherField = accumMeanPVStim(InitAll.avgFRProfile(isNeuWithFieldAligned.idxOther,:),...
            modPyr1NoCue.timeStepRun); % added on 7/8/2022
        FRProfileMeanPyr.RiseFieldBad = accumMeanPVStim(InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxRise,:),...
            modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.DownFieldBad = accumMeanPVStim(InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxDown,:),...
            modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.OtherFieldBad = accumMeanPVStim(InitAll.avgFRProfileBad(isNeuWithFieldAligned.idxOther,:),...
            modPyr1NoCue.timeStepRun); % added on 7/8/2022

        FRProfileMeanPyrStat.RiseField = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.RiseField);
        FRProfileMeanPyrStat.DownField = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.DownField);
        FRProfileMeanPyrStat.OtherField = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.OtherField); % added on 7/8/2022
        
        FRProfileMeanPyrStat.RiseFieldBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.RiseFieldBad);
        FRProfileMeanPyrStat.DownFieldBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.DownFieldBad);
        FRProfileMeanPyrStat.OtherFieldBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.OtherFieldBad); % added on 7/8/2022
        
        % compare good and bad trials
        FRProfileMeanPyrStat.RiseFieldGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.RiseField,FRProfileMeanPyr.RiseFieldBad);
        FRProfileMeanPyrStat.DownFieldGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.DownField,FRProfileMeanPyr.DownFieldBad);
        FRProfileMeanPyrStat.OtherFieldGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.OtherField,FRProfileMeanPyr.OtherFieldBad); % added on 7/8/2022
        
        %% for all the pyramidal neurons
        FRProfileMeanPyr.Rise = accumMeanPVStim(InitAll.avgFRProfile(PyrRise.idxRise,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Down = accumMeanPVStim(InitAll.avgFRProfile(PyrDown.idxDown,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Other = accumMeanPVStim(InitAll.avgFRProfile(PyrOther.idxOther,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

        FRProfileMeanPyr.RiseBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrRise.idxRise,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.DownBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrDown.idxDown,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.OtherBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrOther.idxOther,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

        FRProfileMeanPyrStat.Rise = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.Rise);
        FRProfileMeanPyrStat.Down = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.Down);
        FRProfileMeanPyrStat.Other = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.Other); % added on 7/8/2022
        
        FRProfileMeanPyrStat.RiseBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.RiseBad);
        FRProfileMeanPyrStat.DownBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.DownBad);
        FRProfileMeanPyrStat.OtherBad = accumMeanPyrIntInitPeakStatC(FRProfileMeanPyr.OtherBad); % added on 7/8/2022

        % compare good and bad trials
        FRProfileMeanPyrStat.RiseGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.Rise,FRProfileMeanPyr.RiseBad);
        FRProfileMeanPyrStat.DownGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.Down,FRProfileMeanPyr.DownBad);
        FRProfileMeanPyrStat.OtherGoodBad = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyr.Other,FRProfileMeanPyr.OtherBad); % added on 7/8/2022

        %% for all the interneurons
        for i = 1:max(InitAll.idxC2Int)
            FRProfileMeanInt.Rise{i} = accumMeanPVStim(InitAll.avgFRProfileInt(IntRise.idxRise{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanInt.Down{i} = accumMeanPVStim(InitAll.avgFRProfileInt(IntDown.idxDown{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanInt.RiseBad{i} = accumMeanPVStim(InitAll.avgFRProfileBadInt(IntRise.idxRise{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanInt.DownBad{i} = accumMeanPVStim(InitAll.avgFRProfileBadInt(IntDown.idxDown{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanIntStat.Rise{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanInt.Rise{i});
            FRProfileMeanIntStat.Down{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanInt.Down{i});

            FRProfileMeanIntStat.RiseBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanInt.RiseBad{i});
            FRProfileMeanIntStat.DownBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanInt.DownBad{i});

            % compare good and bad trials
            FRProfileMeanIntStat.RiseGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanInt.Rise{i},FRProfileMeanInt.RiseBad{i});
    %         FRProfileMeanIntStat.DownGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanInt.Down{i},FRProfileMeanInt.DownBad{i});
        end

        save([pathAnal 'initPeakAllPyrIntAllRec.mat'],'InitAll','PyrRise','PyrDown','PyrOther',...
            'IntRise','IntDown',...
            'FRProfileMeanPyr','FRProfileMeanPyrStat',...
            'FRProfileMeanInt','FRProfileMeanIntStat',...
            'relDepthNeuHDefPyr','isNeuWithFieldAligned','minNumTr','-v7.3'); 
    end
    
%     %% plot depth of rise and down pyramidal neurons
    colorSel = 0;
%     plotBoxPlot(relDepthNeuHDefPyr.depthRise,...
%         relDepthNeuHDefPyr.depthDown,'Depth',...
%         'Pyr_relDepthNeuHDefRiseVsDown',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDef,colorSel,[{'Rise'} {'Down'}]);
%     
    plotPyrNeuRiseDownFieldAll(pathAnal,modInt1NoCue.timeStepRun,InitAll,...
            isNeuWithFieldAligned,FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,[{'Good'} {'Bad'}]);
    close all;
    
    plotPyrNeuRiseDownAll(pathAnal,modInt1NoCue.timeStepRun,InitAll,PyrRise,PyrDown,PyrOther,...
            FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,[{'Good'} {'Bad'}]);
    close all;
    
    plotIntNeuRiseDownAll(pathAnal,modInt1NoCue.timeStepRun,...
            InitAll,IntRise,IntDown,FRProfileMean,FRProfileMeanInt,FRProfileMeanIntStat,colorSel,[{'Good'} {'Bad'}]);
    close all;
end





