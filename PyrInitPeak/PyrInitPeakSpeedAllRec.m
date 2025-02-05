function PyrInitPeakSpeedAllRec(taskSel,methodKMean)

    GlobalConstFq;
    
    RecordingListPyrInt;
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakAL\' num2str(methodKMean) '\'];
    end
    
   
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrSpeedAllRec.mat']))
        load([pathAnal0 'initPeakPyrSpeedAllRec.mat']);
    end
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
%     if(taskSel == 1 && exist('modPyrInitSpeedNoCue') == 0)
        disp('No cue - firing rate vs. speed')
        modPyrInitSpeedNoCue = accumPyrInitSpeed(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,sampleFq,nSampBef);

        disp('Active licking - firing rate vs. speed')
        modPyrInitSpeedAL = accumPyrInitSpeed(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,sampleFq,nSampBef);

        disp('Passive licking - firing rate vs. speed')
        modPyrInitSpeedPL = accumPyrInitSpeed(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,sampleFq,nSampBef);

        save([pathAnal0 'initPeakPyrSpeedAllRec.mat'],'modPyrInitSpeedNoCue','modPyrInitSpeedAL','modPyrInitSpeedPL','-v7.3'); 
%     end
    
    modPyrInitSpeed = InterneuronInitPeakSpeedAllRecByType(modPyrInitSpeedNoCue,modPyrInitSpeedAL,modPyrInitSpeedPL,...
        modPyr1NoCue,modPyr1AL,modPyr1PL,taskSel,methodKMean);
      
    save([pathAnal 'initPeakPyrSpeedAllRecSel.mat'],'modPyrInitSpeed');      
end

