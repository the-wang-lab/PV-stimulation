function ProcessPyrNeurons()

onlyRun = 1;
p = 95; % 95% significant level
pDrift = 0.005; % p value threshold for removing neurons with drift
pDriftRec = 0.05; % p value threshold for removing recordings with drift
pDriftNeu = 0.01; % p value threshold for removing neurons with drift (between 0.5 to 1.5s)


%% accumulation all the relevant data from every recordings for pyramidal neurons
PyrPropAllRec(onlyRun);
methodKMean = 2;
PyrModAccumAllRec(onlyRun, methodKMean);

for taskSel = 3 % 2:3
    % taskSel == 1 % including all the neurons
    % taskSel == 2 % including AL and PL neurons
    % taskSel == 3 % AL neurons only
    PyrModAllRec(onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec(onlyRun,taskSel,methodKMean);
    
    PyrModAllRec_GoodTr(onlyRun,taskSel,methodKMean);

    PyrModAllRec_CtrlTr(onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec_CtrlTr(onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec_GoodTr(onlyRun,taskSel,methodKMean);

    PyrModAlignedDistAllRec_GoodTr(onlyRun,taskSel,methodKMean);
    
    PyrInitPeakAllRec(taskSel,methodKMean); % including non-run time

    PyrInitPeakAllRec_LongShortTr(taskSel,methodKMean); % separating long
                                                        % and short trials

    PyrInitPeakSpeedAllRec(taskSel,methodKMean);
    
    PyrBehAlignedAllRec(0,taskSel); 

    PyrBehTimeAlignedAllRec(0,taskSel);
 
end

%% accumulation all the relevant data from every recordings for interneurons
InterneuronPropAllRec(onlyRun);

methodKMean = 2;
InterneuronModAccumAllRec(onlyRun,methodKMean);
for taskSel = 1:3
    InterneuronInitPeakAllRec(taskSel,methodKMean);
    InterneuronInitPeakSpeedAllRec(taskSel,methodKMean);
end


%% find neurons that are significantly changing their FRaft/FRbef
PyrInitPeakAllRecSig(); % calculate 
InterneuronInitPeakAllRecSig();


%%
PyrInitPeakAllRecSigNoStim2ndStimCtrl(); % find neurons that are significantly changing their FRaft/FRbef,
                % including good trials from non-stim ctrl and 2nd stim ctrl as ctrl trials, neurons with significant changes in FRaft/FRbef 
PyrInitPeakAllStimPVRecSigNonStim2ndStimCtrlTr(methodKMean);
                % including good trials from non-stim ctrl and 2nd stim ctrl as ctrl trials, only consider stimulation recordings
                % stim ctrl trials are the second stim ctrl
                % trials from all the stim pulse types from the recording
      
%% used in the manuscript
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec(methodKMean,pDriftRec); 
                % Separating into rise and down neurons, select neurons to
                % remove the recordings with drifted firing rate between ctrl
                % and stimCtrl. Excluding some recordings that have clear drifts during the PV activation experiments 
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_Anova();
                  % perform anova statistical test to compare the firing rate change between
                  % control and stim trials
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_ttest()
                  %  perform ttest  to compare the firing rate change between
                  % control and stim trials
PyrIntInitPeakCorrTPVSigNonStim2ndStimCtrlNoDriftSelRec(methodKMean,pDriftRec);
                % correlation of neurons, 
                % remove the recordings with drifted firing rate between ctrl
                % and stimCtrl. Excluding some recordings that have clear drifts during the PV activation experiments 
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_NoF(methodKMean);
                  % the same as
                  % PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec,
                  % but excluded neurons with fields
              

%% compare behavior in no cue and AL task (Figure 1)
PyrBehALNoCue(0); % compare behavior between no cue and AL condition (aligned to cue, plot over distance)

PyrBehALNoCueAligned(0); % compare behavior between no cue and AL condition (aligned to run, plot over distance)

PyrBehALNoCueAlignedTime(0); % compare behavior between no cue and AL condition (aligned to run, plot over time)


%% Figure 2 in the PV paper
CompPyrModCtrlTrNoCueVsALPL(); % control trials over distance
CompPyrModAlignedCtrlTrNoCueVsALPL(); % control trials over time after aligned to run onset
CompPyrModAlignedGoodVsBadTrALPL(); % good trials vs bad trials over time aligned to run onset
CompPyrModAlignedDistGoodVsBadTrALPL(); % good trials vs bad trials over distance aligned to run onset

PyrPopActivityAlignedCorrCtrl(onlyRun); % population correlation after aligned to run onset
PyrPopActivityAlignedCorrCtrlAllRec(); % accumulation over all the recordings


%% classify PyrUp and PyrDown neurons based on the FR change before and after the run onset
for taskSel = 2:3
    for pshuffle = 2:3
        PyrIntInitPeakSig(taskSel,pshuffle); % select the ones that has a significant change in FR around run onset 
        PyrIntInitPeakNoFNeuronsSig(taskSel,pshuffle); % select the no field neurons that has a significant change in FR around run onset 
    end
          %      (pshuffle = 1 -> 99.9%, 2 -> 99%, 3 -> 95%)
    PyrIntInitPeak(taskSel);
    PyrIntInitPeakDist(taskSel); % plot over distance instead of time
    PyrIntInitPeakNoFNeurons(taskSel); % select neurons without field
end

PyrIntInitPeak_PLoc(); % estimate the peak location and tau of the average firing rate profile for each neuron

%% estimate the peak location and tau of the average firing rate profile during the stimulation sessions
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_pLoc(methodKMean);

PyrIntInitPeakTagged; % including good and bad neurons separately depending on the no. of good vs. bad trials for each neuron
PyrIntInitPeakTaggedAll; % including all the sessions where the good trial no. is larger than certain threshold

PyrIntInitPeakTaggedAllSST; % including all the sessions where the good trial no. is larger than certain threshold, plot the tagged SST neurons


%% muscimol data
ProcessAllRecBehMusc();

%% plotting the putative PV and SST cells
plotPVSSTPutativeCells(); % plot the theta phase and ccg of PV and SST neurons

%% extract 1st stim ctrl and 2nd stim ctrl, and compare 1st stim ctrl with good non-stim ctrl
PyrInitPeakAllStimPVRecSigNonStim_1stStimCtrlTr(methodKMean);

PyrIntInitPeakPVStimNonStim2ndStimCtrlSelSigChange1SelRec1(methodKMean,p,pDriftRec);

%% short vs long trials
taskSel = 2;
speedMode = 0;
PyrInitPeakAllRec_LongShortTr(taskSel,methodKMean);
PyrIntInitPeak_LongShortTr(taskSel,speedMode);

