function PyrModAccumAllRec(onlyRun,methodKMean)
% e.g. PyrModAllRec(1,1,2)
        
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
        
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    GlobalConstFq;
    
%     if(exist('modPyrNoCue') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modPyrNoCue = accumPyrNeurons1(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun);

        disp('Active licking')
        modPyrAL = accumPyrNeurons1(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun);

        disp('Passive licking')
        modPyrPL = accumPyrNeurons1(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun);

        if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
            save([pathAnal0 'autoCorrPyrAllRec.mat'],'modPyrNoCue','modPyrAL','modPyrPL','-append'); 
        else
            save([pathAnal0 'autoCorrPyrAllRec.mat'],'modPyrNoCue','modPyrAL','modPyrPL');
        end
%     end
    
    plotConditions(modPyrNoCue.thetaModHist,modPyrNoCue.phaseMeanDire,...
        modPyrAL.thetaModHist,modPyrAL.phaseMeanDire,...
        modPyrPL.thetaModHist,modPyrPL.phaseMeanDire,...
        'Theta modulation (hist)','Theta phase mean direction',[]);
    
    plotConditions(modPyrNoCue.thetaModHist,modPyrNoCue.thetaModInd3,...
        modPyrAL.thetaModHist,modPyrAL.thetaModInd3,...
        modPyrPL.thetaModHist,modPyrPL.thetaModInd3,...
        'Theta modulation (hist)','Theta modulation 3',[]);
    
    if(methodKMean == 2)
        clu1 = 2; % deep
        clu2 = 1; % superficial
    elseif(methodKMean == 3)
        clu1 = 1; % deep
        clu2 = 2; % superficial
    end
    if(clu1 == 1)
        colorArr = [...
        163/255 207/255 98/255;...
        234/255 131/255 114/255];
    else
        colorArr = [...
        234/255 131/255 114/255;...
        163/255 207/255 98/255];
    end
    
    %% plot each Pyr clusters based on the task type
    plotClusters(modPyrNoCue.burstMeanDire,modPyrNoCue.phaseMeanDire,...
        autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrNoCue.task(1)),...
        'Burst mean direction','Theta phase mean direction','No cue task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    plotClusters(modPyrAL.burstMeanDire,modPyrAL.phaseMeanDire,...
        autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrAL.task(1)),...
        'Burst mean direction','Theta phase mean direction','AL task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    plotClusters(modPyrPL.burstMeanDire,modPyrPL.phaseMeanDire,...
        autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrPL.task(1)),...
        'Burst mean direction','Theta phase mean direction','PL task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    %% number of fields
    plotClusters(modPyrAL.burstMeanDire,modPyrAL.nNeuWithField,...
        autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrAL.task(1)),...
        'Burst mean direction','Num. fields','AL task',colorArr)
    
    plotClusters(modPyrPL.burstMeanDire,modPyrPL.nNeuWithField,...
        autoCorrPyrAll.idxC2(autoCorrPyrAll.task == autoCorrPyrPL.task(1)),...
        'Burst mean direction','Num. fields','PL task',colorArr)
    
    %% plot each Pyr clusters based on the task type, method 3
    plotClusters(modPyrNoCue.burstMeanDire,modPyrNoCue.phaseMeanDire,...
        autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrNoCue.task(1)),...
        'Burst mean direction','Theta phase mean direction','No cue task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    plotClusters(modPyrAL.burstMeanDire,modPyrAL.phaseMeanDire,...
        autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrAL.task(1)),...
        'Burst mean direction','Theta phase mean direction','AL task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    plotClusters(modPyrPL.burstMeanDire,modPyrPL.phaseMeanDire,...
        autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrPL.task(1)),...
        'Burst mean direction','Theta phase mean direction','PL task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
    %% number of fields
    plotClusters(modPyrAL.burstMeanDire,modPyrAL.nNeuWithField,...
        autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrAL.task(1)),...
        'Burst mean direction','Num. fields','AL task',colorArr)
    
    plotClusters(modPyrPL.burstMeanDire,modPyrPL.nNeuWithField,...
        autoCorrPyrAll.idxC3(autoCorrPyrAll.task == autoCorrPyrPL.task(1)),...
        'Burst mean direction','Num. fields','PL task',colorArr)
    
    pause;
    close all;    
end









