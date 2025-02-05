function PyrInitPeakAllStimPVRecSigNonStim2ndStimCtrlTrAll(methodKMean)
%% only consider stimulation recordings
    
    GlobalConstFq;
    
    RecordingListPyrInt;
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\Pyramidal\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlAllSig\2\'];
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
            
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']);
    end
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlAll.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlAll.mat']);
    end
        
%     if(~exist('modPyr1AL'))
        nNeuWithFieldAligned = [modAlignedPyrNoCue.nNeuWithField modAlignedPyrAL.nNeuWithField ...
            modAlignedPyrPL.nNeuWithField];
        isNeuWithFieldAligned = [modAlignedPyrNoCue.isNeuWithField ...
            modAlignedPyrAL.isNeuWithField modAlignedPyrPL.isNeuWithField];

        disp('Active licking - peak firing rate')
        modPyr1AL = accumPyr3NoStim2ndStimCtrlAll(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            nNeuWithFieldAligned,isNeuWithFieldAligned,...
            anmNoInact,anmNoAct,2,modPyr1SigAL,sampleFq,intervalT);

        save([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlAll.mat'],'modPyr1AL'); 
        
        numField = PyrInitPeakPVStimField(pathAnal,pulseMethod,modPyr1AL);
        save([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlAll.mat'],'numField','-append');
%     end
    
    [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = PyrInitPeakPVStimFRProfile(modPyr1AL,methodKMean,pulseMethod);
    save([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlAll_km' num2str(methodKMean) '.mat'],'FRProfileMeanAll',...
        'FRProfile','FRProfileMean','FRProfileMeanStim',...
        'FRProfileMeanStimCtrl','FRProfileMeanStatGoodNonStimVsStim','FRProfileMeanStatStimCtrlVsStim',...
        'anmNoInact','anmNoAct','pulseMethod'); 
    
end






