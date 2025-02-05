function PyrInitPeakAllStimPVRec(methodKMean)
%% only consider stimulation recordings
    
    GlobalConstFq;
    
    RecordingListPyrInt;
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalPVStimAL\' num2str(methodKMean) '\'];
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
            
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal 'initPeakPyrAllRecStim.mat']))
        load([pathAnal 'initPeakPyrAllRecStim.mat']);
    end
        
    if(~exist('modPyr1AL'))
        nNeuWithFieldAligned = [modAlignedPyrNoCue.nNeuWithField modAlignedPyrAL.nNeuWithField ...
            modAlignedPyrPL.nNeuWithField];
        isNeuWithFieldAligned = [modAlignedPyrNoCue.isNeuWithField ...
            modAlignedPyrAL.isNeuWithField modAlignedPyrPL.isNeuWithField];

        disp('Active licking - peak firing rate')
        modPyr1AL = accumPyr3(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            nNeuWithFieldAligned,isNeuWithFieldAligned,...
            anmNoInact,anmNoAct,minFR,maxFR,2,sampleFq,intervalTPopCorr);

        save([pathAnal 'initPeakPyrAllRecStim.mat'],'modPyr1AL'); 
        
        numField = PyrInitPeakPVStimField(pathAnal,pulseMethod,modPyr1AL);
        save([pathAnal 'initPeakPyrAllRecStim.mat'],'numField','-append');
    end
    
    [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = PyrInitPeakPVStimFRProfile(modPyr1AL,methodKMean,pulseMethod);
    save([pathAnal 'initPeakPyrAllRecStim_km' num2str(methodKMean) '.mat'],'FRProfileMeanAll',...
        'FRProfile','FRProfileMean','FRProfileMeanStim',...
        'FRProfileMeanStimCtrl','FRProfileMeanStatGoodNonStimVsStim','FRProfileMeanStatStimCtrlVsStim',...
        'anmNoInact','anmNoAct','pulseMethod'); 
    
end






