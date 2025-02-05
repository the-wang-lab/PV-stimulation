function PyrIntInitPeakALFirst10SigNoFNeu(taskSel,pshuffle)
% compare Pyramidal neurons and PV interneurons on their initial peak
% (pshuffle = 1 -> 99.9%, 2 -> 99%, 3 -> 95%)

    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    pathAnalInt0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    
    if(exist([pathAnal0 'initPeakPyrAllRecSig.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
        load([pathAnal0 'initPeakPyrAllRecSig.mat']);
    end
    if(exist([pathAnalInt0 'initPeakIntAllRecSig.mat']))
        load([pathAnalInt0 'initPeakIntAllRec.mat']);
        load([pathAnalInt0 'initPeakIntAllRecSig.mat']);
    end
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoFNeu\' num2str(pshuffle) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoFNeuALPL\' num2str(pshuffle) '\'];
    elseif(taskSel == 3)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoFNeuAL\' num2str(pshuffle) '\'];
    elseif(taskSel == 4)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoFNeuNoCue\' num2str(pshuffle) '\'];
    elseif(taskSel == 5)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoFNeuAL10\' num2str(pshuffle) '\'];
    end
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    if(exist([pathAnal 'initPeakPyrIntAllRecSigNoFNeu.mat']))
        load([pathAnal 'initPeakPyrIntAllRecSigNoFNeu.mat']);
    end
    
    if(exist('InitAllPyr') == 0)
        InitAllPyr = PyrIntInitPeakByTypeSig(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    modPyr1SigNoCue,modPyr1SigAL,modPyr1SigPL);

        indNoF = find(InitAllPyr.isNeuWithFieldAligned == 0);
        mean0to1 = mean(InitAllPyr.avgFRProfile(indNoF,FRProfileMean.indFR0to1),2);
        meanBefRun = mean(InitAllPyr.avgFRProfile(indNoF,FRProfileMean.indFRBefRun),2);
        ratio0to1BefRun = mean0to1./meanBefRun;
        idxGood = ~isnan(ratio0to1BefRun) & ~isinf(ratio0to1BefRun);
        idxR = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == 1 & idxGood' == 1);
        idxD = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == -1 & idxGood' == 1);
        idxO = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == 0 & idxGood' == 1);
        tsneEmbed(InitAllPyr.avgFRProfileNorm([idxR,idxO,idxD],FRProfileMean.indFRBefRun(1):FRProfileMean.indFR0to1(end)),...
            length(idxR),length(idxR)+length(idxO)+1,...
            pathAnal,'tsneEmbedPyrRiseDown');
        
        %% pyramidal rise and down
        idx = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == 1 & idxGood' == 1); 
        idx = indNoF(idx);
        % neurons with FR increase around 0
        PyrRise.idxRise = idx;
        PyrRise.task = InitAllPyr.task(idx);
        PyrRise.indRec = InitAllPyr.indRec(idx);
        PyrRise.indNeu = InitAllPyr.indNeu(idx);
        PyrRise.idxRiseBadBad = [];
        PyrRise.idxRiseBad = [];
        PyrRise.taskBad = [];
        PyrRise.indRecBad = [];
        PyrRise.indNeuBad = [];
        for i = 1:length(idx)
            idxBad = find(InitAllPyr.taskBad == PyrRise.task(i) & InitAllPyr.indRecBad == PyrRise.indRec(i) ...
                & InitAllPyr.indNeuBad == PyrRise.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrRise.idxRise(i);
                PyrRise.idxRiseBadBad = [PyrRise.idxRiseBadBad idxBad];
                PyrRise.idxRiseBad = [PyrRise.idxRiseBad idxBad1];
                PyrRise.taskBad = [PyrRise.taskBad InitAllPyr.taskBad(idxBad)];
                PyrRise.indRecBad = [PyrRise.indRecBad InitAllPyr.indRecBad(idxBad)];
                PyrRise.indNeuBad = [PyrRise.indNeuBad InitAllPyr.indNeuBad(idxBad)];
            end
        end

        % neurons with FR decrease around 0
        idx = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == -1 & idxGood' == 1); 
        idx = indNoF(idx);
        PyrDown.idxDown = idx;
        PyrDown.task = InitAllPyr.task(idx);
        PyrDown.indRec = InitAllPyr.indRec(idx);
        PyrDown.indNeu = InitAllPyr.indNeu(idx);
        PyrDown.idxDownBad = [];
        PyrDown.idxDownBadBad = [];
        PyrDown.taskBad = [];
        PyrDown.indRecBad = [];
        PyrDown.indNeuBad = [];
        for i = 1:length(idx)
            idxBad = find(InitAllPyr.taskBad == PyrDown.task(i) & InitAllPyr.indRecBad == PyrDown.indRec(i) ...
                & InitAllPyr.indNeuBad == PyrDown.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrDown.idxDown(i);
                PyrDown.idxDownBadBad = [PyrDown.idxDownBadBad idxBad];
                PyrDown.idxDownBad = [PyrDown.idxDownBad idxBad1];
                PyrDown.taskBad = [PyrDown.taskBad InitAllPyr.taskBad(idxBad)];
                PyrDown.indRecBad = [PyrDown.indRecBad InitAllPyr.indRecBad(idxBad)];
                PyrDown.indNeuBad = [PyrDown.indNeuBad InitAllPyr.indNeuBad(idxBad)];
            end
        end
        
        %% added on 7/8/2022
        % other neurons
        idx = find(InitAllPyr.isPeakNeuArrAll(pshuffle,indNoF) == 0 & idxGood' == 1); 
        idx = indNoF(idx);
        PyrOther.idxOther = idx;
        PyrOther.task = InitAllPyr.task(idx);
        PyrOther.indRec = InitAllPyr.indRec(idx);
        PyrOther.indNeu = InitAllPyr.indNeu(idx);
        PyrOther.idxOtherBad = [];
        PyrOther.idxOtherBadBad = [];
        PyrOther.taskBad = [];
        PyrOther.indRecBad = [];
        PyrOther.indNeuBad = [];
        for i = 1:length(idx)
            idxBad = find(InitAllPyr.taskBad == PyrOther.task(i) & InitAllPyr.indRecBad == PyrOther.indRec(i) ...
                & InitAllPyr.indNeuBad == PyrOther.indNeu(i));
            if(length(idxBad) == 1)
                idxBad1 = PyrOther.idxOther(i);
                PyrOther.idxOtherBadBad = [PyrOther.idxOtherBadBad idxBad];
                PyrOther.idxOtherBad = [PyrOther.idxOtherBad idxBad1];
                PyrOther.taskBad = [PyrOther.taskBad InitAllPyr.taskBad(idxBad)];
                PyrOther.indRecBad = [PyrOther.indRecBad InitAllPyr.indRecBad(idxBad)];
                PyrOther.indNeuBad = [PyrOther.indNeuBad InitAllPyr.indNeuBad(idxBad)];
            end
        end

        %% pyramidal neurons
        relDepthNeuHDefPyr.depthRise = InitAllPyr.relDepthNeuHDef(PyrRise.idxRise);
        relDepthNeuHDefPyr.depthDown = InitAllPyr.relDepthNeuHDef(PyrDown.idxDown);
        relDepthNeuHDefPyr.depthOther = InitAllPyr.relDepthNeuHDef(PyrOther.idxOther);% added on 7/8/2022
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
        FRProfileMeanPyr.Rise = accumMeanPVStim(InitAllPyr.avgFRProfile(PyrRise.idxRise,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Down = accumMeanPVStim(InitAllPyr.avgFRProfile(PyrDown.idxDown,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.Other = accumMeanPVStim(InitAllPyr.avgFRProfile(PyrOther.idxOther,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

        FRProfileMeanPyr.RiseBad = accumMeanPVStim(InitAllPyr.avgFRProfileBad(PyrRise.idxRiseBadBad,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.DownBad = accumMeanPVStim(InitAllPyr.avgFRProfileBad(PyrDown.idxDownBadBad,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyr.OtherBad = accumMeanPVStim(InitAllPyr.avgFRProfileBad(PyrOther.idxOtherBadBad,:),modPyr1NoCue.timeStepRun); % added on 7/8/2022

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

        save([pathAnal 'initPeakPyrIntAllRecSigNoFNeu.mat'],'InitAllPyr','PyrRise','PyrDown','PyrOther',...
            'FRProfileMeanPyr','FRProfileMeanPyrStat',...
            'relDepthNeuHDefPyr','-v7.3'); 
    end
    
%     %% plot depth of rise and down pyramidal neurons
    colorSel = 0;
%     plotBoxPlot(relDepthNeuHDefPyr.depthRise,...
%         relDepthNeuHDefPyr.depthDown,'Depth',...
%         'Pyr_relDepthNeuHDefRiseVsDown',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDef,colorSel,[{'Rise'} {'Down'}]);
%         
%     plotBoxPlot(relDepthNeuHDefPyr.depthRise,...
%         relDepthNeuHDefPyr.depthOther,'Depth',...
%         'Pyr_relDepthNeuHDefRiseVsOther',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDefRO,colorSel,[{'Rise'} {'Other'}]);
%     
%     plotBoxPlot(relDepthNeuHDefPyr.depthDown,...
%         relDepthNeuHDefPyr.depthOther,'Depth',...
%         'Pyr_relDepthNeuHDefDownVsOther',pathAnal,[],relDepthNeuHDefPyr.pRSRelDepthNeuHDefDO,colorSel,[{'Down'} {'Other'}]);
%     
    
    plotPyrNeuRiseDownSig(pathAnal,modInt1NoCue.timeStepRun,InitAllPyr,PyrRise,PyrDown,PyrOther,...
            FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,[{'Good'} {'Bad'}]);
    close all;
    
end




