function PyrInitSpeedVsFRChRunOnset(taskSel,methodKMean)

    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakAL\' num2str(methodKMean) '\'];
    end
    
    if(exist([pathAnal 'initPeakPyrSpeedAllRecSel.mat']))
        load([pathAnal 'initPeakPyrSpeedAllRecSel.mat']);
    end
    
    if(taskSel == 1) % including all the neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeak\';
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakALPL\';
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAL\';
    end
    if(exist([pathAnal 'initPeakPyrIntAllRec.mat']))
        load([pathAnal 'initPeakPyrIntAllRec.mat']);
    end
    
    speedDiff = modPyrInitSpeed.meanRunSpeed0to1TrGood(PyrRise.idxRise) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrGood(PyrRise.idxRise);
    plot(modPyrInitSpeed.meanRunSpeed0to1TrGood(PyrRise.idxRise) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrGood(PyrRise.idxRise),...
        FRProfileMeanPyr.Rise.relChangeBefRunVs0to1,'o')
    [corrSpeedFRCh,pSpeedFRCh] = corr(speedDiff',...
        FRProfileMeanPyr.Rise.relChangeBefRunVs0to1);
    
    speedDiff = modPyrInitSpeed.meanRunSpeed0to1TrGood(PyrDown.idxDown) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrGood(PyrDown.idxDown);
    plot(modPyrInitSpeed.meanRunSpeed0to1TrGood(PyrDown.idxDown) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrGood(PyrDown.idxDown),...
        FRProfileMeanPyr.Down.relChangeBefRunVs0to1,'o')
    [corrSpeedFRCh,pSpeedFRCh] = corr(speedDiff',...
        FRProfileMeanPyr.Down.relChangeBefRunVs0to1);
    
    plot(modPyrInitSpeed.meanRunSpeed0to1TrBad(PyrRise.idxRiseBadBad) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrBad(PyrRise.idxRiseBadBad),...
        FRProfileMeanPyr.RiseBad.relChangeBefRunVs0to1,'o')
    
    plot(modPyrInitSpeed.meanRunSpeed0to1TrBad(PyrDown.idxDownBadBad) - ...
        modPyrInitSpeed.meanRunSpeedBefRunTrBad(PyrDown.idxDownBadBad),...
        FRProfileMeanPyr.DownBad.relChangeBefRunVs0to1,'o')
    
    hist(modPyrInitSpeed.corrInstFRRunSpeed0to1Good(PyrRise.idxRise),-1:0.1:1)
    hist(modPyrInitSpeed.corrInstFRRunSpeedBefRunGood(PyrRise.idxRise),-1:0.1:1)
    hist(modPyrInitSpeed.corrInstFRRunSpeed0to1Good(PyrDown.idxDown),-1:0.1:1)
    hist(modPyrInitSpeed.corrInstFRRunSpeedBefRunGood(PyrDown.idxDown),-1:0.1:1)