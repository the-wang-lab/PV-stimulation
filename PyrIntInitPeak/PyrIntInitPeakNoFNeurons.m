function PyrIntInitPeakNoFNeurons(taskSel)
% compare Pyramidal neurons and PV interneurons on their initial peak
    
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
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakNoFNeu\';
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakNoFNeuALPL\';
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakNoFNeuAL\';
    end
    if(exist([pathAnal 'initPeakPyrIntAllRecNoFNeu.mat']))
        load([pathAnal 'initPeakPyrIntAllRecNoFNeu.mat']);
    end
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    if(exist('InitAll') == 0)
        InitAll = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    modInt1NoCue,modInt1AL,modInt1PL);

        indNoF = find(InitAll.isNeuWithFieldAligned == 0);
        
        %% pyramidal rise and down
        mean0to1 = mean(InitAll.avgFRProfile(indNoF,FRProfileMean.indFR0to1),2);
        meanBefRun = mean(InitAll.avgFRProfile(indNoF,FRProfileMean.indFRBefRun),2);
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
        tsneEmbed(InitAll.avgFRProfileNorm([idxR',idxO',idxD'],FRProfileMean.indFRBefRun(1):FRProfileMean.indFR0to1(end)),...
            length(idxR),length(idxR)+length(idxO)+1,pathAnal,'tsneEmbedPyrRiseDown');
        
        idx = find(ratio0to1BefRunOrd < 1.5,1);
        idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');
        % neurons with FR increase around 0
        indOrdTmp = indOrd(1:idx);
        idxNanTmp = idxNan(1:idx);
        idxInfTmp = idxInf(1:idx);
        indOrdTmp = indNoF(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrRise.idxRise = indOrdTmp;
        PyrRise.task = InitAll.task(indOrdTmp);
        PyrRise.indRec = InitAll.indRec(indOrdTmp);
        PyrRise.indNeu = InitAll.indNeu(indOrdTmp);
        PyrRise.idxRiseBadBad = [];
        PyrRise.idxRiseBad = [];
        PyrRise.taskBad = [];
        PyrRise.indRecBad = [];
        PyrRise.indNeuBad = [];
        for i = 1:length(indOrdTmp)
            idxBad = find(InitAll.taskBad == PyrRise.task(i) & InitAll.indRecBad == PyrRise.indRec(i) ...
                & InitAll.indNeuBad == PyrRise.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrRise.idxRise(i);
                PyrRise.idxRiseBadBad = [PyrRise.idxRiseBadBad idxBad];
                PyrRise.idxRiseBad = [PyrRise.idxRiseBad idxBad1];
                PyrRise.taskBad = [PyrRise.taskBad InitAll.taskBad(idxBad)];
                PyrRise.indRecBad = [PyrRise.indRecBad InitAll.indRecBad(idxBad)];
                PyrRise.indNeuBad = [PyrRise.indNeuBad InitAll.indNeuBad(idxBad)];
            end
        end

        % neurons with FR decrease around 0
        indOrdTmp = indOrd(idx1:end);
        idxNanTmp = idxNan(idx1:end);
        idxInfTmp = idxInf(idx1:end);
        indOrdTmp = indNoF(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrDown.idxDown = indOrdTmp;
        PyrDown.task = InitAll.task(indOrdTmp);
        PyrDown.indRec = InitAll.indRec(indOrdTmp);
        PyrDown.indNeu = InitAll.indNeu(indOrdTmp);
        PyrDown.idxDownBad = [];
        PyrDown.idxDownBadBad = [];
        PyrDown.taskBad = [];
        PyrDown.indRecBad = [];
        PyrDown.indNeuBad = [];
        for i = 1:length(indOrdTmp)
            idxBad = find(InitAll.taskBad == PyrDown.task(i) & InitAll.indRecBad == PyrDown.indRec(i) ...
                & InitAll.indNeuBad == PyrDown.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrDown.idxDown(i);
                PyrDown.idxDownBadBad = [PyrDown.idxDownBadBad idxBad];
                PyrDown.idxDownBad = [PyrDown.idxDownBad idxBad1];
                PyrDown.taskBad = [PyrDown.taskBad InitAll.taskBad(idxBad)];
                PyrDown.indRecBad = [PyrDown.indRecBad InitAll.indRecBad(idxBad)];
                PyrDown.indNeuBad = [PyrDown.indNeuBad InitAll.indNeuBad(idxBad)];
            end
        end

        % other neurons (added on 7/9/2022)
        indOrdTmp = indOrd(idx+1:idx1-1);
        idxNanTmp = idxNan(idx+1:idx1-1);
        idxInfTmp = idxInf(idx+1:idx1-1);
        indOrdTmp = indNoF(indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0));
        PyrOther.idxOther = indOrdTmp;
        PyrOther.task = InitAll.task(indOrdTmp);
        PyrOther.indRec = InitAll.indRec(indOrdTmp);
        PyrOther.indNeu = InitAll.indNeu(indOrdTmp);
        PyrOther.idxOtherBad = [];
        PyrOther.idxOtherBadBad = [];
        PyrOther.taskBad = [];
        PyrOther.indRecBad = [];
        PyrOther.indNeuBad = [];
        for i = 1:length(indOrdTmp)
            idxBad = find(InitAll.taskBad == PyrOther.task(i) & InitAll.indRecBad == PyrOther.indRec(i) ...
                & InitAll.indNeuBad == PyrOther.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrOther.idxOther(i);
                PyrOther.idxOtherBadBad = [PyrOther.idxOtherBadBad idxBad];
                PyrOther.idxOtherBad = [PyrOther.idxOtherBad idxBad1];
                PyrOther.taskBad = [PyrOther.taskBad InitAll.taskBad(idxBad)];
                PyrOther.indRecBad = [PyrOther.indRecBad InitAll.indRecBad(idxBad)];
                PyrOther.indNeuBad = [PyrOther.indNeuBad InitAll.indNeuBad(idxBad)];
            end
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

        %% for all the pyramidal neurons
        FRProfileMeanPyr.Rise = accumMeanPVStim(InitAll.avgFRProfile(PyrRise.idxRise,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Down = accumMeanPVStim(InitAll.avgFRProfile(PyrDown.idxDown,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Other = accumMeanPVStim(InitAll.avgFRProfile(PyrOther.idxOther,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

        FRProfileMeanPyr.RiseBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrRise.idxRiseBadBad,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.DownBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrDown.idxDownBadBad,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.OtherBad = accumMeanPVStim(InitAll.avgFRProfileBad(PyrOther.idxOtherBadBad,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

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

        save([pathAnal 'initPeakPyrIntAllRecNoFNeu.mat'],'InitAll','PyrRise','PyrDown','PyrOther',...
            'FRProfileMeanPyr','FRProfileMeanPyrStat',...
            'relDepthNeuHDefPyr'); 
    end
    
%     %% plot depth of rise and down pyramidal neurons
    colorSel = 0;
    plotBoxPlot(relDepthNeuHDefPyr.depthRise,...
        relDepthNeuHDefPyr.depthDown,'Depth',...
        'Pyr_relDepthNeuHDefRiseVsDown',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDef,colorSel,[{'Rise'} {'Down'}]);
    
    plotBoxPlot(relDepthNeuHDefPyr.depthRise,...
        relDepthNeuHDefPyr.depthOther,'Depth',...
        'Pyr_relDepthNeuHDefRiseVsOther',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDefRO,colorSel,[{'Rise'} {'Other'}]);
    
    plotBoxPlot(relDepthNeuHDefPyr.depthDown,...
        relDepthNeuHDefPyr.depthOther,'Depth',...
        'Pyr_relDepthNeuHDefDownVsOther',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDefDO,colorSel,[{'Down'} {'Other'}]);
        
    plotPyrNeuRiseDown(pathAnal,modInt1NoCue.timeStepRun,InitAll,PyrRise,PyrDown,PyrOther,...
            FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,[{'Good'} {'Bad'}]);
    close all;
    
end





