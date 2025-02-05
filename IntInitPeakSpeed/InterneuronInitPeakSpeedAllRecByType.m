function modInt2 = InterneuronInitPeakSpeedAllRecByType(modInt2NoCue,modInt2AL,modInt2PL,modInt1NoCue,modInt1AL,modInt1PL,taskSel,methodKMean)
% the relation between speed and initial peak
    
    pSig = 0.01;
    if(taskSel == 1)
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrGood = [modInt2NoCue.meanRunSpeedTrGood,...
            modInt2AL.meanRunSpeedTrGood,modInt2PL.meanRunSpeedTrGood];
        modInt2.meanRunSpeedBLTrGood = [modInt2NoCue.meanRunSpeedBLTrGood,...
            modInt2AL.meanRunSpeedBLTrGood,modInt2PL.meanRunSpeedBLTrGood];
        modInt2.meanRunSpeedBefRunTrGood = [modInt2NoCue.meanRunSpeedBefRunTrGood,...
            modInt2AL.meanRunSpeedBefRunTrGood,modInt2PL.meanRunSpeedBefRunTrGood];
        modInt2.meanRunSpeed0to1TrGood = [modInt2NoCue.meanRunSpeed0to1TrGood,...
            modInt2AL.meanRunSpeed0to1TrGood,modInt2PL.meanRunSpeed0to1TrGood];
        modInt2.meanRunSpeed3to5TrGood = [modInt2NoCue.meanRunSpeed3to5TrGood,...
            modInt2AL.meanRunSpeed3to5TrGood,modInt2PL.meanRunSpeed3to5TrGood];
        %%
        
        modInt2.corrInstFRRunSpeedGood = [modInt2NoCue.corrInstFRRunSpeedGood,...
            modInt2AL.corrInstFRRunSpeedGood,modInt2PL.corrInstFRRunSpeedGood];
        modInt2.corrInstFRRunSpeedBLGood = [modInt2NoCue.corrInstFRRunSpeedBLGood,...
            modInt2AL.corrInstFRRunSpeedBLGood,modInt2PL.corrInstFRRunSpeedBLGood];
        modInt2.corrInstFRRunSpeedBefRunGood = [modInt2NoCue.corrInstFRRunSpeedBefRunGood,...
            modInt2AL.corrInstFRRunSpeedBefRunGood,modInt2PL.corrInstFRRunSpeedBefRunGood];
        modInt2.corrInstFRRunSpeed0to1Good = [modInt2NoCue.corrInstFRRunSpeed0to1Good,...
            modInt2AL.corrInstFRRunSpeed0to1Good,modInt2PL.corrInstFRRunSpeed0to1Good];
        modInt2.corrInstFRRunSpeed3to5Good = [modInt2NoCue.corrInstFRRunSpeed3to5Good,...
            modInt2AL.corrInstFRRunSpeed3to5Good,modInt2PL.corrInstFRRunSpeed3to5Good];
        modInt2.corrStopTimeRunSpeedGood = [modInt2NoCue.corrStopTimeRunSpeedGood,...
            modInt2AL.corrStopTimeRunSpeedGood,modInt2PL.corrStopTimeRunSpeedGood];
        modInt2.corrStopTimeRunSpeed0to1Good = [modInt2NoCue.corrStopTimeRunSpeed0to1Good,...
            modInt2AL.corrStopTimeRunSpeed0to1Good,modInt2PL.corrStopTimeRunSpeed0to1Good];
        modInt2.corrStopTimeInstFRBefRunGood = [modInt2NoCue.corrStopTimeInstFRBefRunGood,...
            modInt2AL.corrStopTimeInstFRBefRunGood,modInt2PL.corrStopTimeInstFRBefRunGood];
        modInt2.corrStopTimeInstFR0to1Good = [modInt2NoCue.corrStopTimeInstFR0to1Good,...
            modInt2AL.corrStopTimeInstFR0to1Good,modInt2PL.corrStopTimeInstFR0to1Good];

        modInt2.pCorrInstFRRunSpeedGood = [modInt2NoCue.pCorrInstFRRunSpeedGood,...
            modInt2AL.pCorrInstFRRunSpeedGood,modInt2PL.pCorrInstFRRunSpeedGood];
        modInt2.pCorrInstFRRunSpeedBLGood = [modInt2NoCue.pCorrInstFRRunSpeedBLGood,...
            modInt2AL.pCorrInstFRRunSpeedBLGood,modInt2PL.pCorrInstFRRunSpeedBLGood];
        modInt2.pCorrInstFRRunSpeedBefRunGood = [modInt2NoCue.pCorrInstFRRunSpeedBefRunGood,...
            modInt2AL.pCorrInstFRRunSpeedBefRunGood,modInt2PL.pCorrInstFRRunSpeedBefRunGood];
        modInt2.pCorrInstFRRunSpeed0to1Good = [modInt2NoCue.pCorrInstFRRunSpeed0to1Good,...
            modInt2AL.pCorrInstFRRunSpeed0to1Good,modInt2PL.pCorrInstFRRunSpeed0to1Good];
        modInt2.pCorrInstFRRunSpeed3to5Good = [modInt2NoCue.pCorrInstFRRunSpeed3to5Good,...
            modInt2AL.pCorrInstFRRunSpeed3to5Good,modInt2PL.pCorrInstFRRunSpeed3to5Good];
        modInt2.pCorrStopTimeRunSpeedGood = [modInt2NoCue.pCorrStopTimeRunSpeedGood,...
            modInt2AL.pCorrStopTimeRunSpeedGood,modInt2PL.pCorrStopTimeRunSpeedGood];
        modInt2.pCorrStopTimeRunSpeed0to1Good = [modInt2NoCue.pCorrStopTimeRunSpeed0to1Good,...
            modInt2AL.pCorrStopTimeRunSpeed0to1Good,modInt2PL.pCorrStopTimeRunSpeed0to1Good];
        modInt2.pCorrStopTimeInstFRBefRunGood = [modInt2NoCue.pCorrStopTimeInstFRBefRunGood,...
            modInt2AL.pCorrStopTimeInstFRBefRunGood,modInt2PL.pCorrStopTimeInstFRBefRunGood];
        modInt2.pCorrStopTimeInstFR0to1Good = [modInt2NoCue.pCorrStopTimeInstFR0to1Good,...
            modInt2AL.pCorrStopTimeInstFR0to1Good,modInt2PL.pCorrStopTimeInstFR0to1Good];

        modInt2.lmSlopeInstFRRunSpeedGood = [modInt2NoCue.lmSlopeInstFRRunSpeedGood,...
            modInt2AL.lmSlopeInstFRRunSpeedGood,modInt2PL.lmSlopeInstFRRunSpeedGood];
        modInt2.lmSlopeInstFRRunSpeedBefRunGood = [modInt2NoCue.lmSlopeInstFRRunSpeedBefRunGood,...
            modInt2AL.lmSlopeInstFRRunSpeedBefRunGood,modInt2PL.lmSlopeInstFRRunSpeedBefRunGood];
        modInt2.lmSlopeInstFRRunSpeed0to1Good = [modInt2NoCue.lmSlopeInstFRRunSpeed0to1Good,...
            modInt2AL.lmSlopeInstFRRunSpeed0to1Good,modInt2PL.lmSlopeInstFRRunSpeed0to1Good];
        modInt2.lmSlopeInstFRRunSpeed3to5Good = [modInt2NoCue.lmSlopeInstFRRunSpeed3to5Good,...
            modInt2AL.lmSlopeInstFRRunSpeed3to5Good,modInt2PL.lmSlopeInstFRRunSpeed3to5Good];

        modInt2.lmPInstFRRunSpeedGood = [modInt2NoCue.lmPInstFRRunSpeedGood,...
            modInt2AL.lmPInstFRRunSpeedGood,modInt2PL.lmPInstFRRunSpeedGood];
        modInt2.lmPInstFRRunSpeedBefRunGood = [modInt2NoCue.lmPInstFRRunSpeedBefRunGood,...
            modInt2AL.lmPInstFRRunSpeedBefRunGood,modInt2PL.lmPInstFRRunSpeedBefRunGood];
        modInt2.lmPInstFRRunSpeed0to1Good = [modInt2NoCue.lmPInstFRRunSpeed0to1Good,...
            modInt2AL.lmPInstFRRunSpeed0to1Good,modInt2PL.lmPInstFRRunSpeed0to1Good];
        modInt2.lmPInstFRRunSpeed3to5Good = [modInt2NoCue.lmPInstFRRunSpeed3to5Good,...
            modInt2AL.lmPInstFRRunSpeed3to5Good,modInt2PL.lmPInstFRRunSpeed3to5Good];

        modInt2.lmRInstFRRunSpeedGood = [modInt2NoCue.lmRInstFRRunSpeedGood,...
            modInt2AL.lmRInstFRRunSpeedGood,modInt2PL.lmRInstFRRunSpeedGood];
        modInt2.lmRInstFRRunSpeedBefRunGood = [modInt2NoCue.lmRInstFRRunSpeedBefRunGood,...
            modInt2AL.lmRInstFRRunSpeedBefRunGood,modInt2PL.lmRInstFRRunSpeedBefRunGood];
        modInt2.lmRInstFRRunSpeed0to1Good = [modInt2NoCue.lmRInstFRRunSpeed0to1Good,...
            modInt2AL.lmRInstFRRunSpeed0to1Good,modInt2PL.lmRInstFRRunSpeed0to1Good];
        modInt2.lmRInstFRRunSpeed3to5Good = [modInt2NoCue.lmRInstFRRunSpeed3to5Good,...
            modInt2AL.lmRInstFRRunSpeed3to5Good,modInt2PL.lmRInstFRRunSpeed3to5Good];
        
        %% bad trials
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrBad = [modInt2NoCue.meanRunSpeedTrBad,...
            modInt2AL.meanRunSpeedTrBad,modInt2PL.meanRunSpeedTrBad];
        modInt2.meanRunSpeedBLTrBad = [modInt2NoCue.meanRunSpeedBLTrBad,...
            modInt2AL.meanRunSpeedBLTrBad,modInt2PL.meanRunSpeedBLTrBad];
        modInt2.meanRunSpeedBefRunTrBad = [modInt2NoCue.meanRunSpeedBefRunTrBad,...
            modInt2AL.meanRunSpeedBefRunTrBad,modInt2PL.meanRunSpeedBefRunTrBad];
        modInt2.meanRunSpeed0to1TrBad = [modInt2NoCue.meanRunSpeed0to1TrBad,...
            modInt2AL.meanRunSpeed0to1TrBad,modInt2PL.meanRunSpeed0to1TrBad];
        modInt2.meanRunSpeed3to5TrBad = [modInt2NoCue.meanRunSpeed3to5TrBad,...
            modInt2AL.meanRunSpeed3to5TrBad,modInt2PL.meanRunSpeed3to5TrBad];
        %%
        
        modInt2.corrInstFRRunSpeedBad = [modInt2NoCue.corrInstFRRunSpeedBad,...
            modInt2AL.corrInstFRRunSpeedBad,modInt2PL.corrInstFRRunSpeedBad];
        modInt2.corrInstFRRunSpeedBLBad = [modInt2NoCue.corrInstFRRunSpeedBLBad,...
            modInt2AL.corrInstFRRunSpeedBLBad,modInt2PL.corrInstFRRunSpeedBLBad];
        modInt2.corrInstFRRunSpeedBefRunBad = [modInt2NoCue.corrInstFRRunSpeedBefRunBad,...
            modInt2AL.corrInstFRRunSpeedBefRunBad,modInt2PL.corrInstFRRunSpeedBefRunBad];
        modInt2.corrInstFRRunSpeed0to1Bad = [modInt2NoCue.corrInstFRRunSpeed0to1Bad,...
            modInt2AL.corrInstFRRunSpeed0to1Bad,modInt2PL.corrInstFRRunSpeed0to1Bad];
        modInt2.corrInstFRRunSpeed3to5Bad = [modInt2NoCue.corrInstFRRunSpeed3to5Bad,...
            modInt2AL.corrInstFRRunSpeed3to5Bad,modInt2PL.corrInstFRRunSpeed3to5Bad];
        modInt2.corrStopTimeRunSpeedBad = [modInt2NoCue.corrStopTimeRunSpeedBad,...
            modInt2AL.corrStopTimeRunSpeedBad,modInt2PL.corrStopTimeRunSpeedBad];
        modInt2.corrStopTimeInstFRBefRunBad = [modInt2NoCue.corrStopTimeInstFRBefRunBad,...
            modInt2AL.corrStopTimeInstFRBefRunBad,modInt2PL.corrStopTimeInstFRBefRunBad];
         modInt2.corrStopTimeRunSpeed0to1Bad = [modInt2NoCue.corrStopTimeRunSpeed0to1Bad,...
            modInt2AL.corrStopTimeRunSpeed0to1Bad,modInt2PL.corrStopTimeRunSpeed0to1Bad];
        modInt2.corrStopTimeInstFR0to1Bad = [modInt2NoCue.corrStopTimeInstFR0to1Bad,...
            modInt2AL.corrStopTimeInstFR0to1Bad,modInt2PL.corrStopTimeInstFR0to1Bad];

        modInt2.pCorrInstFRRunSpeedBad = [modInt2NoCue.pCorrInstFRRunSpeedBad,...
            modInt2AL.pCorrInstFRRunSpeedBad,modInt2PL.pCorrInstFRRunSpeedBad];
        modInt2.pCorrInstFRRunSpeedBLBad = [modInt2NoCue.pCorrInstFRRunSpeedBLBad,...
            modInt2AL.pCorrInstFRRunSpeedBLBad,modInt2PL.pCorrInstFRRunSpeedBLBad];
        modInt2.pCorrInstFRRunSpeedBefRunBad = [modInt2NoCue.pCorrInstFRRunSpeedBefRunBad,...
            modInt2AL.pCorrInstFRRunSpeedBefRunBad,modInt2PL.pCorrInstFRRunSpeedBefRunBad];
        modInt2.pCorrInstFRRunSpeed0to1Bad = [modInt2NoCue.pCorrInstFRRunSpeed0to1Bad,...
            modInt2AL.pCorrInstFRRunSpeed0to1Bad,modInt2PL.pCorrInstFRRunSpeed0to1Bad];
        modInt2.pCorrInstFRRunSpeed3to5Bad = [modInt2NoCue.pCorrInstFRRunSpeed3to5Bad,...
            modInt2AL.pCorrInstFRRunSpeed3to5Bad,modInt2PL.pCorrInstFRRunSpeed3to5Bad];
        modInt2.pCorrStopTimeRunSpeedBad = [modInt2NoCue.pCorrStopTimeRunSpeedBad,...
            modInt2AL.pCorrStopTimeRunSpeedBad,modInt2PL.pCorrStopTimeRunSpeedBad];
        modInt2.pCorrStopTimeRunSpeed0to1Bad = [modInt2NoCue.pCorrStopTimeRunSpeed0to1Bad,...
            modInt2AL.pCorrStopTimeRunSpeed0to1Bad,modInt2PL.pCorrStopTimeRunSpeed0to1Bad];
        modInt2.pCorrStopTimeInstFRBefRunBad = [modInt2NoCue.pCorrStopTimeInstFRBefRunBad,...
            modInt2AL.pCorrStopTimeInstFRBefRunBad,modInt2PL.pCorrStopTimeInstFRBefRunBad];
        modInt2.pCorrStopTimeInstFR0to1Bad = [modInt2NoCue.pCorrStopTimeInstFR0to1Bad,...
            modInt2AL.pCorrStopTimeInstFR0to1Bad,modInt2PL.pCorrStopTimeInstFR0to1Bad];
        
        if(methodKMean == 1)
            idxC = [modInt1NoCue.idxC1Good modInt1AL.idxC1Good modInt1PL.idxC1Good];
            idxCBad = [modInt1NoCue.idxC1Bad modInt1AL.idxC1Bad modInt1PL.idxC1Bad];
        elseif(methodKMean == 2)
            idxC = [modInt1NoCue.idxC2Good modInt1AL.idxC2Good modInt1PL.idxC2Good];
            idxCBad = [modInt1NoCue.idxC2Bad modInt1AL.idxC2Bad modInt1PL.idxC2Bad];
        elseif(methodKMean == 3)
            idxC = [modInt1NoCue.idxC3Good modInt1AL.idxC3Good modInt1PL.idxC3Good];
            idxCBad = [modInt1NoCue.idxC3Bad modInt1AL.idxC3Bad modInt1PL.idxC3Bad];
        end
    elseif(taskSel == 2)
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrGood = [...
            modInt2AL.meanRunSpeedTrGood,modInt2PL.meanRunSpeedTrGood];
        modInt2.meanRunSpeedBLTrGood = [...
            modInt2AL.meanRunSpeedBLTrGood,modInt2PL.meanRunSpeedBLTrGood];
        modInt2.meanRunSpeedBefRunTrGood = [...
            modInt2AL.meanRunSpeedBefRunTrGood,modInt2PL.meanRunSpeedBefRunTrGood];
        modInt2.meanRunSpeed0to1TrGood = [...
            modInt2AL.meanRunSpeed0to1TrGood,modInt2PL.meanRunSpeed0to1TrGood];
        modInt2.meanRunSpeed3to5TrGood = [...
            modInt2AL.meanRunSpeed3to5TrGood,modInt2PL.meanRunSpeed3to5TrGood];
        %%
        
        modInt2.corrInstFRRunSpeedGood = [modInt2AL.corrInstFRRunSpeedGood,...
            modInt2PL.corrInstFRRunSpeedGood];
        modInt2.corrInstFRRunSpeedBLGood = [...
            modInt2AL.corrInstFRRunSpeedBLGood,modInt2PL.corrInstFRRunSpeedBLGood];
        modInt2.corrInstFRRunSpeedBefRunGood = [...
            modInt2AL.corrInstFRRunSpeedBefRunGood,modInt2PL.corrInstFRRunSpeedBefRunGood];
        modInt2.corrInstFRRunSpeed0to1Good = [...
            modInt2AL.corrInstFRRunSpeed0to1Good,modInt2PL.corrInstFRRunSpeed0to1Good];
        modInt2.corrInstFRRunSpeed3to5Good = [...
            modInt2AL.corrInstFRRunSpeed3to5Good,modInt2PL.corrInstFRRunSpeed3to5Good];
        modInt2.corrStopTimeRunSpeedGood = [...
            modInt2AL.corrStopTimeRunSpeedGood,modInt2PL.corrStopTimeRunSpeedGood];
         modInt2.corrStopTimeRunSpeed0to1Good = [...
            modInt2AL.corrStopTimeRunSpeed0to1Good,modInt2PL.corrStopTimeRunSpeed0to1Good];
        modInt2.corrStopTimeInstFRBefRunGood = [...
            modInt2AL.corrStopTimeInstFRBefRunGood,modInt2PL.corrStopTimeInstFRBefRunGood];
        modInt2.corrStopTimeInstFR0to1Good = [...
            modInt2AL.corrStopTimeInstFR0to1Good,modInt2PL.corrStopTimeInstFR0to1Good];

        modInt2.pCorrInstFRRunSpeedGood = [...
            modInt2AL.pCorrInstFRRunSpeedGood,modInt2PL.pCorrInstFRRunSpeedGood];
        modInt2.pCorrInstFRRunSpeedBLGood = [...
            modInt2AL.pCorrInstFRRunSpeedBLGood,modInt2PL.pCorrInstFRRunSpeedBLGood];
        modInt2.pCorrInstFRRunSpeedBefRunGood = [...
            modInt2AL.pCorrInstFRRunSpeedBefRunGood,modInt2PL.pCorrInstFRRunSpeedBefRunGood];
        modInt2.pCorrInstFRRunSpeed0to1Good = [...
            modInt2AL.pCorrInstFRRunSpeed0to1Good,modInt2PL.pCorrInstFRRunSpeed0to1Good];
        modInt2.pCorrInstFRRunSpeed3to5Good = [...
            modInt2AL.pCorrInstFRRunSpeed3to5Good,modInt2PL.pCorrInstFRRunSpeed3to5Good];
        modInt2.pCorrStopTimeRunSpeedGood = [...
            modInt2AL.pCorrStopTimeRunSpeedGood,modInt2PL.pCorrStopTimeRunSpeedGood];
        modInt2.pCorrStopTimeRunSpeed0to1Good = [...
            modInt2AL.pCorrStopTimeRunSpeed0to1Good,modInt2PL.pCorrStopTimeRunSpeed0to1Good];
        modInt2.pCorrStopTimeInstFRBefRunGood = [...
            modInt2AL.pCorrStopTimeInstFRBefRunGood,modInt2PL.pCorrStopTimeInstFRBefRunGood];
        modInt2.pCorrStopTimeInstFR0to1Good = [...
            modInt2AL.pCorrStopTimeInstFR0to1Good,modInt2PL.pCorrStopTimeInstFR0to1Good];

        modInt2.lmSlopeInstFRRunSpeedGood = [...
            modInt2AL.lmSlopeInstFRRunSpeedGood,modInt2PL.lmSlopeInstFRRunSpeedGood];
        modInt2.lmSlopeInstFRRunSpeedBefRunGood = [...
            modInt2AL.lmSlopeInstFRRunSpeedBefRunGood,modInt2PL.lmSlopeInstFRRunSpeedBefRunGood];
        modInt2.lmSlopeInstFRRunSpeed0to1Good = [...
            modInt2AL.lmSlopeInstFRRunSpeed0to1Good,modInt2PL.lmSlopeInstFRRunSpeed0to1Good];
        modInt2.lmSlopeInstFRRunSpeed3to5Good = [...
            modInt2AL.lmSlopeInstFRRunSpeed3to5Good,modInt2PL.lmSlopeInstFRRunSpeed3to5Good];

        modInt2.lmPInstFRRunSpeedGood = [...
            modInt2AL.lmPInstFRRunSpeedGood,modInt2PL.lmPInstFRRunSpeedGood];
        modInt2.lmPInstFRRunSpeedBefRunGood = [...
            modInt2AL.lmPInstFRRunSpeedBefRunGood,modInt2PL.lmPInstFRRunSpeedBefRunGood];
        modInt2.lmPInstFRRunSpeed0to1Good = [...
            modInt2AL.lmPInstFRRunSpeed0to1Good,modInt2PL.lmPInstFRRunSpeed0to1Good];
        modInt2.lmPInstFRRunSpeed3to5Good = [...
            modInt2AL.lmPInstFRRunSpeed3to5Good,modInt2PL.lmPInstFRRunSpeed3to5Good];

        modInt2.lmRInstFRRunSpeedGood = [...
            modInt2AL.lmRInstFRRunSpeedGood,modInt2PL.lmRInstFRRunSpeedGood];
        modInt2.lmRInstFRRunSpeedBefRunGood = [...
            modInt2AL.lmRInstFRRunSpeedBefRunGood,modInt2PL.lmRInstFRRunSpeedBefRunGood];
        modInt2.lmRInstFRRunSpeed0to1Good = [...
            modInt2AL.lmRInstFRRunSpeed0to1Good,modInt2PL.lmRInstFRRunSpeed0to1Good];
        modInt2.lmRInstFRRunSpeed3to5Good = [...
            modInt2AL.lmRInstFRRunSpeed3to5Good,modInt2PL.lmRInstFRRunSpeed3to5Good];
        
        %% bad trials
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrBad = [...
            modInt2AL.meanRunSpeedTrBad,modInt2PL.meanRunSpeedTrBad];
        modInt2.meanRunSpeedBLTrBad = [...
            modInt2AL.meanRunSpeedBLTrBad,modInt2PL.meanRunSpeedBLTrBad];
        modInt2.meanRunSpeedBefRunTrBad = [...
            modInt2AL.meanRunSpeedBefRunTrBad,modInt2PL.meanRunSpeedBefRunTrBad];
        modInt2.meanRunSpeed0to1TrBad = [...
            modInt2AL.meanRunSpeed0to1TrBad,modInt2PL.meanRunSpeed0to1TrBad];
        modInt2.meanRunSpeed3to5TrBad = [...
            modInt2AL.meanRunSpeed3to5TrBad,modInt2PL.meanRunSpeed3to5TrBad];
        %%
        
        modInt2.corrInstFRRunSpeedBad = [...
            modInt2AL.corrInstFRRunSpeedBad,modInt2PL.corrInstFRRunSpeedBad];
        modInt2.corrInstFRRunSpeedBLBad = [...
            modInt2AL.corrInstFRRunSpeedBLBad,modInt2PL.corrInstFRRunSpeedBLBad];
        modInt2.corrInstFRRunSpeedBefRunBad = [...
            modInt2AL.corrInstFRRunSpeedBefRunBad,modInt2PL.corrInstFRRunSpeedBefRunBad];
        modInt2.corrInstFRRunSpeed0to1Bad = [...
            modInt2AL.corrInstFRRunSpeed0to1Bad,modInt2PL.corrInstFRRunSpeed0to1Bad];
        modInt2.corrInstFRRunSpeed3to5Bad = [...
            modInt2AL.corrInstFRRunSpeed3to5Bad,modInt2PL.corrInstFRRunSpeed3to5Bad];
        modInt2.corrStopTimeRunSpeedBad = [...
            modInt2AL.corrStopTimeRunSpeedBad,modInt2PL.corrStopTimeRunSpeedBad];
         modInt2.corrStopTimeRunSpeed0to1Bad = [...
            modInt2AL.corrStopTimeRunSpeed0to1Bad,modInt2PL.corrStopTimeRunSpeed0to1Bad];
        modInt2.corrStopTimeInstFRBefRunBad = [...
            modInt2AL.corrStopTimeInstFRBefRunBad,modInt2PL.corrStopTimeInstFRBefRunBad];
        modInt2.corrStopTimeInstFR0to1Bad = [...
            modInt2AL.corrStopTimeInstFR0to1Bad,modInt2PL.corrStopTimeInstFR0to1Bad];

        modInt2.pCorrInstFRRunSpeedBad = [...
            modInt2AL.pCorrInstFRRunSpeedBad,modInt2PL.pCorrInstFRRunSpeedBad];
        modInt2.pCorrInstFRRunSpeedBLBad = [...
            modInt2AL.pCorrInstFRRunSpeedBLBad,modInt2PL.pCorrInstFRRunSpeedBLBad];
        modInt2.pCorrInstFRRunSpeedBefRunBad = [...
            modInt2AL.pCorrInstFRRunSpeedBefRunBad,modInt2PL.pCorrInstFRRunSpeedBefRunBad];
        modInt2.pCorrInstFRRunSpeed0to1Bad = [...
            modInt2AL.pCorrInstFRRunSpeed0to1Bad,modInt2PL.pCorrInstFRRunSpeed0to1Bad];
        modInt2.pCorrInstFRRunSpeed3to5Bad = [...
            modInt2AL.pCorrInstFRRunSpeed3to5Bad,modInt2PL.pCorrInstFRRunSpeed3to5Bad];
        modInt2.pCorrStopTimeRunSpeedBad = [...
            modInt2AL.pCorrStopTimeRunSpeedBad,modInt2PL.pCorrStopTimeRunSpeedBad];
        modInt2.pCorrStopTimeRunSpeed0to1Bad = [...
            modInt2AL.pCorrStopTimeRunSpeed0to1Bad,modInt2PL.pCorrStopTimeRunSpeed0to1Bad];
        modInt2.pCorrStopTimeInstFRBefRunBad = [...
            modInt2AL.pCorrStopTimeInstFRBefRunBad,modInt2PL.pCorrStopTimeInstFRBefRunBad];
        modInt2.pCorrStopTimeInstFR0to1Bad = [...
            modInt2AL.pCorrStopTimeInstFR0to1Bad,modInt2PL.pCorrStopTimeInstFR0to1Bad];
        
        if(methodKMean == 1)
            idxC = [modInt1AL.idxC1Good modInt1PL.idxC1Good];
            idxCBad = [modInt1AL.idxC1Bad modInt1PL.idxC1Bad];
        elseif(methodKMean == 2)
            idxC = [modInt1AL.idxC2Good modInt1PL.idxC2Good];
            idxCBad = [modInt1AL.idxC2Bad modInt1PL.idxC2Bad];
        elseif(methodKMean == 3)
            idxC = [modInt1AL.idxC3Good modInt1PL.idxC3Good];
            idxCBad = [modInt1AL.idxC3Bad modInt1PL.idxC3Bad];
        end
    elseif(taskSel == 3)
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrGood = [modInt2AL.meanRunSpeedTrGood];
        modInt2.meanRunSpeedBLTrGood = [modInt2AL.meanRunSpeedBLTrGood];
        modInt2.meanRunSpeedBefRunTrGood = [modInt2AL.meanRunSpeedBefRunTrGood];
        modInt2.meanRunSpeed0to1TrGood = [modInt2AL.meanRunSpeed0to1TrGood];
        modInt2.meanRunSpeed3to5TrGood = [modInt2AL.meanRunSpeed3to5TrGood];
        %%
        
        modInt2.corrInstFRRunSpeedGood = [modInt2AL.corrInstFRRunSpeedGood];
        modInt2.corrInstFRRunSpeedBLGood = [modInt2AL.corrInstFRRunSpeedBLGood];
        modInt2.corrInstFRRunSpeedBefRunGood = [modInt2AL.corrInstFRRunSpeedBefRunGood];
        modInt2.corrInstFRRunSpeed0to1Good = [modInt2AL.corrInstFRRunSpeed0to1Good];
        modInt2.corrInstFRRunSpeed3to5Good = [modInt2AL.corrInstFRRunSpeed3to5Good];
        modInt2.corrStopTimeRunSpeedGood = [modInt2AL.corrStopTimeRunSpeedGood];
        modInt2.corrStopTimeRunSpeed0to1Good = [modInt2AL.corrStopTimeRunSpeed0to1Good];
        modInt2.corrStopTimeInstFRBefRunGood = [modInt2AL.corrStopTimeInstFRBefRunGood];
        modInt2.corrStopTimeInstFR0to1Good = [modInt2AL.corrStopTimeInstFR0to1Good];

        modInt2.pCorrInstFRRunSpeedGood = [modInt2AL.pCorrInstFRRunSpeedGood];
        modInt2.pCorrInstFRRunSpeedBLGood = [modInt2AL.pCorrInstFRRunSpeedBLGood];
        modInt2.pCorrInstFRRunSpeedBefRunGood = [modInt2AL.pCorrInstFRRunSpeedBefRunGood];
        modInt2.pCorrInstFRRunSpeed0to1Good = [modInt2AL.pCorrInstFRRunSpeed0to1Good];
        modInt2.pCorrInstFRRunSpeed3to5Good = [modInt2AL.pCorrInstFRRunSpeed3to5Good];
        modInt2.pCorrStopTimeRunSpeedGood = [modInt2AL.pCorrStopTimeRunSpeedGood];
        modInt2.pCorrStopTimeRunSpeed0to1Good = [modInt2AL.pCorrStopTimeRunSpeed0to1Good];
        modInt2.pCorrStopTimeInstFRBefRunGood = [modInt2AL.pCorrStopTimeInstFRBefRunGood];
        modInt2.pCorrStopTimeInstFR0to1Good = [modInt2AL.pCorrStopTimeInstFR0to1Good];

        modInt2.lmSlopeInstFRRunSpeedGood = [modInt2AL.lmSlopeInstFRRunSpeedGood];
        modInt2.lmSlopeInstFRRunSpeedBefRunGood = [modInt2AL.lmSlopeInstFRRunSpeedBefRunGood];
        modInt2.lmSlopeInstFRRunSpeed0to1Good = [modInt2AL.lmSlopeInstFRRunSpeed0to1Good];
        modInt2.lmSlopeInstFRRunSpeed3to5Good = [modInt2AL.lmSlopeInstFRRunSpeed3to5Good];

        modInt2.lmPInstFRRunSpeedGood = [modInt2AL.lmPInstFRRunSpeedGood];
        modInt2.lmPInstFRRunSpeedBefRunGood = [modInt2AL.lmPInstFRRunSpeedBefRunGood];
        modInt2.lmPInstFRRunSpeed0to1Good = [modInt2AL.lmPInstFRRunSpeed0to1Good];
        modInt2.lmPInstFRRunSpeed3to5Good = [modInt2AL.lmPInstFRRunSpeed3to5Good];

        modInt2.lmRInstFRRunSpeedGood = [modInt2AL.lmRInstFRRunSpeedGood];
        modInt2.lmRInstFRRunSpeedBefRunGood = [modInt2AL.lmRInstFRRunSpeedBefRunGood];
        modInt2.lmRInstFRRunSpeed0to1Good = [modInt2AL.lmRInstFRRunSpeed0to1Good];
        modInt2.lmRInstFRRunSpeed3to5Good = [modInt2AL.lmRInstFRRunSpeed3to5Good];
        
        
        %% bad trials
        %% added on 9/25/2022
        modInt2.meanRunSpeedTrBad = [modInt2AL.meanRunSpeedTrBad];
        modInt2.meanRunSpeedBLTrBad = [modInt2AL.meanRunSpeedBLTrBad];
        modInt2.meanRunSpeedBefRunTrBad = [modInt2AL.meanRunSpeedBefRunTrBad];
        modInt2.meanRunSpeed0to1TrBad = [modInt2AL.meanRunSpeed0to1TrBad];
        modInt2.meanRunSpeed3to5TrBad = [modInt2AL.meanRunSpeed3to5TrBad];
        %%
        modInt2.corrInstFRRunSpeedBad = [modInt2AL.corrInstFRRunSpeedBad];
        modInt2.corrInstFRRunSpeedBLBad = [modInt2AL.corrInstFRRunSpeedBLBad];
        modInt2.corrInstFRRunSpeedBefRunBad = [modInt2AL.corrInstFRRunSpeedBefRunBad];
        modInt2.corrInstFRRunSpeed0to1Bad = [modInt2AL.corrInstFRRunSpeed0to1Bad];
        modInt2.corrInstFRRunSpeed3to5Bad = [modInt2AL.corrInstFRRunSpeed3to5Bad];
        modInt2.corrStopTimeRunSpeedBad = [modInt2AL.corrStopTimeRunSpeedBad];
        modInt2.corrStopTimeRunSpeed0to1Bad = [modInt2AL.corrStopTimeRunSpeed0to1Bad];
        modInt2.corrStopTimeInstFRBefRunBad = [modInt2AL.corrStopTimeInstFRBefRunBad];
        modInt2.corrStopTimeInstFR0to1Bad = [modInt2AL.corrStopTimeInstFR0to1Bad];

        modInt2.pCorrInstFRRunSpeedBad = [modInt2AL.pCorrInstFRRunSpeedBad];
        modInt2.pCorrInstFRRunSpeedBLBad = [modInt2AL.pCorrInstFRRunSpeedBLBad];
        modInt2.pCorrInstFRRunSpeedBefRunBad = [modInt2AL.pCorrInstFRRunSpeedBefRunBad];
        modInt2.pCorrInstFRRunSpeed0to1Bad = [modInt2AL.pCorrInstFRRunSpeed0to1Bad];
        modInt2.pCorrInstFRRunSpeed3to5Bad = [modInt2AL.pCorrInstFRRunSpeed3to5Bad];
        modInt2.pCorrStopTimeRunSpeedBad = [modInt2AL.pCorrStopTimeRunSpeedBad];
        modInt2.pCorrStopTimeRunSpeed0to1Bad = [modInt2AL.pCorrStopTimeRunSpeed0to1Bad];
        modInt2.pCorrStopTimeInstFRBefRunBad = [modInt2AL.pCorrStopTimeInstFRBefRunBad];
        modInt2.pCorrStopTimeInstFR0to1Bad = [modInt2AL.pCorrStopTimeInstFR0to1Bad];
        
        if(methodKMean == 1)
            idxC = [modInt1AL.idxC1Good];
            idxCBad = [modInt1AL.idxC1Bad];
        elseif(methodKMean == 2)
            idxC = [modInt1AL.idxC2Good];
            idxCBad = [modInt1AL.idxC2Bad];
        elseif(methodKMean == 3)
            idxC = [modInt1AL.idxC3Good];
            idxCBad = [modInt1AL.idxC3Bad];
        end
        
    end
    
    for i = 1:max(idxC)
        indCur = idxC' == i;
        modInt2.corrStopTimeRunSpeedGoodC{i} = modInt2.corrStopTimeRunSpeedGood(indCur);
        modInt2.corrStopTimeRunSpeed0to1GoodC{i} = modInt2.corrStopTimeRunSpeed0to1Good(indCur);
        modInt2.corrStopTimeInstFRBefRunGoodC{i} = modInt2.corrStopTimeInstFRBefRunGood(indCur);
        modInt2.corrStopTimeInstFR0to1GoodC{i} = modInt2.corrStopTimeInstFR0to1Good(indCur);
        
        modInt2.pCorrStopTimeRunSpeedGoodC{i} = modInt2.pCorrStopTimeRunSpeedGood(indCur);
        modInt2.pCorrStopTimeRunSpeed0to1GoodC{i} = modInt2.pCorrStopTimeRunSpeed0to1Good(indCur);
        modInt2.pCorrStopTimeInstFRBefRunGoodC{i} = modInt2.pCorrStopTimeInstFRBefRunGood(indCur);
        modInt2.pCorrStopTimeInstFR0to1GoodC{i} = modInt2.pCorrStopTimeInstFR0to1Good(indCur);
        
        modInt2.meanCorrStopTimeRunSpeedGoodC(i) = mean(modInt2.corrStopTimeRunSpeedGoodC{i});
        modInt2.meanCorrStopTimeRunSpeed0to1GoodC(i) = mean(modInt2.corrStopTimeRunSpeed0to1GoodC{i});
        modInt2.meanCorrStopTimeInstFRBefRunGoodC(i) = mean(modInt2.corrStopTimeInstFRBefRunGoodC{i});
        modInt2.meanCorrStopTimeInstFR0to1GoodC(i) = mean(modInt2.corrStopTimeInstFR0to1GoodC{i});
        
        modInt2.percSigCorrStopTimeRunSpeedGoodC(i) = sum(modInt2.pCorrStopTimeRunSpeedGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeRunSpeed0to1GoodC(i) = sum(modInt2.pCorrStopTimeRunSpeed0to1GoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeInstFRBefRunGoodC(i) = sum(modInt2.pCorrStopTimeInstFRBefRunGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeInstFR0to1GoodC(i) = sum(modInt2.pCorrStopTimeInstFR0to1GoodC{i} < pSig)/sum(indCur);
        
        modInt2.corrInstFRRunSpeedGoodC{i} = modInt2.corrInstFRRunSpeedGood(indCur);
        modInt2.corrInstFRRunSpeedBLGoodC{i} = modInt2.corrInstFRRunSpeedBLGood(indCur);
        modInt2.corrInstFRRunSpeedBefRunGoodC{i} = modInt2.corrInstFRRunSpeedBefRunGood(indCur);
        modInt2.corrInstFRRunSpeed0to1GoodC{i} = modInt2.corrInstFRRunSpeed0to1Good(indCur);
        modInt2.corrInstFRRunSpeed3to5GoodC{i} = modInt2.corrInstFRRunSpeed3to5Good(indCur);
        
        modInt2.pCorrInstFRRunSpeedGoodC{i} = modInt2.pCorrInstFRRunSpeedGood(indCur);
        modInt2.pCorrInstFRRunSpeedBLGoodC{i} = modInt2.pCorrInstFRRunSpeedBLGood(indCur);
        modInt2.pCorrInstFRRunSpeedBefRunGoodC{i} = modInt2.pCorrInstFRRunSpeedBefRunGood(indCur);
        modInt2.pCorrInstFRRunSpeed0to1GoodC{i} = modInt2.pCorrInstFRRunSpeed0to1Good(indCur);
        modInt2.pCorrInstFRRunSpeed3to5GoodC{i} = modInt2.pCorrInstFRRunSpeed3to5Good(indCur);
        
        modInt2.meanCorrInstFRRunSpeedGoodC(i) = mean(modInt2.corrInstFRRunSpeedGoodC{i});
        modInt2.meanCorrInstFRRunSpeedBLGoodC(i) = mean(modInt2.corrInstFRRunSpeedBLGoodC{i});
        modInt2.meanCorrInstFRRunSpeedBefRunGoodC(i) = mean(modInt2.corrInstFRRunSpeedBefRunGoodC{i});
        modInt2.meanCorrInstFRRunSpeed0to1GoodC(i) = mean(modInt2.corrInstFRRunSpeed0to1GoodC{i});
        modInt2.meanCorrInstFRRunSpeed3to5GoodC(i) = mean(modInt2.corrInstFRRunSpeed3to5GoodC{i});
        
        modInt2.percSigCorrInstFRRunSpeedGoodC(i) = sum(modInt2.pCorrInstFRRunSpeedGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeedBLGoodC(i) = sum(modInt2.pCorrInstFRRunSpeedBLGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeedBefRunGoodC(i) = sum(modInt2.pCorrInstFRRunSpeedBefRunGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeed0to1GoodC(i) = sum(modInt2.pCorrInstFRRunSpeed0to1GoodC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeed3to5GoodC(i) = sum(modInt2.pCorrInstFRRunSpeed3to5GoodC{i} < pSig)/sum(indCur);
        
        modInt2.lmSlopeInstFRRunSpeedGoodC{i} = modInt2.lmSlopeInstFRRunSpeedGood(indCur);
        modInt2.lmSlopeInstFRRunSpeedBefRunGoodC{i} = modInt2.lmSlopeInstFRRunSpeedBefRunGood(indCur);
        modInt2.lmSlopeInstFRRunSpeed0to1GoodC{i} = modInt2.lmSlopeInstFRRunSpeed0to1Good(indCur);
        modInt2.lmSlopeInstFRRunSpeed3to5GoodC{i} = modInt2.lmSlopeInstFRRunSpeed3to5Good(indCur);
        
        modInt2.lmPInstFRRunSpeedGoodC{i} = modInt2.lmPInstFRRunSpeedGood(indCur);
        modInt2.lmPInstFRRunSpeedBefRunGoodC{i} = modInt2.lmPInstFRRunSpeedBefRunGood(indCur);
        modInt2.lmPInstFRRunSpeed0to1GoodC{i} = modInt2.lmPInstFRRunSpeed0to1Good(indCur);
        modInt2.lmPInstFRRunSpeed3to5GoodC{i} = modInt2.lmPInstFRRunSpeed3to5Good(indCur);
        
        modInt2.percSigLmPInstFRRunSpeedGoodC(i) = sum(modInt2.lmPInstFRRunSpeedGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigLmPInstFRRunSpeedBefRunGoodC(i) = sum(modInt2.lmPInstFRRunSpeedBefRunGoodC{i} < pSig)/sum(indCur);
        modInt2.percSigLmPInstFRRunSpeed0to1GoodC(i) = sum(modInt2.lmPInstFRRunSpeed0to1GoodC{i} < pSig)/sum(indCur);
        modInt2.percSigLmPInstFRRunSpeed3to5GoodC(i) = sum(modInt2.lmPInstFRRunSpeed3to5GoodC{i} < pSig)/sum(indCur);
        
        modInt2.lmRInstFRRunSpeedGoodC{i} = modInt2.lmRInstFRRunSpeedGood(indCur);
        modInt2.lmRInstFRRunSpeedBefRunGoodC{i} = modInt2.lmRInstFRRunSpeedBefRunGood(indCur);
        modInt2.lmRInstFRRunSpeed0to1GoodC{i} = modInt2.lmRInstFRRunSpeed0to1Good(indCur);
        modInt2.lmRInstFRRunSpeed3to5GoodC{i} = modInt2.lmRInstFRRunSpeed3to5Good(indCur);
        
        %% bad trials
        indCur = idxCBad' == i;
        modInt2.corrStopTimeRunSpeedBadC{i} = modInt2.corrStopTimeRunSpeedBad(indCur);
        modInt2.corrStopTimeRunSpeed0to1BadC{i} = modInt2.corrStopTimeRunSpeed0to1Bad(indCur);
        modInt2.corrStopTimeInstFRBefRunBadC{i} = modInt2.corrStopTimeInstFRBefRunBad(indCur);
        modInt2.corrStopTimeInstFR0to1BadC{i} = modInt2.corrStopTimeInstFR0to1Bad(indCur);
        
        modInt2.pCorrStopTimeRunSpeedBadC{i} = modInt2.pCorrStopTimeRunSpeedBad(indCur);
        modInt2.pCorrStopTimeRunSpeed0to1BadC{i} = modInt2.pCorrStopTimeRunSpeed0to1Bad(indCur);
        modInt2.pCorrStopTimeInstFRBefRunBadC{i} = modInt2.pCorrStopTimeInstFRBefRunBad(indCur);
        modInt2.pCorrStopTimeInstFR0to1BadC{i} = modInt2.pCorrStopTimeInstFR0to1Bad(indCur);
        
        modInt2.meanCorrStopTimeRunSpeedBadC(i) = mean(modInt2.corrStopTimeRunSpeedBadC{i});
        modInt2.meanCorrStopTimeRunSpeed0to1BadC(i) = mean(modInt2.corrStopTimeRunSpeed0to1BadC{i});
        modInt2.meanCorrStopTimeInstFRBefRunBadC(i) = mean(modInt2.corrStopTimeInstFRBefRunBadC{i});
        modInt2.meanCorrStopTimeInstFR0to1BadC(i) = mean(modInt2.corrStopTimeInstFR0to1BadC{i});
        
        modInt2.percSigCorrStopTimeRunSpeedBadC(i) = sum(modInt2.pCorrStopTimeRunSpeedBadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeRunSpeed0to1BadC(i) = sum(modInt2.pCorrStopTimeRunSpeed0to1BadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeInstFRBefRunBadC(i) = sum(modInt2.pCorrStopTimeInstFRBefRunBadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrStopTimeInstFR0to1BadC(i) = sum(modInt2.pCorrStopTimeInstFR0to1BadC{i} < pSig)/sum(indCur);
        
        modInt2.corrInstFRRunSpeedBadC{i} = modInt2.corrInstFRRunSpeedBad(indCur);
        modInt2.corrInstFRRunSpeedBLBadC{i} = modInt2.corrInstFRRunSpeedBLBad(indCur);
        modInt2.corrInstFRRunSpeedBefRunBadC{i} = modInt2.corrInstFRRunSpeedBefRunBad(indCur);
        modInt2.corrInstFRRunSpeed0to1BadC{i} = modInt2.corrInstFRRunSpeed0to1Bad(indCur);
        modInt2.corrInstFRRunSpeed3to5BadC{i} = modInt2.corrInstFRRunSpeed3to5Bad(indCur);
        
        modInt2.pCorrInstFRRunSpeedBadC{i} = modInt2.pCorrInstFRRunSpeedBad(indCur);
        modInt2.pCorrInstFRRunSpeedBLBadC{i} = modInt2.pCorrInstFRRunSpeedBLBad(indCur);
        modInt2.pCorrInstFRRunSpeedBefRunBadC{i} = modInt2.pCorrInstFRRunSpeedBefRunBad(indCur);
        modInt2.pCorrInstFRRunSpeed0to1BadC{i} = modInt2.pCorrInstFRRunSpeed0to1Bad(indCur);
        modInt2.pCorrInstFRRunSpeed3to5BadC{i} = modInt2.pCorrInstFRRunSpeed3to5Bad(indCur);
        
        modInt2.meanCorrInstFRRunSpeedBadC(i) = mean(modInt2.corrInstFRRunSpeedBadC{i});
        modInt2.meanCorrInstFRRunSpeedBLBadC(i) = mean(modInt2.corrInstFRRunSpeedBLBadC{i});
        modInt2.meanCorrInstFRRunSpeedBefRunBadC(i) = mean(modInt2.corrInstFRRunSpeedBefRunBadC{i});
        modInt2.meanCorrInstFRRunSpeed0to1BadC(i) = mean(modInt2.corrInstFRRunSpeed0to1BadC{i});
        modInt2.meanCorrInstFRRunSpeed3to5BadC(i) = mean(modInt2.corrInstFRRunSpeed3to5BadC{i});
        
        modInt2.percSigCorrInstFRRunSpeedBadC(i) = sum(modInt2.pCorrInstFRRunSpeedBadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeedBLBadC(i) = sum(modInt2.pCorrInstFRRunSpeedBLBadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeedBefRunBadC(i) = sum(modInt2.pCorrInstFRRunSpeedBefRunBadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeed0to1BadC(i) = sum(modInt2.pCorrInstFRRunSpeed0to1BadC{i} < pSig)/sum(indCur);
        modInt2.percSigCorrInstFRRunSpeed3to5BadC(i) = sum(modInt2.pCorrInstFRRunSpeed3to5BadC{i} < pSig)/sum(indCur);
    end
    
end

