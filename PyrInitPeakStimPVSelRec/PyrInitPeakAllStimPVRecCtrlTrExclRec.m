function PyrInitPeakAllStimPVRecCtrlTrExclRec(methodKMean)
%% only consider stimulation recordings, excluding the recordings defined in GlobalConstFq
    
    GlobalConstFq;
    
    RecordingListPyrInt;
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalPVStimALCtrlSelRec\' num2str(methodKMean) '\'];
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
            
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat']))
        load([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat']);
    end
        
%     if(~exist('modPyr1AL'))
        nNeuWithFieldAligned = [modAlignedPyrNoCue.nNeuWithField modAlignedPyrAL.nNeuWithField ...
            modAlignedPyrPL.nNeuWithField];
        isNeuWithFieldAligned = [modAlignedPyrNoCue.isNeuWithField ...
            modAlignedPyrAL.isNeuWithField modAlignedPyrPL.isNeuWithField];

        disp('Active licking - peak firing rate')
        modPyr1AL = accumPyr3CtrlSelRec(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            nNeuWithFieldAligned,isNeuWithFieldAligned,...
            anmNoInact,anmNoAct,minFR,maxFR,2,sampleFq,intervalTPopCorr,excludeRec);

        save([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat'],'modPyr1AL'); 
        
        numField = PyrInitPeakPVStimField(pathAnal,pulseMethod,modPyr1AL);
        save([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat'],'numField','-append');
%     end
    
    [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = PyrInitPeakPVStimFRProfile(modPyr1AL,methodKMean,pulseMethod);
    save([pathAnal 'initPeakPyrAllRecStimCtrlTr_km' num2str(methodKMean) '.mat'],'FRProfileMeanAll',...
        'FRProfile','FRProfileMean','FRProfileMeanStim',...
        'FRProfileMeanStimCtrl','FRProfileMeanStatGoodNonStimVsStim','FRProfileMeanStatStimCtrlVsStim',...
        'anmNoInact','anmNoAct','pulseMethod'); 
    
end
