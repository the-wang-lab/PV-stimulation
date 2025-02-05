function behAligned = accumBehTime(paths,filenames,mazeSess,task,onlyRun)
%% accumulate behavior across sessions
% this function is called by PyrBehAlignedAllRec.m

    randTrNo = 15;
    randTrNoGood = 15;
    randTrNoBad = 15;
    randTrNoStim = 15;

    numRec = size(paths,1);
    behAligned = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                    'taskNonStim',[],... % no cue - 1, AL - 2, PL - 3
                    'taskNonStimGood',[],... % no cue - 1, AL - 2, PL - 3
                    'taskNonStimBad',[],... % no cue - 1, AL - 2, PL - 3
                    'taskStim',[],... % no cue - 1, AL - 2, PL - 3
                    ...
                    'percGoodNonStim',[],...
                    ...
                    'indRec',[],... % recording index for all the recordings
                    'indRecNonStim',[],... % recording index for all the recordings with non-stimulated ctrl trials
                    'indRecNonStimGood',[],... % recording index for all the recordings with non-stimulated good trials
                    'indRecNonStimBad',[],... % recording index for all the recordings with non-stimulated bad trials
                    'indRecStim',[],... % recording index for all the reoordings with stimulated trials
                    'pulseMeth',[],... % pulse method
                    ...
                    'meanLickPerRec',[],... % mean lick trace per recording
                    'semLickPerRec',[],... % mean lick trace per recording
                    'lickTracePerRec',{cell(1,numRec)},...
                    ...
                    'lickTraceNonStimPerRec',{cell(1,numRec)},... (non-stimulated ctrl trials)
                    ...
                    'meanLickNonStimGoodPerRec',[],... % mean lick trace per recording (non-stimulated good trials)
                    'semLickNonStimGoodPerRec',[],... % mean lick trace per recording (non-stimulated good trials)
                    'lickTraceNonStimGoodPerRec',{cell(1,numRec)},... (non-stimulated good trials)
                    ...
                    'meanLickNonStimBadPerRec',[],... % mean lick trace per recording (non-stimulated bad trials)
                    'semLickNonStimBadPerRec',[],... % mean lick trace per recording (non-stimulated bad trials)
                    'lickTraceNonStimBadPerRec',{cell(1,numRec)},... (non-stimulated bad trials)
                    ...
                    'meanLickStimPerRec',[],... % mean lick trace per recording (stimulated trials)
                    'semLickStimPerRec',[],... % mean lick trace per recording (stimulated trials)
                    'lickTraceStimPerRec',{cell(1,numRec)},... (stimulated trials)
                    ...
                    'meanSpeedPerRec',[],... % mean speed trace per recording
                    'semSpeedPerRec',[],... % mean speed trace per recording
                    'speedTracePerRec',{cell(1,numRec)},... 
                    ...
                    'speedTraceNonStimPerRec',{cell(1,numRec)},... (non-stimulated ctrl trials)
                    ...
                    'meanSpeedNonStimGoodPerRec',[],... % mean speed trace per recording (non-stimulated good trials)
                    'semSpeedNonStimGoodPerRec',[],... % mean speed trace per recording (non-stimulated good trials)
                    'speedTraceNonStimGoodPerRec',{cell(1,numRec)},... (non-stimulated good trials)
                    ...
                    'meanSpeedNonStimBadPerRec',[],... % mean speed trace per recording (non-stimulated bad trials)
                    'semSpeedNonStimBadPerRec',[],... % mean speed trace per recording (non-stimulated bad trials)
                    'speedTraceNonStimBadPerRec',{cell(1,numRec)},... (non-stimulated bad trials)
                    ...
                    'meanSpeedStimPerRec',[],... % mean speed trace per recording (stimulated trials)
                    'semSpeedStimPerRec',[],... % mean speed trace per recording (stimulated trials)
                    'speedTraceStimPerRec',{cell(1,numRec)}); % (stimulated trials)
                
                              
    
    for i = 1:numRec
        if(task == 3 & i == 8)
            a = 1;
        end
        disp(filenames(i,:));        
        
        fullPathBeh = [filenames(i,:) '_behPar_msess' num2str(mazeSess(i)) '.mat'];
        fullPath = [paths(i,:) fullPathBeh];
        if(exist(fullPath) == 0)
            disp('_behPar.mat file does not exist.');
            return;
        end
        load(fullPath,'behPar');
        
        fullPathLick = [filenames(i,:) '_lickTime_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathLick];
        if(exist(fullPath) == 0)
            disp('_lickDist.mat file does not exist.');
            return;
        end
        load(fullPath,'lickOverTime','param');
        paramLick = param;
        
        fullPathSpeed = [filenames(i,:) '_runSpeedTime_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathSpeed];
        if(exist(fullPath) == 0)
            disp('_runSpeedTime.mat file does not exist.');
            return;
        end
        load(fullPath,'speedOverTime','param');
        paramSpeed = param;
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad','trialNoStim','pulseMeth');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAlignedCtrl_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStim');
        
        fileNameFW = [filenames(i,:) '_FieldSpCorr_GoodTr_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        behAligned.spaceStepsLick = paramLick.spaceSteps;
        behAligned.spaceStepsSpeed = paramSpeed.spaceSteps;
        behAligned.task = [behAligned.task task];
        behAligned.indRec = [behAligned.indRec i];       
       
        if(isempty(behAligned.meanLickPerRec))
            behAligned.meanLickPerRec = lickOverTime.meanRun;
            behAligned.semLickPerRec = lickOverTime.SEMRun;

            behAligned.meanSpeedPerRec = speedOverTime.meanRun;
            behAligned.semSpeedPerRec = speedOverTime.SEMRun;

        else
            behAligned.meanLickPerRec = [behAligned.meanLickPerRec; lickOverTime.meanRun];
            behAligned.semLickPerRec = [behAligned.semLickPerRec; lickOverTime.SEMRun];

            behAligned.meanSpeedPerRec = [behAligned.meanSpeedPerRec; speedOverTime.meanRun];
            behAligned.semSpeedPerRec = [behAligned.semSpeedPerRec; speedOverTime.SEMRun];
        end
        
        if(~isempty(trialNoNonStim) & length(trialNoNonStim) > paramF.minNumTr)
            behAligned.taskNonStim = [behAligned.taskNonStim task];
            behAligned.indRecNonStim = [behAligned.indRecNonStim i];  
        end
        
        if(~isempty(trialNoNonStimGood) & length(trialNoNonStimGood) > paramF.minNumTr)
            behAligned.taskNonStimGood = [behAligned.taskNonStimGood task];
            behAligned.indRecNonStimGood = [behAligned.indRecNonStimGood i];            
            if(isempty(behAligned.meanLickNonStimGoodPerRec))
                behAligned.meanLickNonStimGoodPerRec = lickOverTime.meanRunNonStimGood;
                behAligned.semLickNonStimGoodPerRec = lickOverTime.SEMRunNonStimGood;

                behAligned.meanSpeedNonStimGoodPerRec = speedOverTime.meanRunNonStimGood;
                behAligned.semSpeedNonStimGoodPerRec = speedOverTime.SEMRunNonStimGood;
            else
                behAligned.meanLickNonStimGoodPerRec = [behAligned.meanLickNonStimGoodPerRec; ...
                    lickOverTime.meanRunNonStimGood];
                behAligned.semLickNonStimGoodPerRec = [behAligned.semLickNonStimGoodPerRec;...
                    lickOverTime.SEMRunNonStimGood];

                behAligned.meanSpeedNonStimGoodPerRec = [behAligned.meanSpeedNonStimGoodPerRec; ...
                    speedOverTime.meanRunNonStimGood];
                behAligned.semSpeedNonStimGoodPerRec = [behAligned.semSpeedNonStimGoodPerRec;...
                    speedOverTime.SEMRunNonStimGood];
            end
        end
        
        if(~isempty(trialNoNonStimBad) & length(trialNoNonStimBad) > paramF.minNumTr)
            behAligned.taskNonStimBad = [behAligned.taskNonStimBad task];
            behAligned.indRecNonStimBad = [behAligned.indRecNonStimBad i];
            if(isempty(behAligned.meanLickNonStimBadPerRec))
                behAligned.meanLickNonStimBadPerRec = lickOverTime.meanRunNonStimBad;
                behAligned.semLickNonStimBadPerRec = lickOverTime.SEMRunNonStimBad;
                
                behAligned.meanSpeedNonStimBadPerRec = speedOverTime.meanRunNonStimBad;
                behAligned.semSpeedNonStimBadPerRec = speedOverTime.SEMRunNonStimBad;
                
            else
                behAligned.meanLickNonStimBadPerRec = [behAligned.meanLickNonStimBadPerRec;...
                    lickOverTime.meanRunNonStimBad];
                behAligned.semLickNonStimBadPerRec = [behAligned.semLickNonStimBadPerRec;...
                    lickOverTime.SEMRunNonStimBad];
                
                behAligned.meanSpeedNonStimBadPerRec = [behAligned.meanSpeedNonStimBadPerRec;...
                    speedOverTime.meanRunNonStimBad];
                behAligned.semSpeedNonStimBadPerRec = [behAligned.semSpeedNonStimBadPerRec;...
                    speedOverTime.SEMRunNonStimBad];                
            end
        end
        
        for j = 1:length(trialNoStim)
            if(~isempty(trialNoStim{j}) & length(trialNoStim{j}) > paramF.minNumTr)
                behAligned.taskStim = [behAligned.taskStim task];
                behAligned.indRecStim = [behAligned.indRecStim i];
                behAligned.pulseMeth = [behAligned.pulseMeth pulseMeth(j)];
                if(isempty(behAligned.meanLickStimPerRec))
                    behAligned.meanLickStimPerRec = lickOverTime.meanRunStim{j};
                    behAligned.semLickStimPerRec = lickOverTime.SEMRunStim{j};

                    behAligned.meanSpeedStimPerRec = speedOverTime.meanRunStim{j};
                    behAligned.semSpeedStimPerRec = speedOverTime.SEMRunStim{j};

                else
                    behAligned.meanLickStimPerRec = [behAligned.meanLickStimPerRec;...
                        lickOverTime.meanRunStim{j}];
                    behAligned.semLickStimPerRec = [behAligned.semLickStimPerRec;...
                        lickOverTime.SEMRunStim{j}];

                    behAligned.meanSpeedStimPerRec = [behAligned.meanSpeedStimPerRec;...
                        speedOverTime.meanRunStim{j}];
                    behAligned.semSpeedStimPerRec = [behAligned.semSpeedStimPerRec;...
                        speedOverTime.SEMRunStim{j}];
                end
            end
        end
        
        nTr = size(speedOverTime.Run,1);
        if(nTr > randTrNo)
            indTrR = randperm(nTr);
            behAligned.lickTracePerRec{i} = lickOverTime.Run(indTrR(1:randTrNo),:);
            behAligned.speedTracePerRec{i} = speedOverTime.Run(indTrR(1:randTrNo),:);
        else
            behAligned.lickTracePerRec{i} = lickOverTime.Run;
            behAligned.speedTracePerRec{i} = speedOverTime.Run;
        end
        
        nTr = length(trialNoNonStim);
        if(nTr > randTrNo)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimPerRec{i} = lickOverTime.Run(trialNoNonStim(indTrR(1:randTrNo)),:);
            behAligned.speedTraceNonStimPerRec{i} = speedOverTime.Run(trialNoNonStim(indTrR(1:randTrNo)),:);
        else
            behAligned.lickTraceNonStimPerRec{i} = lickOverTime.Run(trialNoNonStim,:);
            behAligned.speedTraceNonStimPerRec{i} = speedOverTime.Run(trialNoNonStim,:);
        end
        
        nTr = length(trialNoNonStimGood);
        if(nTr > randTrNoGood)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimGoodPerRec{i} = lickOverTime.Run(trialNoNonStimGood(indTrR(1:randTrNoGood)),:);
            behAligned.speedTraceNonStimGoodPerRec{i} = speedOverTime.Run(trialNoNonStimGood(indTrR(1:randTrNoGood)),:);
        else
            behAligned.lickTraceNonStimGoodPerRec{i} = lickOverTime.Run(trialNoNonStimGood,:);
            behAligned.speedTraceNonStimGoodPerRec{i} = speedOverTime.Run(trialNoNonStimGood,:);
        end
        
        nTr = length(trialNoNonStimBad);
        if(nTr > randTrNoBad)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimBadPerRec{i} = lickOverTime.Run(trialNoNonStimBad(indTrR(1:randTrNoBad)),:);
            behAligned.speedTraceNonStimBadPerRec{i} = speedOverTime.Run(trialNoNonStimBad(indTrR(1:randTrNoBad)),:);
        elseif(nTr > 0)
            behAligned.lickTraceNonStimBadPerRec{i} = lickOverTime.Run(trialNoNonStimBad,:);
            behAligned.speedTraceNonStimBadPerRec{i} = speedOverTime.Run(trialNoNonStimBad,:);
        end
        
        for j = 1:length(trialNoStim)
            nTr = length(trialNoStim{j});
            if(nTr > randTrNoStim)
                indTrR = randperm(nTr);
                behAligned.lickTraceStimPerRec{i,j} = lickOverTime.Run(trialNoStim{j}(indTrR(1:randTrNoStim)),:);
                behAligned.speedTraceStimPerRec{i,j} = speedOverTime.Run(trialNoStim{j}(indTrR(1:randTrNoStim)),:);
            elseif(nTr > 0)
                behAligned.lickTraceStimPerRec{i,j} = lickOverTime.Run(trialNoStim{j},:);
                behAligned.speedTraceStimPerRec{i,j} = speedOverTime.Run(trialNoStim{j},:);
            end
        end
    end        
end