function modPyr1 = accumPyrInit(paths,filenames,mazeSess,autoCorrPyrAll,nNeuWithField,...
            isNeuWithField,nNeuWithFieldAligned,isNeuWithFieldAligned,...
            minFR,maxFR,task,sampleFq)
    numRec = size(paths,1);
    modPyr1 = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'taskGood',[],... % no cue - 1, AL - 2, PL - 3 Good trials
                              'taskBad',[],... % no cue - 1, AL - 2, PL - 3 Bad trials
                              'indRec',[],... % recording index
                              'indRecGood',[],... % recording index Good trials
                              'indRecBad',[],... % recording index Bad trials
                              'indNeu',[],... % neuron indices
                              'indNeuGood',[],... % neuron indices Good trials
                              'indNeuBad',[],... % neuron indices Bad trials
                              ...
                              'idxC1',[],...  % cluster no. Good trials
                              'idxC1Good',[],... % cluster no. for good trials
                              'idxC1Bad',[],... % cluster no. for bad trials
                              'idxC2',[],...  % cluster no. Good trials
                              'idxC2Good',[],... % cluster no. for good trials
                              'idxC2Bad',[],... % cluster no. for bad trials
                              'idxC3',[],...  % cluster no. Good trials
                              'idxC3Good',[],... % cluster no. for good trials
                              'idxC3Bad',[],... % cluster no. for bad trials
                              ...
                              'relDepthNeuHDef',[],... % depth ctrl trials
                              'nNeuWithField',[],... % number of neurons with fields ctrl trials
                              'nNeuWithFieldAligned',[],... % number of neurons with fields after aligning to run onset ctrl trials
                              'isNeuWithField',[],... % whether this neuron has a field ctrl trials
                              'isNeuWithFieldAligned',[],... % whether this neuron has a field ctrl trials
                              ...
                              'relDepthNeuHDefGood',[],... % depth good trials
                              'nNeuWithFieldGood',[],... % number of neurons with fields good trials
                              'nNeuWithFieldAlignedGood',[],... % number of neurons with fields after aligning to run onset good trials
                              'isNeuWithFieldGood',[],... % whether this neuron has a field good trials
                              'isNeuWithFieldAlignedGood',[],... % whether this neuron has a field good trials
                              ...
                              'timeStepRun',[],...
                              'avgFRProfile',[],...% average firing rate profile all ctrl trials
                              'avgFRProfileGoodAll',[],... % average firing rate profile good trials (include all the neurons, even when trial no is low)
                              'avgFRProfileBadAll',[],... % average firing rate profile bad trials (include all the neurons, even when trial no is low)
                              'avgFRProfileGood',[],... % average firing rate profile good trials (only include neurons when trial no > threshold)
                              'avgFRProfileBad',[],... % average firing rate profile bad trials (only include neurons when trial no > threshold)
                              ...
                              'spaceSteps',[],...
                              'avgFRProfileDistGoodAll',[],... % average firing rate profile good trials (include all the neurons, even when trial no is low)
                              'avgFRProfileDistBadAll',[],... % average firing rate profile bad trials (include all the neurons, even when trial no is low)
                              'avgFRProfileDistGood',[],... % average firing rate profile good trials (only include neurons when trial no > threshold)
                              'avgFRProfileDistBad',[],... % average firing rate profile bad trials (only include neurons when trial no > threshold)
                              ...
                              'numTr',[],... % trial number in ctrl trials
                              'numTrGood',[],... % trial number in good trials
                              'numTrBad',[],... % trial number in bad trials
                              ...
                              'nNeuPerRec',[],... % number of pyramidal neurons per recording
                              'nNeuWithFieldPerRec',[],... % number of field for each recording
                              'nNeuWithFieldAlignedPerRec',[],... % number of field for each recording after aligning to run onset
                              'taskPerRec',[],...
                              'indRecPerRec',[],...
                              ...
                              'nNeuPerRecGood',[],... % number of pyramidal neurons per recording good trials
                              'nNeuWithFieldPerRecGood',[],... % number of field for each recording good trials
                              'nNeuWithFieldAlignedPerRecGood',[],... % number of field for each recording after aligning to run onset good trials
                              'taskPerRecGood',[],... good trials
                              'indRecPerRecGood',[]); ... good trials
    
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
        modPyr1.spaceSteps = paramC.spaceSteps;
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
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
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        
        indTmp = find(autoCorrPyrAll.task == task & autoCorrPyrAll.indRec == i);
        if(length(indTmp) ~= sum(indNeu))
            disp(['the number of neurons in recording task = ' num2str(task) ' rec. no. = ' num2str(i)...
                    'does not match that in the autoCorrPyrAll struct.']);
        end
        
        if(length(pFRNonStimStruct.indLapList) >= paramF.minNumTr)
            profileLength = size(pFRNonStimStruct.avgFRProfile,2);
            profileLengthDist = size(pFRDistNonStimGoodStruct.avgFRProfile,2);
            modPyr1.taskPerRec(i) = task;
            modPyr1.indRecPerRec(i) = i;            
            modPyr1.task = [modPyr1.task task*ones(1,sum(indNeu))];
            modPyr1.indRec = [modPyr1.indRec i*ones(1,sum(indNeu))];
            modPyr1.indNeu = [modPyr1.indNeu find(indNeu == 1)]; 
            modPyr1.avgFRProfile = [modPyr1.avgFRProfile; pFRNonStimStruct.avgFRProfile(indNeu,:)];
            if(~isempty(pFRNonStimGoodStruct))
                modPyr1.avgFRProfileGoodAll = [modPyr1.avgFRProfileGoodAll; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
                modPyr1.avgFRProfileDistGoodAll = [modPyr1.avgFRProfileDistGoodAll; pFRDistNonStimGoodStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
                modPyr1.numTrGood = [modPyr1.numTrGood length(pFRNonStimGoodStruct.indLapList)*ones(1,sum(indNeu))];
            else
                modPyr1.avgFRProfileGoodAll = [modPyr1.avgFRProfileGoodAll; zeros(sum(indNeu),profileLength)];
                modPyr1.avgFRProfileDistGoodAll = [modPyr1.avgFRProfileDistGoodAll; zeros(sum(indNeu),profileLengthDist)]; % added on 11/10/2023
                modPyr1.numTrGood = [modPyr1.numTrGood zeros(1,sum(indNeu))];
            end
            if(~isempty(pFRNonStimBadStruct))
                modPyr1.avgFRProfileBadAll = [modPyr1.avgFRProfileBadAll; pFRNonStimBadStruct.avgFRProfile(indNeu,:)];
                modPyr1.avgFRProfileDistBadAll = [modPyr1.avgFRProfileDistBadAll; pFRDistNonStimBadStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
                modPyr1.numTrBad = [modPyr1.numTrBad length(pFRNonStimBadStruct.indLapList)*ones(1,sum(indNeu))];
            else
                modPyr1.avgFRProfileBadAll = [modPyr1.avgFRProfileBadAll; zeros(sum(indNeu),profileLength)];
                modPyr1.avgFRProfileDistBadAll = [modPyr1.avgFRProfileDistBadAll; zeros(sum(indNeu),profileLengthDist)]; % added on 11/10/2023
                modPyr1.numTrBad = [modPyr1.numTrBad zeros(1,sum(indNeu))];
            end
            modPyr1.numTr = [modPyr1.numTr length(pFRNonStimStruct.indLapList)*ones(1,sum(indNeu))];
            
            
            if(length(indTmp) == sum(indNeu))
                modPyr1.idxC1 = [modPyr1.idxC1 autoCorrPyrAll.idxC1(indTmp)'];
                modPyr1.idxC2 = [modPyr1.idxC2 autoCorrPyrAll.idxC2(indTmp)'];
                modPyr1.idxC3 = [modPyr1.idxC3 autoCorrPyrAll.idxC3(indTmp)];
                modPyr1.relDepthNeuHDef = [modPyr1.relDepthNeuHDef autoCorrPyrAll.relDepthNeuHDef(indTmp)];
                modPyr1.nNeuPerRec(i) = sum(indNeu == 1);
                modPyr1.nNeuWithFieldPerRec(i) = unique(nNeuWithField(indTmp));
                modPyr1.nNeuWithFieldAlignedPerRec(i) = unique(nNeuWithFieldAligned(indTmp));
                modPyr1.nNeuWithField = [modPyr1.nNeuWithField nNeuWithField(indTmp)];
                modPyr1.isNeuWithField = [modPyr1.isNeuWithField isNeuWithField(indTmp)];
                modPyr1.nNeuWithFieldAligned = [modPyr1.nNeuWithFieldAligned nNeuWithFieldAligned(indTmp)];
                modPyr1.isNeuWithFieldAligned = [modPyr1.isNeuWithFieldAligned isNeuWithFieldAligned(indTmp)];
            end
        else
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimStruct.indLapList)) ...
                ' trials.']);
            disp(['No. pyramidal neurons in this recording is ' num2str(sum(indNeu))]);
        end
        
        if(length(pFRNonStimGoodStruct.indLapList) >= paramF.minNumTr)
            modPyr1.taskPerRecGood(i) = task;
            modPyr1.indRecPerRecGood(i) = i;            
            modPyr1.taskGood = [modPyr1.taskGood task*ones(1,sum(indNeu))];
            modPyr1.indRecGood = [modPyr1.indRecGood i*ones(1,sum(indNeu))];
            modPyr1.indNeuGood = [modPyr1.indNeuGood find(indNeu == 1)]; 
            modPyr1.avgFRProfileGood = [modPyr1.avgFRProfileGood; pFRNonStimGoodStruct.avgFRProfile(indNeu,:)];
            modPyr1.avgFRProfileDistGood = [modPyr1.avgFRProfileDistGood; pFRDistNonStimGoodStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
            if(length(indTmp) == sum(indNeu))
                modPyr1.idxC1Good = [modPyr1.idxC1Good autoCorrPyrAll.idxC1(indTmp)'];
                modPyr1.idxC2Good = [modPyr1.idxC2Good autoCorrPyrAll.idxC2(indTmp)'];
                modPyr1.idxC3Good = [modPyr1.idxC3Good autoCorrPyrAll.idxC3(indTmp)];
                modPyr1.relDepthNeuHDefGood = [modPyr1.relDepthNeuHDefGood autoCorrPyrAll.relDepthNeuHDef(indTmp)];
                modPyr1.nNeuPerRecGood(i) = sum(indNeu == 1);
                modPyr1.nNeuWithFieldPerRecGood(i) = unique(nNeuWithField(indTmp));
                modPyr1.nNeuWithFieldAlignedPerRecGood(i) = unique(nNeuWithFieldAligned(indTmp));
                modPyr1.nNeuWithFieldGood = [modPyr1.nNeuWithFieldGood nNeuWithField(indTmp)];
                modPyr1.isNeuWithFieldGood = [modPyr1.isNeuWithFieldGood isNeuWithField(indTmp)];
                modPyr1.nNeuWithFieldAlignedGood = [modPyr1.nNeuWithFieldAlignedGood nNeuWithFieldAligned(indTmp)];
                modPyr1.isNeuWithFieldAlignedGood = [modPyr1.isNeuWithFieldAlignedGood isNeuWithFieldAligned(indTmp)];
            end
        else
            disp([filenames(i,:) ' only has ' num2str(length(pFRNonStimGoodStruct.indLapList)) ...
                ' good trials.']);
            disp(['No. pyramidal neurons in this recording is ' num2str(sum(indNeu))]);
        end
        
        if(~isempty(pFRNonStimBadStruct) && length(pFRNonStimBadStruct.indLapList) >= paramF.minNumTr)
            modPyr1.taskBad = [modPyr1.taskBad task*ones(1,sum(indNeu))];
            modPyr1.indRecBad = [modPyr1.indRecBad i*ones(1,sum(indNeu))];
            modPyr1.indNeuBad = [modPyr1.indNeuBad find(indNeu == 1)]; 
            modPyr1.avgFRProfileBad = [modPyr1.avgFRProfileBad; pFRNonStimBadStruct.avgFRProfile(indNeu,:)];
            modPyr1.avgFRProfileDistBad = [modPyr1.avgFRProfileDistBad; pFRDistNonStimBadStruct.avgFRProfile(indNeu,:)]; % added on 11/10/2023
            if(length(indTmp) == sum(indNeu))
                modPyr1.idxC1Bad = [modPyr1.idxC1Bad autoCorrPyrAll.idxC1(indTmp)'];
                modPyr1.idxC2Bad = [modPyr1.idxC2Bad autoCorrPyrAll.idxC2(indTmp)'];
                modPyr1.idxC3Bad = [modPyr1.idxC3Bad autoCorrPyrAll.idxC3(indTmp)];
            end
        else
            totExcNeu = totExcNeu + sum(indNeu);
            if(isempty(pFRNonStimBadStruct))
                lenTr = 0;
            else
                lenTr = length(pFRNonStimBadStruct.indLapList);
            end
            disp([filenames(i,:) ' only has ' num2str(lenTr) ' bad trials.']);
            disp(['No. pyramidal neurons in this recording is ' num2str(sum(indNeu)) ...
                ', total number of excluded neurons is ' num2str(totExcNeu)]);
        end
        modPyr1.timeStepRun = timeStepRun/sampleFq;
        
    end
end