function [recDataCuePre,recDataCueManip,recDataCuePost] = ...
                accumRecDataCueMusc(path,recSess,manipSess,mazeSess)
    nRec = size(path,1);
    tmp.numSamplesMean = [];
    tmp.maxSpeedMean = [];
    tmp.meanSpeedMean = [];
    tmp.maxRunLenTMean = [];
    tmp.totRunLenTMean = [];
    tmp.numRunMean = [];
    tmp.maxAccMean = [];
    tmp.meanAccMean = [];
    tmp.totStopLenTMean = [];
    tmp.med1stFiveLickDistMean = [];
    tmp.medLickDistMean = [];
    tmp.indRec = [];
    tmp.indSess = [];
    tmp.speedProfile = [];
    tmp.lickProfile = [];
    tmp.meanSpeed = [];
    tmp.meanLick = [];
    tmp.speedProfileRndSel = [];
    tmp.lickProfileRndSel = [];
    
    recDataCuePre = tmp;
    recDataCueManip = tmp;
    recDataCuePost = tmp;
    
    for i = 1:nRec
        ind = findstr(path(i,:),'\');
        recName = path(i,ind(end-1)+1:ind(end)-1);
        disp(recName);
        fullPath = [path(i,:) recName '_compSess.mat'];
        if(~exist(fullPath,'file'))
            disp([fullPath ' does not exist.']);
            return;
        end
        load(fullPath,'sessDataCue','sessDataLick','sessDataSpeed');
        
        indPre = find(recSess{i} < manipSess{i}(1));
        if(isempty(indPre))
            indPre = NaN;
        end
        indPost = find(recSess{i} > manipSess{i}(end));
        if(isempty(indPost))
            indPost = NaN;
        end
        [~,indManip] = intersect(recSess{i}, manipSess{i});
        nSessManip = length(manipSess{i});
        recDataCuePre = concatData(recDataCuePre,sessDataCue,sessDataLick,sessDataSpeed,...
            indPre*ones(1,nSessManip));
        recDataCuePre.indRec = [recDataCuePre.indRec i*ones(1,nSessManip)];
        if(isnan(indPre))
            recDataCuePre.indSess = [recDataCuePre.indSess indPre*ones(1,nSessManip)];
        else
            recDataCuePre.indSess = [recDataCuePre.indSess recSess{i}(indPre)*ones(1,nSessManip)];
        end
        
        recDataCuePost = concatData(recDataCuePost,sessDataCue,sessDataLick,sessDataSpeed,...
            indPost*ones(1,nSessManip));
        recDataCuePost.indRec = [recDataCuePost.indRec i*ones(1,nSessManip)];
        if(isnan(indPost))
            recDataCuePost.indSess = [recDataCuePost.indSess indPost*ones(1,nSessManip)];
        else
            recDataCuePost.indSess = [recDataCuePost.indSess recSess{i}(indPost)*ones(1,nSessManip)];
        end
        
        recDataCueManip = concatData(recDataCueManip,sessDataCue,sessDataLick,sessDataSpeed,indManip);
        recDataCueManip.indRec = [recDataCueManip.indRec i*ones(1,nSessManip)];
        recDataCueManip.indSess = [recDataCueManip.indSess recSess{i}(indManip')];
    end

end

function recData = concatData(recData,sessData,sessDataLick,sessDataSpeed,indSess)
    randTrNo = 20;
    recData.spaceStepsLick = sessDataLick.spaceSteps;
    recData.spaceStepsSpeed = sessDataSpeed.spaceSteps;
    nSess = length(indSess);
    if(sum(isnan(indSess)) > 0)
        recData.numSamplesMean = [recData.numSamplesMean NaN*ones(1,nSess)];
        recData.maxSpeedMean = [recData.maxSpeedMean NaN*ones(1,nSess)];
        recData.meanSpeedMean = [recData.meanSpeedMean NaN*ones(1,nSess)];
        recData.maxRunLenTMean = [recData.maxRunLenTMean NaN*ones(1,nSess)];
        recData.totRunLenTMean = [recData.totRunLenTMean NaN*ones(1,nSess)];
        recData.numRunMean = [recData.numRunMean NaN*ones(1,nSess)];
        recData.maxAccMean = [recData.maxAccMean NaN*ones(1,nSess)];
        recData.meanAccMean = [recData.meanAccMean NaN*ones(1,nSess)];
        recData.totStopLenTMean = [recData.totStopLenTMean NaN*ones(1,nSess)];
        recData.med1stFiveLickDistMean = [recData.med1stFiveLickDistMean NaN*ones(1,nSess)];
        recData.medLickDistMean = [recData.medLickDistMean NaN*ones(1,nSess)];
    else
        recData.numSamplesMean = [recData.numSamplesMean sessData.numSamplesMean(indSess)];
        recData.maxSpeedMean = [recData.maxSpeedMean sessData.maxSpeedMean(indSess)];
        recData.meanSpeedMean = [recData.meanSpeedMean sessData.meanSpeedMean(indSess)];
        recData.maxRunLenTMean = [recData.maxRunLenTMean sessData.maxRunLenTMean(indSess)];
        recData.totRunLenTMean = [recData.totRunLenTMean sessData.totRunLenTMean(indSess)];
        recData.numRunMean = [recData.numRunMean sessData.numRunMean(indSess)];
        recData.maxAccMean = [recData.maxAccMean sessData.maxAccMean(indSess)];
        recData.meanAccMean = [recData.meanAccMean sessData.meanAccMean(indSess)];
        recData.totStopLenTMean = [recData.totStopLenTMean sessData.totStopLenTMean(indSess)];
        recData.med1stFiveLickDistMean = [recData.med1stFiveLickDistMean sessData.med1stFiveLickDistMean(indSess)];
        recData.medLickDistMean = [recData.medLickDistMean sessData.medLickDistMean(indSess)];
        sess = unique(indSess);
        for i = 1:length(sess)
            recData.speedProfile = [recData.speedProfile; sessDataSpeed.meanCue{sess(i)}];
            recData.lickProfile = [recData.lickProfile; sessDataLick.meanCue{sess(i)}];
            recData.meanSpeed = [recData.meanSpeed mean(sessDataSpeed.meanCue{sess(i)})];
            recData.meanLick = [recData.meanLick mean(sessDataLick.meanCue{sess(i)})];
            
            indTrR = randperm(size(sessDataSpeed.Run{sess(i)},1));
            if(length(indTrR) > randTrNo)
                recData.speedProfileRndSel = [recData.speedProfileRndSel;...
                    sessDataSpeed.Cue{sess(i)}(indTrR(1:randTrNo),:)];
                recData.lickProfileRndSel = [recData.lickProfileRndSel;...
                    sessDataLick.Cue{sess(i)}(indTrR(1:randTrNo),:)];
            else
                recData.speedProfileRndSel = [recData.speedProfileRndSel;...
                    sessDataSpeed.Cue{sess(i)}];
                recData.lickProfileRndSel = [recData.lickProfileRndSel;...
                    sessDataLick.Cue{sess(i)}];
            end
        end
    end
end
