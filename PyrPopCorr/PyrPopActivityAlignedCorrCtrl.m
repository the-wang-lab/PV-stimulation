function PyrPopActivityAlignedCorrCtrl(onlyRun)

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\PyramidalPopCorr\';
    
    if(exist(pathAnal0) == 0)
        mkdir(pathAnal0);
    end
    
    GlobalConstFq;
    
    disp('No cue')
    popCorrPyrNoCue = accumPyrPopCorr(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,1,onlyRun,intervalTPopCorr);
%     popCorrPyrFieldNoCue = accumPyrPopCorrField(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,1,onlyRun,intervalTPopCorr);

    disp('AL')
    popCorrPyrAL = accumPyrPopCorr(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,2,onlyRun,intervalTPopCorr);
    popCorrPyrFieldAL = accumPyrPopCorrField(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,2,onlyRun,intervalTPopCorr);
    
    disp('PL')
    popCorrPyrPL = accumPyrPopCorr(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,3,onlyRun,intervalTPopCorr);
    popCorrPyrFieldPL = accumPyrPopCorrField(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,3,onlyRun,intervalTPopCorr);

    save([pathAnal0,'PyrPopActCorrCtrl.mat'],'popCorrPyrNoCue','popCorrPyrAL','popCorrPyrPL',...
        'popCorrPyrFieldAL','popCorrPyrFieldPL');
    
end

