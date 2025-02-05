function modPyr1 = accumPyr3NoStim2ndStimCtrlGoodOnly(paths,filenames,mazeSess,autoCorrPyrAll,...
            nNeuWithFieldAligned,isNeuWithFieldAligned,...
            anmNoInact,anmNoAct,task,modPyr1SigAL,sampleFq,intervalT)
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
                              'meanNZNonStim',[],... corrT NZ (non stim and 2nd stim ctrl good trials)
                              'meanNZStim',[],... corrT NZ (good stim trials)
                              'meanNZStimCtrl',[],... corrT NZ (2nd stim ctrl good trials)
                              'meanNZStimNonStim',[],... corrT NZ (stim good trials vs (non stim and 2nd stim ctrl good trials) )
                              'meanNZStimStimCtrl',[],... corrT NZ (stim good trials vs (2nd stim ctrl good trials) )
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile good trials
                              'avgFRProfileStim',[],... % average firing rate profile stim trials
                              'avgFRProfileStimCtrl',[],... % average firing rate profile stim ctrl trials
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
                              'nNeuPerRec',[],... % number of pyramidal neurons per recording
                              'nNeuWithFieldAlignedPerRec',[],... % number of field for each recording after aligning to run onset
                              'nNeuWithFieldAlignedPerRecGoodNonStim',[],... % number of field for each recording after aligning to run onset, good non-stim 
                              'nNeuWithFieldAlignedPerRecStim',[],... % number of field for each recording after aligning to run onset, stim trials
                              'nNeuWithFieldAlignedPerRecStimCtrl',[],... % number of field for each recording after aligning to run onset, stim ctrl trials
                              'taskPerRec',[],...
                              'indRecPerRec',[],...
                              'actOrInactPerRec',[],...
                              'pulseMethPerRec',[],...
                              'stimLocPerRec',[],...
                              ...
                              'isPeakNeuArrAll',[]);

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
        load(fullPath,'beh'); 
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRStimStruct','pFRStimCtrlStruct');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'pulseMeth','trialNoStim');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'timeStepRun','filteredSpikeArrayRunOnSet');
                      
        fileNameFWStim = [filenames(i,:) '_FieldSpCorrAlignedStim_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFWStim];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAlignedStim" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood','fieldSpCorrSessStim','fieldSpCorrSessStimCtrl','paramF'); 
        
        fileNameCorr = [filenames(i,:) '_spikesCorrTAligned_msess' num2str(mazeSess(i)) '_Run1_intT' ...
            num2str(intervalT) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_spikesCorrTAligned file does not exist.');
            return;
        end
        load(fullPath,'spikeCorrTRun','nonZeroTrRun');

        fileNameCorr = [filenames(i,:) '_meanSpikesCorrTAlignedStim_msess' num2str(mazeSess(i)) '_Run1_intT' ...
            num2str(intervalT) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_meanSpikesCorrTAlignedStim file does not exist.');
            return;
        end
        load(fullPath,'meanCorrTRun');
        
        
        indNeu = modPyr1SigAL.indRec == i;
        
        indTmp = find(autoCorrPyrAll.task == task & autoCorrPyrAll.indRec == i);
        if(length(indTmp) ~= sum(indNeu))
            disp(['the number of neurons in recording task = ' num2str(task) ' rec. no. = ' num2str(i)...
                    'does not match that in the autoCorrPyrAll struct.']);
        end
        
        if(length(modPyr1SigAL.trialNoCtrlGood{i}) < paramF.minNumTr)
            disp([filenames(i,:) ' only has ' num2str(length(modPyr1SigAL.trialNoCtrlGood{i})) ...
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
            modPyr1.indNeu = [modPyr1.indNeu modPyr1SigAL.indNeu(indNeu)];
            modPyr1.actOrInact = [modPyr1.actOrInact actOrInact*ones(1,sum(indNeu))];
            modPyr1.pulseMeth = [modPyr1.pulseMeth pulseMeth(n)*ones(1,sum(indNeu))];
            modPyr1.stimLoc = [modPyr1.stimLoc modPyr1.stimLocPerRec(totRec)*ones(1,sum(indNeu))];
            
            indNeu1 = modPyr1SigAL.indNeu(indNeu);
            for m = 1:length(indNeu1)
                % ctrl good trials
                filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNoCtrlGood{i},:);
                if(isempty(modPyr1.avgFRProfile))
                    modPyr1.avgFRProfile = mean(filteredSpikeArrayTmp);
                else
                    modPyr1.avgFRProfile = [modPyr1.avgFRProfile; mean(filteredSpikeArrayTmp)];
                end                
                
                % 2nd stim ctrl trials
                filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNo2ndStimCtrlGood{i},:);
                if(isempty(modPyr1.avgFRProfileStimCtrl))
                    modPyr1.avgFRProfileStimCtrl = mean(filteredSpikeArrayTmp);
                else
                    modPyr1.avgFRProfileStimCtrl = [modPyr1.avgFRProfileStimCtrl; mean(filteredSpikeArrayTmp)];
                end

                 % 2nd stim ctrl trials
                filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNoStimGood{i}{n},:);
                if(isempty(modPyr1.avgFRProfileStimCtrl))
                    modPyr1.avgFRProfileStim = mean(filteredSpikeArrayTmp);
                else
                    modPyr1.avgFRProfileStim = [modPyr1.avgFRProfileStim; mean(filteredSpikeArrayTmp)];
                end
            end
            
            %% calculate the mean trial-by-trial correlation
            for m = 1:length(indNeu1)
                %% ctrl trials
                corrArr = triu(spikeCorrTRun{indNeu1(m)}(modPyr1SigAL.trialNoCtrlGood{i},...
                    modPyr1SigAL.trialNoCtrlGood{i}),1);
                corrArr = corrArr(:);
                nonZeroTr = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNoCtrlGood{i});
                nNonZeroTr = length(nonZeroTr);
                nElemNonZeroRun = (nNonZeroTr*nNonZeroTr-nNonZeroTr)/2;
                meanNZStimCtrl = sum(corrArr(isnan(corrArr) == 0))/nElemNonZeroRun;
                modPyr1.meanNZNonStim = [modPyr1.meanNZNonStim meanNZStimCtrl];
                
                %% 2nd stim ctrl trials (good)
                corrArr = triu(spikeCorrTRun{indNeu1(m)}(modPyr1SigAL.trialNo2ndStimCtrlGood{i},...
                    modPyr1SigAL.trialNo2ndStimCtrlGood{i}),1);
                corrArr = corrArr(:);
                nonZeroTr = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNo2ndStimCtrlGood{i});
                nNonZeroTr = length(nonZeroTr);
                nElemNonZeroRun = (nNonZeroTr*nNonZeroTr-nNonZeroTr)/2;
                meanNZStimCtrl = sum(corrArr(isnan(corrArr) == 0))/nElemNonZeroRun;
                modPyr1.meanNZStimCtrl = [modPyr1.meanNZStimCtrl meanNZStimCtrl];
                
                %% stim trials (good)
                corrArr = triu(spikeCorrTRun{indNeu1(m)}(modPyr1SigAL.trialNoStimGood{i}{n},...
                    modPyr1SigAL.trialNoStimGood{i}{n}),1);
                corrArr = corrArr(:);
                nonZeroTr = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNoStimGood{i}{n});
                nNonZeroTr = length(nonZeroTr);
                nElemNonZeroRun = (nNonZeroTr*nNonZeroTr-nNonZeroTr)/2;
                meanNZStimCtrl = sum(corrArr(isnan(corrArr) == 0))/nElemNonZeroRun;
                modPyr1.meanNZStim = [modPyr1.meanNZStim meanNZStimCtrl];

                %% stim trial vs ctrl trials
                corrArr = spikeCorrTRun{indNeu1(m)}(modPyr1SigAL.trialNoStimGood{i}{n},modPyr1SigAL.trialNoCtrlGood{i});
                corrArr = corrArr(:);        
                nonZeroTr = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNoStimGood{i}{n});
                nonZeroTr1 = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNoCtrlGood{i});
                nNonZeroTr = length(nonZeroTr);
                nNonZeroTr1 = length(nonZeroTr1);
                nElemNonZeroRun = nNonZeroTr*nNonZeroTr1;
                meanNZStimNonStim = sum(corrArr(isnan(corrArr) == 0))/nElemNonZeroRun;
                modPyr1.meanNZStimNonStim = [modPyr1.meanNZStimNonStim meanNZStimNonStim];
                
                %% stim trial vs 2nd stim ctrl trials
                corrArr = spikeCorrTRun{indNeu1(m)}(modPyr1SigAL.trialNoStimGood{i}{n},modPyr1SigAL.trialNo2ndStimCtrlGood{i});
                corrArr = corrArr(:);        
                nonZeroTr = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNoStimGood{i}{n});
                nonZeroTr1 = intersect(find(nonZeroTrRun{indNeu1(m)} == 1),modPyr1SigAL.trialNo2ndStimCtrlGood{i});
                nNonZeroTr = length(nonZeroTr);
                nNonZeroTr1 = length(nonZeroTr1);
                nElemNonZeroRun = nNonZeroTr*nNonZeroTr1;
                meanNZStimNonStim = sum(corrArr(isnan(corrArr) == 0))/nElemNonZeroRun;
                modPyr1.meanNZStimStimCtrl = [modPyr1.meanNZStimStimCtrl meanNZStimNonStim];
            end
            
            if(length(indTmp) == sum(indNeu))
                modPyr1.idxC1 = [modPyr1.idxC1 autoCorrPyrAll.idxC1(indTmp)'];
                modPyr1.idxC2 = [modPyr1.idxC2 autoCorrPyrAll.idxC2(indTmp)'];
                modPyr1.idxC3 = [modPyr1.idxC3 autoCorrPyrAll.idxC3(indTmp)];
                modPyr1.relDepthNeuHDef = [modPyr1.relDepthNeuHDef autoCorrPyrAll.relDepthNeuHDef(indTmp)];
                modPyr1.nNeuPerRec(totRec) = sum(indNeu == 1);
                
                modPyr1.nNeuWithFieldAlignedPerRec(totRec) = unique(nNeuWithFieldAligned(indTmp));  
                modPyr1.nNeuWithFieldAligned = [modPyr1.nNeuWithFieldAligned nNeuWithFieldAligned(indTmp)];
                modPyr1.isNeuWithFieldAligned = [modPyr1.isNeuWithFieldAligned isNeuWithFieldAligned(indTmp)];
                modPyr1.isPeakNeuArrAll = [modPyr1.isPeakNeuArrAll modPyr1SigAL.isPeakNeuArrAll(indNeu,:)'];
                
                nNeurons = length(cluList.firingRate);
                indNeuWithField = zeros(1,nNeurons);
                modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec) = 0;
                if(~isempty(fieldSpCorrSessNonStimGood))
                    [indNeuF,ia] = unique(fieldSpCorrSessNonStimGood.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec) = sum(indNeuWithField(indNeu1));
                end
                modPyr1.nNeuWithFieldAlignedGoodNonStim = [modPyr1.nNeuWithFieldAlignedGoodNonStim...
                    modPyr1.nNeuWithFieldAlignedPerRecGoodNonStim(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedGoodNonStim = [modPyr1.isNeuWithFieldAlignedGoodNonStim...
                    indNeuWithField(indNeu1)]; 
                
                modPyr1.nNeuWithFieldAlignedPerRecStim(totRec) = 0;
                indNeuWithField = zeros(1,nNeurons);
                if(~isempty(fieldSpCorrSessStim{n}))
                    [indNeuF,ia] = unique(fieldSpCorrSessStim{n}.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecStim(totRec) = sum(indNeuWithField(indNeu1));
                end
                modPyr1.nNeuWithFieldAlignedStim = [modPyr1.nNeuWithFieldAlignedStim...
                    modPyr1.nNeuWithFieldAlignedPerRecStim(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedStim = [modPyr1.isNeuWithFieldAlignedStim...
                    indNeuWithField(indNeu1)];                

                modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec) = 0;
                indNeuWithField = zeros(1,nNeurons);
                if(~isempty(fieldSpCorrSessStimCtrl{n}))
                    [indNeuF,ia] = unique(fieldSpCorrSessStimCtrl{n}.indNeuron); 
                    indNeuWithField(indNeuF) = 1;
                    modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec) = sum(indNeuWithField(indNeu1));
                end
                modPyr1.nNeuWithFieldAlignedStimCtrl = [modPyr1.nNeuWithFieldAlignedStimCtrl...
                    modPyr1.nNeuWithFieldAlignedPerRecStimCtrl(totRec)*ones(1,sum(indNeu))];
                modPyr1.isNeuWithFieldAlignedStimCtrl = [modPyr1.isNeuWithFieldAlignedStimCtrl...
                    indNeuWithField(indNeu1)];
            end
       
        end
        modPyr1.timeStepRun = timeStepRun/sampleFq;
        
       
    end
end