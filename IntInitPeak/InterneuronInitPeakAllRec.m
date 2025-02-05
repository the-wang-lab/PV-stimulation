function InterneuronInitPeakAllRec(taskSel,methodKMean)
    
        
    RecordingListPyrInt;
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    pathAnal1 = ['Z:\Yingxue\Draft\PV\Interneuron\' num2str(methodKMean) '\'];
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\InterneuronInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\InterneuronInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\InterneuronInitPeakAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    GlobalConstFq;
    
    load([pathAnal0 'autoCorrIntAllRec.mat']);
    load([pathAnal1 'modIntAllRec.mat']);
    if(exist([pathAnal0 'initPeakIntAllRec.mat']))
        load([pathAnal0 'initPeakIntAllRec.mat']);
    end
    
%     if(taskSel == 1 && exist('modInt1NoCue') == 0)
        nNeuWithField = [modIntNoCue.nNeuWithField modIntAL.nNeuWithField modIntPL.nNeuWithField];
        nNeuWithFieldAligned = [modIntNoCue.nNeuWithFieldAligned modIntAL.nNeuWithFieldAligned ...
                modIntPL.nNeuWithFieldAligned];

        disp('No cue - peak firing rate')
        modInt1NoCue = accumInterneurons2(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,autoCorrIntAll,...
            nNeuWithField,nNeuWithFieldAligned,minFRInt,1,sampleFq);

        disp('Active licking - peak firing rate')
        modInt1AL = accumInterneurons2(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrIntAll,...
            nNeuWithField,nNeuWithFieldAligned,minFRInt,2,sampleFq);

        disp('Passive licking - peak firing rate')
        modInt1PL = accumInterneurons2(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,autoCorrIntAll,...
            nNeuWithField,nNeuWithFieldAligned,minFRInt,3,sampleFq);

        save([pathAnal0 'initPeakIntAllRec.mat'],'modInt1NoCue','modInt1AL','modInt1PL');
%     end
    
    modInt1 = InterneuronInitPeakAllRecByType(modInt1NoCue,modInt1AL,modInt1PL,taskSel,methodKMean);

    FRProfileMean = accumMeanIntInitPeak(modInt1.avgFRProfile,modInt1AL.timeStepRun);
    
    FRProfileMeanGood = accumMeanIntInitPeak(modInt1.avgFRProfileGood,modInt1AL.timeStepRun);
    
    FRProfileMeanBad = accumMeanIntInitPeak(modInt1.avgFRProfileBad,modInt1AL.timeStepRun);
    
    FRProfileMeanStatC = accumMeanStatCIntInitPeak(FRProfileMean,modInt1.idxC,modInt1.nNeuWithFieldAligned);
    
    FRProfileMeanGoodStatC = accumMeanStatCIntInitPeak(FRProfileMeanGood,modInt1.idxCGood,modInt1.nNeuWithFieldAlignedGood);
    
    FRProfileMeanStatCGoodBad = accumMeanStatCGoodBadIntInitPeak(FRProfileMeanGood,FRProfileMeanBad,...
            modInt1.idxCGood,modInt1.idxCBad);
    
    save([pathAnal 'initPeakIntAllRecSel.mat'],'modInt1','FRProfileMean','FRProfileMeanBad','FRProfileMeanGood',...
            'FRProfileMeanStatC','FRProfileMeanGoodStatC','FRProfileMeanStatCGoodBad'); 
    
    colorSel = 0;
    
%     plotIntInitFieldRecPerClu(pathAnal,modInt1NoCue,modInt1);
%     
%     plotIntInitGoodBadTrPerClu(pathAnal,modInt1NoCue,modInt1,autoCorrIntTag);
%     
%     plotIntIndProfilePerClu(pathAnal,modInt1NoCue,modInt1,autoCorrIntTag,FRProfileMean);
%     
%     plotIntIndProfileFieldPerClu(pathAnal,modInt1NoCue,modInt1,FRProfileMean);
    
    plotCmpIntMeanSegProfile(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatC,colorSel);
    
    plotCmpIntMeanSegProfileField(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatC,colorSel);
    
%     plotCmpIntSegProfile(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatC,colorSel); % hard to tell from the graph
            
    plotCmpIntSegProfileField(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatC,colorSel);
    
    pause;
    close all;
    
    plotCmpIntMeanSegProfileGoodBad(pathAnal,modInt1,FRProfileMeanGood,FRProfileMeanBad,FRProfileMeanStatCGoodBad,colorSel);
            
    plotCmpIntSegProfileGoodBad(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatCGoodBad,colorSel);
    
    pause;
    close all;
    
    plotCmpIntMeanSegRatioProfileGoodBad(pathAnal,modInt1,FRProfileMeanGood,FRProfileMeanBad,FRProfileMeanStatCGoodBad,colorSel);
    
    plotCmpIntSegRatioProfileGoodBad(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatCGoodBad,colorSel);
    
    pause;
    close all;
    
end



