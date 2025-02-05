function modPyr2 = accumPyrInitSpeed(paths,filenames,mazeSess,minFR,maxFR,task,sampleFq,nSampBef)
    numRec = size(paths,1);
    modPyr2 = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              ...
                              'timeStepRun',[],...                              
                              'timeStepRunSpeed',[]);
                             
    totExcNeu = 0;
    curNoNeu = 1;
    curNoNeuBad = 1;
    for i = 1:numRec
        disp(i);
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
        
        fileNameBeh = [filenames(i,:) '_behPar_msess' num2str(mazeSess(i)) '.mat'];
        fullPath = [paths(i,:) fileNameBeh];
        if(exist(fullPath) == 0)
            disp('_behPar.mat file does not exist.');
            return;
        end
        load(fullPath,'behPar');
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct','pFRNonStimBadStruct');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run0.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'timeStepRun');
        
        fileNameThetaPh = [filenames(i,:) '_thetaPhaseOverTimeligned_msess' num2str(mazeSess(i)) '_Run0.mat'];
        fullPath = [paths(i,:) fileNameThetaPh];
        if(exist(fullPath) == 0)
            disp(['The thetaPhaseOverTimeligned file does not exist. Please call ',...
                    'function "thetaPhaseOverTimeAligned" first.']);
            return;
        end
        load(fullPath,'runSpeedNonStimGood','runSpeedNonStimBad','paramC');
        
        fileNameFR = [filenames(i,:) '_FR_Run1.mat'];
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
        
        fileNameFW = [filenames(i,:) '_FieldSpCorr_GoodTr_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
                       
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
                
        if(length(pFRNonStimGoodStruct.indLapList) >= paramF.minNumTr)
            modPyr2.task = [modPyr2.task task*ones(1,sum(indNeu))];
            modPyr2.indRec = [modPyr2.indRec i*ones(1,sum(indNeu))];
            indNeu1 = find(indNeu == 1);
            modPyr2.indNeu = [modPyr2.indNeu indNeu1]; 
        
            modPyr2.timeStepRun = timeStepRun/sampleFq;  
            modPyr2.timeStepRunSpeed = paramC.timeIncBef;
            
            for j = 1:length(indNeu1)           
                timeStep = modPyr2.timeStepRun; 
                indLapsGood = pFRNonStimGoodStruct.indLapList~=1;
                filteredSpArr = pFRNonStimGoodStruct.filteredSpArrAll{indNeu1(j)}(indLapsGood,:);
                trialNoGood = trialNoNonStimGood(trialNoNonStimGood~=1);
                stopTimePerTrGood = behPar.rewardToRun(trialNoGood)';
                meanInstFRTrGood = mean(filteredSpArr,2);
                indFRBaseline = find(timeStep >= -3 & timeStep < -2);
                meanInstFRBLTrGood = mean(filteredSpArr(:,indFRBaseline),2);
                indFRBefRun = find(timeStep >= -1.5 & timeStep < -0.5);
                meanInstFRBefRunTrGood = mean(filteredSpArr(:,indFRBefRun),2);
                indFRBefRun0p5to0 = find(timeStep >= -0.5 & timeStep < 0);
                meanInstFRBefRun0p5to0TrGood = mean(filteredSpArr(:,indFRBefRun0p5to0),2);
                indFR0to1 = find(timeStep >= 0.5 & timeStep < 1.5);
                meanInstFR0to1TrGood = mean(filteredSpArr(:,indFR0to1),2);
                indFR3to5 = find(timeStep >= 3 & timeStep < 5);
                meanInstFR3to5TrGood = mean(filteredSpArr(:,indFR3to5),2);

                timeStep = modPyr2.timeStepRunSpeed;
                runSpeedNonStimGood1 = runSpeedNonStimGood(indLapsGood,:);
                meanRunSpeedTrGood = mean(runSpeedNonStimGood1(:,nSampBef+1:end),2);
                indFRBaseline = find(timeStep >= -3 & timeStep < -2);
                meanRunSpeedBLTrGood = mean(runSpeedNonStimGood1(:,indFRBaseline),2);
                indFRBefRun = find(timeStep >= -1.5 & timeStep < -0.5);
                meanRunSpeedBefRunTrGood = mean(runSpeedNonStimGood1(:,indFRBefRun),2);
                indFRBefRun0p5to0 = find(timeStep >= -0.5 & timeStep < 0);
                meanRunSpeedBefRun0p5to0TrGood = mean(runSpeedNonStimGood1(:,indFRBefRun0p5to0),2);
                indFR0to1 = find(timeStep >= 0.5 & timeStep < 1.5);
                meanRunSpeed0to1TrGood = mean(runSpeedNonStimGood1(:,indFR0to1),2);
                indFR3to5 = find(timeStep >= 3 & timeStep < 5);
                meanRunSpeed3to5TrGood = mean(runSpeedNonStimGood1(:,indFR3to5),2);
                
                %% added on 9/25/2022
                modPyr2.meanRunSpeedTrGood(curNoNeu) = mean(meanRunSpeedTrGood);
                modPyr2.meanRunSpeedBLTrGood(curNoNeu) = mean(meanRunSpeedBLTrGood);
                modPyr2.meanRunSpeedBefRunTrGood(curNoNeu) = mean(meanRunSpeedBefRunTrGood);
                modPyr2.meanRunSpeedBefRun0p5to0TrGood(curNoNeu) = mean(meanRunSpeedBefRun0p5to0TrGood);
                modPyr2.meanRunSpeed0to1TrGood(curNoNeu) = mean(meanRunSpeed0to1TrGood);
                modPyr2.meanRunSpeed3to5TrGood(curNoNeu) = mean(meanRunSpeed3to5TrGood);
                %%
                
                [modPyr2.corrStopTimeRunSpeedGood(curNoNeu),modPyr2.pCorrStopTimeRunSpeedGood(curNoNeu)] = ...
                    corr(stopTimePerTrGood,meanRunSpeedTrGood);
                [modPyr2.corrStopTimeRunSpeed0to1Good(curNoNeu),modPyr2.pCorrStopTimeRunSpeed0to1Good(curNoNeu)] = ...
                    corr(stopTimePerTrGood,meanRunSpeed0to1TrGood);
                [modPyr2.corrStopTimeRunSpeed3to5Good(curNoNeu),modPyr2.pCorrStopTimeRunSpeed3to5Good(curNoNeu)] = ...
                    corr(stopTimePerTrGood,meanRunSpeed3to5TrGood);
                [modPyr2.corrStopTimeInstFRBefRunGood(curNoNeu),modPyr2.pCorrStopTimeInstFRBefRunGood(curNoNeu)] = ...
                    corr(stopTimePerTrGood,meanInstFRBefRunTrGood);
                [modPyr2.corrStopTimeInstFR0to1Good(curNoNeu),modPyr2.pCorrStopTimeInstFR0to1Good(curNoNeu)] = ...
                    corr(stopTimePerTrGood,meanInstFR0to1TrGood);

                [modPyr2.corrInstFRRunSpeedGood(curNoNeu),modPyr2.pCorrInstFRRunSpeedGood(curNoNeu)] = ...
                    corr(meanInstFRTrGood,meanRunSpeedTrGood);
                [modPyr2.corrInstFRRunSpeedBLGood(curNoNeu),modPyr2.pCorrInstFRRunSpeedBLGood(curNoNeu)] = ...
                    corr(meanRunSpeedBLTrGood,meanInstFRBLTrGood);
                [modPyr2.corrInstFRRunSpeedBefRunGood(curNoNeu),modPyr2.pCorrInstFRRunSpeedBefRunGood(curNoNeu)] = ...
                    corr(meanRunSpeedBefRunTrGood,meanInstFRBefRunTrGood);
                [modPyr2.corrInstFRRunSpeed0to1Good(curNoNeu),modPyr2.pCorrInstFRRunSpeed0to1Good(curNoNeu)] = ...
                    corr(meanRunSpeed0to1TrGood,meanInstFR0to1TrGood);
                [modPyr2.corrInstFRRunSpeed3to5Good(curNoNeu),modPyr2.pCorrInstFRRunSpeed3to5Good(curNoNeu)] = ...
                    corr(meanRunSpeed3to5TrGood,meanInstFR3to5TrGood);

                md = fitlm(meanRunSpeedTrGood,meanInstFRTrGood,'linear');
                modPyr2.lmSlopeInstFRRunSpeedGood(curNoNeu) = md.Coefficients.Estimate(2);
                modPyr2.lmPInstFRRunSpeedGood(curNoNeu) = md.Coefficients.pValue(2);
                modPyr2.lmRInstFRRunSpeedGood(curNoNeu) = md.Rsquared.Ordinary;

                md = fitlm(meanRunSpeedBefRunTrGood,meanInstFRBefRunTrGood,'linear');
                modPyr2.lmSlopeInstFRRunSpeedBefRunGood(curNoNeu) = md.Coefficients.Estimate(2);
                modPyr2.lmPInstFRRunSpeedBefRunGood(curNoNeu) = md.Coefficients.pValue(2);
                modPyr2.lmRInstFRRunSpeedBefRunGood(curNoNeu) = md.Rsquared.Ordinary;

                md = fitlm(meanRunSpeed0to1TrGood,meanInstFR0to1TrGood,'linear');
                modPyr2.lmSlopeInstFRRunSpeed0to1Good(curNoNeu) = md.Coefficients.Estimate(2);
                modPyr2.lmPInstFRRunSpeed0to1Good(curNoNeu) = md.Coefficients.pValue(2);
                modPyr2.lmRInstFRRunSpeed0to1Good(curNoNeu) = md.Rsquared.Ordinary;

                md = fitlm(meanRunSpeed3to5TrGood,meanInstFR3to5TrGood,'linear');
                modPyr2.lmSlopeInstFRRunSpeed3to5Good(curNoNeu) = md.Coefficients.Estimate(2);
                modPyr2.lmPInstFRRunSpeed3to5Good(curNoNeu) = md.Coefficients.pValue(2);
                modPyr2.lmRInstFRRunSpeed3to5Good(curNoNeu) = md.Rsquared.Ordinary;
                curNoNeu = curNoNeu+1;
            end
        else
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimGoodStruct.indLapList)) ...
                ' good trials.']);
            disp(['No. interneurons in this recording is ' num2str(sum(indNeu))]);
        end  

        if(~isempty(pFRNonStimBadStruct) && length(pFRNonStimBadStruct.indLapList) >= paramF.minNumTr)
            indNeu1 = find(indNeu == 1);
            for j = 1:length(indNeu1)
                
                timeStep = modPyr2.timeStepRun; 
                indLapsBad = pFRNonStimBadStruct.indLapList~=1;
                filteredSpArr = pFRNonStimBadStruct.filteredSpArrAll{indNeu1(j)}(indLapsBad,:);
                trialNoBad = trialNoNonStimBad(trialNoNonStimBad~=1);
                stopTimePerTrBad = behPar.rewardToRun(trialNoBad)';
                meanInstFRTrBad = mean(filteredSpArr,2);                    
                indFRBaseline = find(timeStep >= -3 & timeStep < -2);
                meanInstFRBLTrBad = mean(filteredSpArr(:,indFRBaseline),2);
                indFRBefRun = find(timeStep >= -1.5 & timeStep < -0.5);
                meanInstFRBefRunTrBad = mean(filteredSpArr(:,indFRBefRun),2);
                indFRBefRun0p5to0 = find(timeStep >= -0.5 & timeStep < 0);
                meanInstFRBefRun0p5to0TrBad = mean(filteredSpArr(:,indFRBefRun0p5to0),2);
                indFR0to1 = find(timeStep >= 0.5 & timeStep < 1.5);
                meanInstFR0to1TrBad = mean(filteredSpArr(:,indFR0to1),2);
                indFR3to5 = find(timeStep >= 3 & timeStep < 5);
                meanInstFR3to5TrBad = mean(filteredSpArr(:,indFR3to5),2);
                
                timeStep = modPyr2.timeStepRunSpeed;
                runSpeedNonStimBad1 = runSpeedNonStimBad(indLapsBad,:);
                meanRunSpeedTrBad = mean(runSpeedNonStimBad1(:,nSampBef+1:end),2);
                indFRBaseline = find(timeStep >= -3 & timeStep < -2);
                meanRunSpeedBLTrBad = mean(runSpeedNonStimBad1(:,indFRBaseline),2);
                indFRBefRun = find(timeStep >= -1.5 & timeStep < -0.5);
                meanRunSpeedBefRunTrBad = mean(runSpeedNonStimBad1(:,indFRBefRun),2);
                indFRBefRun0p5to0 = find(timeStep >= -0.5 & timeStep < 0);
                meanRunSpeedBefRun0p5to0TrBad = mean(runSpeedNonStimBad1(:,indFRBefRun0p5to0),2);
                indFR0to1 = find(timeStep >= 0.5 & timeStep < 1.5);
                meanRunSpeed0to1TrBad = mean(runSpeedNonStimBad1(:,indFR0to1),2);
                indFR3to5 = find(timeStep >= 3 & timeStep < 5);
                meanRunSpeed3to5TrBad = mean(runSpeedNonStimBad1(:,indFR3to5),2);
                
                %% added on 9/25/2022
                modPyr2.meanRunSpeedTrBad(curNoNeuBad) = mean(meanRunSpeedTrBad);
                modPyr2.meanRunSpeedBLTrBad(curNoNeuBad) = mean(meanRunSpeedBLTrBad);
                modPyr2.meanRunSpeedBefRunTrBad(curNoNeuBad) = mean(meanRunSpeedBefRunTrBad);
                modPyr2.meanRunSpeedBefRun0p5to0TrBad(curNoNeuBad) = mean(meanRunSpeedBefRun0p5to0TrBad);
                modPyr2.meanRunSpeed0to1TrBad(curNoNeuBad) = mean(meanRunSpeed0to1TrBad);
                modPyr2.meanRunSpeed3to5TrBad(curNoNeuBad) = mean(meanRunSpeed3to5TrBad);
                %%
                
                [modPyr2.corrStopTimeRunSpeedBad(curNoNeuBad),modPyr2.pCorrStopTimeRunSpeedBad(curNoNeuBad)] = ...
                    corr(stopTimePerTrBad,meanRunSpeedTrBad);
                [modPyr2.corrStopTimeRunSpeed0to1Bad(curNoNeuBad),modPyr2.pCorrStopTimeRunSpeed0to1Bad(curNoNeuBad)] = ...
                    corr(stopTimePerTrBad,meanRunSpeed0to1TrBad);
                [modPyr2.corrStopTimeRunSpeed3to5Bad(curNoNeuBad),modPyr2.pCorrStopTimeRunSpeed3to5Bad(curNoNeuBad)] = ...
                    corr(stopTimePerTrBad,meanRunSpeed3to5TrBad);
                [modPyr2.corrStopTimeInstFRBefRunBad(curNoNeuBad),modPyr2.pCorrStopTimeInstFRBefRunBad(curNoNeuBad)] = ...
                    corr(stopTimePerTrBad,meanInstFRBefRunTrBad);
                [modPyr2.corrStopTimeInstFR0to1Bad(curNoNeuBad),modPyr2.pCorrStopTimeInstFR0to1Bad(curNoNeuBad)] = ...
                    corr(stopTimePerTrBad,meanInstFR0to1TrBad);

                [modPyr2.corrInstFRRunSpeedBad(curNoNeuBad),modPyr2.pCorrInstFRRunSpeedBad(curNoNeuBad)] = ...
                    corr(meanInstFRTrBad,meanRunSpeedTrBad);
                [modPyr2.corrInstFRRunSpeedBLBad(curNoNeuBad),modPyr2.pCorrInstFRRunSpeedBLBad(curNoNeuBad)] = ...
                    corr(meanRunSpeedBLTrBad,meanInstFRBLTrBad);
                [modPyr2.corrInstFRRunSpeedBefRunBad(curNoNeuBad),modPyr2.pCorrInstFRRunSpeedBefRunBad(curNoNeuBad)] = ...
                    corr(meanRunSpeedBefRunTrBad,meanInstFRBefRunTrBad);
                [modPyr2.corrInstFRRunSpeed0to1Bad(curNoNeuBad),modPyr2.pCorrInstFRRunSpeed0to1Bad(curNoNeuBad)] = ...
                    corr(meanRunSpeed0to1TrBad,meanInstFR0to1TrBad);
                [modPyr2.corrInstFRRunSpeed3to5Bad(curNoNeuBad),modPyr2.pCorrInstFRRunSpeed3to5Bad(curNoNeuBad)] = ...
                    corr(meanRunSpeed3to5TrBad,meanInstFR3to5TrBad);
                
                curNoNeuBad = curNoNeuBad+1;
            end
        else
            totExcNeu = totExcNeu + sum(indNeu);
            if(isempty(pFRNonStimBadStruct))
                lenTr = 0;
            else
                lenTr = length(pFRNonStimBadStruct.indLapList);
            end
            disp([filenames(i,:) ' only has ' num2str(lenTr) ' bad trials.']);
            disp(['No. interneurons in this recording is ' num2str(sum(indNeu)) ...
                ', total number of excluded neurons is ' num2str(totExcNeu)]);
        end  
    end
end
