function [thetaMod,thetaModStim,thetaModStimCtrl] = accumThetaMod(modPyr1,ind)

    thetaMod.thetaFreqHMean = modPyr1.thetaFreqHMeanGoodNonStim(ind);
    thetaMod.thetaMod = modPyr1.thetaModGoodNonStim(ind);
    thetaMod.thetaModInd = modPyr1.thetaModIndGoodNonStim(ind);
    thetaMod.thetaModInd3 = modPyr1.thetaModInd3GoodNonStim(ind);
    thetaMod.thetaAsym3 = modPyr1.thetaAsym3GoodNonStim(ind);
    thetaMod.thetaModFreq3 = modPyr1.thetaModFreq3GoodNonStim(ind);
    thetaMod.diffThetaFreq = thetaMod.thetaModFreq3-thetaMod.thetaFreqHMean; 
    
    thetaModStim.thetaFreqHMean = modPyr1.thetaFreqHMeanStim(ind);
    thetaModStim.thetaMod = modPyr1.thetaModStim(ind);
    thetaModStim.thetaModInd = modPyr1.thetaModIndStim(ind);
    thetaModStim.thetaModInd3 = modPyr1.thetaModInd3Stim(ind);
    thetaModStim.thetaAsym3 = modPyr1.thetaAsym3Stim(ind);
    thetaModStim.thetaModFreq3 = modPyr1.thetaModFreq3Stim(ind);
    thetaModStim.diffThetaFreq = thetaModStim.thetaModFreq3-thetaModStim.thetaFreqHMean; 
    
    thetaModStimCtrl.thetaFreqHMean = modPyr1.thetaFreqHMeanStimCtrl(ind);
    thetaModStimCtrl.thetaMod = modPyr1.thetaModStimCtrl(ind);
    thetaModStimCtrl.thetaModInd = modPyr1.thetaModIndStimCtrl(ind);
    thetaModStimCtrl.thetaModInd3 = modPyr1.thetaModInd3StimCtrl(ind);
    thetaModStimCtrl.thetaAsym3 = modPyr1.thetaAsym3StimCtrl(ind);
    thetaModStimCtrl.thetaModFreq3 = modPyr1.thetaModFreq3StimCtrl(ind);
    thetaModStimCtrl.diffThetaFreq = thetaModStimCtrl.thetaModFreq3-thetaModStimCtrl.thetaFreqHMean; 
end