function IntInitPeakAllStimPVRecCtrlTr(methodKMean)
%% only consider stimulation recordings
    
    GlobalConstFq;
    
    RecordingListPyrInt;
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    pathAnal = ['Z:\Yingxue\Draft\PV\InterneuronPVStimALCtrl\' num2str(methodKMean) '\'];
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
            
    load([pathAnal0 'autoCorrIntAllRec.mat']);
    if(exist([pathAnal 'initPeakIntAllRecStimCtrlTr.mat']))
        load([pathAnal 'initPeakIntAllRecStimCtrlTr.mat']);
    end
        
    if(~exist('modInt1AL'))
        
        disp('Active licking - peak firing rate')
        modInt1AL = accumInterneuron4Ctrl(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrIntAll,...
            anmNoInact,anmNoAct,minFRInt,2,sampleFq,intervalTPopCorr);

        save([pathAnal 'initPeakIntAllRecStimCtrlTr.mat'],'modInt1AL'); 
    end
    
    [FRProfileMeanAll,...
        FRProfile,FRProfileMean,FRProfileMeanStim,...
        FRProfileMeanStimCtrl,FRProfileMeanStatGoodNonStimVsStim,...
        FRProfileMeanStatStimCtrlVsStim] = IntInitPeakPVStimFRProfile(modInt1AL,methodKMean,pulseMethod);
    save([pathAnal 'initPeakIntAllRecStimCtrlTr_km' num2str(methodKMean) '.mat'],'FRProfileMeanAll',...
        'FRProfile','FRProfileMean','FRProfileMeanStim',...
        'FRProfileMeanStimCtrl','FRProfileMeanStatGoodNonStimVsStim','FRProfileMeanStatStimCtrlVsStim',...
        'anmNoInact','anmNoAct','pulseMethod'); 
    
end






