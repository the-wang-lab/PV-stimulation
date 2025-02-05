function CompPyrIntInitPeakSigField(taskSel,pshuffle)
% compare the run onset response for recordings with and without fields

     pathAnal00 = 'Z:\Yingxue\Draft\PV\Pyramidal\';

    if(exist([pathAnal00 'initPeakPyrAllRec.mat']))
        load([pathAnal00 'initPeakPyrAllRec.mat'],'modPyr1NoCue');
    end
    
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    if(taskSel == 2)
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigALPL\' num2str(pshuffle) '\'];
        pathAnal = ['Z:\Yingxue\Draft\PV\CompPyrIntInitPeakSigFieldNoFieldALPL\' num2str(pshuffle) '\'];
    elseif(taskSel == 3)
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigAL\' num2str(pshuffle) '\'];
        pathAnal = ['Z:\Yingxue\Draft\PV\CompPyrIntInitPeakSigFieldNoFieldAL\' num2str(pshuffle) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    if(exist([pathAnal0 'initPeakPyrIntAllRecSig.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecSig.mat']);
    end
    
    if(exist([pathAnal 'initPeakPyrIntAllRecSigFNoF.mat']))
        load([pathAnal 'initPeakPyrIntAllRecSigFNoF.mat']);
    end
    
    if(exist('InitAllPyrField') == 0)
        InitAllPyrField = calFieldPerRec(InitAllPyr);
        InitAllF = findRecFieldInitAll(InitAllPyr,InitAllPyrField,1);
        InitAllNoF = findRecFieldInitAll(InitAllPyr,InitAllPyrField,0);

        %% Pyr Rise
        % pyr rise recordings with field
        PyrRiseF = findRecField(PyrRise,InitAllPyrField,1);
        PyrRiseF.idxRise = PyrRise.idxRise(PyrRiseF.idx);
        PyrRiseF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldRise(PyrRiseF.idx);
        % pyr rise recordings without field
        PyrRiseNoF = findRecField(PyrRise,InitAllPyrField,0);
        PyrRiseNoF.idxRise = PyrRise.idxRise(PyrRiseNoF.idx);
        PyrRiseNoF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldRise(PyrRiseNoF.idx);
        % pyr rise all
        PyrRiseAll = findRecField(PyrRise,InitAllPyrField,2);
        PyrRiseAll.idxRise = PyrRise.idxRise;
        PyrRiseAll.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldRise(PyrRiseAll.idx);

        %% Pyr Down
        % pyr down recordings with field
        PyrDownF = findRecField(PyrDown,InitAllPyrField,1);
        PyrDownF.idxDown = PyrDown.idxDown(PyrDownF.idx);
        PyrDownF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldDown(PyrDownF.idx);
        % pyr down recordings without field
        PyrDownNoF = findRecField(PyrDown,InitAllPyrField,0);
        PyrDownNoF.idxDown = PyrDown.idxDown(PyrDownNoF.idx);
        PyrDownNoF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldDown(PyrDownNoF.idx);
        % pyr down all
        PyrDownAll = findRecField(PyrDown,InitAllPyrField,2);
        PyrDownAll.idxDown = PyrDown.idxDown;
        PyrDownAll.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldDown(PyrDownAll.idx);

        %% Pyr Other
        % pyr other recordings with field
        PyrOtherF = findRecField(PyrOther,InitAllPyrField,1);
        PyrOtherF.idxOther = PyrOther.idxOther(PyrOtherF.idx);
        PyrOtherF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldOther(PyrOtherF.idx);
        % pyr other recordings without field
        PyrOtherNoF = findRecField(PyrOther,InitAllPyrField,0);
        PyrOtherNoF.idxOther = PyrOther.idxOther(PyrOtherNoF.idx);
        PyrOtherNoF.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldOther(PyrOtherNoF.idx);
        % pyr other all
        PyrOtherAll = findRecField(PyrOther,InitAllPyrField,2);
        PyrOtherAll.idxOther = PyrOther.idxOther;
        PyrOtherAll.isNeuWithFieldAligned = isNeuWithFieldAligned.isFieldOther(PyrOtherAll.idx);

        %% FR profiles
        FRProfileMeanPyrFNoFRec.RiseF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrRiseF.idxRise,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyrFNoFRec.RiseNoF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrRiseNoF.idxRise,:),modPyr1NoCue.timeStepRun);

        FRProfileMeanPyrFNoFRec.DownF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrDownF.idxDown,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyrFNoFRec.DownNoF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrDownNoF.idxDown,:),modPyr1NoCue.timeStepRun);

        FRProfileMeanPyrFNoFRec.OtherF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrOtherF.idxOther,:),modPyr1NoCue.timeStepRun);
        FRProfileMeanPyrFNoFRec.OtherNoF = ...
            accumMeanPVStim(InitAllPyr.avgFRProfile(PyrOtherNoF.idxOther,:),modPyr1NoCue.timeStepRun);

        %% compare recordings with and without fields
        FRProfileMeanPyrFNoFRecStat.Rise = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrFNoFRec.RiseF,FRProfileMeanPyrFNoFRec.RiseNoF);
        FRProfileMeanPyrFNoFRecStat.Down = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrFNoFRec.DownF,FRProfileMeanPyrFNoFRec.DownNoF);
        FRProfileMeanPyrFNoFRecStat.Other = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrFNoFRec.OtherF,FRProfileMeanPyrFNoFRec.OtherNoF); % added on 7/8/2022

        PyrRiseF1 = calPercNeuPerRec(InitAllPyr,PyrRiseF,InitAllPyrField,1);
        PyrDownF1 = calPercNeuPerRec(InitAllPyr,PyrDownF,InitAllPyrField,1);
        PyrOtherF1 = calPercNeuPerRec(InitAllPyr,PyrOtherF,InitAllPyrField,1);

        PyrRiseNoF1 = calPercNeuPerRec(InitAllPyr,PyrRiseNoF,InitAllPyrField,0);
        PyrDownNoF1 = calPercNeuPerRec(InitAllPyr,PyrDownNoF,InitAllPyrField,0);
        PyrOtherNoF1 = calPercNeuPerRec(InitAllPyr,PyrOtherNoF,InitAllPyrField,0);

        PyrRiseAll1 = calPercNeuPerRec(InitAllPyr,PyrRiseAll,InitAllPyrField,2);
        PyrDownAll1 = calPercNeuPerRec(InitAllPyr,PyrDownAll,InitAllPyrField,2);
        PyrOtherAll1 = calPercNeuPerRec(InitAllPyr,PyrOtherAll,InitAllPyrField,2);

        FRProfileMeanPyrFNoFRecStat.Rise.pRSPercNeuPerRec = ranksum(PyrRiseF1.percNeuPerRec,PyrRiseNoF1.percNeuPerRec);
        FRProfileMeanPyrFNoFRecStat.Down.pRSPercNeuPerRec = ranksum(PyrDownF1.percNeuPerRec,PyrDownNoF1.percNeuPerRec);
        FRProfileMeanPyrFNoFRecStat.Other.pRSPercNeuPerRec = ranksum(PyrOtherF1.percNeuPerRec,PyrOtherNoF1.percNeuPerRec);

        %% the relationship between the perc of field in a recording and perc of rise(down, other) neurons
        [FRProfileMeanPyrFNoFRecStat.Rise.corrPercNeuPerRec,...
            FRProfileMeanPyrFNoFRecStat.Rise.pCorrPercNeuPerRec] = ...
            corr(InitAllPyrField.percNeuPerRec',PyrRiseAll1.percNeuPerRec','Type','Spearman');
        [FRProfileMeanPyrFNoFRecStat.Down.corrPercNeuPerRec,...
            FRProfileMeanPyrFNoFRecStat.Down.pCorrPercNeuPerRec] = ...
            corr(InitAllPyrField.percNeuPerRec',PyrDownAll1.percNeuPerRec','Type','Spearman');
        [FRProfileMeanPyrFNoFRecStat.Other.corrPercNeuPerRec,...
            FRProfileMeanPyrFNoFRecStat.Other.pCorrPercNeuPerRec] = ...
            corr(InitAllPyrField.percNeuPerRec',PyrOtherAll1.percNeuPerRec','Type','Spearman');

        Pyrlm.Rise = calLinearReg(InitAllPyrField.percNeuPerRec,PyrRiseAll1.percNeuPerRec);
        Pyrlm.Down = calLinearReg(InitAllPyrField.percNeuPerRec,PyrDownAll1.percNeuPerRec);
        Pyrlm.Other = calLinearReg(InitAllPyrField.percNeuPerRec,PyrOtherAll1.percNeuPerRec);

        %% perc of rise and down neurons with field
        PyrRiseField = calFieldPerRecPyr(PyrRiseAll,InitAllPyr);
        PyrDownField = calFieldPerRecPyr(PyrDownAll,InitAllPyr);
        PyrOtherField = calFieldPerRecPyr(PyrOtherAll,InitAllPyr);

        %% the relationship between the perc of field in rise(down, other) neurons and perc of rise(down, other) neurons
        Pyrlm.RiseField = calLinearReg(PyrRiseField.percNeuPerRec,PyrRiseAll1.percNeuPerRec);
        Pyrlm.DownField = calLinearReg(PyrDownField.percNeuPerRec,PyrDownAll1.percNeuPerRec);
        nonzeroField = ~isnan(PyrDownField.percNeuPerRec) & ...
            PyrDownField.percNeuPerRec ~= 0;
        Pyrlm.DownFieldNonZero = calLinearReg(PyrDownField.percNeuPerRec(nonzeroField),...
            PyrDownAll1.percNeuPerRec(nonzeroField));
        Pyrlm.OtherField = calLinearReg(PyrOtherField.percNeuPerRec,PyrOtherAll1.percNeuPerRec);

        [FRProfileMeanPyrFNoFRecStat.Rise.corrPercNeuPerRecField,...
            FRProfileMeanPyrFNoFRecStat.Rise.pCorrPercNeuPerRecField] = ...
            corr(PyrRiseField.percNeuPerRec',PyrRiseAll1.percNeuPerRec','Type','Spearman');
        [FRProfileMeanPyrFNoFRecStat.Down.corrPercNeuPerRecField,...
            FRProfileMeanPyrFNoFRecStat.Down.pCorrPercNeuPerRecField] = ...
            corr(PyrDownField.percNeuPerRec(~isnan(PyrDownField.percNeuPerRec))',...
            PyrDownAll1.percNeuPerRec(~isnan(PyrDownField.percNeuPerRec))','Type','Spearman');
        [FRProfileMeanPyrFNoFRecStat.Down.corrPercNeuPerRecFieldNonZero,...
            FRProfileMeanPyrFNoFRecStat.Down.pCorrPercNeuPerRecFieldNonZero] = ...
            corr(PyrDownField.percNeuPerRec(~isnan(PyrDownField.percNeuPerRec) & ...
            PyrDownField.percNeuPerRec ~= 0)',...
            PyrDownAll1.percNeuPerRec(~isnan(PyrDownField.percNeuPerRec) & ...
            PyrDownField.percNeuPerRec ~= 0)','Type','Spearman');
        [FRProfileMeanPyrFNoFRecStat.Other.corrPercNeuPerRecField,...
            FRProfileMeanPyrFNoFRecStat.Other.pCorrPercNeuPerRecField] = ...
            corr(PyrOtherField.percNeuPerRec',PyrOtherAll1.percNeuPerRec','Type','Spearman');

        save([pathAnal 'initPeakPyrIntAllRecSigFNoF.mat'],'InitAllPyrField',...
                'InitAllF','InitAllNoF',...
                'PyrRiseF','PyrDownF','PyrOtherF',...
                'PyrRiseNoF','PyrDownNoF','PyrOtherNoF',...
                'PyrRiseAll','PyrDownAll','PyrOtherAll',...
                'PyrRiseF1','PyrDownF1','PyrOtherF1',...
                'PyrRiseNoF1','PyrDownNoF1','PyrOtherNoF1',...
                'PyrRiseAll1','PyrDownAll1','PyrOtherAll1',...
                'FRProfileMeanPyrFNoFRec','FRProfileMeanPyrFNoFRecStat','Pyrlm',...
                '-v7.3'); 
    end
        
    colorSel = 0;
    plotPyrNeuRiseDownSigFVsNoFIndN(pathAnal,modPyr1NoCue.timeStepRun,...
            InitAllF,InitAllNoF,InitAllPyr.avgFRProfileNorm,...
                PyrRiseF.idxRise,PyrRiseNoF.idxRise,...
                PyrDownF.idxDown,PyrDownNoF.idxDown,...
                PyrOtherF.idxOther,PyrOtherNoF.idxOther,FRProfileMean);
        
    plotPyrNeuRiseDownFVsNoF(pathAnal,modPyr1NoCue.timeStepRun,...
                InitAllPyr,PyrRiseF,PyrRiseNoF,PyrDownF,PyrDownNoF,...
                PyrOtherF,PyrOtherNoF,FRProfileMeanPyrFNoFRec,...
                FRProfileMeanPyrFNoFRecStat,colorSel,[{'NoF'} {'F'}]);
            
    plotPyrNeuRiseDownSigFNoFPercNeu(pathAnal,PyrRiseF1,PyrDownF1,PyrOtherF1,...
        PyrRiseNoF1,PyrDownNoF1,PyrOtherNoF1,FRProfileMeanPyrFNoFRecStat,colorSel,...
        [{'NoF'} {'F'}]);
    
    plotRunOnsetChangeVsPercField(pathAnal,Pyrlm);
   
    close all;
end

% find fields
function InitAllF = calFieldPerRec(InitAll)
    taskU = unique(InitAll.task);
    recNo = 1;
    InitAllF.task = [];
    InitAllF.indRec = [];
    InitAllF.numNeuField = [];
    InitAllF.numAllNeu = [];
    InitAllF.percNeuPerRec = [];
    for i = 1:length(taskU)
        recU = unique(InitAll.indRec(InitAll.task == taskU(i)));
        for j = 1:length(recU)
            indRecAll = InitAll.task == taskU(i) & InitAll.indRec == recU(j);
            InitAllF.task(recNo) = taskU(i);
            InitAllF.indRec(recNo) = recU(j);
            InitAllF.numAllNeu(recNo) = sum(indRecAll);
            InitAllF.numNeuField(recNo) = sum(InitAll.isNeuWithFieldAligned(indRecAll));
            InitAllF.percNeuPerRec(recNo) = sum(InitAll.isNeuWithFieldAligned(indRecAll))/sum(indRecAll);
            recNo = recNo + 1;
        end
    end
end

function PyrF = calFieldPerRecPyr(Pyr,InitAll)
    taskU = unique(InitAll.task);
    recNo = 1;
    PyrF.task = [];
    PyrF.indRec = [];
    PyrF.numNeuField = [];
    PyrF.numAllNeu = [];
    PyrF.percNeuPerRec = [];
    for i = 1:length(taskU)
        recU = unique(InitAll.indRec(InitAll.task == taskU(i)));
        for j = 1:length(recU)
            indRecPyr = Pyr.task == taskU(i) & Pyr.indRec == recU(j);
            PyrF.task(recNo) = taskU(i);
            PyrF.indRec(recNo) = recU(j);
            PyrF.numAllNeu(recNo) = sum(indRecPyr);
            PyrF.numNeuField(recNo) = sum(Pyr.isNeuWithFieldAligned(indRecPyr));
            PyrF.percNeuPerRec(recNo) = sum(Pyr.isNeuWithFieldAligned(indRecPyr))/sum(indRecPyr);
            recNo = recNo + 1;
        end
    end
end

function PyrF = findRecField(Pyr,InitAllPyrField,isField)
    if(isField == 1) % recordings with field
        indRec = find(InitAllPyrField.numNeuField > 1);
    elseif(isField == 0)
        indRec = find(InitAllPyrField.numNeuField <= 1);
    else
        indRec = 1:length(InitAllPyrField.numNeuField);
    end
    
    idx1 = [];
    for i = 1:length(indRec)
        idx = find(Pyr.task == InitAllPyrField.task(indRec(i)) & ...
            Pyr.indRec == InitAllPyrField.indRec(indRec(i)));
        idx1 = [idx1 idx]; 
    end
    PyrF.idx = idx1;
    PyrF.task = Pyr.task(PyrF.idx);
    PyrF.indRec = Pyr.indRec(PyrF.idx);
    PyrF.indNeu = Pyr.indNeu(PyrF.idx);
end

function InitF = findRecFieldInitAll(InitAll,InitAllPyrField,isField)
    if(isField == 1) % recordings with field
        indRec = find(InitAllPyrField.numNeuField > 1);
    else
        indRec = find(InitAllPyrField.numNeuField <= 1);
    end
    
    idx1 = [];
    for i = 1:length(indRec)
        idx = find(InitAll.task == InitAllPyrField.task(indRec(i)) & ...
            InitAll.indRec == InitAllPyrField.indRec(indRec(i)));
        idx1 = [idx1 idx]; 
    end
    InitF.idx = idx1;
    InitF.task = InitAll.task(InitF.idx);
    InitF.indRec = InitAll.indRec(InitF.idx);
    InitF.indNeu = InitAll.indNeu(InitF.idx);
    InitF.avgFRProfile = InitAll.avgFRProfile(InitF.idx,:);
    InitF.avgFRProfileNorm = InitAll.avgFRProfileNorm(InitF.idx,:);
    InitF.relDepthNeuHDef = InitAll.relDepthNeuHDef(InitF.idx);
    InitF.isNeuWithFieldAligned = InitAll.isNeuWithFieldAligned(InitF.idx);
    InitF.isPeakNeuArrAll = InitAll.isPeakNeuArrAll(:,InitF.idx); 
end

function PyrAL = calPercNeuPerRec(InitAll,Pyr,InitAllPyrField,isField)
    taskU = unique(InitAll.task);
    recNo = 1;
    PyrAL.task = [];
    PyrAL.indRec = [];
    PyrAL.numAllNeu = [];
    PyrAL.numSelNeu = [];
    PyrAL.percNeuPerRec = [];
    for i = 1:length(taskU)
        indTask = find(InitAll.task == taskU(i));
        recU = unique(InitAll.indRec(indTask));
        for j = 1:length(recU)
            indRecPyr = Pyr.task == taskU(i) & Pyr.indRec == recU(j);
            indRecAll = InitAll.task == taskU(i) & InitAll.indRec == recU(j);
            PyrAL.task(recNo) = taskU(i);
            PyrAL.indRec(recNo) = recU(j);
            PyrAL.numAllNeu(recNo) = sum(indRecAll);
            PyrAL.numSelNeu(recNo) = sum(indRecPyr);
            PyrAL.percNeuPerRec(recNo) = sum(indRecPyr)/sum(indRecAll);
            recNo = recNo + 1;
        end
    end
    
    if(isField == 1) % recordings with field
        indRec = find(InitAllPyrField.numNeuField > 1);
    elseif(isField == 0)
        indRec = find(InitAllPyrField.numNeuField <= 1);
    else
        indRec = 1:length(InitAllPyrField.numNeuField);
    end
    PyrAL.task = PyrAL.task(indRec);
    PyrAL.indRec = PyrAL.indRec(indRec);
    PyrAL.numAllNeu = PyrAL.numAllNeu(indRec);
    PyrAL.numSelNeu = PyrAL.numSelNeu(indRec);
    PyrAL.percNeuPerRec = PyrAL.percNeuPerRec(indRec);
end

function Pyrlm = calLinearReg(percNeuPerRecF,percNeuPerRec)
    Pyrlm = fitlm(percNeuPerRecF,percNeuPerRec);
end