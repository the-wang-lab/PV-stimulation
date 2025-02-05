function modPyr = accumPyrNeurons1GoodTrDist(paths,filenames,mazeSess,minFR,maxFR,task,onlyRun,intervalD,goodTr)

    %% 
    numRec = size(paths,1);
    modPyr = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              ...
                              'meanCorrDistRun',[],... % mean correlation in time aligned to run
                              'meanCorrDistRunNZ',[],... % mean correlation in time aligned to run (trials with spikes)
                              'meanCorrDistRew',[],... % mean correlation in time aligned to rew
                              'meanCorrDistRewNZ',[],... % mean correlation in time aligned to rew (trials with spikes)
                              'meanCorrDistCue',[],... % mean correlation in time aligned to rew
                              'meanCorrDistCueNZ',[]); % mean correlation in time aligned to rew (trials with spikes)
                                                         
    for i = 1:numRec
        disp(filenames(i,:));
        if(i == 7)
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
        
        fullPathFRAll = [filenames(i,:) '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathFRAll];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFRAll = mFRStructSess{mazeSess(i)};
        else
            mFRAll = mFRStruct;
        end
                
        fileNameFR = [filenames(i,:) '_FRAlignedRun_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFR];
        if(exist(fullPath,'file') == 0)
            disp('_FRAlignedRun file does not exist.');
        end
        if(goodTr == 1)
            load(fullPath,'mFRStructNonStimGood');       
            mFR = mFRStructNonStimGood;
        else
            load(fullPath,'mFRStructNonStimBad');       
            mFR = mFRStructNonStimBad;
        end
                
        fileNamePeakFR = [filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) ...
            '_Run' num2str(onlyRun) '.mat']; 
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        if(goodTr == 1)
            load(fullPath,'pFRNonStimGoodStruct','pFRNonStimCueGoodStruct','trialNoNonStimGood');
            indLaps = trialNoNonStimGood; 
            pFR = pFRNonStimGoodStruct;
            pFRCue = pFRNonStimCueGoodStruct;
        else
            load(fullPath,'pFRNonStimBadStruct','pFRNonStimCueBadStruct','trialNoNonStimBad');
            indLaps = trialNoNonStimBad; 
            pFR = pFRNonStimBadStruct;
            pFRCue = pFRNonStimCueBadStruct;
        end
                         
        fileNameCorr = [filenames(i,:) '_meanSpikesCorrDistAligned_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '_intD' ...
            num2str(intervalD) '.mat'];
        fullPath = [paths(i,:) fileNameCorr];
        if(exist(fullPath) == 0)
            disp('_meanSpikesCorrTAligned file does not exist.');
            return;
        end
        load(fullPath,'meanCorrDistRun','meanCorrDistRew','meanCorrDistCue');
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp('_FieldSpCorrAligned file does not exist.');
            return;
        end
        load(fullPath, 'paramF');
                
        indNeu = mFRAll.mFR > minFR & mFRAll.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        modPyr.task = [modPyr.task task*ones(1,sum(indNeu))];
        modPyr.indRec = [modPyr.indRec i*ones(1,sum(indNeu))];
        modPyr.indNeu = [modPyr.indNeu find(indNeu == 1)]; 
        
        numNeu = sum(indNeu);
        if(length(indLaps) >= paramF.minNumTr) 
            if(goodTr == 1)
                modPyr.meanCorrDistRun = [modPyr.meanCorrDistRun meanCorrDistRun.meanGood(indNeu)];
                modPyr.meanCorrDistRunNZ = [modPyr.meanCorrDistRunNZ meanCorrDistRun.meanGoodNZ(indNeu)];
                modPyr.meanCorrDistRew = [modPyr.meanCorrDistRew meanCorrDistRew.meanGood(indNeu)];
                modPyr.meanCorrDistRewNZ = [modPyr.meanCorrDistRewNZ meanCorrDistRew.meanGoodNZ(indNeu)];
                modPyr.meanCorrDistCue = [modPyr.meanCorrDistCue meanCorrDistCue.meanGood(indNeu)];
                modPyr.meanCorrDistCueNZ = [modPyr.meanCorrDistCueNZ meanCorrDistCue.meanGoodNZ(indNeu)];
            else
                modPyr.meanCorrDistRun = [modPyr.meanCorrDistRun meanCorrDistRun.meanBad(indNeu)];
                modPyr.meanCorrDistRunNZ = [modPyr.meanCorrDistRunNZ meanCorrDistRun.meanBadNZ(indNeu)];
                modPyr.meanCorrDistRew = [modPyr.meanCorrDistRew meanCorrDistRew.meanBad(indNeu)];
                modPyr.meanCorrDistRewNZ = [modPyr.meanCorrDistRewNZ meanCorrDistRew.meanBadNZ(indNeu)];
                modPyr.meanCorrDistCue = [modPyr.meanCorrDistCue meanCorrDistCue.meanBad(indNeu)];
                modPyr.meanCorrDistCueNZ = [modPyr.meanCorrDistCueNZ meanCorrDistCue.meanBadNZ(indNeu)];
            end
        else
            modPyr.meanCorrDistRun = [modPyr.meanCorrDistRun NaN(1,numNeu)];
            modPyr.meanCorrDistRunNZ = [modPyr.meanCorrDistRunNZ NaN(1,numNeu)];
            modPyr.meanCorrDistRew = [modPyr.meanCorrDistRew NaN(1,numNeu)];
            modPyr.meanCorrDistRewNZ = [modPyr.meanCorrDistRewNZ NaN(1,numNeu)];
            modPyr.meanCorrDistCue = [modPyr.meanCorrDistCue NaN(1,numNeu)];
            modPyr.meanCorrDistCueNZ = [modPyr.meanCorrDistCueNZ NaN(1,numNeu)];
        end
    end
end