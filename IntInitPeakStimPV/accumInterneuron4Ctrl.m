function modInt1 = accumInterneuron4Ctrl(paths,filenames,mazeSess,autoCorrIntAll,...
            anmNoInact,anmNoAct,minFRInt,task,sampleFq,intervalT)
    numRec = size(paths,1);
    modInt1 = struct('actOrInact',[],... % is it activation or inactivation
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
                              'relDepthNeuHDef',[],... % depth
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile good trials
                              'avgFRProfileStim',[],... % average firing rate profile stim trials
                              'avgFRProfileStimCtrl',[],... % average firing rate profile stim ctrl trials
                              ...
                              'meanNZNonStim',[],... corrT NZ
                              'meanNZStim',[],... corrT NZ
                              'meanNZStimCtrl',[],... corrT NZ
                              'meanNZStimNonStim',[],... corrT NZ
                              ...
                              'nNeuPerRec',[],... % number of interneurons per recording
                              'taskPerRec',[],...
                              'indRecPerRec',[],...
                              'actOrInactPerRec',[],...
                              'pulseMethPerRec',[],...
                              'stimLocPerRec',[],...
                              ...
                              'pRSMeanFRNonStimVsStimCtrl0to1',[],... % compare the 0to1 sec mean firing rate between ctrl and stim ctrl trials
                              'pKSMeanFRNonStimVsStimCtrl0to1',[],...
                              ...
                              'pRSMeanFRNonStimVsStimCtrlBL',[],... % compare the mean firing rate between ctrl and stim ctrl trials
                              'pKSMeanFRNonStimVsStimCtrlBL',[]);

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
        
        fileNamePeakFR = [filenames(i,:) '_PeakFRCtrl_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_AlignedCtrlOnly" first.']);
            return;
        end
        load(fullPath,'pFRNonStimStruct');
        pFRNonStimGoodStruct = pFRNonStimStruct;
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAlignedCtrl_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStim');
        trialNoNonStimGood = trialNoNonStim;
        
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
        load(fullPath,'trialNoStim','trialNoStimCtrl','pulseMeth');
                
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
        
        fileNameCorr = [filenames(i,:) '_meanSpikesCorrTAlignedStim_msess' num2str(mazeSess(i)) '_Run1_intT' ...
            num2str(intervalT) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_meanSpikesCorrTAlignedStim file does not exist.');
            return;
        end
        load(fullPath,'meanCorrTRun');
        
        fileNameFWStim = [filenames(i,:) '_FieldSpCorrAlignedStim_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFWStim];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAlignedStim" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        indNeu = mFR.mFR > minFRInt &...
                    autoCorr.isInterneuron == 1;
        indNeuTmp = find(indNeu == 1);
        indTmp = find(autoCorrIntAll.task == task & autoCorrIntAll.indRec == i);
        if(length(indTmp) ~= sum(indNeu))
            disp(['the number of neurons in recording task = ' num2str(task) ' rec. no. = ' num2str(indRec)...
                    'does not match that in the autoCorrIntAll struct.']);
        end
        
        if(length(pFRNonStimGoodStruct.indLapList) < paramF.minNumTr)
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimGoodStruct.indLapList)) ...
                ' good trials.']);
            disp(['No. interneurons in this recording is ' num2str(sum(indNeu))]);
            
            continue;
        end
        
        %% added by Yingxue on 5/10/2022
        indBaseline = find(timeStepRun/sampleFq >= -3 & timeStepRun/sampleFq < -1);
        indFR0to1s = find(timeStepRun/sampleFq >= 0.5 & timeStepRun/sampleFq < 1.5);
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
            %%
            totRec = totRec+ 1;
            modInt1.taskPerRec(totRec) = task;
            modInt1.actOrInactPerRec(totRec) = actOrInact;
            modInt1.pulseMethPerRec(totRec) = pulseMeth(n);
            if(pulseMeth(n) ~= 3)
               modInt1.stimLocPerRec(totRec) = 0;
            else
               modInt1.stimLocPerRec(totRec) = stimLocTmp; 
            end
            modInt1.indRecPerRec(totRec) = i;            
            modInt1.task = [modInt1.task task*ones(1,sum(indNeu))];
            modInt1.indRec = [modInt1.indRec i*ones(1,sum(indNeu))];
            modInt1.indNeu = [modInt1.indNeu find(indNeu == 1)]; 
            modInt1.actOrInact = [modInt1.actOrInact actOrInact*ones(1,sum(indNeu))];
            modInt1.pulseMeth = [modInt1.pulseMeth pulseMeth(n)*ones(1,sum(indNeu))];
            modInt1.stimLoc = [modInt1.stimLoc modInt1.stimLocPerRec(totRec)*ones(1,sum(indNeu))];
            modInt1.avgFRProfile = [modInt1.avgFRProfile; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
            modInt1.avgFRProfileStim = [modInt1.avgFRProfileStim; pFRStimStruct{n}.avgFRProfile(indNeu,:)];
            modInt1.avgFRProfileStimCtrl = [modInt1.avgFRProfileStimCtrl; pFRStimCtrlStruct{n}.avgFRProfile(indNeu,:)];
            
            %% added on 8/14/2022
            modInt1.meanNZNonStim = [modInt1.meanNZNonStim meanCorrTRun.meanNZNonStim(indNeu)];
            modInt1.meanNZStim = [modInt1.meanNZStim meanCorrTRun.meanNZStim(n,indNeu)];
            modInt1.meanNZStimCtrl = [modInt1.meanNZStimCtrl meanCorrTRun.meanNZStimCtrl(n,indNeu)];
            modInt1.meanNZStimNonStim = [modInt1.meanNZStimNonStim meanCorrTRun.meanNZStimNonStim(n,indNeu)];
            %%
            
            %% added by Yingxue on 5/10/2022
            % check change in firing rate over time
            
            for m = 1:length(indNeuTmp)
                meanFRNonStim = mean(pFRNonStimGoodStruct.filteredSpArrAll{indNeuTmp(m)}(:,indBaseline),2);
                if(pulseMeth(n) == 3 && modInt1.stimLocPerRec(totRec) == 120)
                    meanFRStimCtrl = mean(pFRStimStruct{n}.filteredSpArrAll{indNeuTmp(m)}(:,indBaseline),2);
                    disp('recording stim 3 loc 120 cm')
                else
                    meanFRStimCtrl = mean(pFRStimCtrlStruct{n}.filteredSpArrAll{indNeuTmp(m)}(:,indBaseline),2);
                end
                modInt1.pRSMeanFRNonStimVsStimCtrlBL = [modInt1.pRSMeanFRNonStimVsStimCtrlBL ranksum(meanFRNonStim,meanFRStimCtrl)];
                [~,p] = kstest2(meanFRNonStim,meanFRStimCtrl);
                modInt1.pKSMeanFRNonStimVsStimCtrlBL = [modInt1.pKSMeanFRNonStimVsStimCtrlBL p];
                
                %% added on 10/29/2022
                meanFRNonStim = mean(pFRNonStimGoodStruct.filteredSpArrAll{indNeuTmp(m)}(:,indFR0to1s),2);
                if(pulseMeth(n) == 3 && modInt1.stimLocPerRec(totRec) == 120)
                    meanFRStimCtrl = mean(pFRStimStruct{n}.filteredSpArrAll{indNeuTmp(m)}(:,indFR0to1s),2);
                    disp('recording stim 3 loc 120 cm')
                else
                    meanFRStimCtrl = mean(pFRStimCtrlStruct{n}.filteredSpArrAll{indNeuTmp(m)}(:,indFR0to1s),2);
                end
                modInt1.pRSMeanFRNonStimVsStimCtrl0to1 = [modInt1.pRSMeanFRNonStimVsStimCtrl0to1 ranksum(meanFRNonStim,meanFRStimCtrl)];
                [~,p] = kstest2(meanFRNonStim,meanFRStimCtrl);
                modInt1.pKSMeanFRNonStimVsStimCtrl0to1 = [modInt1.pKSMeanFRNonStimVsStimCtrlBL p];
            end
            %%
            
            if(length(indTmp) == sum(indNeu))
                modInt1.idxC1 = [modInt1.idxC1 autoCorrIntAll.idxC1(indTmp)'];
                modInt1.idxC2 = [modInt1.idxC2 autoCorrIntAll.idxC2(indTmp)'];
                modInt1.idxC3 = [modInt1.idxC3 autoCorrIntAll.idxC3(indTmp)'];
                modInt1.relDepthNeuHDef = [modInt1.relDepthNeuHDef autoCorrIntAll.relDepthNeuHDef(indTmp)];
                modInt1.nNeuPerRec(totRec) = sum(indNeu == 1);
            end
        end
        modInt1.timeStepRun = timeStepRun/sampleFq;
        
    end
end