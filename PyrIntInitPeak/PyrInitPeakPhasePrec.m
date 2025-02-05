function PyrInitPeakPhasePrec()
% get the phase information for all the neurons in each stimulation
% condition

    pathAnal0 = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakALPL\';
    load([pathAnal0 'initPeakPyrIntAllRec.mat'],'InitAll','PyrRise','PyrDown','PyrOther');
    
    pathAnal1 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    load([pathAnal1 'autoCorrPyrAllRec.mat'],'modAlignedPyrAL','modAlignedPyrPL');
    
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
            
    modAlignedPyrAL1.task = [];
    modAlignedPyrAL1.indRec = [];
    modAlignedPyrAL1.indNeu = [];
    modAlignedPyrAL1.thetaModFreq3 = [];
    modAlignedPyrAL1.thetaFreqHMean = [];
    modAlignedPyrAL1.diffNeuronLFPFreq = [];
    modAlignedPyrAL1.isNeuWithField = [];
    avgFRProfile = [];
    % AL recordings
    indRec = unique(InitAll.indRec(InitAll.task == 2));
    for n = 1:length(indRec)
        indRec_alignedModPyr = find(modAlignedPyrAL.indRec == indRec(n));
        indRec_modPyr = find(InitAll.indRec == indRec(n) & InitAll.task == 2);
        if(length(indRec_alignedModPyr) ~= length(indRec_modPyr))
            disp(['the number of neurons in recording ' num2str(indRec(n))...
                    ' is not matched. modAlignedPyrAL ' num2str(length(indRec_alignedModPyr)) ...
                    ' InitAll ' num2str(length(indRec_modPyr))]);
            continue;
        else
            modAlignedPyrAL1.task = [modAlignedPyrAL1.task InitAll.task(indRec_modPyr)]; % recording index
            modAlignedPyrAL1.indRec = [modAlignedPyrAL1.indRec InitAll.indRec(indRec_modPyr)]; % recording index
            modAlignedPyrAL1.indNeu = [modAlignedPyrAL1.indNeu InitAll.indNeu(indRec_modPyr)]; % neuron indices trials
            avgFRProfile = [avgFRProfile; InitAll.avgFRProfile(indRec_modPyr,:)];
            modAlignedPyrAL1.thetaModFreq3 = [modAlignedPyrAL1.thetaModFreq3 modAlignedPyrAL.thetaModFreq3(indRec_alignedModPyr)];
            modAlignedPyrAL1.thetaFreqHMean = [modAlignedPyrAL1.thetaFreqHMean modAlignedPyrAL.thetaFreqHMean(indRec_alignedModPyr)];
            modAlignedPyrAL1.diffNeuronLFPFreq = [modAlignedPyrAL1.diffNeuronLFPFreq modAlignedPyrAL.thetaModFreq3(indRec_alignedModPyr)...
                        - modAlignedPyrAL.thetaFreqHMean(indRec_alignedModPyr)];
            modAlignedPyrAL1.isNeuWithField = [modAlignedPyrAL1.isNeuWithField modAlignedPyrAL.isNeuWithField(indRec_alignedModPyr)];
        end  
    end
    % PL recordings
    indRec = unique(InitAll.indRec(InitAll.task == 3));
    for n = 1:length(indRec)
        indRec_alignedModPyr = find(modAlignedPyrPL.indRec == indRec(n));
        indRec_modPyr = find(InitAll.indRec == indRec(n) & InitAll.task == 3);
        if(length(indRec_alignedModPyr) ~= length(indRec_modPyr))
            disp(['the number of neurons in recording ' num2str(indRec(n))...
                    ' is not matched. modAlignedPyrAL ' num2str(length(indRec_alignedModPyr)) ...
                    ' InitAll ' num2str(length(indRec_modPyr))]);
            continue;
        else
            modAlignedPyrAL1.task = [modAlignedPyrAL1.task InitAll.task(indRec_modPyr)]; % recording index
            modAlignedPyrAL1.indRec = [modAlignedPyrAL1.indRec InitAll.indRec(indRec_modPyr)]; % recording index
            modAlignedPyrAL1.indNeu = [modAlignedPyrAL1.indNeu InitAll.indNeu(indRec_modPyr)]; % neuron indices trials
            avgFRProfile = [avgFRProfile; InitAll.avgFRProfile(indRec_modPyr,:)];
            modAlignedPyrAL1.thetaModFreq3 = [modAlignedPyrAL1.thetaModFreq3 modAlignedPyrPL.thetaModFreq3(indRec_alignedModPyr)];
            modAlignedPyrAL1.thetaFreqHMean = [modAlignedPyrAL1.thetaFreqHMean modAlignedPyrPL.thetaFreqHMean(indRec_alignedModPyr)];
            modAlignedPyrAL1.diffNeuronLFPFreq = [modAlignedPyrAL1.diffNeuronLFPFreq modAlignedPyrPL.thetaModFreq3(indRec_alignedModPyr)...
                        - modAlignedPyrAL.thetaFreqHMean(indRec_alignedModPyr)];
            modAlignedPyrAL1.isNeuWithField = [modAlignedPyrAL1.isNeuWithField modAlignedPyrPL.isNeuWithField(indRec_alignedModPyr)];
        end  
    end
    
    %% pyramidal rise and down
    mean0to1 = mean(avgFRProfile(:,FRProfileMean.indFR0to1),2);
    meanBefRun = mean(avgFRProfile(:,FRProfileMean.indFRBefRun),2);
    ratio0to1BefRun = mean0to1./meanBefRun;
    [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
    idxNan = isnan(ratio0to1BefRunOrd);
    idxInf = isinf(ratio0to1BefRunOrd);

    idx = find(ratio0to1BefRunOrd < 1.5,1);
    idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');
    % neurons with FR increase around 0
    indOrdTmp = indOrd(1:idx);
    idxNanTmp = idxNan(1:idx);
    idxInfTmp = idxInf(1:idx);
    indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
    PyrRisePP.idxRise = indOrdTmp;
    PyrRisePP.task = modAlignedPyrAL1.task(indOrdTmp);
    PyrRisePP.indRec = modAlignedPyrAL1.indRec(indOrdTmp);
    PyrRisePP.indNeu = modAlignedPyrAL1.indNeu(indOrdTmp);
    
    % neurons with FR decrease around 0
    indOrdTmp = indOrd(idx1:end);
    idxNanTmp = idxNan(idx1:end);
    idxInfTmp = idxInf(idx1:end);
    indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
    PyrDownPP.idxDown = indOrdTmp;
    PyrDownPP.task = modAlignedPyrAL1.task(indOrdTmp);
    PyrDownPP.indRec = modAlignedPyrAL1.indRec(indOrdTmp);
    PyrDownPP.indNeu = modAlignedPyrAL1.indNeu(indOrdTmp);
    
    % other neurons (added on 7/9/2022)
    indOrdTmp = indOrd(idx+1:idx1-1);
    idxNanTmp = idxNan(idx+1:idx1-1);
    idxInfTmp = idxInf(idx+1:idx1-1);
    indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
    PyrOtherPP.idxOther = indOrdTmp;
    PyrOtherPP.task = modAlignedPyrAL1.task(indOrdTmp);
    PyrOtherPP.indRec = modAlignedPyrAL1.indRec(indOrdTmp);
    PyrOtherPP.indNeu = modAlignedPyrAL1.indNeu(indOrdTmp);
    
    
    %% All pyramidal rise, down and other neurons
    % rise
    idxNoF = modAlignedPyrAL1.isNeuWithField(PyrRisePP.idxRise) == 0;
    PyrRisePP.idxRiseNoF = PyrRisePP.idxRise(idxNoF);
    PyrRisePP.taskNoF = PyrRisePP.indRec(idxNoF);
    PyrRisePP.indRecNoF = PyrRisePP.indRec(idxNoF);
    PyrRisePP.indNeuNoF = PyrRisePP.indNeu(idxNoF);
    PyrRisePP.thetaModFreq3NoF = modAlignedPyrAL1.thetaModFreq3(PyrRisePP.idxRise(idxNoF));
    PyrRisePP.thetaFreqHMeanNoF = modAlignedPyrAL1.thetaFreqHMean(PyrRisePP.idxRise(idxNoF));
    PyrRisePP.diffNeuronLFPFreqNoF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrRisePP.idxRise(idxNoF));
    
    idxF = modAlignedPyrAL1.isNeuWithField(PyrRisePP.idxRise) == 1;
    PyrRisePP.idxRiseF = PyrRisePP.idxRise(idxF);
    PyrRisePP.taskF = PyrRisePP.task(idxF);
    PyrRisePP.indRecF = PyrRisePP.indRec(idxF);
    PyrRisePP.indNeuF = PyrRisePP.indNeu(idxF);
    PyrRisePP.thetaModFreq3F = modAlignedPyrAL1.thetaModFreq3(PyrRisePP.idxRise(idxF));
    PyrRisePP.thetaFreqHMeanF = modAlignedPyrAL1.thetaFreqHMean(PyrRisePP.idxRise(idxF));
    PyrRisePP.diffNeuronLFPFreqF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrRisePP.idxRise(idxF));
    
    PyrRisePP.pRSDiffNeuronLFPFreqFNoF = ranksum(PyrRisePP.diffNeuronLFPFreqNoF,PyrRisePP.diffNeuronLFPFreqF);
    groupRise = [ones(length(PyrRisePP.diffNeuronLFPFreqNoF),1); 2*ones(length(PyrRisePP.diffNeuronLFPFreqF),1)];
    PyrRisePP.pAVDiffNeuronLFPFreqFNoF = anova1([PyrRisePP.diffNeuronLFPFreqNoF';PyrRisePP.diffNeuronLFPFreqF'],groupRise);
          
    % down
    idxNoF = modAlignedPyrAL1.isNeuWithField(PyrDownPP.idxDown) == 0;
    PyrDownPP.idxRiseNoF = PyrDownPP.idxDown(idxNoF);
    PyrDownPP.taskNoF = PyrDownPP.task(idxNoF);
    PyrDownPP.indRecNoF = PyrDownPP.indRec(idxNoF);
    PyrDownPP.indNeuNoF = PyrDownPP.indNeu(idxNoF);
    PyrDownPP.thetaModFreq3NoF = modAlignedPyrAL1.thetaModFreq3(PyrDownPP.idxDown(idxNoF));
    PyrDownPP.thetaFreqHMeanNoF = modAlignedPyrAL1.thetaFreqHMean(PyrDownPP.idxDown(idxNoF));
    PyrDownPP.diffNeuronLFPFreqNoF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrDownPP.idxDown(idxNoF));
    
    idxF = modAlignedPyrAL1.isNeuWithField(PyrDownPP.idxDown) == 1;
    PyrDownPP.idxDownF = PyrDownPP.idxDown(idxF);
    PyrDownPP.taskF = PyrDownPP.task(idxF);
    PyrDownPP.indRecF = PyrDownPP.indRec(idxF);
    PyrDownPP.indNeuF = PyrDownPP.indNeu(idxF);
    PyrDownPP.thetaModFreq3F = modAlignedPyrAL1.thetaModFreq3(PyrDownPP.idxDown(idxF));
    PyrDownPP.thetaFreqHMeanF = modAlignedPyrAL1.thetaFreqHMean(PyrDownPP.idxDown(idxF));
    PyrDownPP.diffNeuronLFPFreqF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrDownPP.idxDown(idxF));
    
    PyrDownPP.pRSDiffNeuronLFPFreqFNoF = ranksum(PyrDownPP.diffNeuronLFPFreqNoF,PyrDownPP.diffNeuronLFPFreqF);
    groupDown = [ones(length(PyrDownPP.diffNeuronLFPFreqNoF),1); 2*ones(length(PyrDownPP.diffNeuronLFPFreqF),1)];
    PyrDownPP.pAVDiffNeuronLFPFreqFNoF = anova1([PyrDownPP.diffNeuronLFPFreqNoF';PyrDownPP.diffNeuronLFPFreqF'],groupDown);
    
    % other
    idxNoF = modAlignedPyrAL1.isNeuWithField(PyrOtherPP.idxOther) == 0;
    PyrOtherPP.idxOtherNoF = PyrOtherPP.idxOther(idxNoF);
    PyrOtherPP.taskNoF = PyrOtherPP.task(idxNoF);
    PyrOtherPP.indRecNoF = PyrOtherPP.indRec(idxNoF);
    PyrOtherPP.indNeuNoF = PyrOtherPP.indNeu(idxNoF);
    PyrOtherPP.thetaModFreq3NoF = modAlignedPyrAL1.thetaModFreq3(PyrOtherPP.idxOther(idxNoF));
    PyrOtherPP.thetaFreqHMeanNoF = modAlignedPyrAL1.thetaFreqHMean(PyrOtherPP.idxOther(idxNoF));
    PyrOtherPP.diffNeuronLFPFreqNoF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrOtherPP.idxOther(idxNoF));
    
    idxF = modAlignedPyrAL1.isNeuWithField(PyrOtherPP.idxOther) == 1;
    PyrOtherPP.idxOtherF = PyrOtherPP.idxOther(idxF);
    PyrOtherPP.taskF = PyrOtherPP.task(idxF);
    PyrOtherPP.indRecF = PyrOtherPP.indRec(idxF);
    PyrOtherPP.indNeuF = PyrOtherPP.indNeu(idxF);
    PyrOtherPP.thetaModFreq3F = modAlignedPyrAL1.thetaModFreq3(PyrOtherPP.idxOther(idxF));
    PyrOtherPP.thetaFreqHMeanF = modAlignedPyrAL1.thetaFreqHMean(PyrOtherPP.idxOther(idxF));
    PyrOtherPP.diffNeuronLFPFreqF = modAlignedPyrAL1.diffNeuronLFPFreq(PyrOtherPP.idxOther(idxF));
    
    PyrOtherPP.pRSDiffNeuronLFPFreqFNoF = ranksum(PyrOtherPP.diffNeuronLFPFreqNoF,PyrOtherPP.diffNeuronLFPFreqF);
    groupOther = [ones(length(PyrOtherPP.diffNeuronLFPFreqNoF),1); 2*ones(length(PyrOtherPP.diffNeuronLFPFreqF),1)];
    PyrOtherPP.pAVDiffNeuronLFPFreqFNoF = anova1([PyrOtherPP.diffNeuronLFPFreqNoF';PyrOtherPP.diffNeuronLFPFreqF'],groupOther);
    
    indF = modAlignedPyrAL1.isNeuWithField == 1;     
    modAlignedPyrAL1.pRSDiffNeuronLFPFreqFRiseNoF = ranksum(modAlignedPyrAL1.diffNeuronLFPFreq(indF),PyrRisePP.diffNeuronLFPFreqNoF);
    modAlignedPyrAL1.pRSDiffNeuronLFPFreqFDownNoF = ranksum(modAlignedPyrAL1.diffNeuronLFPFreq(indF),PyrDownPP.diffNeuronLFPFreqNoF);
    modAlignedPyrAL1.pRSDiffNeuronLFPFreqFOtherNoF = ranksum(modAlignedPyrAL1.diffNeuronLFPFreq(indF),PyrOtherPP.diffNeuronLFPFreqNoF);
    
    save([pathAnal0 'initPeakPyrIntAllRec_PhPrec.mat'],'modAlignedPyrAL1',...
        'PyrRisePP','PyrDownPP','PyrOtherPP');
    
    close all;
    
    plotBarOnly([mean(PyrRisePP.diffNeuronLFPFreqNoF),mean(PyrRisePP.diffNeuronLFPFreqF)],...
        [std(PyrRisePP.diffNeuronLFPFreqNoF)/sqrt(length(PyrRisePP.diffNeuronLFPFreqNoF)),...
        std(PyrRisePP.diffNeuronLFPFreqF)/sqrt(length(PyrRisePP.diffNeuronLFPFreqF))],...
        '','RiseNeuron mod. freq. - LFP freq.', ['p=' num2str(PyrRisePP.pRSDiffNeuronLFPFreqFNoF)],pathAnal0,'ModFreqMinorsLFPFreqField_PyrRise')
    
    plotBarOnly([mean(PyrDownPP.diffNeuronLFPFreqNoF),mean(PyrDownPP.diffNeuronLFPFreqF)],...
        [std(PyrDownPP.diffNeuronLFPFreqNoF)/sqrt(length(PyrDownPP.diffNeuronLFPFreqNoF)),...
        std(PyrDownPP.diffNeuronLFPFreqF)/sqrt(length(PyrDownPP.diffNeuronLFPFreqF))],...
        '','DownNeuron mod. freq. - LFP freq.', ['p=' num2str(PyrDownPP.pRSDiffNeuronLFPFreqFNoF)],pathAnal0,'ModFreqMinorsLFPFreqField_PyrDown')
    
    plotBarOnly([mean(PyrOtherPP.diffNeuronLFPFreqNoF),mean(PyrOtherPP.diffNeuronLFPFreqF)],...
        [std(PyrOtherPP.diffNeuronLFPFreqNoF)/sqrt(length(PyrOtherPP.diffNeuronLFPFreqNoF)),...
        std(PyrOtherPP.diffNeuronLFPFreqF)/sqrt(length(PyrOtherPP.diffNeuronLFPFreqF))],...
        '','OtherNeuron mod. freq. - LFP freq.', ['p=' num2str(PyrOtherPP.pRSDiffNeuronLFPFreqFNoF)],pathAnal0,'ModFreqMinorsLFPFreqField_PyrOther')
    
                