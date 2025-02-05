function modInt1 = accumInterneurons2(paths,filenames,mazeSess,autoCorrIntAll,nNeuWithField,...
            nNeuWithFieldAligned,minFRInt,task,sampleFq)
    numRec = size(paths,1);
    modInt1 = struct('task',[],... % no cue - 1, AL - 2, PL - 3 ctrl trials
                              'taskGood',[],... % no cue - 1, AL - 2, PL - 3 Good trials
                              'taskBad',[],... % no cue - 1, AL - 2, PL - 3 Bad trials
                              'indRec',[],... % recording index  ctrl trials
                              'indRecGood',[],... % recording index Good trials
                              'indRecBad',[],... % recording index Bad trials
                              'indNeu',[],... % neuron indices   ctrl trials
                              'indNeuGood',[],... % neuron indices Good trials
                              'indNeuBad',[],... % neuron indices  Bad trials
                              ...                              
                              'idxC1',[],...  % cluster no. ctrl trials
                              'idxC1Good',[],... % cluster no. for good trials
                              'idxC1Bad',[],... % cluster no. for bad trials
                              'idxC2',[],...  % cluster no. ctrl trials
                              'idxC2Good',[],... % cluster no. for good trials
                              'idxC2Bad',[],... % cluster no. for bad trials
                              'idxC3',[],...  % cluster no. ctrl trials
                              'idxC3Good',[],... % cluster no. for good trials
                              'idxC3Bad',[],... % cluster no. for bad trials
                              ...
                              'nNeuWithField',[],... % number of neurons with fields ctrl trials
                              'nNeuWithFieldAligned',[],... % number of neurons with fields after aligning to run onset ctrl trials
                              'nNeuWithFieldGood',[],... % number of neurons with fields good trials
                              'nNeuWithFieldAlignedGood',[],... % number of neurons with fields after aligning to run onset good trials
                              ...
                              'numTr',[],... % trial number in ctrl trials
                              'numTrGood',[],... % trial number in good trials
                              'numTrBad',[],... % trial number in bad trials
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile all ctrl trials
                              'avgFRProfileGoodAll',[],... % average firing rate profile good trials (include all the neurons, even when trial no is low)
                              'avgFRProfileBadAll',[],... % average firing rate profile bad trials (include all the neurons, even when trial no is low)
                              'avgFRProfileGood',[],... % average firing rate profile bad trials (only include neurons when trial no > threshold)
                              'avgFRProfileBad',[],... % average firing rate profile bad trials (only include neurons when trial no > threshold)
                              ...
                              'spaceSteps',[],...
                              'avgFRProfileDistGoodAll',[],... % average firing rate profile good trials (include all the neurons, even when trial no is low)
                              'avgFRProfileDistBadAll',[],... % average firing rate profile bad trials (include all the neurons, even when trial no is low)
                              'avgFRProfileDistGood',[],... % average firing rate profile good trials (only include neurons when trial no > threshold)
                              'avgFRProfileDistBad',[]); % average firing rate profile bad trials (only include neurons when trial no > threshold)
                              
    totExcNeu = 0;
    for i = 1:numRec
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
        
        fileNamePeakFR = [filenames(i,:) '_PeakFRDistAligned_msess' num2str(mazeSess(i)) ...
                        '_Run0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct','pFRNonStimBadStruct');
        pFRDistNonStimGoodStruct = pFRNonStimGoodStruct;
        pFRDistNonStimBadStruct = pFRNonStimBadStruct;
        
        fileNameConv = [filenames(i,:) '_convSpikesDistAligned_msess' num2str(mazeSess(i)) '_Run0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The _convSpikesDistAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'paramC');
        spaceSteps = paramC.spaceSteps;
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct','pFRNonStimBadStruct');
        
        fileNamePeakFR = [filenames(i,:) '_PeakFRCtrl_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_AlignedRunOnsetCtrlOnly" first.']);
            return;
        end
        load(fullPath,'pFRNonStimStruct');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'timeStepRun');
        
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
        
