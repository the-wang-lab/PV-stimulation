function ProcessRecordingBehMusc(path,recName,sessNo,mazeSessArr,injectionSess)
% process individual files in a recording
% e.g.: ProcessRecordingBeh('Z:\Yingxue\DataAnalysisXiaoliang\A517-20191114\','A517-20191114',[1 3 4 5],[])

    onlyRun = 1;
    
    if(isempty(mazeSessArr))
        mazeSessArr = ones(1,length(sessNo));
    end
    
    % compare between different sessions
    sessDataRun = compBehRun(path,recName,sessNo,mazeSessArr);
        
    sessDataCue = compBehCue(path,recName,sessNo);
    
    sessDataLick = compBehLick(path,recName,sessNo);
    
    sessDataSpeed = compBehSpeed(path,recName,sessNo,onlyRun);
    
    sessDataRecTime = compRecTime(path,recName,sessNo,injectionSess);
    
    fullPath = [path '\' recName '_compSess.mat'];
    save(fullPath, 'sessDataRun','sessDataLick','sessDataSpeed','sessDataRecTime');
    save(fullPath,'sessDataCue','-append');
    
    close all;
end


function sessData = compBehRun(path,recName,sessNo,mazeSess)
    nSess = length(sessNo);
    sessData.sessNo = sessNo;
    sessData.numSamplesMean = zeros(1,nSess);
    sessData.numSamplesSEM = zeros(1,nSess);
    sessData.maxSpeedMean = zeros(1,nSess);
    sessData.maxSpeedSEM = zeros(1,nSess);
    sessData.meanSpeedMean = zeros(1,nSess);
    sessData.meanSpeedSEM = zeros(1,nSess);
    sessData.maxSpeedRunMean = zeros(1,nSess);
    sessData.maxSpeedRunSEM = zeros(1,nSess);
    sessData.meanSpeedRunMean = zeros(1,nSess);
    sessData.meanSpeedRunSEM = zeros(1,nSess);
    sessData.maxRunLenTMean = zeros(1,nSess);
    sessData.maxRunLenTSEM = zeros(1,nSess);
    sessData.totRunLenTMean = zeros(1,nSess);
    sessData.totRunLenTSEM = zeros(1,nSess);
    sessData.numRunMean = zeros(1,nSess);
    sessData.numRunSEM = zeros(1,nSess);
    sessData.maxAccMean = zeros(1,nSess);
    sessData.maxAccSEM = zeros(1,nSess);    
    sessData.meanAccMean = zeros(1,nSess);
    sessData.meanAccSEM = zeros(1,nSess);
    sessData.totStopLenTMean = zeros(1,nSess);
    sessData.totStopLenTSEM = zeros(1,nSess);
    sessData.startCueToRunMean = zeros(1,nSess);
    sessData.startCueToRunSEM = zeros(1,nSess);
    sessData.med1stFiveLickDistMean = zeros(1,nSess);
    sessData.med1stFiveLickDistSEM = zeros(1,nSess);
    sessData.medLickDistMean = zeros(1,nSess);
    sessData.medLickDistSEM = zeros(1,nSess);
    sessData.med1stFiveLickDistBefRewMean = zeros(1,nSess);
    sessData.med1stFiveLickDistBefRewSEM = zeros(1,nSess);
    sessData.medLickDistBefRewMean = zeros(1,nSess);
    sessData.medLickDistBefRewSEM = zeros(1,nSess);
    sessData.percNonStop = zeros(1,nSess);
    sessData.meanSpeedProfile = [];
    
    for i = 1:nSess
        fileName = [recName '-0' num2str(sessNo(i))];
        pathTmp = [path fileName '\'];

        fullpath = [pathTmp fileName '_behPar.mat'];
        if(~exist(fullpath,'file'))
            disp([fullpath ' does not exist.']);
            return;
        end
        load(fullpath,'behParRun','param');
        
        fullPath = [pathTmp fileName '_alignRun_msess' num2str(mazeSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The aligned to run file does not exist');
            return;
        end
        load(fullPath,'trialsRun');
        
        trInd = param.startTr:param.endTr;
        nTr = length(trInd);
            
        sessData.numSamplesMean(i) = mean(behParRun.numSamples(trInd));
        sessData.numSamplesSEM(i) = std(behParRun.numSamples(trInd))/sqrt(nTr);
        sessData.maxSpeedMean(i) = mean(behParRun.maxSpeed(trInd));
        sessData.maxSpeedSEM(i) = std(behParRun.maxSpeed(trInd))/sqrt(nTr);
        sessData.meanSpeedMean(i) = mean(behParRun.meanSpeed(trInd));
        sessData.meanSpeedSEM(i) = std(behParRun.meanSpeed(trInd))/sqrt(nTr);
        sessData.maxSpeedRunMean(i) = mean(behParRun.maxSpeedRun(trInd));
        sessData.maxSpeedRunSEM(i) = std(behParRun.maxSpeedRun(trInd))/sqrt(nTr);
        sessData.meanSpeedRunMean(i) = mean(behParRun.meanSpeedRun(trInd));
        sessData.meanSpeedRunSEM(i) = std(behParRun.meanSpeedRun(trInd))/sqrt(nTr);
        sessData.maxRunLenTMean(i) = mean(behParRun.maxRunLenT(trInd));
        sessData.maxRunLenTSEM(i) = std(behParRun.maxRunLenT(trInd))/sqrt(nTr);
        sessData.totRunLenTMean(i) = mean(behParRun.totRunLenT(trInd));
        sessData.totRunLenTSEM(i) = std(behParRun.totRunLenT(trInd))/sqrt(nTr);
        sessData.numRunMean(i) = mean(behParRun.numRun(trInd));
        sessData.numRunSEM(i) = std(behParRun.numRun(trInd))/sqrt(nTr);
        sessData.maxAccMean(i) = mean(behParRun.maxAcc(trInd));
        sessData.maxAccSEM(i) = std(behParRun.maxAcc(trInd))/sqrt(nTr);
        sessData.meanAccMean(i) = mean(behParRun.meanAcc(trInd));
        sessData.meanAccSEM(i) = std(behParRun.meanAcc(trInd))/sqrt(nTr);
        sessData.totStopLenTMean(i) = mean(behParRun.totStopLenT(trInd));
        sessData.totStopLenTSEM(i) = std(behParRun.totStopLenT(trInd))/sqrt(nTr);
        sessData.startCueToRunMean(i) = mean(behParRun.startCueToRun(trInd));
        sessData.startCueToRunSEM(i) = std(behParRun.startCueToRun(trInd))/sqrt(nTr);
        sessData.numLicksBefRewMean(i) = mean(behParRun.numLicksBefRew(trInd));
        sessData.numLicksBefRewSEM(i) = std(behParRun.numLicksBefRew(trInd))/sqrt(nTr);
        sessData.numLicksRewMean(i) = mean(behParRun.numLicksRew(trInd));
        sessData.numLicksRewSEM(i) = std(behParRun.numLicksRew(trInd))/sqrt(nTr);
        
        indN = ~isnan(behParRun.med1stFiveLickDist(trInd));
        med1stFiveLickDist = behParRun.med1stFiveLickDist(trInd);
        sessData.med1stFiveLickDistMean(i) = mean(med1stFiveLickDist(indN));
        sessData.med1stFiveLickDistSEM(i) = std(med1stFiveLickDist(indN))/sqrt(sum(indN));
        
        indN = ~isnan(behParRun.medLickDist(trInd));
        medLickDist = behParRun.medLickDist(trInd);
        sessData.medLickDistMean(i) = mean(medLickDist(indN));
        sessData.medLickDistSEM(i) = std(medLickDist(indN))/sqrt(sum(indN));  
        
        indN = ~isnan(behParRun.med1stFiveLickDistBefRew(trInd));
        med1stFiveLickDistBefRew = behParRun.med1stFiveLickDistBefRew(trInd);
        sessData.med1stFiveLickDistBefRewMean(i) = mean(med1stFiveLickDistBefRew(indN));
        sessData.med1stFiveLickDistBefRewSEM(i) = std(med1stFiveLickDistBefRew(indN))/sqrt(sum(indN));
        
        indN = ~isnan(behParRun.medLickDistBefRew(trInd));
        medLickDistBefRew = behParRun.medLickDistBefRew(trInd);
        sessData.medLickDistBefRewMean(i) = mean(medLickDistBefRew(indN));
        sessData.medLickDistBefRewSEM(i) = std(medLickDistBefRew(indN))/sqrt(sum(indN));
        
        sessData.percRewarded(i) = sum(behParRun.rewarded(trInd)==1)/nTr;
        sessData.percNonStop(i) = sum(behParRun.nonStop(trInd))/nTr;
        sessData.speedProfile{i} = behParRun.speedProfile(trInd,:)/10;
        sessData.lickProfile{i} = behParRun.lickProfile(trInd,:);
        
        indN = behParRun.pumpLfpInd(trInd) > 0;
        sessData.pumpLfpIndMean(i) = mean(behParRun.pumpLfpInd(trInd(indN)));
        sessData.pumpLfpIndSEM(i) = std(behParRun.pumpLfpInd(trInd(indN)))/sqrt(sum(indN));
        sessData.pumpMMMean(i) = mean(behParRun.pumpMM(trInd(indN)));
        sessData.pumpMMSEM(i) = std(behParRun.pumpMM(trInd(indN)))/sqrt(sum(indN));
    end
    

end

function sessData = compBehCue(path,recName,sessNo)
    nSess = length(sessNo);
    sessData.sessNo = sessNo;
    sessData.numSamplesMean = zeros(1,nSess);
    sessData.numSamplesSEM = zeros(1,nSess);
    sessData.maxSpeedMean = zeros(1,nSess);
    sessData.maxSpeedSEM = zeros(1,nSess);
    sessData.meanSpeedMean = zeros(1,nSess);
    sessData.meanSpeedSEM = zeros(1,nSess);
    sessData.maxSpeedRunMean = zeros(1,nSess);
    sessData.maxSpeedRunSEM = zeros(1,nSess);
    sessData.meanSpeedRunMean = zeros(1,nSess);
    sessData.meanSpeedRunSEM = zeros(1,nSess);
    sessData.maxRunLenTMean = zeros(1,nSess);
    sessData.maxRunLenTSEM = zeros(1,nSess);
    sessData.totRunLenTMean = zeros(1,nSess);
    sessData.totRunLenTSEM = zeros(1,nSess);
    sessData.numRunMean = zeros(1,nSess);
    sessData.numRunSEM = zeros(1,nSess);
    sessData.maxAccMean = zeros(1,nSess);
    sessData.maxAccSEM = zeros(1,nSess);
    sessData.meanAccMean = zeros(1,nSess);
    sessData.meanAccSEM = zeros(1,nSess);
    sessData.totStopLenTMean = zeros(1,nSess);
    sessData.totStopLenTSEM = zeros(1,nSess);
    sessData.startCueToRunMean = zeros(1,nSess);
    sessData.startCueToRunSEM = zeros(1,nSess);
    sessData.med1stFiveLickDistMean = zeros(1,nSess);
    sessData.med1stFiveLickDistSEM = zeros(1,nSess);
    sessData.medLickDistMean = zeros(1,nSess);
    sessData.medLickDistSEM = zeros(1,nSess);
    
    
    for i = 1:nSess
        fileName = [recName '-0' num2str(sessNo(i))];
        pathTmp = [path fileName '\'];
        
        fullpath = [pathTmp fileName '_behPar.mat'];
        if(~exist(fullpath,'file'))
            disp([fullpath ' does not exist.']);
            return;
        end
        load(fullpath,'behParCue','param');
        
        trInd = param.startTr:param.endTr;
        nTr = length(trInd);
        
        sessData.numSamplesMean(i) = mean(behParCue.numSamples(trInd));
        sessData.numSamplesSEM(i) = std(behParCue.numSamples(trInd))/sqrt(nTr);
        sessData.maxSpeedMean(i) = mean(behParCue.maxSpeed(trInd));
        sessData.maxSpeedSEM(i) = std(behParCue.maxSpeed(trInd))/sqrt(nTr);
        sessData.meanSpeedMean(i) = mean(behParCue.meanSpeed(trInd));
        sessData.meanSpeedSEM(i) = std(behParCue.meanSpeed(trInd))/sqrt(nTr);
        sessData.maxSpeedRunMean(i) = mean(behParCue.maxSpeedRun(trInd));
        sessData.maxSpeedRunSEM(i) = std(behParCue.maxSpeedRun(trInd))/sqrt(nTr);
        sessData.meanSpeedRunMean(i) = mean(behParCue.meanSpeedRun(trInd));
        sessData.meanSpeedRunSEM(i) = std(behParCue.meanSpeedRun(trInd))/sqrt(nTr);
        sessData.maxRunLenTMean(i) = mean(behParCue.maxRunLenT(trInd));
        sessData.maxRunLenTSEM(i) = std(behParCue.maxRunLenT(trInd))/sqrt(nTr);
        sessData.totRunLenTMean(i) = mean(behParCue.totRunLenT(trInd));
        sessData.totRunLenTSEM(i) = std(behParCue.totRunLenT(trInd))/sqrt(nTr);
        sessData.numRunMean(i) = mean(behParCue.numRun(trInd));
        sessData.numRunSEM(i) = std(behParCue.numRun(trInd))/sqrt(nTr);
        sessData.maxAccMean(i) = mean(behParCue.maxAcc(trInd));
        sessData.maxAccSEM(i) = std(behParCue.maxAcc(trInd))/sqrt(nTr);
        sessData.meanAccMean(i) = mean(behParCue.meanAcc(trInd));
        sessData.meanAccSEM(i) = std(behParCue.meanAcc(trInd))/sqrt(nTr);
        sessData.totStopLenTMean(i) = mean(behParCue.totStopLenT(trInd));
        sessData.totStopLenTSEM(i) = std(behParCue.totStopLenT(trInd))/sqrt(nTr);
        sessData.numLicksBefRewMean(i) = mean(behParCue.numLicksBefRew(trInd));
        sessData.numLicksBefRewSEM(i) = std(behParCue.numLicksBefRew(trInd))/sqrt(nTr);
        sessData.numLicksRewMean(i) = mean(behParCue.numLicksRew(trInd));
        sessData.numLicksRewSEM(i) = std(behParCue.numLicksRew(trInd))/sqrt(nTr);
        
        indN = ~isnan(behParCue.med1stFiveLickDist(trInd));
        med1stFiveLickDist = behParCue.med1stFiveLickDist(trInd);
        sessData.med1stFiveLickDistMean(i) = mean(med1stFiveLickDist(indN));
        sessData.med1stFiveLickDistSEM(i) = std(med1stFiveLickDist(indN))/sqrt(sum(indN));
        
        indN = ~isnan(behParCue.medLickDist(trInd));
        medLickDist = behParCue.medLickDist(trInd);
        sessData.medLickDistMean(i) = mean(medLickDist(indN));
        sessData.medLickDistSEM(i) = std(medLickDist(indN))/sqrt(sum(indN));
        
        indN = ~isnan(behParCue.med1stFiveLickDistBefRew(trInd));
        med1stFiveLickDist = behParCue.med1stFiveLickDist(trInd);
        sessData.med1stFiveLickDistBefRewMean(i) = mean(med1stFiveLickDist(indN));
        sessData.med1stFiveLickDistBefRewSEM(i) = std(med1stFiveLickDist(indN))/sqrt(sum(indN));
        
        indN = ~isnan(behParCue.medLickDistBefRew(trInd));
        medLickDistBefRew = behParCue.medLickDistBefRew(trInd);
        sessData.medLickDistBefRewMean(i) = mean(medLickDistBefRew(indN));
        sessData.medLickDistBefRewSEM(i) = std(medLickDistBefRew(indN))/sqrt(sum(indN));
    end
    
end

function sessData = compBehLick(path,recName,sessNo)
    nSess = length(sessNo);
    sessData.sessNo = sessNo;
    sessData.Run = [];
    sessData.meanRun = [];
    sessData.stdRun = [];
    sessData.SEMRun = [];
    sessData.Cue = [];
    sessData.meanCue = [];
    sessData.stdCue = [];
    sessData.SEMCue = [];
    for i = 1:nSess
        fileName = [recName '-0' num2str(sessNo(i))];
        pathTmp = [path fileName '\'];
        
        fullpath = [pathTmp fileName '_lickDist.mat'];
        if(~exist(fullpath,'file'))
            disp([fullpath ' does not exist.']);
            return;
        end
        load(fullpath,'lickOverDist','param');
        trInd = param.startTr:param.endTr;
        
        sessData.spaceSteps = param.spaceSteps;
        sessData.Run{i} = lickOverDist.Run(trInd,:);
        sessData.meanRun{i} = lickOverDist.meanRun;
        sessData.stdRun{i} = lickOverDist.stdRun;
        sessData.SEMRun{i} = lickOverDist.SEMRun;
        
        sessData.Cue{i} = lickOverDist.Cue(trInd,:);
        sessData.meanCue{i} = lickOverDist.meanCue;
        sessData.stdCue{i} = lickOverDist.stdCue;
        sessData.SEMCue{i} = lickOverDist.SEMCue;
    end
    
end

function lickPlot(data,x,xl,yl,ti)
    figure
    nSess = length(data);
    for i = 1:nSess
        options.handle     = subplot(1,nSess,i);
        options.color_area = [224 191 232]./255; %[128 193 219]./255;    % Blue theme
        options.color_line = [129 98 137]./255; %[ 52 148 186]./255;
        options.alpha      = 0.5;
        options.line_width = 2;
        options.error      = 'sem';
        options.x_axis = x;
        plot_areaerrorbarSub(data{i}, options);
        set(gca,'XLim',[0 max(x)],'YLim',[-2 4])
        xlabel(xl)
        ylabel(yl)
    end
end

function sessData = compBehSpeed(path,recName,sessNo,onlyRun)
    nSess = length(sessNo);
    sessData.sessNo = sessNo;
    sessData.Run = [];
    sessData.meanRun = [];
    sessData.stdRun = [];
    sessData.SEMRun = [];
    sessData.Cue = [];
    sessData.meanCue = [];
    sessData.stdCue = [];
    sessData.SEMCue = [];
    for i = 1:nSess
        fileName = [recName '-0' num2str(sessNo(i))];
        pathTmp = [path fileName '\'];
        
        fullpath = [pathTmp fileName '_runSpeedDist_Run' num2str(onlyRun) '.mat'];
        if(~exist(fullpath,'file'))
            disp([fullpath ' does not exist.']);
            return;
        end
        load(fullpath,'speedOverDist','param');
        trInd = param.startTr:param.endTr;
       
        sessData.spaceSteps = param.spaceSteps;
        sessData.Run{i} = speedOverDist.Run(trInd,:)/10;
        sessData.meanRun{i} = speedOverDist.meanRun/10;
        sessData.stdRun{i} = speedOverDist.stdRun/10;
        sessData.SEMRun{i} = speedOverDist.SEMRun/10;
        
        sessData.Cue{i} = speedOverDist.Cue(trInd,:)/10;
        sessData.meanCue{i} = speedOverDist.meanCue/10;
        sessData.stdCue{i} = speedOverDist.stdCue/10;
        sessData.SEMCue{i} = speedOverDist.SEMCue/10;
    end
end

function runPlot(data,x,xl,yl,ti)
    figure
    nSess = length(data);
    for i = 1:nSess
        options.handle     = subplot(1,nSess,i);
        options.color_area = [224 191 232]./255; %[128 193 219]./255;    % Blue theme
        options.color_line = [129 98 137]./255; %[ 52 148 186]./255;
        options.alpha      = 0.5;
        options.line_width = 2;
        options.error      = 'sem';
        options.x_axis = x;
        plot_areaerrorbarSub(data{i}, options);
        set(gca,'XLim',[0 max(x)],'YLim',[-2 105])
        xlabel(xl)
        ylabel(yl)
    end
end

function sessData = compRecTime(path,recName,sessNo,injectionSess)
    nSess = length(sessNo);
    sessData.sessNo = sessNo;
    sessData.timeEnd = [];
    sessData.timeStart = [];
    sessData.duration = zeros(1,nSess);
    sessData.tDiffInjStart = zeros(1,nSess);
    sessData.tDiffInjEnd = zeros(1,nSess);
    
    fullpath = [path recName '_recTime.mat'];
    if(~exist(fullpath,'file'))
        disp([fullpath ' does not exist.']);
        return;
    end
    load(fullpath,'fInfo');
    ind = fInfo.sessNo == injectionSess;
    injTime = datetime(fInfo.time{ind});
    
    for i = 1:nSess
        fileName = [recName '-0' num2str(sessNo(i))];
        pathTmp = [path fileName '\'];
        
        fullpath = [pathTmp fileName 'B.mat'];
        if(~exist(fullpath,'file'))
            disp([fullpath ' does not exist.']);
            return;
        end
        load(fullpath,'behEvents');
        timeStart = behEvents.trialT(1,1);
        fnames = fieldnames(behEvents);
        timeEnd = timeStart;
        for n = 1:length(fnames)
            if(strcmp(fnames{n},'movieTDescr'))
                continue;
            end
            timeEnd = max(timeEnd, behEvents.(fnames{n})(end,1));
        end
        sessData.duration(i) = (timeEnd - timeStart)/1000; % sec
        
        ind = fInfo.sessNo == sessNo(i);
        sessData.timeEnd{i} = datetime(fInfo.time{ind});
        sessData.timeStart{i} = datetime(fInfo.time{ind}) - ...
            seconds(sessData.duration(i));
        
        sessData.tDiffInjStart(i) = seconds(sessData.timeStart{i} - injTime);
        sessData.tDiffInjEnd(i) = seconds(sessData.timeEnd{i} - injTime);
    end
end