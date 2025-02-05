function behAligned = accumBehInt(paths,filenames,mazeSess,task,onlyRun)
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
                    'meanLickNonStimPerRec',[],... % mean lick trace per recording (non-stimulated ctrl trials)
                    'semLickNonStimPerRec',[],... % mean lick trace per recording (non-stimulated ctrl trials)
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
                    'meanSpeedNonStimPerRec',[],... % mean speed trace per recording (non-stimulated ctrl trials)
                    'semSpeedNonStimPerRec',[],... % mean speed trace per recording (non-stimulated ctrl trials)
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
        
        fullPathLick = [filenames(i,:) '_lickDist_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathLick];
        if(exist(fullPath) == 0)
            disp('_lickDist.mat file does not exist.');
            return;
        end
        load(fullPath,'lickOverDist','param');
        paramLick = param;
        
        fullPathLick = [filenames(i,:) '_lickDistCtrl_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathLick];
        if(exist(fullPath) == 0)
            disp('_lickDist.mat file does not exist.');
            return;
        end
        load(fullPath,'lickOverDistCtrl');
        
        fullPathSpeed = [filenames(i,:) '_runSpeedDist_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathSpeed];
        if(exist(fullPath) == 0)
            disp('_runSpeedDist.mat file does not exist.');
            return;
        end
        load(fullPath,'speedOverDist','param');
        paramSpeed = param;
        
        fullPathLick = [filenames(i,:) '_runSpeedDistCtrl_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathLick];
        if(exist(fullPath) == 0)
            disp('_lickDist.mat file does not exist.');
            return;
        end
        load(fullPath,'speedOverDistCtrl');
        
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
            behAligned.meanLickPerRec = lickOverDist.meanRun;
            behAligned.semLickPerRec = lickOverDist.SEMRun;

            behAligned.meanSpeedPerRec = speedOverDist.meanRun;
            behAligned.semSpeedPerRec = speedOverDist.SEMRun;

        else
            behAligned.meanLickPerRec = [behAligned.meanLickPerRec; lickOverDist.meanRun];
            behAligned.semLickPerRec = [behAligned.semLickPerRec; lickOverDist.SEMRun];

            behAligned.meanSpeedPerRec = [behAligned.meanSpeedPerRec; speedOverDist.meanRun];
            behAligned.semSpeedPerRec = [behAligned.semSpeedPerRec; speedOverDist.SEMRun];
        end
        
        if(~isempty(trialNoNonStim) & length(trialNoNonStim) > paramF.minNumTr)
            behAligned.taskNonStim = [behAligned.taskNonStim task];
            behAligned.indRecNonStim = [behAligned.indRecNonStim i];            
            if(isempty(behAligned.meanLickNonStimPerRec))
                behAligned.meanLickNonStimPerRec = lickOverDistCtrl.meanRunNonStim;
                behAligned.semLickNonStimPerRec = lickOverDistCtrl.SEMRunNonStim;

                behAligned.meanSpeedNonStimPerRec = speedOverDistCtrl.meanRunNonStim;
                behAligned.semSpeedNonStimPerRec = speedOverDistCtrl.SEMRunNonStim;

            else
                behAligned.meanLickNonStimPerRec = [behAligned.meanLickNonStimPerRec; ...
                    lickOverDistCtrl.meanRunNonStim];
                behAligned.semLickNonStimPerRec = [behAligned.semLickNonStimPerRec;...
                    lickOverDistCtrl.SEMRunNonStim];

                behAligned.meanSpeedNonStimPerRec = [behAligned.meanSpeedNonStimPerRec; ...
                    speedOverDistCtrl.meanRunNonStim];
                behAligned.semSpeedNonStimGoodPerRec = [behAligned.semSpeedNonStimPerRec;...
                    speedOverDistCtrl.SEMRunNonStim];
            end
        end
        
        if(~isempty(trialNoNonStimGood) & length(trialNoNonStimGood) > paramF.minNumTr)
            behAligned.taskNonStimGood = [behAligned.taskNonStimGood task];
            behAligned.indRecNonStimGood = [behAligned.indRecNonStimGood i];            
            if(isempty(behAligned.meanLickNonStimGoodPerRec))
                behAligned.meanLickNonStimGoodPerRec = lickOverDist.meanRunNonStimGood;
                behAligned.semLickNonStimGoodPerRec = lickOverDist.SEMRunNonStimGood;

                behAligned.meanSpeedNonStimGoodPerRec = speedOverDist.meanRunNonStimGood;
                behAligned.semSpeedNonStimGoodPerRec = speedOverDist.SEMRunNonStimGood;

            else
                behAligned.meanLickNonStimGoodPerRec = [behAligned.meanLickNonStimGoodPerRec; ...
                    lickOverDist.meanRunNonStimGood];
                behAligned.semLickNonStimGoodPerRec = [behAligned.semLickNonStimGoodPerRec;...
                    lickOverDist.SEMRunNonStimGood];

                behAligned.meanSpeedNonStimGoodPerRec = [behAligned.meanSpeedNonStimGoodPerRec; ...
                    speedOverDist.meanRunNonStimGood];
                behAligned.semSpeedNonStimGoodPerRec = [behAligned.semSpeedNonStimGoodPerRec;...
                    speedOverDist.SEMRunNonStimGood];
            end
        end
        
        if(~isempty(trialNoNonStimBad) & length(trialNoNonStimBad) > paramF.minNumTr)
            behAligned.taskNonStimBad = [behAligned.taskNonStimBad task];
            behAligned.indRecNonStimBad = [behAligned.indRecNonStimBad i];
            if(isempty(behAligned.meanLickNonStimBadPerRec))
                behAligned.meanLickNonStimBadPerRec = lickOverDist.meanRunNonStimBad;
                behAligned.semLickNonStimBadPerRec = lickOverDist.SEMRunNonStimBad;
                
                behAligned.meanSpeedNonStimBadPerRec = speedOverDist.meanRunNonStimBad;
                behAligned.semSpeedNonStimBadPerRec = speedOverDist.SEMRunNonStimBad;
                
            else
                behAligned.meanLickNonStimBadPerRec = [behAligned.meanLickNonStimBadPerRec;...
                    lickOverDist.meanRunNonStimBad];
                behAligned.semLickNonStimBadPerRec = [behAligned.semLickNonStimBadPerRec;...
                    lickOverDist.SEMRunNonStimBad];
                
                behAligned.meanSpeedNonStimBadPerRec = [behAligned.meanSpeedNonStimBadPerRec;...
                    speedOverDist.meanRunNonStimBad];
                behAligned.semSpeedNonStimBadPerRec = [behAligned.semSpeedNonStimBadPerRec;...
                    speedOverDist.SEMRunNonStimBad];                
            end
        end
        
        for j = 1:length(trialNoStim)
            if(~isempty(trialNoStim{j}) & length(trialNoStim{j}) > paramF.minNumTr)
                behAligned.taskStim = [behAligned.taskStim task];
                behAligned.indRecStim = [behAligned.indRecStim i];
                behAligned.pulseMeth = [behAligned.pulseMeth pulseMeth(j)];
                if(isempty(behAligned.meanLickStimPerRec))
                    behAligned.meanLickStimPerRec = lickOverDist.meanRunStim{j};
                    behAligned.semLickStimPerRec = lickOverDist.SEMRunStim{j};

                    behAligned.meanSpeedStimPerRec = speedOverDist.meanRunStim{j};
                    behAligned.semSpeedStimPerRec = speedOverDist.SEMRunStim{j};

                else
                    behAligned.meanLickStimPerRec = [behAligned.meanLickStimPerRec;...
                        lickOverDist.meanRunStim{j}];
                    behAligned.semLickStimPerRec = [behAligned.semLickStimPerRec;...
                        lickOverDist.SEMRunStim{j}];

                    behAligned.meanSpeedStimPerRec = [behAligned.meanSpeedStimPerRec;...
                        speedOverDist.meanRunStim{j}];
                    behAligned.semSpeedStimPerRec = [behAligned.semSpeedStimPerRec;...
                        speedOverDist.SEMRunStim{j}];
                end
            end
        end
        
        nTr = size(speedOverDist.Run,1);
        if(nTr > randTrNo)
            indTrR = randperm(nTr);
            behAligned.lickTracePerRec{i} = lickOverDist.Run(indTrR(1:randTrNo),:);
            behAligned.speedTracePerRec{i} = speedOverDist.Run(indTrR(1:randTrNo),:);
        else
            behAligned.lickTracePerRec{i} = lickOverDist.Run;
            behAligned.speedTracePerRec{i} = speedOverDist.Run;
        end
        
        nTr = length(trialNoNonStim);
        if(nTr > randTrNo)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimPerRec{i} = lickOverDist.Run(trialNoNonStim(indTrR(1:randTrNo)),:);
            behAligned.speedTraceNonStimPerRec{i} = speedOverDist.Run(trialNoNonStim(indTrR(1:randTrNo)),:);
        else
            behAligned.lickTraceNonStimPerRec{i} = lickOverDist.Run(trialNoNonStim,:);
            behAligned.speedTraceNonStimPerRec{i} = speedOverDist.Run(trialNoNonStim,:);
        end
        
        nTr = length(trialNoNonStimGood);
        if(nTr > randTrNoGood)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimGoodPerRec{i} = lickOverDist.Run(trialNoNonStimGood(indTrR(1:randTrNoGood)),:);
            behAligned.speedTraceNonStimGoodPerRec{i} = speedOverDist.Run(trialNoNonStimGood(indTrR(1:randTrNoGood)),:);
        else
            behAligned.lickTraceNonStimGoodPerRec{i} = lickOverDist.Run(trialNoNonStimGood,:);
            behAligned.speedTraceNonStimGoodPerRec{i} = speedOverDist.Run(trialNoNonStimGood,:);
        end
        
        nTr = length(trialNoNonStimBad);
        if(nTr > randTrNoBad)
            indTrR = randperm(nTr);
            behAligned.lickTraceNonStimBadPerRec{i} = lickOverDist.Run(trialNoNonStimBad(indTrR(1:randTrNoBad)),:);
            behAligned.speedTraceNonStimBadPerRec{i} = speedOverDist.Run(trialNoNonStimBad(indTrR(1:randTrNoBad)),:);
        elseif(nTr > 0)
            behAligned.lickTraceNonStimBadPerRec{i} = lickOverDist.Run(trialNoNonStimBad,:);
            behAligned.speedTraceNonStimBadPerRec{i} = speedOverDist.Run(trialNoNonStimBad,:);
        end
        
        for j = 1:length(trialNoStim)
            nTr = length(trialNoStim{j});
            if(nTr > randTrNoStim)
                indTrR = randperm(nTr);
                behAligned.lickTraceStimPerRec{i,j} = lickOverDist.Run(trialNoStim{j}(indTrR(1:randTrNoStim)),:);
                behAligned.speedTraceStimPerRec{i,j} = speedOverDist.Run(trialNoStim{j}(indTrR(1:randTrNoStim)),:);
            elseif(nTr > 0)
                behAligned.lickTraceStimPerRec{i,j} = lickOverDist.Run(trialNoStim{j},:);
                behAligned.speedTraceStimPerRec{i,j} = speedOverDist.Run(trialNoStim{j},:);
            end
        end
    end        
end