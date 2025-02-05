function autoCorrPyr = accumPyrNeurons(paths,filenames,mazeSess,minFR,maxFR,task,methodTheta,onlyRun)
% accumulate the information about the pyramidal neuron properties for a
% particular taske
% This functions is called By PyrPropAllRec.m

    %% interneurons in no cue passive task
    numRec = size(paths,1);
    autoCorrPyr = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              'mean',[],... % mean of autocorrelogram
                              'peakAmp',[],... % peak amplitude of autocorrelogram
                              'peakTime',[],... % time of the peak of autocorrelogram
                              'peakToMean',[],... % peak to mean ratio of autocorrelogram
                              'peakTo40ms',[],... % peak to 20 ms ratio of autocorrelogram
                              'refract',[],... % refractory period
                              'relDepthNeuHDef',[],... % depth in the layer
                              'isSpikeHighAmp',[],... % whether the spike amplitude is large enough for layer detection
                              'isSpikeHighAmp200',[],... % whether the spike amplitude is large enough for layer detection - threshold -200uV
                              ...
                              'ccgVal',[], ... % autocorrelogram
                              ...
                              'shankID',[],...
                              'localClu',[],...
                              ...
                              'phaseMeanDire',[],... % the mean phase direction
                              'thetaModHist',[],... % theta modulation calculated based on theta phase
                              'maxPhaseArr',[],... % the phase which fires the largest number of spikes (based on filtered histogram)  
                              'minPhaseArr',[],... % the phase which fires the lowest number of spikes (based on filtered histogram) 
                              'maxPhaseOArr',[],... % the phase which fires the largest number of spikes (based on original histogram) 
                              'minPhaseOArr',[],... % the phase which fires the lowest number of spikes (based on original histogram)
                              'histPhaseFil',[],... % filtered theta phase histogram
                              'histPhase',[],... % theta phase histogram
                              ...
                              'burstInd',[],... % burst index
                              'realMean',[],... % mean of autocorrelogram
                              'realPeakAmp',[],... % peak amplitude of autocorrelogram
                              'realPeakTime',[],... % time of the peak of autocorrelogram
                              'realPeakToMean',[],... % peak to mean ratio of autocorrelogram
                              'realPeakTo40ms',[]); % peak to 20 ms ratio of autocorrelogram
                          
    for i = 1:numRec
        disp(filenames(i,:));
        if(i == 17)
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
                
        indexFileName = strfind(filenames(i,:),'_');
        fileNameCCGT = [filenames(i,1:indexFileName(1)-1)...
                            '_BehavElectrDataLFP_CCG.mat'];
        fullPath = [paths(i,:) fileNameCCGT];
        if(exist(fullPath) == 0)
            disp('_BehavElectrDataLFP_CCG.mat file does not exist.');
            return;
        end
        load(fullPath,'ccgVal','ccgT'); 
        
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
        
        if(methodTheta == 0)
            fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseH_Run' num2str(onlyRun) '.mat'];
        else
            fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseL_Run' num2str(onlyRun) '.mat'];
        end
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhase file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseStruct','spikeThetaPhaseStructSess');
        if(length(beh.mazeSessAll) > 1)
            spikeThetaPhase = spikeThetaPhaseStructSess{mazeSess(i)};
        else
            spikeThetaPhase = spikeThetaPhaseStruct;
        end
                       
