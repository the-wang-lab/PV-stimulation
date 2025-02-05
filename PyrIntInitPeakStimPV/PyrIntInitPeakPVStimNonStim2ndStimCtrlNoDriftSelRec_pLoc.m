function PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_pLoc(methodKMean)

    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSig\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat'],'modPyr1AL');
    end
    
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1','PyrRise','PyrDown');
    end
    
    pathAnal1 = [pathAnal0 'FRPeak\'];
    if(~exist(pathAnal1))
        mkdir(pathAnal1);
    end
    
    GlobalConstFq;
    RSqThresh = 0.7;
    
    %% label recordings to be excluded
    indInclRec = ones(1,length(modPyr1AL.indRec));
    for i = 1:length(excludeRec)
        ind = modPyr1AL.indRec == excludeRec(i);
        indInclRec(ind) = 0;
    end
    
    ind = modPyr1AL.indDriftRec & indInclRec;
    modPyr1AL.actOrInact = modPyr1AL.actOrInact(ind); % is it activation or inactivation
    modPyr1AL.indRec = modPyr1AL.indRec(ind); % recording index
    modPyr1AL.indNeu = modPyr1AL.indNeu(ind); % neuron indices trials
    modPyr1AL.pulseMeth = modPyr1AL.pulseMeth(ind); % pulse method
    modPyr1AL.stimLoc = modPyr1AL.stimLoc(ind); % stimulation location on the track
    modPyr1AL.isNeuWithFieldAlignedGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim(ind); % whether this neuron has a field, good non-stim trials
    modPyr1AL.isNeuWithFieldAlignedStim = modPyr1AL.isNeuWithFieldAlignedStim(ind); % whether this neuron has a field, stim trials
    modPyr1AL.avgFRProfile = modPyr1AL.avgFRProfile(ind,:); % average firing rate profile good trials
    modPyr1AL.avgFRProfileStim = modPyr1AL.avgFRProfileStim(ind,:); % average firing rate profile stim trials
    modPyr1AL.avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl(ind,:); % average firing rate profile stim ctrl trials
    
    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl;
    
    condNum = length(PyrRise.FRProfileMean);
    
    for i = 1:condNum
        idxPyrRise = PyrStim1.FRProfile1{i}.indPyrRise;
        idxPyrDown = PyrStim1.FRProfile1{i}.indPyrDown;
        
        %% identify peaks
        % PyrRise
        % time step indices during which the peak will be identified
        idx_TimeAftRun = find(modPyr1AL.timeStepRun > 0 & modPyr1AL.timeStepRun <= 6); % after run onset
        % peak detection for pyrRise neurons in control trials
        PyrRisePeak_AftRun_Ctrl{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfile(idxPyrRise,:),idx_TimeAftRun);
        % peak detection for pyrRise neurons in stim trials
        PyrRisePeak_AftRun_Stim{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrRise,:),idx_TimeAftRun);
        
        % PyrDown
        % time step indices during which the peak will be identified
        idx_TimeBefRunDown = find(modPyr1AL.timeStepRun >= -1.5 & modPyr1AL.timeStepRun < 1.5); % Bef run onset
        idx_TimeAftRunDown = find(modPyr1AL.timeStepRun > 1 & modPyr1AL.timeStepRun <= 6); % after run onset
        % peak detection for pyrDown neurons in control trials
        PyrDownPeak_BefRun_Ctrl{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfile(idxPyrDown,:),idx_TimeBefRunDown);
        PyrDownPeak_AftRun_Ctrl{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfile(idxPyrDown,:),idx_TimeAftRunDown);
        % peak detection for pyrDown neurons in stim trials
        PyrDownPeak_BefRun_Stim{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrDown,:),idx_TimeBefRunDown);
        PyrDownPeak_AftRun_Stim{i} = peakDetectionPyr(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrDown,:),idx_TimeAftRunDown);
        
        %% calculate decay time constant
        % pyrRise   
        % Extract the decay time constant(a*exp(b*x)), for control trials
        displayFig = 0;
        [PyrRisePeak_AftRun_Ctrl{i}.tau,PyrRisePeak_AftRun_Ctrl{i}.fitcurve,PyrRisePeak_AftRun_Ctrl{i}.gofcurve]...
            = tauDecayExtraction(modPyr1AL.timeStepRun,avgFRProfile(idxPyrRise,:),...
                PyrRisePeak_AftRun_Ctrl{i}.loc,PyrRisePeak_AftRun_Ctrl{i}.amp,displayFig);
        % Extract the decay time constant(a*exp(b*x)), for stim trials
        [PyrRisePeak_AftRun_Stim{i}.tau,PyrRisePeak_AftRun_Stim{i}.fitcurve,PyrRisePeak_AftRun_Stim{i}.gofcurve]...
            = tauDecayExtraction(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrRise,:),...
                PyrRisePeak_AftRun_Stim{i}.loc,PyrRisePeak_AftRun_Stim{i}.amp,displayFig);
        % statistics for the decay time constant(a*exp(b*x)) between ctrl
        % and stim
        PyrRisePeak_AftRun_Stim{i}.pRSTau = ranksum(PyrRisePeak_AftRun_Ctrl{i}.tau,...
            PyrRisePeak_AftRun_Stim{i}.tau);
        [~,PyrRisePeak_AftRun_Stim{i}.pTTTau] = ttest2(PyrRisePeak_AftRun_Ctrl{i}.tau,...
            PyrRisePeak_AftRun_Stim{i}.tau);
        [~,PyrRisePeak_AftRun_Stim{i}.pKSTau] = kstest2(PyrRisePeak_AftRun_Ctrl{i}.tau,...
            PyrRisePeak_AftRun_Stim{i}.tau);
        
        % statistics for the decay time constant(a*exp(b*x)) between ctrl
        % and stim (with good fit)
        % only select those with good fit, added on 1/13/2024
        adjrsquareCtrl = zeros(1,length(PyrRisePeak_AftRun_Ctrl{i}.tau));
        adjrsquareStim = zeros(1,length(PyrRisePeak_AftRun_Stim{i}.tau));
        for j = 1:length(PyrRisePeak_AftRun_Ctrl{i}.tau) 
            adjrsquareCtrl(j) = PyrRisePeak_AftRun_Ctrl{i}.gofcurve{j}.adjrsquare;
        end
        for j = 1:length(PyrRisePeak_AftRun_Stim{i}.tau) 
            adjrsquareStim(j) = PyrRisePeak_AftRun_Stim{i}.gofcurve{j}.adjrsquare;
        end
        idxGoodNeurons = adjrsquareCtrl' > RSqThresh & adjrsquareStim' >= RSqThresh;
        PyrRisePeak_AftRun_Stim{i}.pRSTauGood = ranksum(PyrRisePeak_AftRun_Ctrl{i}.tau(idxGoodNeurons),...
            PyrRisePeak_AftRun_Stim{i}.tau(idxGoodNeurons));
        [~,PyrRisePeak_AftRun_Stim{i}.pTTTauGood] = ttest2(PyrRisePeak_AftRun_Ctrl{i}.tau(idxGoodNeurons),...
            PyrRisePeak_AftRun_Stim{i}.tau(idxGoodNeurons));
        [~,PyrRisePeak_AftRun_Stim{i}.pKSTauGood] = kstest2(PyrRisePeak_AftRun_Ctrl{i}.tau(idxGoodNeurons),...
            PyrRisePeak_AftRun_Stim{i}.tau(idxGoodNeurons));
        PyrRisePeak_AftRun_Stim{i}.idxGoodFitNeurons = idxGoodNeurons;

        % pyrDown
        % Extract the decay time constant (a*exp(b*x)), for control trials 
        [PyrDownPeak_BefRun_Ctrl{i}.tau,PyrDownPeak_BefRun_Ctrl{i}.fitcurve,PyrDownPeak_BefRun_Ctrl{i}.gofcurve] ...
            = tauDecayExtractionInterval(modPyr1AL.timeStepRun,avgFRProfile(idxPyrDown,:),...
                idx_TimeBefRunDown(end),PyrDownPeak_BefRun_Ctrl{i}.loc,PyrDownPeak_BefRun_Ctrl{i}.amp,displayFig);        
        % Extract the decay time constant (a*exp(b*x)), for stim trials
        [PyrDownPeak_BefRun_Stim{i}.tau,PyrDownPeak_BefRun_Stim{i}.fitcurve,PyrDownPeak_BefRun_Stim{i}.gofcurve] ...
            = tauDecayExtractionInterval(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrDown,:),...
                idx_TimeBefRunDown(end),PyrDownPeak_BefRun_Stim{i}.loc,PyrDownPeak_BefRun_Stim{i}.amp,displayFig);
        % statistics for the decay time constant(a*exp(b*x)) between ctrl
        % and stim
        PyrDownPeak_BefRun_Stim{i}.pRSTau = ranksum(PyrDownPeak_BefRun_Ctrl{i}.tau,...
            PyrDownPeak_BefRun_Stim{i}.tau);
        [~,PyrDownPeak_BefRun_Stim{i}.pTTTau] = ttest2(PyrDownPeak_BefRun_Ctrl{i}.tau,...
            PyrDownPeak_BefRun_Stim{i}.tau);
        [~,PyrDownPeak_BefRun_Stim{i}.pKSTau] = kstest2(PyrDownPeak_BefRun_Ctrl{i}.tau,...
            PyrDownPeak_BefRun_Stim{i}.tau);

        % Extract the rise time constant (a*exp(b*x)) with x inversed in time, for control trials 
        [PyrDownPeak_AftRun_Ctrl{i}.tau,PyrDownPeak_AftRun_Ctrl{i}.fitcurve,PyrDownPeak_AftRun_Ctrl{i}.gofcurve] ...
            = tauRiseExtraction(modPyr1AL.timeStepRun,avgFRProfile(idxPyrDown,:),...
                idx_TimeAftRunDown(1),PyrDownPeak_AftRun_Ctrl{i}.loc,PyrDownPeak_AftRun_Ctrl{i}.amp,displayFig);
        % Extract the rise time constant (a*exp(b*x)) with x inversed in time, for stim trials
        [PyrDownPeak_AftRun_Stim{i}.tau,PyrDownPeak_AftRun_Stim{i}.fitcurve,PyrDownPeak_AftRun_Stim{i}.gofcurve] ...
            = tauRiseExtraction(modPyr1AL.timeStepRun,avgFRProfileStim(idxPyrDown,:),...
                idx_TimeAftRunDown(1),PyrDownPeak_AftRun_Stim{i}.loc,PyrDownPeak_AftRun_Stim{i}.amp,displayFig);
        % statistics for the rise time constant(a*exp(b*x)) between ctrl
        % and stim
        PyrDownPeak_AftRun_Stim{i}.pRSTau = ranksum(PyrDownPeak_AftRun_Ctrl{i}.tau,...
            PyrDownPeak_AftRun_Stim{i}.tau);
        [~,PyrDownPeak_AftRun_Stim{i}.pTTTau] = ttest2(PyrDownPeak_AftRun_Ctrl{i}.tau,...
            PyrDownPeak_AftRun_Stim{i}.tau);
        [~,PyrDownPeak_AftRun_Stim{i}.pKSTau] = kstest2(PyrDownPeak_AftRun_Ctrl{i}.tau,...
            PyrDownPeak_AftRun_Stim{i}.tau);
        
        % statistics for the rise time constant(a*exp(b*x)) between ctrl
        % and stim (with good fit)
        % only select those with good fit, added on 1/13/2024 
        adjrsquareCtrlD = zeros(1,length(PyrDownPeak_AftRun_Ctrl{i}.tau));
        adjrsquareStimD = zeros(1,length(PyrDownPeak_AftRun_Stim{i}.tau));
        for j = 1:length(PyrDownPeak_AftRun_Ctrl{i}.tau) 
            if(~isempty(PyrDownPeak_AftRun_Ctrl{i}.gofcurve{j}))
                adjrsquareCtrlD(j) = PyrDownPeak_AftRun_Ctrl{i}.gofcurve{j}.adjrsquare;
            end
        end
        for j = 1:length(PyrDownPeak_AftRun_Stim{i}.tau) 
            if(~isempty(PyrDownPeak_AftRun_Stim{i}.gofcurve{j}))
                adjrsquareStimD(j) = PyrDownPeak_AftRun_Stim{i}.gofcurve{j}.adjrsquare;
            end
        end
        idxGoodNeuronsD = adjrsquareCtrlD' > RSqThresh & adjrsquareStimD' >= RSqThresh;
        PyrDownPeak_AftRun_Stim{i}.pRSTauGood = ranksum(PyrDownPeak_AftRun_Ctrl{i}.tau(idxGoodNeuronsD),...
            PyrDownPeak_AftRun_Stim{i}.tau(idxGoodNeuronsD));
        [~,PyrDownPeak_AftRun_Stim{i}.pTTTauGood] = ttest2(PyrDownPeak_AftRun_Ctrl{i}.tau(idxGoodNeuronsD),...
            PyrDownPeak_AftRun_Stim{i}.tau(idxGoodNeuronsD));
        [~,PyrDownPeak_AftRun_Stim{i}.pKSTauGood] = kstest2(PyrDownPeak_AftRun_Ctrl{i}.tau(idxGoodNeuronsD),...
            PyrDownPeak_AftRun_Stim{i}.tau(idxGoodNeuronsD));
        PyrDownPeak_AftRun_Stim{i}.idxGoodFitNeurons = idxGoodNeuronsD;
        
            
        %% compute the correlation between the peak time and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakTime, PyrRisePeak_AftRun_Ctrl{i}.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.time);
        % Calculate the correlation, stim trials
        [PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsPeakTime, PyrRisePeak_AftRun_Stim{i}.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.time);

        % Estimate the slope using linear regression, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsPeakTime, PyrRisePeak_AftRun_Ctrl{i}.slopeP_OrderVsPeakTime,...
            PyrRisePeak_AftRun_Ctrl{i}.slope_OrderVsPeakTime, PyrRisePeak_AftRun_Ctrl{i}.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.time);
        % Estimate the slope using linear regression, stim trials
        [PyrRisePeak_AftRun_Stim{i}.lm_OrderVsPeakTime, PyrRisePeak_AftRun_Stim{i}.slopeP_OrderVsPeakTime,...
            PyrRisePeak_AftRun_Stim{i}.slope_OrderVsPeakTime, PyrRisePeak_AftRun_Stim{i}.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.time);

        % PyrDown
        % Calculate the correlation, control trials
        [PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakTime, PyrDownPeak_AftRun_Ctrl{i}.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun_Ctrl{i}.time);
        % Calculate the correlation, stim trials
        [PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsPeakTime, PyrDownPeak_AftRun_Stim{i}.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun_Stim{i}.time);

        % Estimate the slope using linear regression, control trials
        [PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsPeakTime, PyrDownPeak_AftRun_Ctrl{i}.slopeP_OrderVsPeakTime,...
            PyrDownPeak_AftRun_Ctrl{i}.slope_OrderVsPeakTime, PyrDownPeak_AftRun_Ctrl{i}.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Ctrl{i}.time);
        % Estimate the slope using linear regression, stim trials
        [PyrDownPeak_AftRun_Stim{i}.lm_OrderVsPeakTime, PyrDownPeak_AftRun_Stim{i}.slopeP_OrderVsPeakTime,...
            PyrDownPeak_AftRun_Stim{i}.slope_OrderVsPeakTime, PyrDownPeak_AftRun_Stim{i}.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Stim{i}.time);
        
        
        %% compute the correlation between the peak amplitude and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakAmp, PyrRisePeak_AftRun_Ctrl{i}.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.amp);
        % Calculate the correlation, stim trials
        [PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsPeakAmp, PyrRisePeak_AftRun_Stim{i}.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.amp);

        % Estimate the slope using linear regression, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsPeakAmp, PyrRisePeak_AftRun_Ctrl{i}.slopeP_OrderVsPeakAmp,...
            PyrRisePeak_AftRun_Ctrl{i}.slope_OrderVsPeakAmp, PyrRisePeak_AftRun_Ctrl{i}.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.amp);
        % Estimate the slope using linear regression, stim trials
        [PyrRisePeak_AftRun_Stim{i}.lm_OrderVsPeakAmp, PyrRisePeak_AftRun_Stim{i}.slopeP_OrderVsPeakAmp,...
            PyrRisePeak_AftRun_Stim{i}.slope_OrderVsPeakAmp, PyrRisePeak_AftRun_Stim{i}.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.amp);

        % PyrDown
        % Calculate the correlation, control trials
        [PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakAmp, PyrDownPeak_AftRun_Ctrl{i}.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun_Ctrl{i}.amp);
        % Calculate the correlation, stim trials
        [PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsPeakAmp, PyrDownPeak_AftRun_Stim{i}.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun_Stim{i}.amp);

        % Estimate the slope using linear regression, control trials
        [PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsPeakAmp, PyrDownPeak_AftRun_Ctrl{i}.slopeP_OrderVsPeakAmp,...
            PyrDownPeak_AftRun_Ctrl{i}.slope_OrderVsPeakAmp, PyrDownPeak_AftRun_Ctrl{i}.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Ctrl{i}.amp);
        % Estimate the slope using linear regression, stim trials
        [PyrDownPeak_AftRun_Stim{i}.lm_OrderVsPeakAmp, PyrDownPeak_AftRun_Stim{i}.slopeP_OrderVsPeakAmp,...
            PyrDownPeak_AftRun_Stim{i}.slope_OrderVsPeakAmp, PyrDownPeak_AftRun_Stim{i}.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Stim{i}.amp);
        
        
        %% compute the correlation between time constant and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsTau, PyrRisePeak_AftRun_Ctrl{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.tau);
        % Calculate the correlation, stim trials
        [PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsTau, PyrRisePeak_AftRun_Stim{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.tau);

        % Estimate the slope using linear regression, control trials
        [PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsTau, PyrRisePeak_AftRun_Ctrl{i}.slopeP_OrderVsTau,...
            PyrRisePeak_AftRun_Ctrl{i}.slope_OrderVsTau, PyrRisePeak_AftRun_Ctrl{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Ctrl{i}.tau);
        % Estimate the slope using linear regression, stim trials
        [PyrRisePeak_AftRun_Stim{i}.lm_OrderVsTau, PyrRisePeak_AftRun_Stim{i}.slopeP_OrderVsTau,...
            PyrRisePeak_AftRun_Stim{i}.slope_OrderVsTau, PyrRisePeak_AftRun_Stim{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun_Stim{i}.tau);

        % PyrDown
        % Calculate the correlation between -1.5 to 1.5s, control trials
        idxValid = find(isnan(PyrDownPeak_BefRun_Ctrl{i}.tau) == 0);
        [PyrDownPeak_BefRun_Ctrl{i}.corrCoef_OrderVsTau, PyrDownPeak_BefRun_Ctrl{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_BefRun_Ctrl{i}.tau(idxValid));
        % Calculate the correlation between -1.5 to 1.5s, stim trials
        idxValid = find(isnan(PyrDownPeak_BefRun_Stim{i}.tau) == 0);
        [PyrDownPeak_BefRun_Stim{i}.corrCoef_OrderVsTau, PyrDownPeak_BefRun_Stim{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_BefRun_Stim{i}.tau(idxValid));

        % Estimate the slope using linear regression, control trials
        [PyrDownPeak_BefRun_Ctrl{i}.lm_OrderVsTau, PyrDownPeak_BefRun_Ctrl{i}.slopeP_OrderVsTau,...
            PyrDownPeak_BefRun_Ctrl{i}.slope_OrderVsTau, PyrDownPeak_BefRun_Ctrl{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_BefRun_Ctrl{i}.tau);
        % Estimate the slope using linear regression, stim trials
        [PyrDownPeak_BefRun_Stim{i}.lm_OrderVsTau, PyrDownPeak_BefRun_Stim{i}.slopeP_OrderVsTau,...
            PyrDownPeak_BefRun_Stim{i}.slope_OrderVsTau, PyrDownPeak_BefRun_Stim{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_BefRun_Stim{i}.tau);

        % Calculate the correlation between 1 to 6 s, control trials
        idxValid = find(isnan(PyrDownPeak_AftRun_Ctrl{i}.tau) == 0);
        [PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsTau, PyrDownPeak_AftRun_Ctrl{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_AftRun_Ctrl{i}.tau(idxValid));
        % Calculate the correlation between 1 to 6 s, stim trials
        idxValid = find(isnan(PyrDownPeak_AftRun_Stim{i}.tau) == 0);
        [PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsTau, PyrDownPeak_AftRun_Stim{i}.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_AftRun_Stim{i}.tau(idxValid));


        % Estimate the slope using linear regression, control trials
        [PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsTau, PyrDownPeak_AftRun_Ctrl{i}.slopeP_OrderVsTau,...
            PyrDownPeak_AftRun_Ctrl{i}.slope_OrderVsTau, PyrDownPeak_AftRun_Ctrl{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Ctrl{i}.tau);
        % Estimate the slope using linear regression, stim trials
        [PyrDownPeak_AftRun_Stim{i}.lm_OrderVsTau, PyrDownPeak_AftRun_Stim{i}.slopeP_OrderVsTau,...
            PyrDownPeak_AftRun_Stim{i}.slope_OrderVsTau, PyrDownPeak_AftRun_Stim{i}.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun_Stim{i}.tau);

        save([pathAnal1 'avgFRProfile_PeakAndTau_Stim.mat'], 'PyrRisePeak_AftRun_Ctrl','PyrDownPeak_AftRun_Ctrl','PyrDownPeak_BefRun_Ctrl',...
            'PyrRisePeak_AftRun_Stim','PyrDownPeak_AftRun_Stim','PyrDownPeak_BefRun_Stim');

        
        %% plot the peak time vs the neuron order 
        % PyrRise, control
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Ctrl{i}.time',...
            PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsPeakTime,PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakTime,...
            'Neuron no. (PyrRise)',['Peak time (s) CtrlC' num2str(i)],pathAnal1,['PyrRise_PeakTimeVsOrderNoCtrl_Cond' num2str(i)]);
        % PyrRise, stim
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Stim{i}.time',...
            PyrRisePeak_AftRun_Stim{i}.lm_OrderVsPeakTime,PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsPeakTime,...
            'Neuron no. (PyrRise)',['Peak time (s) StimC' num2str(i)],pathAnal1,['PyrRise_PeakTimeVsOrderNoStim_Cond' num2str(i)]);
        %PyrDown, control
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Ctrl{i}.time',...
            PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsPeakTime,PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakTime,...
            'Neuron no. (PyrDown)',['Peak time (s) CtrlC' num2str(i)],pathAnal1,['PyrDown_PeakTimeVsOrderNoCtrl_Cond' num2str(i)]);
        %PyrDown, stim
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Stim{i}.time',...
            PyrDownPeak_AftRun_Stim{i}.lm_OrderVsPeakTime,PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsPeakTime,...
            'Neuron no. (PyrDown)',['Peak time (s) StimC' num2str(i)],pathAnal1,['PyrDown_PeakTimeVsOrderNoStim_Cond' num2str(i)]);

        %% plot the peak amplitude vs the neuron order 
        % PyrRise, control
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Ctrl{i}.amp',...
            PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsPeakAmp,PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakAmp,...
            'Neuron no. (PyrRise)',['Peak amplitude (Hz) CtrlC' num2str(i)],pathAnal1,['PyrRise_PeakAmpVsOrderNoCtrl_Cond' num2str(i)]);
        % PyrRise, stim
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Stim{i}.amp',...
            PyrRisePeak_AftRun_Stim{i}.lm_OrderVsPeakAmp,PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsPeakAmp,...
            'Neuron no. (PyrRise)',['Peak amplitude (Hz) StimC' num2str(i)],pathAnal1,['PyrRise_PeakAmpVsOrderNoStim_Cond' num2str(i)]);
        %PyrDown, control
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Ctrl{i}.amp',...
            PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsPeakAmp,PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsPeakAmp,...
            'Neuron no. (PyrDown)',['Peak amplitude (Hz) CtrlC' num2str(i)],pathAnal1,['PyrDown_PeakAmpVsOrderNoCtrl_Cond' num2str(i)]);
        %PyrDown, stim
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Stim{i}.amp',...
            PyrDownPeak_AftRun_Stim{i}.lm_OrderVsPeakAmp,PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsPeakAmp,...
            'Neuron no. (PyrDown)',['Peak amplitude (Hz) StimC' num2str(i)],pathAnal1,['PyrDown_PeakAmpVsOrderNoStim_Cond' num2str(i)]);

        %% plot tau vs the neuron order 
        % PyrRise, conrol
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Ctrl{i}.tau',...
            PyrRisePeak_AftRun_Ctrl{i}.lm_OrderVsTau,PyrRisePeak_AftRun_Ctrl{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrRise)',['Time constant (s) CtrlC' num2str(i)],pathAnal1,['PyrRise_TauVsOrderNoCtrl_Cond' num2str(i)]);
        % PyrRise, stim
        plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun_Stim{i}.tau',...
            PyrRisePeak_AftRun_Stim{i}.lm_OrderVsTau,PyrRisePeak_AftRun_Stim{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrRise)',['Time constant (s) StimC' num2str(i)],pathAnal1,['PyrRise_TauVsOrderNoStim_Cond' num2str(i)]);

        %PyrDown, control
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_BefRun_Ctrl{i}.tau',...
            PyrDownPeak_BefRun_Ctrl{i}.lm_OrderVsTau,PyrDownPeak_BefRun_Ctrl{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrDown)',['BefRun time constant (s) CtrlC' num2str(i)],pathAnal1,['PyrDown_BefRunTauVsOrderNoCtrl_Cond' num2str(i)]);
        %PyrDown, stim
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_BefRun_Stim{i}.tau',...
            PyrDownPeak_BefRun_Stim{i}.lm_OrderVsTau,PyrDownPeak_BefRun_Stim{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrDown)',['BefRun time constant (s) StimC' num2str(i)],pathAnal1,['PyrDown_BefRunTauVsOrderNoStim_Cond' num2str(i)]);

        %PyrDown, control
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Ctrl{i}.tau',...
            PyrDownPeak_AftRun_Ctrl{i}.lm_OrderVsTau,PyrDownPeak_AftRun_Ctrl{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrDown)',['Time constant (s) CtrlC' num2str(i)],pathAnal1,['PyrDown_TauVsOrderNoCtrl_Cond' num2str(i)]);
        %PyrDown, stim
        plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun_Stim{i}.tau',...
            PyrDownPeak_AftRun_Stim{i}.lm_OrderVsTau,PyrDownPeak_AftRun_Stim{i}.corrCoef_OrderVsTau,...
            'Neuron no. (PyrDown)',['Time constant (s) StimC' num2str(i)],pathAnal1,['PyrDown_TauVsOrderNoStim_Cond' num2str(i)]);
    
        
        %% plot the distribution of tau, compare between ctrl and stim
        % PyrRise
        plotDistributionsTwo(PyrRisePeak_AftRun_Ctrl{i}.tau,...
            PyrRisePeak_AftRun_Stim{i}.tau,PyrRisePeak_AftRun_Stim{i}.pRSTau,pathAnal1,...
            ['PyrRise_TauDistrStimVsCtrl_Cond' num2str(i)],['PyrRise Tau (s) C' num2str(i)] ,'Prob.');
    
        % PyrDown
        plotDistributionsTwo(PyrDownPeak_BefRun_Ctrl{i}.tau,...
            PyrDownPeak_BefRun_Stim{i}.tau,PyrDownPeak_BefRun_Stim{i}.pRSTau,pathAnal1,...
            ['PyrDown_BefRunTauDistrStimVsCtrl_Cond' num2str(i)],['PyrDown BefRun Tau (s) C' num2str(i)] ,'Prob.');
        
        plotDistributionsTwo(PyrDownPeak_AftRun_Ctrl{i}.tau,...
            PyrDownPeak_AftRun_Stim{i}.tau,PyrDownPeak_AftRun_Stim{i}.pRSTau,pathAnal1,...
            ['PyrDown_TauDistrStimVsCtrl_Cond' num2str(i)],['PyrDown Tau (s) C' num2str(i)] ,'Prob.');
        
        %% plot the comparison between ctrl and stim trials for tau
        % PyrRise
        plotCtrlVsStim(PyrRisePeak_AftRun_Ctrl{i}.tau,...
            PyrRisePeak_AftRun_Stim{i}.tau,[PyrRisePeak_AftRun_Stim{i}.pRSTau PyrRisePeak_AftRun_Stim{i}.pTTTau],pathAnal1,...
            ['PyrRise_TauStimVsCtrl_Cond' num2str(i)],['PyrRise Tau Ctrl (s) C' num2str(i)] ,'PyrRise Tau Stim (s)');
        % select neurons with good fit, added on 1/13/2024
        plotCtrlVsStim(PyrRisePeak_AftRun_Ctrl{i}.tau(idxGoodNeurons),...
            PyrRisePeak_AftRun_Stim{i}.tau(idxGoodNeurons),[PyrRisePeak_AftRun_Stim{i}.pRSTauGood PyrRisePeak_AftRun_Stim{i}.pTTTauGood],pathAnal1,...
            ['PyrRise_TauGoodStimVsCtrl_Cond' num2str(i)],['PyrRise TauGood Ctrl (s) C' num2str(i)] ,'PyrRise TauGood Stim (s)');
        
        % PyrDown
        plotCtrlVsStim(PyrDownPeak_BefRun_Ctrl{i}.tau,...
            PyrDownPeak_BefRun_Stim{i}.tau,[PyrDownPeak_BefRun_Stim{i}.pRSTau PyrDownPeak_BefRun_Stim{i}.pTTTau],pathAnal1,...
            ['PyrDown_BefRunTauStimVsCtrl_Cond' num2str(i)],['PyrDown BefRun Tau Ctrl (s) C' num2str(i)],'Tau Stim (s)');
        
        plotCtrlVsStim(PyrDownPeak_AftRun_Ctrl{i}.tau,...
            PyrDownPeak_AftRun_Stim{i}.tau,[PyrDownPeak_AftRun_Stim{i}.pRSTau PyrDownPeak_AftRun_Stim{i}.pTTTau],pathAnal1,...
            ['PyrDown_TauStimVsCtrl_Cond' num2str(i)],['PyrDown Tau Ctrl (s) C' num2str(i)],'Tau Stim (s)');
        % select neurons with good fit, added on 1/13/2024
        plotCtrlVsStim(PyrDownPeak_AftRun_Ctrl{i}.tau(idxGoodNeuronsD),...
            PyrDownPeak_AftRun_Stim{i}.tau(idxGoodNeuronsD),...
            [PyrDownPeak_AftRun_Stim{i}.pRSTauGood PyrDownPeak_AftRun_Stim{i}.pTTTauGood],pathAnal1,...
            ['PyrDown_TauGoodStimVsCtrl_Cond' num2str(i)],['PyrDown TauGood Ctrl (s) C' num2str(i)] ,'PyrDown TauGood Stim (s)');         
    
        %% plot the averaged FR profile for comparing neurons with high FR ratio, mid FR ratio and low FR ratio
        % PyrRise
        numNeurons = 1:floor(length(idxPyrRise)/3):length(idxPyrRise);
        if(length(numNeurons) == 3)
            numNeurons(4) = length(idxPyrRise);
        end
        avgProfileTmp = avgFRProfile(idxPyrRise,:);
        comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
            avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
            avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
            'Time from runonset(s)',['FR (Hz) CtrlC' num2str(i)],pathAnal1,['PyrRise_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatioCtrl_Cond' num2str(i)]);

        % PyrRiseStim
        avgProfileTmp = avgFRProfileStim(idxPyrRise,:);
        comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
            avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
            avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
            'Time from runonset(s)',['FR (Hz) StimC' num2str(i)],pathAnal1,['PyrRise_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatioStim_Cond' num2str(i)]);

        % PyrDown
        numNeurons = 1:floor(length(idxPyrDown)/3):length(idxPyrDown);
        if(length(numNeurons) == 3)
            numNeurons(4) = length(idxPyrDown);
        end
        avgProfileTmp = avgFRProfile(idxPyrDown,:);
        comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
            avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
            avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
            'Time from runonset(s)',['FR (Hz) CtrlC' num2str(i)],pathAnal1,['PyrDown_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatioCtrl_Cond' num2str(i)]);

        avgProfileTmp = avgFRProfileStim(idxPyrDown,:);
        comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
            avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
            avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
            'Time from runonset(s)',['FR (Hz) StimC' num2str(i)],pathAnal1,['PyrDown_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatioStim_Cond' num2str(i)]);
    end