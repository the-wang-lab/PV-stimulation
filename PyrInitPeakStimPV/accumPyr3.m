function modPyr1 = accumPyr3(paths,filenames,mazeSess,autoCorrPyrAll,...
            nNeuWithFieldAligned,isNeuWithFieldAligned,...
            anmNoInact,anmNoAct,minFR,maxFR,task,sampleFq,intervalT)
    numRec = size(paths,1);
    modPyr1 = struct('actOrInact',[],... % is it activation or inactivation
                              'task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices trials
                              'pulseMeth',[], ... % pulse method
                              'stimLoc',[],... % stimulation location on the track
                              ...
                              'idxC1',[],...  % cluster no. Good trials
                              'idxC2',[],...  % cluster no. Good trials
                              'idxC3',[],...  % cluster no. Good trials
                              ...
                              'thetaFreqHMeanGoodNonStim',[],... % theta frequency hilbert
                              'thetaFreqHMeanStim',[],... % theta frequency hilbert
                              'thetaFreqHMeanStimCtrl',[],... % theta frequency hilbert
                              ...
                              'thetaModGoodNonStim',[],... % theta modulation
                              'thetaModStim',[],... % theta modulation
                              'thetaModStimCtrl',[],... % theta modulation
                              ...
                              'thetaModIndGoodNonStim',[],... % theta modulation index
                              'thetaModIndStim',[],... % theta modulation index
                              'thetaModIndStimCtrl',[],... % theta modulation index
                              ...
                              'thetaModInd3GoodNonStim',[],... % theta modulation index (method 3)
                              'thetaModInd3Stim',[],... % theta modulation index (method 3)
                              'thetaModInd3StimCtrl',[],... % theta modulation index (method 3)
                              ...
                              'thetaAsym3GoodNonStim',[],... % theta asymmetry (method 3)
                              'thetaAsym3Stim',[],... % theta asymmetry (method 3)
                              'thetaAsym3StimCtrl',[],... % theta asymmetry (method 3)
                              ...
                              'thetaModFreq3GoodNonStim',[],... % theta modulation frequency (method 3)
                              'thetaModFreq3Stim',[],... % theta modulation frequency (method 3)
                              'thetaModFreq3StimCtrl',[],... % theta modulation frequency (method 3)
                              ...
                              'meanNZGoodNonStim',[],... % mean corrT non zero trials 
                              'meanNZStim',[],... % mean corrT non zero trials 
                              'meanNZStimCtrl',[],... % mean corrT non zero trials 
                              ...
                              'relDepthNeuHDef',[],... % depth
                              'nNeuWithFieldAligned',[],... % number of neurons with fields after aligning to run onset
                              'nNeuWithFieldAlignedGoodNonStim',[],... % number of neurons with fields after aligning to run onset, non-stim good
                              'nNeuWithFieldAlignedStim',[],... % number of neurons with fields after aligning to run onset, stim trials
                              'nNeuWithFieldAlignedStimCtrl',[],... % number of neurons with fields after aligning to run onset, stim ctrl trials
                              'isNeuWithFieldAligned',[],... % whether this neuron has a field
                              'isNeuWithFieldAlignedGoodNonStim',[],... % whether this neuron has a field, good non-stim trials
                              'isNeuWithFieldAlignedStim',[],... % whether this neuron has a field, stim trials
                              'isNeuWithFieldAlignedStimCtrl',[],... % whether this neuron has a field, stim ctrl trials
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile good trials
                              'avgFRProfileStim',[],... % average firing rate profile stim trials
                              'avgFRProfileStimCtrl',[],... % average firing rate profile stim ctrl trials
                              ...
                              'nNeuPerRec',[],... % number of pyramidal neurons per recording
                              'nNeuWithFieldAlignedPerRec',[],... % number of field for each recording after aligning to run onset
                              'nNeuWithFieldAlignedPerRecGoodNonStim',[],... % number of field for each recording after aligning to run onset, good non-stim 
                              'nNeuWithFieldAlignedPerRecStim',[],... % number of field for each recording after aligning to run onset, stim trials
                              'nNeuWithFieldAlignedPerRecStimCtrl',[],... % number of field for each recording after aligning to run onset, stim ctrl trials
                              'taskPerRec',[],...
                              'indRecPerRec',[],...
                              'actOrInactPerRec',[],...
                              'pulseMethPerRec',[],...
                              'stimLocPerRec',[]);

    totRec = 0;
    for i = 1:numRec
        actOrInact = 0;
        anmNo = str2num(filenames(i,2:4));
        % does the recording belong to inactivation
        indTmp = find(anmNoInact == anmNo);
        if(~isempty(indTmp))
            actOrInact = 1;
        end
        % does the recording belong to activation
        indTmp1 = find(anmNoAct == anmNo);
        if(~isempty(indTmp1))
            actOrInact = 2;
        end
        % continue if the recording is not an activation or inactivation
        % recording
        if(isempty(indTmp) && isempty(indTmp1))
            continue;
        end
        
        indTmp = strfind(filenames(i,:),'_');
        fullPath = [paths(i,:) filenames(i,1:indTmp(1)-1) 'BTDT.mat'];
        if(exist(fullPath) == 0)
            disp(['File ' filenames(i,1:indTmp(1)-1) 'BTDT.mat does not exist.']);
            return;
        end
        load(fullPath,'behEventsTdt');
        stimLoc = zeros(1,length(behEventsTdt.movieTDescr));
        for j = 1:length(behEventsTdt.movieTDescr)
            stimLoc(j) = behEventsTdt.movieTDescr{j}(9);
        end
        stimLocTmp = unique(stimLoc);
        stimLocTmp = stimLocTmp(find(stimLocTmp ~= 0,1,'last'));
        
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
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct','pFRStimStruct','pFRStimCtrlStruct');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoStim','trialNoStimCtrl','pulseMeth');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'timeStepRun');
        
        fullPathFR = [filenames(i,:) '_FR_Run1.mat'];
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
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAligned" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood'); 
        fieldSpCorrSessAll = fieldSpCorrSessNonStimGood;
        
        fileNameFWStim = [filenames(i,:) '_FieldSpCorrAlignedStim_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFWStim];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAlignedStim" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood','fieldSpCorrSessStim','fieldSpCorrSessStimCtrl','paramF'); 
        
        fileNameThetaMod = [filenames(i,:) '_ThetaModAlignedRun_msess' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameThetaMod];
        if(exist(fullPath) == 0)
            disp('_ThetaModAlignedRun file does not exist.');
            return;
        end
        load(fullPath,'thetaModNonStimGood','thetaModStim','thetaModStimCtrl');
        
        fileNameCorr = [filenames(i,:) '_meanSpikesCorrTAlignedStim_msess' num2str(mazeSess(i)) '_Run1_intT' ...
            num2str(intervalT) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_meanSpikesCorrTAlignedStim file does not exist.');
            return;
        end
        load(fullPath,'meanCorrTRun');
        
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        
        indTmp = find(autoCorrPyrAll.task == task & autoCorrPyrAll.indRec == i);
        if(length(indTmp) ~= sum(indNeu))
            disp(['the number of neurons in recording task = ' num2str(task) ' rec. no. = ' num2str(i)...
                    'does not match that in the autoCorrPyrAll struct.']);
        end
        
        if(length(pFRNonStimGoodStruct.indLapList) < paramF.minNumTr)
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimGoodStruct.indLapList)) ...
                ' good trials.']);
            disp(['No. pyramidal neurons in this recording is ' num2str(sum(indNeu))]);
            
            continue;
        end
        
        for n = 1:length(pulseMeth)
            disp(['Pulse method = ' num2str(pulseMeth(n))]);
            if(pulseMeth(n) ~= 2 && pulseMeth(n) ~= 3 && pulseMeth(n) ~= 4) % check the pulse method number
                disp(['Wrong pulse method = ' num2str(pulseMeth(n)), ' continue ...']);
                continue;
            end
            %% added on 7/30/2022
            if(length(pFRStimStruct{n}.indLapList) < paramF.minNumTr)
                disp([filenames(i,:) ' only has ' num2str(length(pFRStimStruct{n}.indLapList)) ...
                    ' stim trials for pulse method' num2str(pulseMeth(n)) '.']);
                continue;
            end
            %%
            totRec = totRec+ 1;
            modPyr1.taskPerRec(totRec) = task;
            modPyr1.actOrInactPerRec(totRec) = actOrInact;
            modPyr1.pulseMethPerRec(totRec) = pulseMeth(n);
            if(pulseMeth(n) ~= 3)
               modPyr1.stimLocPerRec(totRec) = 0;
            else
               modPyr1.stimLocPerRec(totRec) = stimLocTmp; 
            end
            modPyr1.indRecPerRec(totRec) = i;            
            modPyr1.task = [modPyr1.task task*ones(1,sum(indNeu))];
            modPyr1.indRec = [modPyr1.indRec i*ones(1,sum(indNeu))];
            modPyr1.indNeu = [modPyr1.indNeu find(indNeu == 1)]; 
            modPyr1.actOrInact = [modPyr1.actOrInact actOrInact*ones(1,sum(indNeu))];
            modPyr1.pulseMeth = [modPyr1.pulseMeth pulseMeth(n)*ones(1,sum(indNeu))];
            modPyr1.stimLoc = [modPyr1.stimLoc modPyr1.stimLocPerRec(totRec)*ones(1,sum(indNeu))];
            modPyr1.avgFRProfile = [modPyr1.avgFRProfile; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
            modPyr1.avgFRProfileStim = [modPyr1.avgFRProfileStim; pFRStimStruct{n}.avgFRProfile(indNeu,:)];
            modPyr1.avgFRProfileStimCtrl = [modPyr1.avgFRProfileStimCtrl; pFRStimCtrlStruct{n}.avgFRProfile(indNeu,:)];
            
            %% added on 7/14/2022
            modPyr1.thetaFreqHMeanGoodNonStim = [modPyr1.thetaFreqHMeanGoodNonStim mean(beh.thetaFreqHMean(trialNoNonStimGood))*ones(1,sum(indNeu))];
            modPyr1.thetaFreqHMeanStim = [modPyr1.thetaFreqHMeanStim mean(beh.thetaFreqHMean(trialNoStim{n}))*ones(1,sum(indNeu))];
            modPyr1.thetaFreqHMeanStimCtrl = [modPyr1.thetaFreqHMeanStimCtrl mean(beh.thetaFreqHMean(trialNoStimCtrl{n}))*ones(1,sum(indNeu))];
                
            modPyr1.thetaModGoodNonStim = [modPyr1.thetaModGoodNonStim thetaModNonStimGood.thetaMod(indNeu)];
            modPyr1.thetaModStim = [modPyr1.thetaModStim thetaModStim{n}.thetaMod(indNeu)];
            modPyr1.thetaModStimCtrl = [modPyr1.thetaModStimCtrl thetaModStimCtrl{n}.thetaMod(indNeu)];
            
            modPyr1.thetaModIndGoodNonStim = [modPyr1.thetaModIndGoodNonStim thetaModNonStimGood.thetaModInd(indNeu)];
            modPyr1.thetaModIndStim = [modPyr1.thetaModIndStim thetaModStim{n}.thetaModInd(indNeu)];
            modPyr1.thetaModIndStimCtrl = [modPyr1.thetaModIndStimCtrl thetaModStimCtrl{n}.thetaModInd(indNeu)];
            
            modPyr1.thetaAsym3GoodNonStim = [modPyr1.thetaAsym3GoodNonStim ...
                (abs(thetaModNonStimGood.peakT3(indNeu))-abs(thetaModNonStimGood.troughT3(indNeu)))./...
                (abs(thetaModNonStimGood.peakT3(indNeu)))];
            modPyr1.thetaAsym3Stim = [modPyr1.thetaAsym3Stim ...
                (abs(thetaModStim{n}.peakT3(indNeu))-abs(thetaModStim{n}.troughT3(indNeu)))./...
                (abs(thetaModStim{n}.peakT3(indNeu)))];
            modPyr1.thetaAsym3StimCtrl = [modPyr1.thetaAsym3StimCtrl ...
                (abs(thetaModStimCtrl{n}.peakT3(indNeu))-abs(thetaModStimCtrl{n}.troughT3(indNeu)))./...
                (abs(thetaModStimCtrl{n}.peakT3(indNeu)))];
            
            modPyr1.thetaModFreq3GoodNonStim = [modPyr1.thetaModFreq3GoodNonStim ...
                1000./(abs(thetaModNonStimGood.peakT3(indNeu)))];
            modPyr1.thetaModFreq3Stim = [modPyr1.thetaModFreq3Stim ...
                1000./(abs(thetaModStim{n}.peakT3(indNeu)))];
            modPyr1.thetaModFreq3StimCtrl = [modPyr1.thetaModFreq3StimCtrl ...
                1000./(abs(thetaModStimCtrl{n}.peakT3(indNeu)))];
            
            modPyr1.thetaModInd3GoodNonStim = [modPyr1.thetaModInd3GoodNonStim thetaModNonStimGood.thetaModInd3(indNeu)];
            modPyr1.thetaModInd3Stim = [modPyr1.thetaModInd3Stim thetaModStim{n}.thetaModInd3(indNeu)];
            modPyr1.thetaModInd3StimCtrl = [modPyr1.thetaModInd3StimCtrl thetaModStimCtrl{n}.thetaModInd3(indNeu)];
            %%
            
            %% added on 8/14/2022
            modPyr1.meanNZGoodNonStim = [modPyr1.meanNZGoodNonStim meanCorrTRun.meanNZNonStimGood(indNeu)];
            modPyr1.meanNZStim = [modPyr1.meanNZStim meanCorrTRun.meanNZStim(n,indNeu)];
            modPyr1.meanNZStimCtrl = [modPyr1.meanNZStimCtrl meanCorrTRun.meanNZStimCtrl(n,indNeu)];
            %%
            
            if(length(indTmp) == sum(indNeu))
                modPyr1.idxC1 = [modPyr1.idxC1 autoCorrPyrAll.idxC1(indTmp)'];
                modPyr1.idxC2 = [modPyr1.idxC2 autoCorrPyrAll.idxC2(indTmp)'];
                modPyr1.idxC3 = [modPyr1.idxC3 autoCorrPyrAll.idxC3(indTmp)];
                modPyr1.relDepthNeuHDef = [modPyr1.relDepthNeuHDef autoCorrPyrAll.relDepthNeuHDef(indTmp)];
                modPyr1.nNeuPerRec(totRec) = sum(indNeu == 1);
                
                modPyr1.nNeuWithFieldAlignedPerRec(totRec) = unique(nNeuWithFieldAligned(indTmp));  
                modPyr1.nNeuWithFieldAligned = [modPyr1.nNeuWithFieldAligned nNeuWithFieldAligned(indTmp)];
                modPyr1.isNeuWithFieldAligned = [modPyr1.isNeuWithFieldAligned isNeuWithFieldAligned(indTmp)];
                
                nNeurons = length(cluList.firingRate);
                indNeuWithField = zeros(1,nNeurons);
                modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec) = 0;
                if(~isempty(fieldSpCorrSessNonStimGood))
                    [indNeuF,ia] = unique(fieldSpCorrSessNonStimGood.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec) = sum(indNeuWithField(indNeu));
                end
                modPyr1.nNeuWithFieldAlignedGoodNonStim = [modPyr1.nNeuWithFieldAlignedGoodNonStim...
                    modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedGoodNonStim = [modPyr1.isNeuWithFieldAlignedGoodNonStim...
                    indNeuWithField(indNeu)]; 
                
                modPyr1.nNeuWithFieldAlignedPerRecStim(totRec) = 0;
                indNeuWithField = zeros(1,nNeurons);
                if(~isempty(fieldSpCorrSessStim{n}))
                    [indNeuF,ia] = unique(fieldSpCorrSessStim{n}.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecStim(totRec) = sum(indNeuWithField(indNeu));
                end
                modPyr1.nNeuWithFieldAlignedStim = [modPyr1.nNeuWithFieldAlignedStim...
                    modPyr1.nNeuWithFieldAlignedPerRecStim(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedStim = [modPyr1.isNeuWithFieldAlignedStim...
                    indNeuWithField(indNeu)];                

                modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec) = 0;
                indNeuWithField = zeros(1,nNeurons);
                if(~isempty(fieldSpCorrSessStimCtrl{n}))
                    [indNeuF,ia] = unique(fieldSpCorrSessStimCtrl{n}.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec) = sum(indNeuWithField(indNeu));
                end
                modPyr1.nNeuWithFieldAlignedStimCtrl = [modPyr1.nNeuWithFieldAlignedStimCtrl...
                    modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedStimCtrl = [modPyr1.isNeuWithFieldAlignedStimCtrl...
                    indNeuWithField(indNeu)];
            end
       
        end
        modPyr1.timeStepRun = timeStepRun/sampleFq;
        
       
    end
end