%         indNeu = cluList.firingRate > minFR & cluList.firingRate < maxFR &...
%                     autoCorr.isPyrneuron == 1;
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        neu = find(indNeu == 1);
        indCCG = find(abs(ccgT) <= 50);
        for n = 1:length(neu)
            if(isempty(autoCorrPyr.ccgVal))
                autoCorrPyr.ccgVal = squeeze(ccgVal(indCCG,neu(n),neu(n)))';
            else
                autoCorrPyr.ccgVal = [autoCorrPyr.ccgVal; squeeze(ccgVal(indCCG,neu(n),neu(n)))'];
            end
        end
        autoCorrPyr.task = [autoCorrPyr.task task*ones(1,sum(indNeu))];
        autoCorrPyr.indRec = [autoCorrPyr.indRec i*ones(1,sum(indNeu))];
        autoCorrPyr.indNeu = [autoCorrPyr.indNeu neu];
        autoCorrPyr.mean = [autoCorrPyr.mean autoCorr.mean(indNeu)];
        autoCorrPyr.peakAmp = [autoCorrPyr.peakAmp autoCorr.peakAmp(indNeu)];
        autoCorrPyr.peakTime = [autoCorrPyr.peakTime autoCorr.peakTime(indNeu)];
        autoCorrPyr.peakToMean = [autoCorrPyr.peakToMean autoCorr.peakToMean(indNeu)];
        autoCorrPyr.peakTo40ms = [autoCorrPyr.peakTo40ms autoCorr.peakTo40ms(indNeu)];        
        autoCorrPyr.refract = [autoCorrPyr.refract autoCorr.refract(indNeu)];
        autoCorrPyr.relDepthNeuHDef = [autoCorrPyr.relDepthNeuHDef autoCorr.relDepthNeuHDef(indNeu)];
        autoCorrPyr.isSpikeHighAmp = [autoCorrPyr.isSpikeHighAmp autoCorr.isSpikeHighAmp(indNeu)];
        autoCorrPyr.isSpikeHighAmp200 = [autoCorrPyr.isSpikeHighAmp200 autoCorr.isSpikeHighAmp200(indNeu)];
        
        autoCorrPyr.shankID = [autoCorrPyr.shankID cluList.shank(indNeu)];
        autoCorrPyr.localClu = [autoCorrPyr.localClu cluList.localClu(indNeu)];
                
        autoCorrPyr.phaseMeanDire = [autoCorrPyr.phaseMeanDire spikeThetaPhase.meanDire(indNeu)];
        autoCorrPyr.thetaModHist = [autoCorrPyr.thetaModHist spikeThetaPhase.thetaMod(indNeu)];
        autoCorrPyr.maxPhaseArr = [autoCorrPyr.maxPhaseArr spikeThetaPhase.maxPhaseFilArr(indNeu)];
        autoCorrPyr.minPhaseArr = [autoCorrPyr.minPhaseArr spikeThetaPhase.minPhaseFilArr(indNeu)];
        autoCorrPyr.maxPhaseOArr = [autoCorrPyr.maxPhaseOArr spikeThetaPhase.maxPhaseArr(indNeu)];
        autoCorrPyr.minPhaseOArr = [autoCorrPyr.minPhaseOArr spikeThetaPhase.minPhaseArr(indNeu)];
        
        for n = 1:length(neu)
            if(isempty(autoCorrPyr.histPhaseFil))
                autoCorrPyr.histPhaseFil = spikeThetaPhase.histPhaseFilPerNeuron{neu(n)};
                autoCorrPyr.histPhase = spikeThetaPhase.histPhasePerNeuron{neu(n)};
            else
                autoCorrPyr.histPhaseFil = [autoCorrPyr.histPhaseFil; spikeThetaPhase.histPhaseFilPerNeuron{neu(n)}];
                autoCorrPyr.histPhase = [autoCorrPyr.histPhase; spikeThetaPhase.histPhasePerNeuron{neu(n)}];
            end
        end  
        
        autoCorrPyr.burstInd = [autoCorrPyr.burstInd autoCorr.burstInd(indNeu)];
        autoCorrPyr.realMean = [autoCorrPyr.realMean autoCorr.realMean(indNeu)];
        autoCorrPyr.realPeakAmp = [autoCorrPyr.realPeakAmp autoCorr.realPeakAmp(indNeu)];
        autoCorrPyr.realPeakTime = [autoCorrPyr.realPeakTime autoCorr.realPeakTime(indNeu)];
        autoCorrPyr.realPeakToMean = [autoCorrPyr.realPeakToMean autoCorr.realPeakToMean(indNeu)];
        autoCorrPyr.realPeakTo40ms = [autoCorrPyr.realPeakTo40ms autoCorr.realPeakTo40ms(indNeu)];
    end
    
    indDire = find(autoCorrPyr.phaseMeanDire < 0);
    autoCorrPyr.phaseMeanDire(indDire) = autoCorrPyr.phaseMeanDire(indDire) + 2*pi;
end
