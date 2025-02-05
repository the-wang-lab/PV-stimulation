function mod = InterneuronModAllRecByType(modIntNoCue,modIntAL,modIntPL,...
    autoCorrIntNoCue,autoCorrIntAL,autoCorrIntPL,autoCorrIntAll,task)
%% accumulate data across trial types
% this function is called by InterneuronModAllRec.m

    if(task == 1)
        mod.nNeuWithField = [modIntNoCue.nNeuWithField modIntAL.nNeuWithField modIntPL.nNeuWithField];
        mod.burstMeanDire = [modIntNoCue.burstMeanDire modIntAL.burstMeanDire modIntPL.burstMeanDire];
        mod.nonBurstMeanDire = [modIntNoCue.nonBurstMeanDire modIntAL.nonBurstMeanDire modIntPL.nonBurstMeanDire];
        mod.burstMeanDireStart = [modIntNoCue.burstMeanDireStart modIntAL.burstMeanDireStart modIntPL.burstMeanDireStart];
        mod.numSpPerBurstMean = [modIntNoCue.numSpPerBurstMean modIntAL.numSpPerBurstMean modIntPL.numSpPerBurstMean];
        mod.fractBurst = [modIntNoCue.fractBurst modIntAL.fractBurst modIntPL.fractBurst];

        mod.thetaModHist = [modIntNoCue.thetaModHist modIntAL.thetaModHist modIntPL.thetaModHist];
        mod.thetaModHistH = [modIntNoCue.thetaModHistH modIntAL.thetaModHistH modIntPL.thetaModHistH];
        mod.phaseMeanDire = [modIntNoCue.phaseMeanDire modIntAL.phaseMeanDire modIntPL.phaseMeanDire];
        mod.phaseMeanDireH = [modIntNoCue.phaseMeanDireH modIntAL.phaseMeanDireH modIntPL.phaseMeanDireH];
        mod.maxPhaseArr = [modIntNoCue.maxPhaseFil modIntAL.maxPhaseFil modIntPL.maxPhaseFil];
        mod.maxPhaseArrH = [modIntNoCue.maxPhaseFilH modIntAL.maxPhaseFilH modIntPL.maxPhaseFilH];
        mod.minPhaseArr = [modIntNoCue.minPhaseFil modIntAL.minPhaseFil modIntPL.minPhaseFil];
        mod.minPhaseArrH = [modIntNoCue.minPhaseFilH modIntAL.minPhaseFilH modIntPL.minPhaseFilH];
        mod.phaseDiff = abs(mod.maxPhaseArr - mod.minPhaseArr);
        mod.phaseDiff(mod.phaseDiff < 0) = mod.phaseDiff(mod.phaseDiff < 0) + 360;
        mod.phaseDiffH = abs(mod.maxPhaseArrH - mod.minPhaseArrH);
        mod.phaseDiffH(mod.phaseDiffH < 0) = mod.phaseDiffH(mod.phaseDiffH < 0) + 360;

        mod.thetaModFreq3 = [modIntNoCue.thetaModFreq3 modIntAL.thetaModFreq3 modIntPL.thetaModFreq3];
        mod.thetaModInd3 = [modIntNoCue.thetaModInd3 modIntAL.thetaModInd3 modIntPL.thetaModInd3];
        mod.thetaModInd = [modIntNoCue.thetaModInd modIntAL.thetaModInd modIntPL.thetaModInd];   
        mod.thetaAsym3 = [modIntNoCue.thetaAsym3 modIntAL.thetaAsym3 modIntPL.thetaAsym3];

    %     mod.idxC = [autoCorrIntAll.idxC(autoCorrIntAll.task == autoCorrIntNoCue.task(1))' ...
    %         autoCorrIntAll.idxC(autoCorrIntAll.task == autoCorrIntAL.task(1))' ...
    %         autoCorrIntAll.idxC(autoCorrIntAll.task == autoCorrIntPL.task(1))'];
    %     mod.idxC = [autoCorrIntAll.idxC1(autoCorrIntAll.task == autoCorrIntNoCue.task(1))' ...
    %         autoCorrIntAll.idxC1(autoCorrIntAll.task == autoCorrIntAL.task(1))' ...
    %         autoCorrIntAll.idxC1(autoCorrIntAll.task == autoCorrIntPL.task(1))'];
        mod.idxC = [autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntNoCue.task(1))' ...
            autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntAL.task(1))' ...
            autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntPL.task(1))'];
    elseif(task == 2)
        mod.nNeuWithField = [modIntPL.nNeuWithField modIntAL.nNeuWithField];
        mod.burstMeanDire = [modIntPL.burstMeanDire modIntAL.burstMeanDire];
        mod.nonBurstMeanDire = [modIntPL.nonBurstMeanDire modIntAL.nonBurstMeanDire];
        mod.burstMeanDireStart = [modIntPL.burstMeanDireStart modIntAL.burstMeanDireStart];
        mod.numSpPerBurstMean = [modIntPL.numSpPerBurstMean modIntAL.numSpPerBurstMean];
        mod.fractBurst = [modIntPL.fractBurst modIntAL.fractBurst];

        mod.thetaModHist = [modIntPL.thetaModHist modIntAL.thetaModHist];
        mod.thetaModHistH = [modIntPL.thetaModHistH modIntAL.thetaModHistH];
        mod.phaseMeanDire = [modIntPL.phaseMeanDire modIntAL.phaseMeanDire];
        mod.phaseMeanDireH = [modIntPL.phaseMeanDireH modIntAL.phaseMeanDireH];
        mod.maxPhaseArr = [modIntPL.maxPhaseFil modIntAL.maxPhaseFil];
        mod.maxPhaseArrH = [modIntPL.maxPhaseFilH modIntAL.maxPhaseFilH];
        mod.minPhaseArr = [modIntPL.minPhaseFil modIntAL.minPhaseFil];
        mod.minPhaseArrH = [modIntPL.minPhaseFilH modIntAL.minPhaseFilH];
        mod.phaseDiff = abs(mod.maxPhaseArr - mod.minPhaseArr);
        mod.phaseDiff(mod.phaseDiff < 0) = mod.phaseDiff(mod.phaseDiff < 0) + 360;
        mod.phaseDiffH = abs(mod.maxPhaseArrH - mod.minPhaseArrH);
        mod.phaseDiffH(mod.phaseDiffH < 0) = mod.phaseDiffH(mod.phaseDiffH < 0) + 360;

        mod.thetaModFreq3 = [modIntPL.thetaModFreq3 modIntAL.thetaModFreq3];
        mod.thetaModInd3 = [modIntPL.thetaModInd3 modIntAL.thetaModInd3];
        mod.thetaModInd = [modIntPL.thetaModInd modIntAL.thetaModInd];   
        mod.thetaAsym3 = [modIntPL.thetaAsym3 modIntAL.thetaAsym3];

        mod.idxC = [autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntPL.task(1))'...
            autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntAL.task(1))'];
    else
        mod.nNeuWithField = modIntAL.nNeuWithField;
        mod.burstMeanDire = modIntAL.burstMeanDire;
        mod.nonBurstMeanDire = modIntAL.nonBurstMeanDire;
        mod.burstMeanDireStart = modIntAL.burstMeanDireStart;
        mod.numSpPerBurstMean = modIntAL.numSpPerBurstMean;
        mod.fractBurst = modIntAL.fractBurst;

        mod.thetaModHist = modIntAL.thetaModHist;
        mod.thetaModHistH = modIntAL.thetaModHistH;
        mod.phaseMeanDire = modIntAL.phaseMeanDire;
        mod.phaseMeanDireH = modIntAL.phaseMeanDireH;
        mod.maxPhaseArr = modIntAL.maxPhaseFil;
        mod.maxPhaseArrH = modIntAL.maxPhaseFilH;
        mod.minPhaseArr = modIntAL.minPhaseFil;
        mod.minPhaseArrH = modIntAL.minPhaseFilH;
        mod.phaseDiff = abs(mod.maxPhaseArr - mod.minPhaseArr);
        mod.phaseDiff(mod.phaseDiff < 0) = mod.phaseDiff(mod.phaseDiff < 0) + 360;
        mod.phaseDiffH = abs(mod.maxPhaseArrH - mod.minPhaseArrH);
        mod.phaseDiffH(mod.phaseDiffH < 0) = mod.phaseDiffH(mod.phaseDiffH < 0) + 360;

        mod.thetaModFreq3 = modIntAL.thetaModFreq3;
        mod.thetaModInd3 = modIntAL.thetaModInd3;
        mod.thetaModInd = modIntAL.thetaModInd;   
        mod.thetaAsym3 = modIntAL.thetaAsym3;

        mod.idxC = autoCorrIntAll.idxC2(autoCorrIntAll.task == autoCorrIntAL.task(1))';
    end