function modPyr = accumPyrNeurons1CtrlTr(paths,filenames,mazeSess,minFR,maxFR,task,methodTheta,onlyRun,intervalT)

    %% 
    numRec = size(paths,1);
    modPyr = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              'thetaFreqHMean',[],... % theta frequency hilbert
                              ...
                              'thetaMod',[],... % theta modulation
                              'trough',[],... % % ACG first trough
                              'peak',[],... % % ACG first peak
                              'thetaModInd',[],... % theta modulation index
                              'troughT3',[],... % % time of ACG first trough
                              'peakT3',[],... % % time of ACG first peak
                              'thetaModInd3',[],... % theta modulation index (method 3)
                              'thetaAsym3',[],... % theta asymmetry (method 3)
                              'thetaModFreq3',[],... % theta modulation frequency (method 3)
                              ...
                              'mFR',[],... % mean firing rate
                              'meanInstFR',[], ... % mean instantaneous firing rate (aligned to run)
                              'meanInstFRCue',[], ... % mean instantaneous firing rate (aligned to cue) 
                              'meanInstFRGood',[], ... % mean instantaneous firing rate (aligned to run)
                              'meanInstFRCueGood',[], ... % mean instantaneous firing rate (aligned to cue) 
                              ...
                              'nNeuWithField',[],... % number of pyr neurons with fields in the recording (aligned to run)
                              'nNeuWithFieldAll',[],... % number of neurons with fields in the recording (aligned to run)
                              'isNeuWithField',[],... % does the neuron have field(s) (aligned to run)
                              'fieldWidth',[],... % field width (aligned to run)
                              'indStartField',[],... % start index of a field (aligned to run)
                              'indPeakField',[],... % peak index of a field (aligned to run)
                              ...
                              'nNeuWithFieldCue',[],... % number of pyr neurons with fields in the recording (aligned to cue)
                              'nNeuWithFieldAllCue',[],... % number of neurons with fields in the recording (aligned to cue)
                              'isNeuWithFieldCue',[],... % does the neuron have field(s) (aligned to cue)
                              'fieldWidthCue',[],... % field width (aligned to cue)
                              'indStartFieldCue',[],... % start index of a field (aligned to cue)
                              'indPeakFieldCue',[],... % peak index of a field (aligned to cue)
                              ...
                              'nNeuWithFieldGood',[],... % number of pyr neurons with fields in the recording (aligned to run good trials)
                              'nNeuWithFieldAllGood',[],... % number of neurons with fields in the recording (aligned to run good tiials)
                              'isNeuWithFieldGood',[],... % does the neuron have field(s) (aligned to run)
                              'fieldWidthGood',[],... % field width (aligned to run)
                              'indStartFieldGood',[],... % start index of a field (aligned to run)
                              'indPeakFieldGood',[],... % peak index of a field (aligned to run)
                              ...
                              'nNeuWithFieldCueGood',[],... % number of pyr neurons with fields in the recording (aligned to cue)
                              'nNeuWithFieldAllCueGood',[],... % number of neurons with fields in the recording (aligned to cue)
                              'isNeuWithFieldCueGood',[],... % does the neuron have field(s) (aligned to cue)
                              'fieldWidthCueGood',[],... % field width (aligned to cue)
                              'indStartFieldCueGood',[],... % start index of a field (aligned to cue)
                              'indPeakFieldCueGood',[],... % peak index of a field (aligned to cue)
                              ...
                              'fractBurst',[],... % fraction of spikes which belongs to a burst over all the spikes across all the trials
                              'burstMeanDire',[],... % the mean phase direction
                              'burstMeanResultantLen',[],... % the mean resultant length of the mean phase direction
                              'nonBurstMeanDire',[],... % the mean phase direction of non-burst spikes
                              'nonBurstMeanResultantLen',[],... % the mean resultant length of the mean phase direction of non-burst spikes
                              'burstMeanDireStart',[],... % the mean phase direction of the first spike of a burst
                              'burstMeanResultantLenStart',[],... % the mean resultant length of the mean phase direction of the first spike of a burst
                              'numSpPerBurstMean',[],... % mean number of spikes per burst
                              ...  
                              'trialLenMean',[],... % mean trial length
                              'trackLen',[],... % track length in mm
                              'minPhaseFilH',[],... % the phase which fires the least number of spikes (hilbert)
                              'maxPhaseFilH',[],... % the phase which fires the largest number of spikes (hilbert)
                              'thetaModHistH',[],... % theta modulation calculated based on theta phase histogram (hilbert)
                              'phaseMeanDireH',[],... % the mean phase direction (hilbert)
                              'phaseMeanResultantLenH',[],... % the mean resultant length of the mean phase direction (hilbert)
                              ...
                              'minPhaseFil',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFil',[],... % the phase which fires the largest number of spikes 
                              'thetaModHist',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDire',[],... % the mean phase direction
                              'phaseMeanResultantLen',[],... % the mean resultant length of the mean phase direction
                              ...
                              'meanCorrTRun',[],... % mean correlation in time aligned to run
                              'meanCorrTRunNZ',[],... % mean correlation in time aligned to run (trials with spikes)
                              'meanCorrTRew',[],... % mean correlation in time aligned to rew
                              'meanCorrTRewNZ',[],... % mean correlation in time aligned to rew (trials with spikes)
                              'meanCorrTCue',[],... % mean correlation in time aligned to rew
                              'meanCorrTCueNZ',[],... % mean correlation in time aligned to rew (trials with spikes)
                              'adaptSpatialInfo',[],... % spatial information (aligned to run)
                              'spatialInfo',[],... % spatial information (aligned to run), added on 7/21/2022
                              'sparsity',[],... % sparsity (aligned to run)
                              'adaptSpatialInfoCue',[],... % spatial information (aligned to cue)
                              'spatialInfoCue',[],... % spatial information (aligned to cue), added on 7/21/2022
                              'sparsityCue',[]); % sparsity (aligned to cue)
                          
    for i = 1:numRec
        disp(filenames(i,:));
        if(i == 7)
            a = 1;
        end
        fullPath = [paths(i,:) filenames(i,:) '.mat'];
        if(exist(fullPath) == 0)
            disp('File does not exist.');
            return;
        end
        load(fullPath,'cluList'); 
        
        fileNameInfo = [filenames(i,:) '_Info.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr','beh'); 
        
        fullPathFRAll = [filenames(i,:) '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathFRAll];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFRAll = mFRStructSess{mazeSess(i)};
        else
            mFRAll = mFRStruct;
        end
                
        fileNameFR = [filenames(i,:) '_FRAlignedRunCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFR];
        if(exist(fullPath,'file') == 0)
            disp('_FR_Ctrl file does not exist. Please run "MeanFiringRateAlignedCtrlOnly" function first');
        end
        load(fullPath,'mFRStructNonStim');       
        mFR = mFRStructNonStim;
                
        fileNamePeakFR = [filenames(i,:) '_PeakFRAlignedCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat']; 
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_AlignedCtrlOnly" first.']);
            return;
        end
        load(fullPath,'pFRNonStimStruct','pFRNonStimCueStruct','trialNoNonStim');
        indLaps = trialNoNonStim; 
        pFR = pFRNonStimStruct;
        pFRCue = pFRNonStimCueStruct;
        
        fileNameThetaMod = [filenames(i,:) '_ThetaModAlignedRunCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaMod];
        if(exist(fullPath) == 0)
            disp('_ThetaModAlignedRunCtrl file does not exist.');
            return;
        end
        load(fullPath,'thetaModNonStim');
        thetaMod = thetaModNonStim;
                 
        fileNameSpInfo = [filenames(i,:) '_SpInfoAlignedCtrl_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameSpInfo];
        if(exist(fullPath) == 0)
            disp('_SpInfoAlignedCtrl file does not exist.');
            return;
        end
        load(fullPath,'spatialInfoSessNonStim');
        spatialInfo = spatialInfoSessNonStim;
        
        fileNameSpInfo = [filenames(i,:) '_SpInfoAlignedCueCtrl_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameSpInfo];
        if(exist(fullPath) == 0)
            disp('_SpInfoAlignedCueCtrl file does not exist.');
            return;
        end
        load(fullPath,'spatialInfoSessNonStim');
        spatialInfoCue = spatialInfoSessNonStim;
        
        fileNameCorr = [filenames(i,:) '_meanSpikesCorrTAlignedCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '_intT' num2str(intervalT) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_meanSpikesCorrTAlignedCtrl file does not exist.');
            return;
        end
        load(fullPath,'meanCorrTRunCtrl','meanCorrTRewCtrl','meanCorrTCueCtrl');
                
        if(methodTheta == 0)
            th = 'H';
        else
            th = 'L';
        end               
        fileNameBurst = [filenames(i,:) '_burstAllAlignedRunCtrl_TH' th '_msess' ...
            num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameBurst];
        if(exist(fullPath) == 0)
            disp('_burstAllAlignedRunCtrl file does not exist.');
            return;
        end
        load(fullPath,'burstIsiPerNeuronNonStim');
        burstIsi = burstIsiPerNeuronNonStim;
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseLAlignedCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat']; % changed from "ThetaPhaseH" to "ThetaPhaseL" on 7/24/2022
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseLAlignedCtrl file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStim');
        spikeThetaPhase = spikeThetaPhaseRunNoStim;
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseHAlignedCtrl_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseHAlignedCtrl file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStim');
        spikeThetaPhaseH = spikeThetaPhaseRunNoStim;
        
        trialLenMean = mean(beh.lenTrials(indLaps));
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAlignedCtrl_Run' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp('_FieldSpCorrAlignedCtrl file does not exist.');
            return;
        end
        load(fullPath, 'fieldSpCorrSessNonStim','fieldSpCorrSessNonStimCue','paramF');
        fieldSpCorr = fieldSpCorrSessNonStim;
        fieldSpCorrCue = fieldSpCorrSessNonStimCue;
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp('_FieldSpCorrAligned file does not exist.');
            return;
        end
        load(fullPath, 'fieldSpCorrSessNonStimGood','fieldSpCorrSessNonStimGoodCue');
        fieldSpCorrGood = fieldSpCorrSessNonStimGood;
        fieldSpCorrCueGood = fieldSpCorrSessNonStimGoodCue;
             
%         indNeu = cluList.firingRate > minFR & cluList.firingRate < maxFR &...
%                     autoCorr.isPyrneuron == 1;
        indNeu = mFRAll.mFR > minFR & mFRAll.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        modPyr.task = [modPyr.task task*ones(1,sum(indNeu))];
        modPyr.indRec = [modPyr.indRec i*ones(1,sum(indNeu))];
        modPyr.indNeu = [modPyr.indNeu find(indNeu == 1)]; 
        modPyr.trialLenMean = [modPyr.trialLenMean trialLenMean*ones(1,sum(indNeu))];
        modPyr.trackLen = [modPyr.trackLen unique(beh.trackLen(beh.mazeSess == mazeSess(i)))*ones(1,sum(indNeu))];
        modPyr.thetaFreqHMean = [modPyr.thetaFreqHMean mean(beh.thetaFreqHMean(indLaps))*ones(1,sum(indNeu))];
        
        numNeu = sum(indNeu);
        if(length(indLaps) >= paramF.minNumTr)
            modPyr.thetaMod = [modPyr.thetaMod thetaMod.thetaMod(indNeu)];
            modPyr.trough = [modPyr.trough thetaMod.trough(indNeu)];
            modPyr.peak = [modPyr.peak thetaMod.peak(indNeu)];
            modPyr.thetaModInd = [modPyr.thetaModInd thetaMod.thetaModInd(indNeu)];
            modPyr.peakT3 = [modPyr.peakT3 thetaMod.peakT3(indNeu)];
            modPyr.troughT3 = [modPyr.troughT3 thetaMod.troughT3(indNeu)];
            modPyr.thetaAsym3 = [modPyr.thetaAsym3 ...
                (abs(thetaMod.peakT3(indNeu))-abs(thetaMod.troughT3(indNeu)))./...
                (abs(thetaMod.peakT3(indNeu)))];
            modPyr.thetaModFreq3 = [modPyr.thetaModFreq3 ...
                1000./(abs(thetaMod.peakT3(indNeu)))];
            modPyr.thetaModInd3 = [modPyr.thetaModInd3 thetaMod.thetaModInd3(indNeu)];
            modPyr.mFR = [modPyr.mFR mFR.mFR(indNeu)];

            % field align to run onset
            nNeurons = length(cluList.firingRate);
            nFieldArr = zeros(1,sum(indNeu));
            indNeuWithField = zeros(1,nNeurons);
            fieldWidth = zeros(1,nNeurons);
            indStartField = zeros(1,nNeurons);
            indPeakField = zeros(1,nNeurons);
            
            [indNeuF,ia] = unique(fieldSpCorr.indNeuron);
            [indNeuF,ic] = intersect(indNeuF,find(autoCorr.isPyrneuron == 1));
            if(length(ia) ~= length(ic))
               ia = ia(ic); 
            end
            indNeuWithField(indNeuF) = 1;
            fieldWidth(indNeuF) = fieldSpCorr.FW(ia);
            indStartField(indNeuF) = fieldSpCorr.indStartField(ia);
            indPeakField(indNeuF) = fieldSpCorr.indPeakField(ia);
            numField = length(indNeuF);
            if(numField > 0)
                nFieldArr = numField * ones(1,sum(indNeu));
            end
            modPyr.nNeuWithFieldAll = [modPyr.nNeuWithFieldAll nFieldArr];
            modPyr.nNeuWithField = [modPyr.nNeuWithField sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithField = [modPyr.isNeuWithField indNeuWithField(indNeu)];
            modPyr.fieldWidth = [modPyr.fieldWidth fieldWidth(indNeu)];
            modPyr.indStartField = [modPyr.indStartField indStartField(indNeu)];
            modPyr.indPeakField = [modPyr.indPeakField indPeakField(indNeu)];
            modPyr.meanInstFR = [modPyr.meanInstFR pFR.meanInstFR(indNeu)];
            
            % field align to cue
            nFieldArr = zeros(1,sum(indNeu));
            indNeuWithField = zeros(1,nNeurons);
            fieldWidth = zeros(1,nNeurons);
            indStartField = zeros(1,nNeurons);
            indPeakField = zeros(1,nNeurons);
            
            [indNeuF,ia] = unique(fieldSpCorrCue.indNeuron);
            [indNeuF,ic] = intersect(indNeuF,find(autoCorr.isPyrneuron == 1));
            if(length(ia) ~= length(ic))
               ia = ia(ic); 
            end
            indNeuWithField(indNeuF) = 1;
            fieldWidth(indNeuF) = fieldSpCorrCue.FW(ia);
            indStartField(indNeuF) = fieldSpCorrCue.indStartField(ia);
            indPeakField(indNeuF) = fieldSpCorrCue.indPeakField(ia);
            numField = length(indNeuF);
            if(numField > 0)
                nFieldArr = numField * ones(1,sum(indNeu));
            end
            modPyr.nNeuWithFieldAllCue = [modPyr.nNeuWithFieldAllCue nFieldArr];
            modPyr.nNeuWithFieldCue = [modPyr.nNeuWithFieldCue sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithFieldCue = [modPyr.isNeuWithFieldCue indNeuWithField(indNeu)];
            modPyr.fieldWidthCue = [modPyr.fieldWidthCue fieldWidth(indNeu)];
            modPyr.indStartFieldCue = [modPyr.indStartFieldCue indStartField(indNeu)];
            modPyr.indPeakFieldCue = [modPyr.indPeakFieldCue indPeakField(indNeu)];
            modPyr.meanInstFRCue = [modPyr.meanInstFRCue pFRCue.meanInstFR(indNeu)];
            
            %% added on 7/24/2022
            % field align to run onset (good trials)
            nFieldArr = zeros(1,sum(indNeu));
            indNeuWithField = zeros(1,nNeurons);
            fieldWidth = zeros(1,nNeurons);
            indStartField = zeros(1,nNeurons);
            indPeakField = zeros(1,nNeurons);
            
            [indNeuF,ia] = unique(fieldSpCorrGood.indNeuron);
            [indNeuF,ic] = intersect(indNeuF,find(autoCorr.isPyrneuron == 1));
            if(length(ia) ~= length(ic))
               ia = ia(ic); 
            end
            indNeuWithField(indNeuF) = 1;
            fieldWidth(indNeuF) = fieldSpCorrGood.FW(ia);
            indStartField(indNeuF) = fieldSpCorrGood.indStartField(ia);
            indPeakField(indNeuF) = fieldSpCorrGood.indPeakField(ia);
            numField = length(indNeuF);
            if(numField > 0)
                nFieldArr = numField * ones(1,sum(indNeu));
            end
            modPyr.nNeuWithFieldAllGood = [modPyr.nNeuWithFieldAllGood nFieldArr];
            modPyr.nNeuWithFieldGood = [modPyr.nNeuWithFieldGood sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithFieldGood = [modPyr.isNeuWithFieldGood indNeuWithField(indNeu)];
            modPyr.fieldWidthGood = [modPyr.fieldWidthGood fieldWidth(indNeu)];
            modPyr.indStartFieldGood = [modPyr.indStartFieldGood indStartField(indNeu)];
            modPyr.indPeakFieldGood = [modPyr.indPeakFieldGood indPeakField(indNeu)];
            modPyr.meanInstFRGood = [modPyr.meanInstFRGood pFR.meanInstFR(indNeu)];
            
            % field align to cue (good trials)
            nFieldArr = zeros(1,sum(indNeu));
            indNeuWithField = zeros(1,nNeurons);
            fieldWidth = zeros(1,nNeurons);
            indStartField = zeros(1,nNeurons);
            indPeakField = zeros(1,nNeurons);
            
            [indNeuF,ia] = unique(fieldSpCorrCueGood.indNeuron);
            [indNeuF,ic] = intersect(indNeuF,find(autoCorr.isPyrneuron == 1));
            if(length(ia) ~= length(ic))
               ia = ia(ic); 
            end
            indNeuWithField(indNeuF) = 1;
            fieldWidth(indNeuF) = fieldSpCorrCueGood.FW(ia);
            indStartField(indNeuF) = fieldSpCorrCueGood.indStartField(ia);
            indPeakField(indNeuF) = fieldSpCorrCueGood.indPeakField(ia);
            numField = length(indNeuF);
            if(numField > 0)
                nFieldArr = numField * ones(1,sum(indNeu));
            end
            modPyr.nNeuWithFieldAllCueGood = [modPyr.nNeuWithFieldAllCueGood nFieldArr];
            modPyr.nNeuWithFieldCueGood = [modPyr.nNeuWithFieldCueGood sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithFieldCueGood = [modPyr.isNeuWithFieldCueGood indNeuWithField(indNeu)];
            modPyr.fieldWidthCueGood = [modPyr.fieldWidthCueGood fieldWidth(indNeu)];
            modPyr.indStartFieldCueGood = [modPyr.indStartFieldCueGood indStartField(indNeu)];
            modPyr.indPeakFieldCueGood = [modPyr.indPeakFieldCueGood indPeakField(indNeu)];
            modPyr.meanInstFRCueGood = [modPyr.meanInstFRCueGood pFRCue.meanInstFR(indNeu)];
            %%
            
            % 
            numSpPerBurst = zeros(1,nNeurons);
            for m = 1:nNeurons
                if(~isempty(burstIsi.numSpPerBurst{m}))
                    numSpPerBurst(m) = mean(burstIsi.numSpPerBurst{m});
                end
            end
            modPyr.fractBurst = [modPyr.fractBurst burstIsi.fractBurst(indNeu)];
            modPyr.numSpPerBurstMean = [modPyr.numSpPerBurstMean numSpPerBurst(indNeu)]; 
            modPyr.burstMeanDire = [modPyr.burstMeanDire burstIsi.meanDire(indNeu)];        
            modPyr.burstMeanResultantLen = [modPyr.burstMeanResultantLen burstIsi.meanResultantLen(indNeu)];

            modPyr.nonBurstMeanDire = [modPyr.nonBurstMeanDire burstIsi.meanDireNonBurst(indNeu)];
            modPyr.nonBurstMeanResultantLen = [modPyr.nonBurstMeanResultantLen burstIsi.meanResultantLenNonBurst(indNeu)];

            modPyr.burstMeanDireStart = [modPyr.burstMeanDireStart burstIsi.meanDireStart(indNeu)];        
            modPyr.burstMeanResultantLenStart = [modPyr.burstMeanResultantLenStart burstIsi.meanResultantLenStart(indNeu)];

            modPyr.minPhaseFil = [modPyr.minPhaseFil spikeThetaPhase.minPhaseFilArr(indNeu)];
            modPyr.maxPhaseFil = [modPyr.maxPhaseFil spikeThetaPhase.maxPhaseFilArr(indNeu)];
            modPyr.phaseMeanDire = [modPyr.phaseMeanDire spikeThetaPhase.meanDire(indNeu)];
            modPyr.phaseMeanResultantLen = [modPyr.phaseMeanResultantLen spikeThetaPhase.meanResultantLen(indNeu)];
            modPyr.thetaModHist = [modPyr.thetaModHist spikeThetaPhase.thetaMod(indNeu)]; 

            modPyr.minPhaseFilH = [modPyr.minPhaseFilH spikeThetaPhaseH.minPhaseFilArr(indNeu)];
            modPyr.maxPhaseFilH = [modPyr.maxPhaseFilH spikeThetaPhaseH.maxPhaseFilArr(indNeu)];
            modPyr.phaseMeanDireH = [modPyr.phaseMeanDireH spikeThetaPhaseH.meanDire(indNeu)];
            modPyr.phaseMeanResultantLenH = [modPyr.phaseMeanResultantLenH spikeThetaPhaseH.meanResultantLen(indNeu)];
            modPyr.thetaModHistH = [modPyr.thetaModHistH spikeThetaPhaseH.thetaMod(indNeu)]; 
            
            modPyr.meanCorrTRun = [modPyr.meanCorrTRun meanCorrTRunCtrl.mean(indNeu)];
            modPyr.meanCorrTRunNZ = [modPyr.meanCorrTRunNZ meanCorrTRunCtrl.meanNZ(indNeu)];
            modPyr.meanCorrTRew = [modPyr.meanCorrTRew meanCorrTRewCtrl.mean(indNeu)];
            modPyr.meanCorrTRewNZ = [modPyr.meanCorrTRewNZ meanCorrTRewCtrl.meanNZ(indNeu)];
            modPyr.meanCorrTCue = [modPyr.meanCorrTCue meanCorrTCueCtrl.mean(indNeu)];
            modPyr.meanCorrTCueNZ = [modPyr.meanCorrTCueNZ meanCorrTCueCtrl.meanNZ(indNeu)];
            
            modPyr.adaptSpatialInfo = [modPyr.adaptSpatialInfo spatialInfo.adaptSpatialInfo(indNeu)];
            modPyr.spatialInfo = [modPyr.spatialInfo spatialInfo.spatialInfo(indNeu)];
            modPyr.sparsity = [modPyr.sparsity spatialInfo.sparsity(indNeu)];
            modPyr.adaptSpatialInfoCue = [modPyr.adaptSpatialInfoCue spatialInfoCue.adaptSpatialInfo(indNeu)];
            modPyr.spatialInfoCue = [modPyr.spatialInfoCue spatialInfoCue.spatialInfo(indNeu)];
            modPyr.sparsityCue = [modPyr.sparsityCue spatialInfoCue.sparsity(indNeu)];
        else
            modPyr.thetaMod = [modPyr.thetaMod NaN(1,numNeu)];
            modPyr.trough = [modPyr.trough NaN(1,numNeu)];
            modPyr.peak = [modPyr.peak NaN(1,numNeu)];
            modPyr.thetaModInd = [modPyr.thetaModInd NaN(1,numNeu)];
            modPyr.peakT3 = [modPyr.peakT3 NaN(1,numNeu)];
            modPyr.troughT3 = [modPyr.troughT3 NaN(1,numNeu)];
            modPyr.thetaAsym3 = [modPyr.thetaAsym3 NaN(1,numNeu)];
            modPyr.thetaModFreq3 = [modPyr.thetaModFreq3 NaN(1,numNeu)];
            modPyr.thetaModInd3 = [modPyr.thetaModInd3 NaN(1,numNeu)];
            modPyr.mFR = [modPyr.mFR NaN(1,numNeu)];
            
            modPyr.nNeuWithFieldAll = [modPyr.nNeuWithFieldAll NaN(1,numNeu)];
            modPyr.nNeuWithField = [modPyr.nNeuWithField NaN(1,numNeu)];
            modPyr.isNeuWithField = [modPyr.isNeuWithField NaN(1,numNeu)];
            modPyr.fieldWidth = [modPyr.fieldWidth NaN(1,numNeu)];
            modPyr.indStartField = [modPyr.indStartField NaN(1,numNeu)];
            modPyr.indPeakField = [modPyr.indPeakField NaN(1,numNeu)];
            modPyr.meanInstFR = [modPyr.meanInstFR NaN(1,numNeu)];
            
            modPyr.nNeuWithFieldAllCue = [modPyr.nNeuWithFieldAllCue NaN(1,numNeu)];
            modPyr.nNeuWithFieldCue = [modPyr.nNeuWithFieldCue NaN(1,numNeu)]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithFieldCue = [modPyr.isNeuWithFieldCue NaN(1,numNeu)];
            modPyr.fieldWidthCue = [modPyr.fieldWidthCue NaN(1,numNeu)];
            modPyr.indStartFieldCue = [modPyr.indStartFieldCue NaN(1,numNeu)];
            modPyr.indPeakFieldCue = [modPyr.indPeakFieldCue NaN(1,numNeu)];
            modPyr.meanInstFRCue = [modPyr.meanInstFRCue NaN(1,numNeu)];
            
            %% added on 7/24/2022
            modPyr.nNeuWithFieldAllGood = [modPyr.nNeuWithFieldAllGood NaN(1,numNeu)];
            modPyr.nNeuWithFieldGood = [modPyr.nNeuWithFieldGood NaN(1,numNeu)];
            modPyr.isNeuWithFieldGood = [modPyr.isNeuWithFieldGood NaN(1,numNeu)];
            modPyr.fieldWidthGood = [modPyr.fieldWidthGood NaN(1,numNeu)];
            modPyr.indStartFieldGood = [modPyr.indStartFieldGood NaN(1,numNeu)];
            modPyr.indPeakFieldGood = [modPyr.indPeakFieldGood NaN(1,numNeu)];
            modPyr.meanInstFRGood = [modPyr.meanInstFRGood NaN(1,numNeu)];
            
            modPyr.nNeuWithFieldAllCueGood = [modPyr.nNeuWithFieldAllCueGood NaN(1,numNeu)];
            modPyr.nNeuWithFieldCueGood = [modPyr.nNeuWithFieldCueGood NaN(1,numNeu)]; %% added by Yingxue on 3/27/2022
            modPyr.isNeuWithFieldCueGood = [modPyr.isNeuWithFieldCueGood NaN(1,numNeu)];
            modPyr.fieldWidthCueGood = [modPyr.fieldWidthCueGood NaN(1,numNeu)];
            modPyr.indStartFieldCueGood = [modPyr.indStartFieldCueGood NaN(1,numNeu)];
            modPyr.indPeakFieldCueGood = [modPyr.indPeakFieldCueGood NaN(1,numNeu)];
            modPyr.meanInstFRCueGood = [modPyr.meanInstFRCueGood NaN(1,numNeu)];
            %%
            
            modPyr.fractBurst = [modPyr.fractBurst NaN(1,numNeu)];
            modPyr.numSpPerBurstMean = [modPyr.numSpPerBurstMean NaN(1,numNeu)]; 
            modPyr.burstMeanDire = [modPyr.burstMeanDire NaN(1,numNeu)];        
            modPyr.burstMeanResultantLen = [modPyr.burstMeanResultantLen NaN(1,numNeu)];

            modPyr.nonBurstMeanDire = [modPyr.nonBurstMeanDire NaN(1,numNeu)];
            modPyr.nonBurstMeanResultantLen = [modPyr.nonBurstMeanResultantLen NaN(1,numNeu)];

            modPyr.burstMeanDireStart = [modPyr.burstMeanDireStart NaN(1,numNeu)];        
            modPyr.burstMeanResultantLenStart = [modPyr.burstMeanResultantLenStart NaN(1,numNeu)];

            modPyr.minPhaseFil = [modPyr.minPhaseFil NaN(1,numNeu)];
            modPyr.maxPhaseFil = [modPyr.maxPhaseFil NaN(1,numNeu)];
            modPyr.phaseMeanDire = [modPyr.phaseMeanDire NaN(1,numNeu)];
            modPyr.phaseMeanResultantLen = [modPyr.phaseMeanResultantLen NaN(1,numNeu)];
            modPyr.thetaModHist = [modPyr.thetaModHist NaN(1,numNeu)]; 

            modPyr.minPhaseFilH = [modPyr.minPhaseFilH NaN(1,numNeu)];
            modPyr.maxPhaseFilH = [modPyr.maxPhaseFilH NaN(1,numNeu)];
            modPyr.phaseMeanDireH = [modPyr.phaseMeanDireH NaN(1,numNeu)];
            modPyr.phaseMeanResultantLenH = [modPyr.phaseMeanResultantLenH NaN(1,numNeu)];
            modPyr.thetaModHistH = [modPyr.thetaModHistH NaN(1,numNeu)]; 
            
            modPyr.meanCorrTRun = [modPyr.meanCorrTRun NaN(1,numNeu)];
            modPyr.meanCorrTRunNZ = [modPyr.meanCorrTRunNZ NaN(1,numNeu)];
            modPyr.meanCorrTRew = [modPyr.meanCorrTRew NaN(1,numNeu)];
            modPyr.meanCorrTRewNZ = [modPyr.meanCorrTRewNZ NaN(1,numNeu)];
            modPyr.meanCorrTCue = [modPyr.meanCorrTCue NaN(1,numNeu)];
            modPyr.meanCorrTCueNZ = [modPyr.meanCorrTCueNZ NaN(1,numNeu)];
            
            modPyr.adaptSpatialInfo = [modPyr.adaptSpatialInfo NaN(1,numNeu)];
            modPyr.spatialInfo = [modPyr.spatialInfo NaN(1,numNeu)];
            modPyr.sparsity = [modPyr.sparsity NaN(1,numNeu)];
            modPyr.adaptSpatialInfoCue = [modPyr.adaptSpatialInfoCue NaN(1,numNeu)];
            modPyr.spatialInfoCue = [modPyr.spatialInfoCue NaN(1,numNeu)];
            modPyr.sparsityCue = [modPyr.sparsityCue NaN(1,numNeu)];
        end
    end
    
    indDire = find(modPyr.burstMeanDire < 0);
    modPyr.burstMeanDire(indDire) = modPyr.burstMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.nonBurstMeanDire < 0);
    modPyr.nonBurstMeanDire(indDire) = modPyr.nonBurstMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.burstMeanDireStart < 0);
    modPyr.burstMeanDireStart(indDire) = modPyr.burstMeanDireStart(indDire) + 2*pi;
    
    indDire = find(modPyr.phaseMeanDire < 0);
    modPyr.phaseMeanDire(indDire) = modPyr.phaseMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.phaseMeanDireH < 0);
    modPyr.phaseMeanDireH(indDire) = modPyr.phaseMeanDireH(indDire) + 2*pi;
end