function modPyr = accumPyrNeuronsAligned(paths,filenames,mazeSess,minFR,maxFR,task,methodTheta,onlyRun,samplefq)

    %% Pyrs in no cue passive task
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
                              'meanInstFR',[], ... % mean instantaneous firing rate
                              ...
                              'nNeuWithField',[],... % number of pyr neurons with fields in the recording
                              'nNeuWithFieldAll',[],... % number of neurons with fields in the recording
                              'isNeuWithField',[],... % does the neuron have field(s)
                              'fieldWidth',[],... % field width
                              'indStartField',[],... % start index of a field
                              'indPeakField',[],... % peak index of a field
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
                              'phaseMeanResultantLen',[]); % the mean resultant length of the mean phase direction
                          
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
        
        fullPath = [paths(i,:) filenames(i,:) '_alignRun_msess' num2str(mazeSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The aligned to run file does not exist');
            return;
        end
        load(fullPath,'trialsRun');
                
        fullPathFR = [filenames(i,:) '_FRAlignedRun_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FRAlignedRun.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStructNonStimGood'); 
        mFR = mFRStructNonStimGood;
        
        fileNamePeakFR = [filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct','trialNoNonStimGood');
        
        fileNameThetaMod = [filenames(i,:) '_ThetaModAlignedRun_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaMod];
        if(exist(fullPath) == 0)
            disp('_ThetaModAlignedRun file does not exist.');
            return;
        end
        load(fullPath,'thetaModNonStimGood');
        thetaModSessTmp = thetaModNonStimGood;
                
        if(methodTheta == 0)
            th = 'H';
        else
            th = 'L';
        end
        fileNameBurst = [filenames(i,:) '_burstAllAlignedRun_TH' th '_msess' num2str(mazeSess(i)) ...
                     '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameBurst];
        if(exist(fullPath) == 0)
            disp('_burstAllAlignedRun file does not exist.');
            return;
        end
        load(fullPath,'burstIsiPerNeuronNonStimGood');
        burstIsi = burstIsiPerNeuronNonStimGood;
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseLAligned_msess' num2str(mazeSess(i)) ...
                    '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseLAligned file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStimGood');
        spikeThetaPhase = spikeThetaPhaseRunNoStimGood;
                
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseHAligned_msess' num2str(mazeSess(i)) ...
                    '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseHAligned file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStimGood');
        spikeThetaPhaseH = spikeThetaPhaseRunNoStimGood;
        
        fullPathFR = [filenames(i,:) '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFR = mFRStructSess{mazeSess(i)};
        else
            mFR = mFRStruct;
        end
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAligned" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood','paramF');   
                        
        trialLenMean = mean(trialsRun.numSamples(trialNoNonStimGood))/samplefq;
       
        
%         indNeu = cluList.firingRate > minFR & cluList.firingRate < maxFR &...
%                     autoCorr.isPyrneuron == 1;
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        modPyr.task = [modPyr.task task*ones(1,sum(indNeu))];
        modPyr.indRec = [modPyr.indRec i*ones(1,sum(indNeu))];
        modPyr.indNeu = [modPyr.indNeu find(indNeu == 1)]; 
        modPyr.trialLenMean = [modPyr.trialLenMean trialLenMean*ones(1,sum(indNeu))];
        modPyr.thetaFreqHMean = [modPyr.thetaFreqHMean mean(beh.thetaFreqHMean(trialNoNonStimGood))*ones(1,sum(indNeu))];
                
        modPyr.thetaMod = [modPyr.thetaMod thetaModSessTmp.thetaMod(indNeu)];
        modPyr.trough = [modPyr.trough thetaModSessTmp.trough(indNeu)];
        modPyr.peak = [modPyr.peak thetaModSessTmp.peak(indNeu)];
        modPyr.thetaModInd = [modPyr.thetaModInd thetaModSessTmp.thetaModInd(indNeu)];
        modPyr.peakT3 = [modPyr.peakT3 thetaModSessTmp.peakT3(indNeu)];
        modPyr.troughT3 = [modPyr.troughT3 thetaModSessTmp.troughT3(indNeu)];
        modPyr.thetaAsym3 = [modPyr.thetaAsym3 ...
            (abs(thetaModSessTmp.peakT3(indNeu))-abs(thetaModSessTmp.troughT3(indNeu)))./...
            (abs(thetaModSessTmp.peakT3(indNeu)))];
        modPyr.thetaModFreq3 = [modPyr.thetaModFreq3 ...
            1000./(abs(thetaModSessTmp.peakT3(indNeu)))];
        modPyr.thetaModInd3 = [modPyr.thetaModInd3 thetaModSessTmp.thetaModInd3(indNeu)];
        modPyr.mFR = [modPyr.mFR mFR.mFR(indNeu)]; % ??
        
        nNeurons = length(cluList.firingRate);
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
        
        %% neurons with fields after alignment
        nNeurons = length(cluList.firingRate);
        nFieldArr = zeros(1,sum(indNeu));
        indNeuWithField = zeros(1,nNeurons);
        fieldWidth = zeros(1,nNeurons);
        indStartField = zeros(1,nNeurons);
        indPeakField = zeros(1,nNeurons);
        if(length(pFRNonStimGoodStruct.indLapList) > paramF.minNumTr) % more than 15 trirals
            if(~isempty(fieldSpCorrSessNonStimGood))
                [indNeuF,ia] = unique(fieldSpCorrSessNonStimGood.indNeuron); 
                indNeuWithField(indNeuF) = 1;
                fieldWidth(indNeuF) = fieldSpCorrSessNonStimGood.FW(ia);
                indStartField(indNeuF) = fieldSpCorrSessNonStimGood.indStartField(ia)*paramF.timeBin;
                indPeakField(indNeuF) = fieldSpCorrSessNonStimGood.indPeakField(ia)*paramF.timeBin;
                numField = length(indNeuF);
                if(numField > 0)
                    nFieldArr = numField * ones(1,sum(indNeu));
                end
            end
        end
        modPyr.nNeuWithField = [modPyr.nNeuWithField sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; % added by Yingxue on 3/27/2022
        modPyr.nNeuWithFieldAll = [modPyr.nNeuWithFieldAll nFieldArr];
        modPyr.isNeuWithField = [modPyr.isNeuWithField indNeuWithField(indNeu)];
        modPyr.fieldWidth = [modPyr.fieldWidth fieldWidth(indNeu)];
        modPyr.indStartField = [modPyr.indStartField indStartField(indNeu)];
        modPyr.indPeakField = [modPyr.indPeakField indPeakField(indNeu)];
        modPyr.meanInstFR = [modPyr.meanInstFR pFRNonStimGoodStruct.meanInstFR(indNeu)];
        
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