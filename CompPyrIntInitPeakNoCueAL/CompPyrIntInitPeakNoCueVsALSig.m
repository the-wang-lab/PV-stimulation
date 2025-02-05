function CompPyrIntInitPeakNoCueVsALSig(mode,pshuffle)
% compare the run onset response for PyrRise and PyrDown neurons
% for No cue and AL (or ALPL) tasks
% mode = 1, No cue vs ALPL
% mode = 2, No cue vs AL
% mode = 3, No cue vs AL first 10 recordings

    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';

    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat'],'modPyr1NoCue');
    end

    if(mode == 1)
        pathAnalAL = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigALPL\' num2str(pshuffle) '\'];
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakCmpNoCueSigALPL\' num2str(pshuffle) '\'];
    elseif(mode == 2)
        pathAnalAL = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigAL\' num2str(pshuffle) '\'];
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakCmpSigNoCueAL\' num2str(pshuffle) '\'];
    else
        pathAnalAL = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigAL10\' num2str(pshuffle) '\'];
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakCmpSigNoCueAL10\' num2str(pshuffle) '\'];
    end
    pathAnalNoCue = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigNoCue\' num2str(pshuffle) '\'];

    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end    

    if(exist([pathAnalAL 'initPeakPyrIntAllRecSig.mat']))
        load([pathAnalAL 'initPeakPyrIntAllRecSig.mat']);
        InitAllAL = InitAllPyr;
        PyrRiseAL = PyrRise;
        PyrDownAL = PyrDown;
        PyrOtherAL = PyrOther;
        FRProfileMeanPyrAL = FRProfileMeanPyr;
    end

    if(exist([pathAnalNoCue 'initPeakPyrIntAllRecSig.mat']))
        load([pathAnalNoCue 'initPeakPyrIntAllRecSig.mat']);
        InitAllNoCue = InitAllPyr;
        PyrRiseNoCue = PyrRise;
        PyrDownNoCue = PyrDown;
        PyrOtherNoCue = PyrOther;
        FRProfileMeanPyrNoCue = FRProfileMeanPyr;
    end

    FRProfileMeanPyrStat1.RiseALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Rise,FRProfileMeanPyrNoCue.Rise);
    FRProfileMeanPyrStat1.DownALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Down,FRProfileMeanPyrNoCue.Down);
    FRProfileMeanPyrStat1.OtherALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Other,FRProfileMeanPyrNoCue.Other);

    FRProfileMeanPyrStat1.RiseBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.RiseBad,FRProfileMeanPyrNoCue.RiseBad);
    FRProfileMeanPyrStat1.DownBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.DownBad,FRProfileMeanPyrNoCue.DownBad);
    FRProfileMeanPyrStat1.OtherBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.OtherBad,FRProfileMeanPyrNoCue.OtherBad);

    PyrRiseAL1 = calPercNeuPerRec(InitAllAL,PyrRiseAL);
    PyrDownAL1 = calPercNeuPerRec(InitAllAL,PyrDownAL);
    PyrOtherAL1 = calPercNeuPerRec(InitAllAL,PyrOtherAL);

    PyrRiseNoCue1 = calPercNeuPerRec(InitAllNoCue,PyrRiseNoCue);
    PyrDownNoCue1 = calPercNeuPerRec(InitAllNoCue,PyrDownNoCue);
    PyrOtherNoCue1 = calPercNeuPerRec(InitAllNoCue,PyrOtherNoCue);

    FRProfileMeanPyrStat1.RiseALNoCue.pRSPercNeuPerRec = ranksum(PyrRiseAL1.percNeuPerRec,PyrRiseNoCue1.percNeuPerRec);
    FRProfileMeanPyrStat1.DownALNoCue.pRSPercNeuPerRec = ranksum(PyrDownAL1.percNeuPerRec,PyrDownNoCue1.percNeuPerRec);
    FRProfileMeanPyrStat1.OtherALNoCue.pRSPercNeuPerRec = ranksum(PyrOtherAL1.percNeuPerRec,PyrOtherNoCue1.percNeuPerRec);

    save([pathAnal 'initPeakPyrIntAllRecNoCueVsAL.mat'],'FRProfileMeanPyrStat1',...
        'PyrRiseAL1','PyrDownAL1','PyrOtherAL1',...
        'PyrRiseNoCue1','PyrDownNoCue1','PyrOtherNoCue1'); 

    colorSel = 0;
    plotPyrNeuRiseDownNoCueVsAL(pathAnal,modPyr1NoCue.timeStepRun,...
                InitAllAL,InitAllNoCue,PyrRiseAL,PyrRiseNoCue,PyrDownAL,PyrDownNoCue,...
                PyrOtherAL,PyrOtherNoCue,FRProfileMeanPyrAL,FRProfileMeanPyrNoCue,...
                FRProfileMeanPyrStat1,colorSel,[{'NoCue'} {'AL'}]);
            
    plotPyrNeuRiseDownSigALNoCuePercNeu(pathAnal,PyrRiseAL1,PyrDownAL1,PyrOtherAL1,...
        PyrRiseNoCue1,PyrDownNoCue1,PyrOtherNoCue1,FRProfileMeanPyrStat1,colorSel,...
        [{'NoCue'} {'AL'}]);

    close all;
end

function PyrAL = calPercNeuPerRec(InitAll,Pyr)
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
end