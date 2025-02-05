function PyrModAllRec_CtrlTr(onlyRun,taskSel,methodKMean)

    if(nargin == 1)
        methodKMean = 2; % which kmean method is used
    end
    
    GlobalConstFq;
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalCtrlTr\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalCtrlTrALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalCtrlTrAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
        
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    if(exist([pathAnal0 'autoCorrPyrAllRec_CtrlTr.mat']))
        load([pathAnal0 'autoCorrPyrAllRec_CtrlTr.mat']);
    end
    
    if(taskSel == 1 && exist('modPyrNoCue_CtrlTr') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modPyrNoCue_CtrlTr = accumPyrNeuronsCtrlTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,spaceBin);

        disp('Active licking')
        modPyrAL_CtrlTr = accumPyrNeuronsCtrlTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,spaceBin);
        
        disp('Passive licking')
        modPyrPL_CtrlTr = accumPyrNeuronsCtrlTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,spaceBin);

        if(exist([pathAnal0 'autoCorrPyrAllRec_CtrlTr.mat']))
            save([pathAnal0 'autoCorrPyrAllRec_CtrlTr.mat'],'modPyrNoCue_CtrlTr','modPyrAL_CtrlTr',...
                'modPyrPL_CtrlTr','-append'); 
        else
            save([pathAnal0 'autoCorrPyrAllRec_CtrlTr.mat'],'modPyrNoCue_CtrlTr','modPyrAL_CtrlTr',...
                'modPyrPL_CtrlTr');
        end
    end
    
    mod_CtrlTr = PyrModAllRecByTypeGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyrNoCue_CtrlTr,modPyrAL_CtrlTr,modPyrPL_CtrlTr,autoCorrPyrAll,taskSel,methodKMean);
    
    save([pathAnal 'pyrAllRec_CtrlTr.mat'],'mod_CtrlTr');
end




