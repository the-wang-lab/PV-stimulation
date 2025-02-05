function PyrModAlignedAllRec_GoodTr(onlyRun,taskSel,methodKMean)

    if(nargin == 1)
        methodKMean = 2; % which kmean method is used
    end
    
    GlobalConstFq;
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAlignedGoodTr\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAlignedGoodTrALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAlignedGoodTrAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
        
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    if(exist([pathAnal0 'autoCorrPyrAlignedAllRec_GoodTr.mat']))
        load([pathAnal0 'autoCorrPyrAlignedAllRec_GoodTr.mat']);
    end
    
    if(taskSel == 1 && exist('modPyr1NoCue_GoodTr') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modPyr1NoCue_GoodTr = accumPyrNeurons1GoodTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,intervalT,1);
        modPyr1NoCue_BadTr = accumPyrNeurons1GoodTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,intervalT,0);

        disp('Active licking')
        modPyr1AL_GoodTr = accumPyrNeurons1GoodTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,intervalT,1);
        modPyr1AL_BadTr = accumPyrNeurons1GoodTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,intervalT,0);
        
        disp('Passive licking')
        modPyr1PL_GoodTr = accumPyrNeurons1GoodTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,intervalT,1);
        modPyr1PL_BadTr = accumPyrNeurons1GoodTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,intervalT,0);

        if(exist([pathAnal0 'autoCorrPyrAlignedAllRec_GoodTr.mat']))
            save([pathAnal0 'autoCorrPyrAlignedAllRec_GoodTr.mat'],'modPyr1NoCue_GoodTr','modPyr1AL_GoodTr',...
                'modPyr1PL_GoodTr','modPyr1NoCue_BadTr','modPyr1AL_BadTr',...
                'modPyr1PL_BadTr','-append'); 
        else
            save([pathAnal0 'autoCorrPyrAlignedAllRec_GoodTr.mat'],'modPyr1NoCue_GoodTr','modPyr1AL_GoodTr',...
                'modPyr1PL_GoodTr','modPyr1NoCue_BadTr','modPyr1AL_BadTr',...
                'modPyr1PL_BadTr');
        end
    end
    
    mod_GoodTr1 = PyrModAllRecByTypeAlignedGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyr1NoCue_GoodTr,modPyr1AL_GoodTr,modPyr1PL_GoodTr,autoCorrPyrAll,taskSel,methodKMean);
    mod_BadTr1 = PyrModAllRecByTypeAlignedGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyr1NoCue_BadTr,modPyr1AL_BadTr,modPyr1PL_BadTr,autoCorrPyrAll,taskSel,methodKMean);
    
    save([pathAnal 'pyrAlignedAllRec_GoodTr.mat'],'mod_GoodTr1','mod_BadTr1');
end