function popCorrPyr = accumPyrPopCorr(paths,filenames,mazeSess,task,onlyRun,intervalT)
    
    numRec = size(paths,1);
    
    popCorrPyr = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                          'indRec',[],... % recording index
                          'meanNoStimGoodRun',[],... % mean population correlation non stim good trials
                          'meanNoStimBadRun',[],... % mean population correlation non stim bad trials
                          'meanNoStimRun',[],... % mean population correlation non stim trials
                          ...
                          'meanNoStimGoodRew',[],... % mean population correlation non stim good trials
                          'meanNoStimBadRew',[],... % mean population correlation non stim bad trials
                          'meanNoStimRew',[],... % mean population correlation non stim trials
                          ...
                          ...
                          'meanNoStimGoodCue',[],... % mean population correlation non stim good trials
                          'meanNoStimBadCue',[],... % mean population correlation non stim bad trials
                          'meanNoStimCue',[]); % mean population correlation non stim trials
                              
    for i = 1:numRec
        
        fullPath = [paths(i,:) filenames(i,:) '_popCorrT_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '_intT' ...
            num2str(intervalT) '.mat'];
        
        if(exist(fullPath) == 0)
            disp('The _popCorrTAligned_Run file does not exist');
            return;
        end
        load(fullPath,'popCorrTRun','popCorrTRew','popCorrTCue');  
        
        fullPath = [paths(i,:) filenames(i,:) '_meanPopCorrT_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '_intT' ...
                num2str(intervalT) '.mat'];
        if(exist(fullPath) == 0)
            disp('The meanPopSpikeCorrT file does not exist');
            return;
        end
        load(fullPath,'meanPopCorrTRun','meanPopCorrTRew','meanPopCorrTCue');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad','trialNoStim','trialNoStimCtrl','pulseMeth');

        fullPath = [paths(i,:) filenames(i,:) '_behPar_msess' num2str(mazeSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The _behPar file does not exist');
            return;
        end
        load(fullPath);
        
        popCorrPyr.task(i) = task;
        popCorrPyr.indRec(i) = i;
        
        popCorrPyr.meanNoStimGoodRun(i) = meanPopCorrTRun.meanNoStimGood;
        popCorrPyr.meanNoStimBadRun(i) = meanPopCorrTRun.meanNoStimBad;
                
        % reward aligned correlation good no stim trials
        goodNoStimTrCorr = popCorrTRew(trialNoNonStimGood,trialNoNonStimGood);
        goodNoStimTrCorr = triu(goodNoStimTrCorr,1);
        goodNoStimTrCorr = goodNoStimTrCorr(:);
        nNoStimGoodTr = length(trialNoNonStimGood);
        nElemNoStimGood = (nNoStimGoodTr*nNoStimGoodTr-nNoStimGoodTr)/2;
        popCorrPyr.meanNoStimGoodRew(i) = sum(goodNoStimTrCorr(isnan(goodNoStimTrCorr) == 0))/nElemNoStimGood;
        popCorrPyr.nNoStimGoodTr(i) = nNoStimGoodTr;

        % cue aligned correlation good no stim trials
        goodNoStimTrCorr = popCorrTCue(trialNoNonStimGood,trialNoNonStimGood);
        goodNoStimTrCorr = triu(goodNoStimTrCorr,1);
        goodNoStimTrCorr = goodNoStimTrCorr(:);
        nElemNoStimGood = (nNoStimGoodTr*nNoStimGoodTr-nNoStimGoodTr)/2;
        popCorrPyr.meanNoStimGoodCue(i) = sum(goodNoStimTrCorr(isnan(goodNoStimTrCorr) == 0))/nElemNoStimGood;
        
        % reward aligned correlation bad no stim trials
        badNoStimTrCorr = popCorrTRew(trialNoNonStimBad,trialNoNonStimBad);
        badNoStimTrCorr = triu(badNoStimTrCorr,1);
        badNoStimTrCorr = badNoStimTrCorr(:);
        nNoStimBadTr = length(trialNoNonStimBad);
        nElemNoStimBad = (nNoStimBadTr*nNoStimBadTr-nNoStimBadTr)/2;
        popCorrPyr.meanNoStimBadRew(i) = sum(badNoStimTrCorr(isnan(badNoStimTrCorr) == 0))/nElemNoStimBad;
        popCorrPyr.nNoStimBadTr(i) = nNoStimBadTr;
        
        % cue aligned correlation bad no stim trials
        badNoStimTrCorr = popCorrTCue(trialNoNonStimBad,trialNoNonStimBad);
        badNoStimTrCorr = triu(badNoStimTrCorr,1);
        badNoStimTrCorr = badNoStimTrCorr(:);
        nNoStimBadTr = length(trialNoNonStimBad);
        nElemNoStimBad = (nNoStimBadTr*nNoStimBadTr-nNoStimBadTr)/2;
        popCorrPyr.meanNoStimBadCue(i) = sum(badNoStimTrCorr(isnan(badNoStimTrCorr) == 0))/nElemNoStimBad;
    
        % ctrl trials run
        trialNoNonStim = [trialNoNonStimGood;trialNoNonStimBad];
        noStimTrCorr = popCorrTRun(trialNoNonStim,trialNoNonStim);
        noStimTrCorr = triu(noStimTrCorr,1);
        noStimTrCorr = noStimTrCorr(:);
        nNoStimTr = length(trialNoNonStim);
        nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
        popCorrPyr.meanNoStimRun(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
        popCorrPyr.nNoStimTr(i) = nNoStimTr;
        
        % ctrl trials rew
        noStimTrCorr = popCorrTRew(trialNoNonStim,trialNoNonStim);
        noStimTrCorr = triu(noStimTrCorr,1);
        noStimTrCorr = noStimTrCorr(:);
        nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
        popCorrPyr.meanNoStimRew(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
        
        % ctrl trials cue
        noStimTrCorr = popCorrTCue(trialNoNonStim,trialNoNonStim);
        noStimTrCorr = triu(noStimTrCorr,1);
        noStimTrCorr = noStimTrCorr(:);
        nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
        popCorrPyr.meanNoStimCue(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
        
    end
end

function popCorrPyrField = accumPyrPopCorrField(paths,filenames,mazeSess,task,onlyRun,intervalT)
    
    numRec = size(paths,1);
    
    popCorrPyrField = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                          'indRec',[],... % recording index
                          'popCorrExist',[],... % pop corr exists when number of neurons with field >= 2
                          ...
                          'meanNoStimGoodRun',[],... % mean population correlation non stim good trials
                          'meanNoStimBadRun',[],... % mean population correlation non stim bad trials
                          'meanNoStimRun',[],... % mean population correlation non stim trials
                          ...
                          'meanNoStimGoodRew',[],... % mean population correlation non stim good trials
                          'meanNoStimBadRew',[],... % mean population correlation non stim bad trials
                          'meanNoStimRew',[],... % mean population correlation non stim trials
                          ...
                          ...
                          'meanNoStimGoodCue',[],... % mean population correlation non stim good trials
                          'meanNoStimBadCue',[],... % mean population correlation non stim bad trials
                          'meanNoStimCue',[]); % mean population correlation non stim trials
                              
    for i = 1:numRec
        
        fullPath = [paths(i,:) filenames(i,:) '_popCorrTField_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '_intT' ...
            num2str(intervalT) '.mat'];
        
        if(exist(fullPath) == 0)
            disp('The _popCorrTField file does not exist');
            return;
        end
        load(fullPath,'popCorrTRun','popCorrTRew','popCorrTCue');  
        
        fullPath = [paths(i,:) filenames(i,:) '_meanPopCorrTField_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '_intT' ...
                num2str(intervalT) '.mat'];
        if(exist(fullPath) == 0)
            disp('The meanPopSpikeCorrTField file does not exist');
            return;
        end
        load(fullPath,'meanPopCorrTRun','meanPopCorrTRew','meanPopCorrTCue');
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad','trialNoStim','trialNoStimCtrl','pulseMeth');

        fullPath = [paths(i,:) filenames(i,:) '_behPar_msess' num2str(mazeSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The _behPar file does not exist');
            return;
        end
        load(fullPath);
        
        popCorrPyrField.task(i) = task;
        popCorrPyrField.indRec(i) = i;
        
        if(~isempty(popCorrTRun))
            popCorrPyrField.popCorrExist(i) = 1;
        else
            popCorrPyrField.popCorrExist(i) = 0;
        end
        
        popCorrPyrField.meanNoStimGoodRun(i) = meanPopCorrTRun.meanNoStimGood;
        popCorrPyrField.meanNoStimBadRun(i) = meanPopCorrTRun.meanNoStimBad;
                
        % reward aligned correlation good no stim trials
        if(~isempty(popCorrTRew))
            goodNoStimTrCorr = popCorrTRew(trialNoNonStimGood,trialNoNonStimGood);
            goodNoStimTrCorr = triu(goodNoStimTrCorr,1);
            goodNoStimTrCorr = goodNoStimTrCorr(:);
            nNoStimGoodTr = length(trialNoNonStimGood);
            nElemNoStimGood = (nNoStimGoodTr*nNoStimGoodTr-nNoStimGoodTr)/2;
            popCorrPyrField.meanNoStimGoodRew(i) = sum(goodNoStimTrCorr(isnan(goodNoStimTrCorr) == 0))/nElemNoStimGood;
            popCorrPyrField.nNoStimGoodTr(i) = nNoStimGoodTr;
        else
            popCorrPyrField.meanNoStimGoodRew(i) = 0;
            popCorrPyrField.nNoStimGoodTr(i) = length(trialNoNonStimGood);
        end

        % cue aligned correlation good no stim trials
        if(~isempty(popCorrTCue))
            goodNoStimTrCorr = popCorrTCue(trialNoNonStimGood,trialNoNonStimGood);
            goodNoStimTrCorr = triu(goodNoStimTrCorr,1);
            goodNoStimTrCorr = goodNoStimTrCorr(:);
            nElemNoStimGood = (nNoStimGoodTr*nNoStimGoodTr-nNoStimGoodTr)/2;
            popCorrPyrField.meanNoStimGoodCue(i) = sum(goodNoStimTrCorr(isnan(goodNoStimTrCorr) == 0))/nElemNoStimGood;
        else
            popCorrPyrField.meanNoStimGoodCue(i) = 0;
        end
        
        % reward aligned correlation bad no stim trials
        if(~isempty(popCorrTRew))
            badNoStimTrCorr = popCorrTRew(trialNoNonStimBad,trialNoNonStimBad);
            badNoStimTrCorr = triu(badNoStimTrCorr,1);
            badNoStimTrCorr = badNoStimTrCorr(:);
            nNoStimBadTr = length(trialNoNonStimBad);
            nElemNoStimBad = (nNoStimBadTr*nNoStimBadTr-nNoStimBadTr)/2;
            popCorrPyrField.meanNoStimBadRew(i) = sum(badNoStimTrCorr(isnan(badNoStimTrCorr) == 0))/nElemNoStimBad;
            popCorrPyrField.nNoStimBadTr(i) = nNoStimBadTr;
        else
            popCorrPyrField.meanNoStimBadRew(i) = 0;
            popCorrPyrField.nNoStimBadTr(i) = length(trialNoNonStimBad);
        end
        
        % cue aligned correlation bad no stim trials
        if(~isempty(popCorrTCue))
            badNoStimTrCorr = popCorrTCue(trialNoNonStimBad,trialNoNonStimBad);
            badNoStimTrCorr = triu(badNoStimTrCorr,1);
            badNoStimTrCorr = badNoStimTrCorr(:);
            nNoStimBadTr = length(trialNoNonStimBad);
            nElemNoStimBad = (nNoStimBadTr*nNoStimBadTr-nNoStimBadTr)/2;
            popCorrPyrField.meanNoStimBadCue(i) = sum(badNoStimTrCorr(isnan(badNoStimTrCorr) == 0))/nElemNoStimBad;
        else
            popCorrPyrField.meanNoStimBadCue(i) = 0;
        end
        
        % ctrl trials run
        trialNoNonStim = [trialNoNonStimGood;trialNoNonStimBad];
        if(~isempty(popCorrTRun))
            noStimTrCorr = popCorrTRun(trialNoNonStim,trialNoNonStim);
            noStimTrCorr = triu(noStimTrCorr,1);
            noStimTrCorr = noStimTrCorr(:);
            nNoStimTr = length(trialNoNonStim);
            nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
            popCorrPyrField.meanNoStimRun(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
            popCorrPyrField.nNoStimTr(i) = nNoStimTr;
        else
            popCorrPyrField.meanNoStimRun(i) = 0;
            popCorrPyrField.nNoStimTr(i) = length(trialNoNonStim);
        end
        
        % ctrl trials rew
        if(~isempty(popCorrTRew))
            noStimTrCorr = popCorrTRew(trialNoNonStim,trialNoNonStim);
            noStimTrCorr = triu(noStimTrCorr,1);
            noStimTrCorr = noStimTrCorr(:);
            nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
            popCorrPyrField.meanNoStimRew(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
        else
            popCorrPyrField.meanNoStimRew(i) = 0;
        end
        
        % ctrl trials cue
        if(~isempty(popCorrTCue))
            noStimTrCorr = popCorrTCue(trialNoNonStim,trialNoNonStim);
            noStimTrCorr = triu(noStimTrCorr,1);
            noStimTrCorr = noStimTrCorr(:);
            nElemNoStim = (nNoStimTr*nNoStimTr-nNoStimTr)/2;
            popCorrPyrField.meanNoStimCue(i) = sum(noStimTrCorr(isnan(noStimTrCorr) == 0))/nElemNoStim;
        else
            popCorrPyrField.meanNoStimCue(i) = 0;
        end
    end
end