%         indNeu = autoCorr.isInterneuron == 1 & cluList.firingRate > minFRInt;
        indNeu = autoCorr.isInterneuron == 1 & mFR.mFR > minFRInt;
        
        indTmp = find(autoCorrIntAll.task == task & autoCorrIntAll.indRec == i);
        if(length(indTmp) ~= sum(indNeu))
            disp(['the number of animals in recording task = ' num2str(task) ' rec. no. = ' num2str(i)...
                    'does not match that in the autoCorrIntAll struct.']);
        end
        
        if(length(pFRNonStimStruct.indLapList) >= paramF.minNumTr)  
            profileLength = size(pFRNonStimStruct.avgFRProfile,2);
            profileLengthDist = size(pFRDistNonStimGoodStruct.avgFRProfile,2);
            modInt1.task = [modInt1.task task*ones(1,sum(indNeu))];
            modInt1.indRec = [modInt1.indRec i*ones(1,sum(indNeu))];
            modInt1.indNeu = [modInt1.indNeu find(indNeu == 1)];          
            modInt1.avgFRProfile = [modInt1.avgFRProfile; pFRNonStimStruct.avgFRProfile(indNeu,:)];
            if(~isempty(pFRNonStimGoodStruct))
                modInt1.avgFRProfileGoodAll = [modInt1.avgFRProfileGoodAll; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
                modInt1.avgFRProfileDistGoodAll = [modInt1.avgFRProfileDistGoodAll; pFRDistNonStimGoodStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
                modInt1.numTrGood = [modInt1.numTrGood length(pFRNonStimGoodStruct.indLapList)*ones(1,sum(indNeu))];
            else
                modInt1.avgFRProfileGoodAll = [modInt1.avgFRProfileGoodAll; zeros(sum(indNeu),profileLength)];
                modInt1.avgFRProfileDistGoodAll = [modInt1.avgFRProfileDistGoodAll; zeros(sum(indNeu),profileLengthDist)]; % added on 11/10/2023
                modInt1.numTrGood = [modInt1.numTrGood zeros(1,sum(indNeu))];
            end
            if(~isempty(pFRNonStimBadStruct))
                modInt1.avgFRProfileBadAll = [modInt1.avgFRProfileBadAll; pFRNonStimBadStruct.avgFRProfile(indNeu,:)];
                modInt1.avgFRProfileDistBadAll = [modInt1.avgFRProfileDistBadAll; pFRDistNonStimBadStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
                modInt1.numTrBad = [modInt1.numTrBad length(pFRNonStimBadStruct.indLapList)*ones(1,sum(indNeu))];
            else
                modInt1.avgFRProfileBadAll = [modInt1.avgFRProfileBadAll; zeros(sum(indNeu),profileLength)];
                modInt1.avgFRProfileDistBadAll = [modInt1.avgFRProfileDistBadAll; zeros(sum(indNeu),profileLengthDist)]; % added on 11/10/2023
                modInt1.numTrBad = [modInt1.numTrBad zeros(1,sum(indNeu))];
            end
            modInt1.numTr = [modInt1.numTr length(pFRNonStimStruct.indLapList)*ones(1,sum(indNeu))];
            
            if(length(indTmp) == sum(indNeu))
                modInt1.idxC1 = [modInt1.idxC1 autoCorrIntAll.idxC1(indTmp)'];
                modInt1.idxC2 = [modInt1.idxC2 autoCorrIntAll.idxC2(indTmp)'];
                modInt1.idxC3 = [modInt1.idxC3 autoCorrIntAll.idxC3(indTmp)'];
                modInt1.nNeuWithField = [modInt1.nNeuWithField nNeuWithField(indTmp)];
                modInt1.nNeuWithFieldAligned = [modInt1.nNeuWithFieldAligned nNeuWithFieldAligned(indTmp)];
            end
        else
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimStruct.indLapList)) ...
                ' trials.']);
            disp(['No. interneurons in this recording is ' num2str(sum(indNeu))]);
        end
        
        if(length(pFRNonStimGoodStruct.indLapList) >= paramF.minNumTr)  
            modInt1.taskGood = [modInt1.taskGood task*ones(1,sum(indNeu))];
            modInt1.indRecGood = [modInt1.indRecGood i*ones(1,sum(indNeu))];
            modInt1.indNeuGood = [modInt1.indNeuGood find(indNeu == 1)]; 
            modInt1.avgFRProfileGood = [modInt1.avgFRProfileGood; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
            modInt1.avgFRProfileDistGood = [modInt1.avgFRProfileDistGood; pFRDistNonStimGoodStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
            if(length(indTmp) == sum(indNeu))
                modInt1.idxC1Good = [modInt1.idxC1Good autoCorrIntAll.idxC1(indTmp)'];
                modInt1.idxC2Good = [modInt1.idxC2Good autoCorrIntAll.idxC2(indTmp)'];
                modInt1.idxC3Good = [modInt1.idxC3Good autoCorrIntAll.idxC3(indTmp)'];
                modInt1.nNeuWithFieldGood = [modInt1.nNeuWithFieldGood nNeuWithField(indTmp)];
                modInt1.nNeuWithFieldAlignedGood = [modInt1.nNeuWithFieldAlignedGood nNeuWithFieldAligned(indTmp)];
            end
        else
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimGoodStruct.indLapList)) ...
                ' good trials.']);
            disp(['No. interneurons in this recording is ' num2str(sum(indNeu))]);
        end
        if(~isempty(pFRNonStimBadStruct) && length(pFRNonStimBadStruct.indLapList) >= paramF.minNumTr)
            modInt1.avgFRProfileBad = [modInt1.avgFRProfileBad; pFRNonStimBadStruct.avgFRProfile(indNeu,:)];
            modInt1.avgFRProfileDistBad = [modInt1.avgFRProfileDistBad; pFRDistNonStimBadStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
            modInt1.taskBad = [modInt1.taskBad task*ones(1,sum(indNeu))];
            modInt1.indRecBad = [modInt1.indRecBad i*ones(1,sum(indNeu))];
            modInt1.indNeuBad = [modInt1.indNeuBad find(indNeu == 1)];        
            if(length(indTmp) == sum(indNeu))
                modInt1.idxC1Bad = [modInt1.idxC1Bad autoCorrIntAll.idxC1(indTmp)'];
                modInt1.idxC2Bad = [modInt1.idxC2Bad autoCorrIntAll.idxC2(indTmp)'];
                modInt1.idxC3Bad = [modInt1.idxC3Bad autoCorrIntAll.idxC3(indTmp)'];
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
        modInt1.timeStepRun = timeStepRun/sampleFq;
        
    end
end