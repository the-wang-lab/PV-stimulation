function PyrModAllRec_GoodTr(onlyRun,taskSel,methodKMean)

    if(nargin == 1)
        methodKMean = 2; % which kmean method is used
    end
    
    GlobalConstFq;
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalGoodTr\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalGoodTrALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalGoodTrAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
        
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    if(exist([pathAnal0 'autoCorrPyrAllRec_GoodTr.mat']))
        load([pathAnal0 'autoCorrPyrAllRec_GoodTr.mat']);
    end
    
    if(taskSel == 1 && exist('modPyrNoCue_GoodTr') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modPyrNoCue_GoodTr = accumPyrNeuronsGoodTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,1,spaceBin);
        modPyrNoCue_BadTr = accumPyrNeuronsGoodTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,0,spaceBin);

        disp('Active licking')
        modPyrAL_GoodTr = accumPyrNeuronsGoodTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,1,spaceBin);
        modPyrAL_BadTr = accumPyrNeuronsGoodTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,0,spaceBin);

        disp('Passive licking')
        modPyrPL_GoodTr = accumPyrNeuronsGoodTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,1,spaceBin);
        modPyrPL_BadTr = accumPyrNeuronsGoodTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,0,spaceBin);

        if(exist([pathAnal0 'autoCorrPyrAllRec_GoodTr.mat']))
            save([pathAnal0 'autoCorrPyrAllRec_GoodTr.mat'],'modPyrNoCue_GoodTr','modPyrAL_GoodTr',...
                'modPyrPL_GoodTr','modPyrNoCue_BadTr','modPyrAL_BadTr','modPyrPL_BadTr','-append'); 
        else
            save([pathAnal0 'autoCorrPyrAllRec_GoodTr.mat'],'modPyrNoCue_GoodTr','modPyrAL_GoodTr',...
                'modPyrPL_GoodTr','modPyrNoCue_BadTr','modPyrAL_BadTr','modPyrPL_BadTr');
        end
    end
    
    mod_GoodTr = PyrModAllRecByTypeGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyrNoCue_GoodTr,modPyrAL_GoodTr,modPyrPL_GoodTr,autoCorrPyrAll,taskSel,methodKMean);
    mod_BadTr = PyrModAllRecByTypeGoodTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyrNoCue_BadTr,modPyrAL_BadTr,modPyrPL_BadTr,autoCorrPyrAll,taskSel,methodKMean);
    
    indFGood = mod_GoodTr.isNeuWithField == 1;
    plotCompXY(mod_BadTr.meanCorrDistNZ(indFGood),mod_GoodTr.meanCorrDistNZ(indFGood),...
        'Pyr_GoodVsBadTrMeanCorrDist_GoodTrField',pathAnal,'MeanCorrDist BadTr','MeanCorrDist GooddTr','GoodTrField');
    plotCompXY(mod_BadTr.adaptSpatialInfo(indFGood),mod_GoodTr.adaptSpatialInfo(indFGood),...
        'Pyr_GoodVsBadTrAdaptSpInfo_GoodTrField',pathAnal,'Adapt spatial info. BadTr','Adapt spatial info. GoodTr','GoodTrField');
    plotCompXY(mod_BadTr.spatialInfo(indFGood),mod_GoodTr.spatialInfo(indFGood),...
        'Pyr_GoodVsBadTrSpInfo_GoodTrField',pathAnal,'Spatial info. BadTr','Spatial info. GoodTr','GoodTrField');
    
    indFBad = mod_BadTr.isNeuWithField == 1;
    plotCompXY(mod_BadTr.meanCorrDistNZ(indFBad),mod_GoodTr.meanCorrDistNZ(indFBad),...
        'Pyr_GoodVsBadTrMeanCorrDist_BadTrField',pathAnal,'MeanCorrDist BadTr','MeanCorrDist GooddTr','BadTrField');
    plotCompXY(mod_BadTr.adaptSpatialInfo(indFBad),mod_GoodTr.adaptSpatialInfo(indFBad),...
        'Pyr_GoodVsBadTrAdaptSpInfo_BadTrField',pathAnal,'Adapt spatial info. BadTr','Adapt spatial info. GoodTr','BadTrField');
    plotCompXY(mod_BadTr.spatialInfo(indFBad),mod_GoodTr.spatialInfo(indFBad),...
        'Pyr_GoodVsBadTrSpInfo_BadTrField',pathAnal,'Spatial info. BadTr','Spatial info. GoodTr','BadTrField');
    
    plotCompXY(mod_BadTr.meanCorrDistNZ,mod_GoodTr.meanCorrDistNZ,...
        'Pyr_GoodVsBadTrMeanCorrDist',pathAnal,'MeanCorrDist BadTr','MeanCorrDist GoodTr','All');
    plotCompXY(mod_BadTr.adaptSpatialInfo,mod_GoodTr.adaptSpatialInfo,...
        'Pyr_GoodVsBadTrAdaptSpInfo',pathAnal,'Adapt spatial info. BadTr','Adapt spatial info. GoodTr','All');
    plotCompXY(mod_BadTr.spatialInfo,mod_GoodTr.spatialInfo,...
        'Pyr_GoodVsBadTrSpInfo',pathAnal,'Spatial info. BadTr','Spatial info. GoodTr','All');
   
    plotBurstVsTheta(mod_GoodTr.burstMeanDire,mod_GoodTr.phaseMeanDire,mod_GoodTr.fractBurst,[pathAnal,'GoodTr-']);
    plotBurstVsTheta(mod_BadTr.burstMeanDire,mod_BadTr.phaseMeanDire,mod_BadTr.fractBurst,[pathAnal,'BadTr-']);
    
    modPyrStatsGoodVsBad = modPyrStats_GoodVsBad(mod_GoodTr,mod_BadTr);

    save([pathAnal 'autoCorrPyrAllRec_GoodTrSel.mat'],'modPyrStatsGoodVsBad'); 
    
        
    %% compare good vs bad trials
    colorSel = 0;
    plotCompPyrGoodBadTr(pathAnal, mod_GoodTr, mod_BadTr, modPyrStatsGoodVsBad, colorSel);
       
    pause;
    close all;
end




