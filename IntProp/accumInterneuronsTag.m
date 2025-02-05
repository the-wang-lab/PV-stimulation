function autoCorrInt = accumInterneuronsTag(paths,filenames,mazeSess,minFRInt,tasks,indRecs,cellType,methodTheta,onlyRun)

    %% interneurons in no cue passive task
    numRec = size(paths,1);
    autoCorrInt = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'cellType',[],... % cell type PV -- 1, SST -- 2
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
                              ...
                              'ccgVal',[], ... % autocorrelogram
                              ...
                              'phaseMeanDire',[],... % the mean phase direction
                              'thetaModHist',[],... % theta modulation calculated based on theta phase
                              'maxPhaseArr',[],... % the phase which fires the largest number of spikes (based on filtered histogram) 
                              'minPhaseArr',[],... % the phase which fires the lowest number of spikes (based on filtered histogram)
                              'maxPhaseOArr',[],... % the phase which fires the largest number of spikes (based on original histogram) 
                              'minPhaseOArr',[],... % the phase which fires the lowest number of spikes (based on original histogram)
                              ...
                              'burstInd',[],... % burst index
                              'realMean',[],... % mean of autocorrelogram
                              'realPeakAmp',[],... % peak amplitude of autocorrelogram
                              'realPeakTime',[],... % time of the peak of autocorrelogram
                              'realPeakToMean',[],... % peak to mean ratio of autocorrelogram
                              'realPeakTo40ms',[]); % peak to 20 ms ratio of autocorrelogram
                          
    for i = 1:numRec
        if(i == 19)
            a = 1;
        end
        disp(filenames(i,:));
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
        
        fileNameInfo = [filenames(i,:) '_StimEff.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_StimEff.mat file does not exist.');
            continue;
        end
        load(fullPath,'stimResp'); 
        
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
        
%         indNeu = autoCorr.isInterneuron == 1 & cluList.firingRate > minFRInt & stimResp.tagged == 1;
        indNeu = mFR.mFR > minFRInt & stimResp.tagged == 1 &...
                    autoCorr.isInterneuron == 1;
        indCCG = find(abs(ccgT) <= 50);
        neu = find(indNeu == 1);
        for n = 1:length(neu)
            if(isempty(autoCorrInt.ccgVal))
                autoCorrInt.ccgVal = squeeze(ccgVal(indCCG,neu(n),neu(n)))';
            else
                autoCorrInt.ccgVal = [autoCorrInt.ccgVal; squeeze(ccgVal(indCCG,neu(n),neu(n)))'];
            end
        end
        autoCorrInt.task = [autoCorrInt.task tasks(i)*ones(1,sum(indNeu))];
        autoCorrInt.cellType = [autoCorrInt.cellType cellType(i)*ones(1,sum(indNeu))];
        autoCorrInt.indRec = [autoCorrInt.indRec indRecs(i)*ones(1,sum(indNeu))];
        autoCorrInt.indNeu = [autoCorrInt.indNeu find(indNeu == 1)];
        autoCorrInt.mean = [autoCorrInt.mean autoCorr.mean(indNeu)];
        autoCorrInt.peakAmp = [autoCorrInt.peakAmp autoCorr.peakAmp(indNeu)];
        autoCorrInt.peakTime = [autoCorrInt.peakTime autoCorr.peakTime(indNeu)];
        autoCorrInt.peakToMean = [autoCorrInt.peakToMean autoCorr.peakToMean(indNeu)];
        autoCorrInt.peakTo40ms = [autoCorrInt.peakTo40ms autoCorr.peakTo40ms(indNeu)];        
        autoCorrInt.refract = [autoCorrInt.refract autoCorr.refract(indNeu)];
        autoCorrInt.relDepthNeuHDef = [autoCorrInt.relDepthNeuHDef autoCorr.relDepthNeuHDef(indNeu)];
        autoCorrInt.isSpikeHighAmp = [autoCorrInt.isSpikeHighAmp autoCorr.isSpikeHighAmp(indNeu)];

        autoCorrInt.phaseMeanDire = [autoCorrInt.phaseMeanDire spikeThetaPhase.meanDire(indNeu)];
        autoCorrInt.thetaModHist = [autoCorrInt.thetaModHist spikeThetaPhase.thetaMod(indNeu)];
        autoCorrInt.maxPhaseArr = [autoCorrInt.maxPhaseArr spikeThetaPhase.maxPhaseFilArr(indNeu)];
        autoCorrInt.minPhaseArr = [autoCorrInt.minPhaseArr spikeThetaPhase.minPhaseFilArr(indNeu)];
        autoCorrInt.maxPhaseOArr = [autoCorrInt.maxPhaseOArr spikeThetaPhase.maxPhaseArr(indNeu)];
        autoCorrInt.minPhaseOArr = [autoCorrInt.minPhaseOArr spikeThetaPhase.minPhaseArr(indNeu)];
    
        autoCorrInt.burstInd = [autoCorrInt.burstInd autoCorr.burstInd(indNeu)];
        autoCorrInt.realMean = [autoCorrInt.realMean autoCorr.realMean(indNeu)];
        autoCorrInt.realPeakAmp = [autoCorrInt.realPeakAmp autoCorr.realPeakAmp(indNeu)];
        autoCorrInt.realPeakTime = [autoCorrInt.realPeakTime autoCorr.realPeakTime(indNeu)];
        autoCorrInt.realPeakToMean = [autoCorrInt.realPeakToMean autoCorr.realPeakToMean(indNeu)];
        autoCorrInt.realPeakTo40ms = [autoCorrInt.realPeakTo40ms autoCorr.realPeakTo40ms(indNeu)];
        
    end
    
    indDire = find(autoCorrInt.phaseMeanDire < 0);
    autoCorrInt.phaseMeanDire(indDire) = autoCorrInt.phaseMeanDire(indDire) + 2*pi;
end


