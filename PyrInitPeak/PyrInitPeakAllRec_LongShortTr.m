function PyrInitPeakAllRec_LongShortTr(taskSel,methodKMean)
%% accumulate the firing rate profiles separately for trials where the
% reward is given around 180 cm vs 200cm
    
    if(nargin == 0)
        methodKMean = 2;
    end
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakAL\' num2str(methodKMean) '\'];
    end
    
    GlobalConstFq;
    
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
%     if(taskSel == 2 && exist('modPyr2NoCue') == 0)
        disp('No cue - peak firing rate')
        modPyr2NoCue = accumLongShorTrialProfile(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,autoCorrPyrAll,...
            minFR,maxFR,1,sampleFq);

        disp('Active licking - peak firing rate')
        modPyr2AL = accumLongShorTrialProfile(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            minFR,maxFR,2,sampleFq);

        disp('Passive licking - peak firing rate')
        modPyr2PL = accumLongShorTrialProfile(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,autoCorrPyrAll,...
            minFR,maxFR,3,sampleFq);

        save([pathAnal 'initPeakPyrAllRec_LongShortTr.mat'],'modPyr2NoCue','modPyr2AL','modPyr2PL','-v7.3'); 
%     end