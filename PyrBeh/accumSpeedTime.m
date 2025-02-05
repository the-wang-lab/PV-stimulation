function behAligned = accumSpeedTime(paths,filenames,mazeSess,task,onlyRun)
% accumulate speed and time
% this function is called by PyrBehAlignedAllRec.m

    numRec = size(paths,1);
    behAligned = struct(...
                    'taskNonStimGood',[],... % no cue - 1, AL - 2, PL - 3
                    'taskNonStimBad',[],... % no cue - 1, AL - 2, PL - 3
                    ...
                    'indRecNonStimGood',[],... % recording index for all the reoordings with non-stimulated good trials
                    'indRecNonStimBad',[],... % recording index for all the reoordings with non-stimulated bad trials
                    ...
                    'timeStep',[],...
                    ...
                    'meanSpeedTimeNonStimGoodPerRec',[],... % mean speed trace per recording (non-stimulated good trials)
                    'semSpeedTimeNonStimGoodPerRec',[],... % mean speed trace per recording (non-stimulated good trials)
                    ...
                    'meanSpeedTimeNonStimBadPerRec',[],... % mean speed trace per recording (non-stimulated bad trials)
                    'semSpeedTimeNonStimBadPerRec',[]); % mean speed trace per recording (non-stimulated bad trials)

    for i = 1:numRec
        if(task == 3 & i == 8)
            a = 1;
        end
        disp(filenames(i,:));            
        
        fullPathSpeed = [filenames(i,:) '_thetaPhaseOverTimeligned_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathSpeed];
        if(exist(fullPath) == 0)
            disp('_thetaPhaseOverTimeligned.mat file does not exist.');
            return;
        end
        load(fullPath,'runSpeedNonStimGood','runSpeedNonStimBad','paramC');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad','trialNoStim','pulseMeth');
        
        fileNameFW = [filenames(i,:) '_FieldSpCorr_GoodTr_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        behAligned.timeStep = paramC.timeIncBef;
        
        if(~isempty(trialNoNonStimGood) & length(trialNoNonStimGood) > paramF.minNumTr)
            behAligned.taskNonStimGood = [behAligned.taskNonStimGood task];
            behAligned.indRecNonStimGood = [behAligned.indRecNonStimGood i];
            meanRunNonStimGood = mean(runSpeedNonStimGood);
            SEMRunNonStimGood = std(runSpeedNonStimGood)/sqrt(length(trialNoNonStimGood));
            if(isempty(behAligned.meanSpeedTimeNonStimGoodPerRec))
                behAligned.meanSpeedTimeNonStimGoodPerRec = meanRunNonStimGood;
                behAligned.semSpeedTimeNonStimGoodPerRec = SEMRunNonStimGood;
            else
                behAligned.meanSpeedTimeNonStimGoodPerRec = [behAligned.meanSpeedTimeNonStimGoodPerRec; ...
                    meanRunNonStimGood];
                behAligned.semSpeedTimeNonStimGoodPerRec = [behAligned.semSpeedTimeNonStimGoodPerRec;...
                    SEMRunNonStimGood];
            end
        end
        
        if(~isempty(trialNoNonStimBad) & length(trialNoNonStimBad) > paramF.minNumTr)
            behAligned.taskNonStimBad = [behAligned.taskNonStimBad task];
            behAligned.indRecNonStimBad = [behAligned.indRecNonStimBad i];
            meanRunNonStimBad = mean(runSpeedNonStimBad);
            SEMRunNonStimBad = std(runSpeedNonStimBad)/sqrt(length(trialNoNonStimBad));
            if(isempty(behAligned.meanSpeedTimeNonStimBadPerRec))
                behAligned.meanSpeedTimeNonStimBadPerRec = meanRunNonStimBad;
                behAligned.semSpeedTimeNonStimBadPerRec = SEMRunNonStimBad;
            else
                behAligned.meanSpeedTimeNonStimBadPerRec = [behAligned.meanSpeedTimeNonStimBadPerRec;...
                    meanRunNonStimBad];
                behAligned.semSpeedTimeNonStimBadPerRec = [behAligned.semSpeedTimeNonStimBadPerRec;...
                    SEMRunNonStimBad];
            end
        end
        
    end        
end