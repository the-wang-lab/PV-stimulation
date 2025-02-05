function modPyr1 = accumPyr3NoStim_1stStimCtrl(paths,filenames,mazeSess,autoCorrPyrAll,...
            anmNoInact,anmNoAct,task,modPyr1SigAL,sampleFq,intervalT)
    numRec = size(paths,1);
    modPyr1 = struct('actOrInact',[],... % is it activation or inactivation
                              'task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices trials
                              'pulseMeth',[], ... % pulse method
                              'stimLoc',[],... % stimulation location on the track
                              ...
                              'trialNo1stStimCtrl',[],... 1st stim control trials
                              'trialNo2ndStimCtrl',[],... 2nd stim control trials
                              'trialNoStim',[],... stim trials
                              'trialNoCtrlGood',[],... (non stim and 2nd stim ctrl good trials)
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile good trials (non stim and 2nd stim ctrl good trials)
                              'avgFRProfileStim',[],... % average firing rate profile stim trials
                              'avgFRProfile1stStimCtrl',[],... % average firing rate profile stim ctrl trials (1st stim ctrl trials)
                              'avgFRProfile2ndStimCtrl',[],... % average firing rate profile stim ctrl trials (2nd stim ctrl trials)
                              ...
                              'taskPerRec',[],...
                              'indRecPerRec',[],...
                              'actOrInactPerRec',[],...
                              'pulseMethPerRec',[],...
                              'stimLocPerRec',[],...
                              ...
                              'isPeakNeuArrAll',[]);

    totRec = 0;
    for i = 1:numRec
        disp(filenames(i,:));
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
        load(fullPath,'pFRStimStruct','pFRStimCtrlStruct','pFRNonStimGoodStruct','');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'pulseMeth','trialNoStim','trialNoStimCtrl','trialNoNonStimGood');
        
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
            disp([filenames(i,:) ' only has ' num2str(length(length(modPyr1SigAL.trialNoCtrlGood{i}))) ...
                ' good trials.']);
            disp(['No. pyramidal neurons in this recording is ' num2str(sum(indNeu))]);
            
            continue;
        end
        
        %% added by Yingxue on 5/10/2022
        indBaseline = find(timeStepRun/sampleFq >= -2 & timeStepRun/sampleFq < -1); % changed from [-3 -1] to [-2 to -1]
        indFRAll = find(timeStepRun/sampleFq >= -1 & timeStepRun/sampleFq < 4);
        %%
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
                        
            % 1st stim ctrl trial
            trialNo1stStimCtrl = intersect(trialNoStim{n}+1,trialNoStimCtrl{n});
            modPyr1.trialNo1stStimCtrl = [modPyr1.trialNo1stStimCtrl {trialNo1stStimCtrl}];
            % 2nd stim ctrl trial
            trialNo2ndStimCtrl = setdiff(trialNoStimCtrl{n},trialNo1stStimCtrl);
            modPyr1.trialNo2ndStimCtrl = [modPyr1.trialNo2ndStimCtrl {trialNo2ndStimCtrl}];
            
            trialNoStim1 = trialNoStim{n};
            modPyr1.trialNoStim = [modPyr1.trialNoStim {trialNoStim1}];
            
            trialNoCtrlGood = [trialNoNonStimGood;  trialNo2ndStimCtrl];
            modPyr1.trialNoCtrlGood = [modPyr1.trialNoCtrlGood {trialNoCtrlGood}];
           
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
                filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(trialNoCtrlGood,:);
                if(isempty(modPyr1.avgFRProfile))
                    modPyr1.avgFRProfile = mean(filteredSpikeArrayTmp);
                else
                    modPyr1.avgFRProfile = [modPyr1.avgFRProfile; mean(filteredSpikeArrayTmp)];
                end     
                
                % 1st stim ctrl trials
                filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(trialNo1stStimCtrl,:);
                if(isempty(modPyr1.avgFRProfile1stStimCtrl))
                    modPyr1.avgFRProfile1stStimCtrl = mean(filteredSpikeArrayTmp);
                else
                    modPyr1.avgFRProfile1stStimCtrl = [modPyr1.avgFRProfile1stStimCtrl; mean(filteredSpikeArrayTmp)];
                end
                
                % 2nd stim ctrl 
                if(isempty(trialNo2ndStimCtrl))
                    filteredSpikeArrayTmp = zeros(1,size(filteredSpikeArrayRunOnSet{indNeu1(m)},2));
                else
                    filteredSpikeArrayTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(trialNo2ndStimCtrl,:);
                end
                
                if(isempty(modPyr1.avgFRProfile2ndStimCtrl))
                    if(size(filteredSpikeArrayTmp,1) == 1)
                        modPyr1.avgFRProfile2ndStimCtrl = filteredSpikeArrayTmp;
                    else
                        modPyr1.avgFRProfile2ndStimCtrl = mean(filteredSpikeArrayTmp);
                    end
                else
                    if(size(filteredSpikeArrayTmp,1) == 1)
                        modPyr1.avgFRProfile2ndStimCtrl = [modPyr1.avgFRProfile2ndStimCtrl; filteredSpikeArrayTmp];
                    else
                        modPyr1.avgFRProfile2ndStimCtrl = [modPyr1.avgFRProfile2ndStimCtrl; mean(filteredSpikeArrayTmp)];
                    end
                end
            end
            modPyr1.avgFRProfileStim = [modPyr1.avgFRProfileStim; pFRStimStruct{n}.avgFRProfile(indNeu1,:)];
            
            if(length(indTmp) == sum(indNeu))
                modPyr1.isPeakNeuArrAll = [modPyr1.isPeakNeuArrAll modPyr1SigAL.isPeakNeuArrAll(indNeu,:)'];  
            end
       
        end
        modPyr1.timeStepRun = timeStepRun/sampleFq;
        
       
    end
end