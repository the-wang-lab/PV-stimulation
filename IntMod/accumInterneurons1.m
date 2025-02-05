function modInt = accumInterneurons1(paths,filenames,mazeSess,minFRInt,minFR,maxFR,task,methodTheta,onlyRun)

    %% interneurons in no cue passive task
    numRec = size(paths,1);
    modInt = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
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
                              'nNeuWithField',[],... % number of neurons with fields in the recording
                              'nNeuWithFieldAligned',[],... % number of neurons with fields in the recording
                              'nNeuWithFieldAll',[],... % number of pyr neurons with fields in the recording
                              'nNeuWithFieldAlignedAll',[],... % number of pyr neurons with fields in the recording
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
        if(i == 3)
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
        
        fileNameFW = [filenames(i,:) '_FieldSpCorr_GoodTr_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessGoodTr','paramF'); 
        if(mazeSess(i) == 0)
            mazeSessTmp = 1;
        else
            mazeSessTmp = mazeSess(i);
        end
        fieldSpCorrSessGoodTr = fieldSpCorrSessGoodTr{mazeSessTmp};
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAligned" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood');    
                        
        fileNamePeakFR = [filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct');
        
        fileNameThetaMod = [filenames(i,:) '_ThetaMod_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaMod];
        if(exist(fullPath) == 0)
            disp('_ThetaMod file does not exist.');
            return;
        end
        load(fullPath,'thetaModSess');
        if(length(beh.mazeSessAll) == 1)
           thetaModSessTmp = thetaModSess{1};
        else
           thetaModSessTmp = thetaModSess{mazeSess(i)}; 
        end
        
        if(methodTheta == 0)
            th = 'H';
        else
            th = 'L';
        end
        fileNameBurst = [filenames(i,:) '_burstAll_TH' th '_Run' num2str(onlyRun) ...
                     '.mat'];
        fullPath = [paths(i,:) fileNameBurst];
        if(exist(fullPath) == 0)
            disp('_bustAll file does not exist.');
            return;
        end
        load(fullPath,'burstIsiPerNeuron','burstIsiPerNeuronSess');
        if(length(beh.mazeSessAll) > 1)
            burstIsi = burstIsiPerNeuronSess{mazeSess(i)};
        else
            burstIsi = burstIsiPerNeuron;
        end
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseL_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseL file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseStruct','spikeThetaPhaseStructSess');
        if(length(beh.mazeSessAll) > 1)
            spikeThetaPhase = spikeThetaPhaseStructSess{mazeSess(i)};
        else
            spikeThetaPhase = spikeThetaPhaseStruct;
        end
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseH_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseH file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseStruct','spikeThetaPhaseStructSess');
        if(length(beh.mazeSessAll) > 1)
            spikeThetaPhaseH = spikeThetaPhaseStructSess{mazeSess(i)};
        else
            spikeThetaPhaseH = spikeThetaPhaseStruct;
        end
        
        fileNameFR = [filenames(i,:) '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFR];
        if(exist(fullPath) == 0)
            disp('_FR file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess');
        if(length(beh.mazeSessAll) > 1)
            mFR = mFRStructSess{mazeSess(i)};
        else
            mFR = mFRStruct;
        end
                                      
%         indNeu = autoCorr.isInterneuron == 1 & cluList.firingRate > minFRInt;
        indNeu = autoCorr.isInterneuron == 1 & mFR.mFR > minFRInt;         
        modInt.task = [modInt.task task*ones(1,sum(indNeu))];
        modInt.indRec = [modInt.indRec i*ones(1,sum(indNeu))];
        modInt.indNeu = [modInt.indNeu find(indNeu == 1)]; 
        
        modInt.thetaMod = [modInt.thetaMod thetaModSessTmp.thetaMod(indNeu)];
        modInt.trough = [modInt.trough thetaModSessTmp.trough(indNeu)];
        modInt.peak = [modInt.peak thetaModSessTmp.peak(indNeu)];
        modInt.thetaModInd = [modInt.thetaModInd thetaModSessTmp.thetaModInd(indNeu)];
        modInt.peakT3 = [modInt.peakT3 thetaModSessTmp.peakT3(indNeu)];
        modInt.troughT3 = [modInt.troughT3 thetaModSessTmp.troughT3(indNeu)];
        modInt.thetaAsym3 = [modInt.thetaAsym3 ...
            (abs(thetaModSessTmp.peakT3(indNeu))-abs(thetaModSessTmp.troughT3(indNeu)))./...
            (abs(thetaModSessTmp.peakT3(indNeu)))];
        modInt.thetaModFreq3 = [modInt.thetaModFreq3 ...
            1000./(abs(thetaModSessTmp.peakT3(indNeu)))];
        modInt.thetaModInd3 = [modInt.thetaModInd3 thetaModSessTmp.thetaModInd3(indNeu)];
                
        nNeurons = length(cluList.firingRate);
        indNeuP = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        indNeuWithField = zeros(1,nNeurons);
        nFieldArr = zeros(1,sum(indNeu));
        if(length(pFRNonStimGoodStruct.indLapList) >= paramF.minNumTr) % more than 15 trirals
            if(~isempty(fieldSpCorrSessGoodTr))
                [indNeuF,ia] = unique(fieldSpCorrSessGoodTr.indNeuron); 
                indNeuWithField(indNeuF) = 1;
                numField = length(unique(fieldSpCorrSessGoodTr.indNeuron));
            else
                numField = [];
            end
            if(~isempty(numField))
                nFieldArr = numField * ones(1,sum(indNeu));
            end
        end
        modInt.nNeuWithFieldAll = [modInt.nNeuWithFieldAll nFieldArr];
        modInt.nNeuWithField = [modInt.nNeuWithField sum(indNeuWithField(indNeuP))*ones(1,sum(indNeu))];
        
        indNeuWithField = zeros(1,nNeurons);
        nFieldArr = zeros(1,sum(indNeu));
        if(length(pFRNonStimGoodStruct.indLapList) >= paramF.minNumTr) % more than 15 trirals
            if(~isempty(fieldSpCorrSessNonStimGood))
                [indNeuF,ia] = unique(fieldSpCorrSessNonStimGood.indNeuron); 
                indNeuWithField(indNeuF) = 1;
                numField = length(unique(fieldSpCorrSessNonStimGood.indNeuron));
            else
                numField = [];
            end                
            if(~isempty(numField))
                nFieldArr = numField * ones(1,sum(indNeu));
            end
        end
        modInt.nNeuWithFieldAlignedAll = [modInt.nNeuWithFieldAlignedAll nFieldArr];
        modInt.nNeuWithFieldAligned = [modInt.nNeuWithFieldAligned sum(indNeuWithField(indNeuP))*ones(1,sum(indNeu))];
        
        numSpPerBurst = zeros(1,nNeurons);
        for m = 1:nNeurons
            if(~isempty(burstIsi.numSpPerBurst{m}))
                numSpPerBurst(m) = mean(burstIsi.numSpPerBurst{m});
            end
        end
        modInt.fractBurst = [modInt.fractBurst burstIsi.fractBurst(indNeu)];
        modInt.numSpPerBurstMean = [modInt.numSpPerBurstMean numSpPerBurst(indNeu)]; 
        modInt.burstMeanDire = [modInt.burstMeanDire burstIsi.meanDire(indNeu)];        
        modInt.burstMeanResultantLen = [modInt.burstMeanResultantLen burstIsi.meanResultantLen(indNeu)];
        
        modInt.nonBurstMeanDire = [modInt.nonBurstMeanDire burstIsi.meanDireNonBurst(indNeu)];
        modInt.nonBurstMeanResultantLen = [modInt.nonBurstMeanResultantLen burstIsi.meanResultantLenNonBurst(indNeu)];
        
        modInt.burstMeanDireStart = [modInt.burstMeanDireStart burstIsi.meanDireStart(indNeu)];        
        modInt.burstMeanResultantLenStart = [modInt.burstMeanResultantLenStart burstIsi.meanResultantLenStart(indNeu)];
        
        modInt.minPhaseFil = [modInt.minPhaseFil spikeThetaPhase.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFil = [modInt.maxPhaseFil spikeThetaPhase.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDire = [modInt.phaseMeanDire spikeThetaPhase.meanDire(indNeu)];
        modInt.phaseMeanResultantLen = [modInt.phaseMeanResultantLen spikeThetaPhase.meanResultantLen(indNeu)];
        modInt.thetaModHist = [modInt.thetaModHist spikeThetaPhase.thetaMod(indNeu)]; 
        
        modInt.minPhaseFilH = [modInt.minPhaseFilH spikeThetaPhaseH.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFilH = [modInt.maxPhaseFilH spikeThetaPhaseH.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDireH = [modInt.phaseMeanDireH spikeThetaPhaseH.meanDire(indNeu)];
        modInt.phaseMeanResultantLenH = [modInt.phaseMeanResultantLenH spikeThetaPhaseH.meanResultantLen(indNeu)];
        modInt.thetaModHistH = [modInt.thetaModHistH spikeThetaPhaseH.thetaMod(indNeu)]; 
    end
    
    indDire = find(modInt.burstMeanDire < 0);
    modInt.burstMeanDire(indDire) = modInt.burstMeanDire(indDire) + 2*pi;
    
    indDire = find(modInt.nonBurstMeanDire < 0);
    modInt.nonBurstMeanDire(indDire) = modInt.nonBurstMeanDire(indDire) + 2*pi;
    
    indDire = find(modInt.burstMeanDireStart < 0);
    modInt.burstMeanDireStart(indDire) = modInt.burstMeanDireStart(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDire < 0);
    modInt.phaseMeanDire(indDire) = modInt.phaseMeanDire(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDireH < 0);
    modInt.phaseMeanDireH(indDire) = modInt.phaseMeanDireH(indDire) + 2*pi;
end