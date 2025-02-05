function PyrInitPeakAllStimPVRecSigNonStim_1stStimCtrlTr(methodKMean)
%% only consider stimulation recordings, extract stim, 1st stim ctrl, 2nd stim ctrl trials
    
    GlobalConstFq;
    
    RecordingListPyrInt;
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\Pyramidal\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim_1stStimCtrlSig\2\'];
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
            
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']);
    end
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim_1stStimCtrl.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim_1stStimCtrl.mat']);
    end
        
    if(~exist('modPyr1AL'))
        disp('Active licking - peak firing rate')
        modPyr1AL = accumPyr3NoStim_1stStimCtrl(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            anmNoInact,anmNoAct,2,modPyr1SigAL,sampleFq,intervalT);

        save([pathAnal 'initPeakPyrAllRecSigStimNoStim_1stStimCtrl.mat'],'modPyr1AL'); 
    end
    
    [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMean1stStimCtrl,FRProfileMean2ndStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStat1stStimCtrlVsGoodNonStim,FRProfileMeanStat2ndStimCtrlVsGoodNonStim,...
        FRProfileMeanStat1stStimCtrlVsStim,FRProfileMeanStat2ndStimCtrlVsStim] = PyrInitPeakPVStimFRProfile_1stStimCtrl(modPyr1AL,methodKMean,pulseMethod);
    save([pathAnal 'initPeakPyrAllRecSigStimNoStim_1stSTimCtrl_km' num2str(methodKMean) '.mat'],'FRProfileMeanAll',...
        'FRProfile','FRProfileMean','FRProfileMeanStim',...
        'FRProfileMean1stStimCtrl','FRProfileMean2ndStimCtrl','FRProfileMeanStatGoodNonStimVsStim',...
        'FRProfileMeanStat1stStimCtrlVsGoodNonStim','FRProfileMeanStat2ndStimCtrlVsGoodNonStim',...
        'FRProfileMeanStat1stStimCtrlVsStim','FRProfileMeanStat2ndStimCtrlVsStim',...
        'anmNoInact','anmNoAct','pulseMethod'); 
    
end






