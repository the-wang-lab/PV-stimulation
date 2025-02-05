function NaiveBayesClassifierGpuWithCrossVal(paths,filenames,mazeSess,upDown,task,onlyRun)
% use a subpopulation of neurons to predit time or distance

    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakNoFNeuALPL\'];
    if(upDown == 1) % PyrUp
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrRise');
        PyrInd = PyrRise.idxRise;
        PyrTask = PyrRise.task;
        PyrRec = PyrRise.indRec;
        PyrNeu = PyrRise.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\[\PyrRiseNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrRiseAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrRisePL\'];
        end
    elseif(upDown == 2) % PyrDown
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrDown');
        PyrInd = PyrDown.idxDown;
        PyrTask = PyrDown.task;
        PyrRec = PyrDown.indRec;
        PyrNeu = PyrDown.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrDownNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrDownAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrDownPL\'];
        end
    else % PyrOther
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrOther');
        PyrInd = PyrOther.idxOther;
        PyrTask = PyrOther.task;
        PyrRec = PyrOther.indRec;
        PyrNeu = PyrOther.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrOtherNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrOtherAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrOtherPL\'];
        end
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
              
    GlobalConstFq;
    
    paramC.minTrNum = 25;
    paramC.trialLenT = 5; %sec
    paramC.timeBin = 0.0016; %sec
    std0 = 0.2/paramC.timeBin;
    paramC.timeBin1 = 0.2; %sec
    timeBinRatio = paramC.timeBin1/paramC.timeBin;
%     std0 = 0.05/paramC.timeBin;
    paramC.gaussFilt = gaussFilter(12*std0, std0);
    lenGaussKernel = length(paramC.gaussFilt);
    normFactor = sum(paramC.gaussFilt);
    paramC.gaussFilt = paramC.gaussFilt./normFactor;
    paramC.numShuffle = 50;
    paramC.minNoNeurons = 15;
    
    nMaxSample = paramC.trialLenT*sampleFq;
    nSamplePerBin = paramC.timeBin*sampleFq;
    if(floor(nSamplePerBin/2) ~= 0)
        paramC.timeStep = floor(nSamplePerBin/2):nSamplePerBin:nMaxSample;
    else
        paramC.timeStep = 1:nSamplePerBin:nMaxSample;
    end

    nSamplePerBin = paramC.timeBin1*sampleFq;
    paramC.timeStep1 = floor(nSamplePerBin/2):nSamplePerBin:nMaxSample;
    nBins = length(paramC.timeStep);
        
    numRec = size(paths,1);
    naiveBayes = struct( ...
        'trialNo',{cell(1,numRec)},...
        'indNeu',{cell(1,numRec)},...
        'task',zeros(1,numRec),...
        ...
        'filteredSpikeNorm2',{cell(1,numRec)},...
        'time',{cell(1,numRec)},...
        'mdlNorm2',{cell(1,numRec)},...
        'labelN2',{cell(1,numRec)},...
        'PosteriorN2',{cell(1,numRec)},...
        'CostN2',{cell(1,numRec)},...
        'decodingErr',{cell(1,numRec)},...
        'cmNorm2',{cell(1,numRec)},...
        ...
        'labelN2Shuf',{cell(numRec,paramC.numShuffle)},...
        'PosteriorN2Shuf',{cell(numRec,paramC.numShuffle)},...
        'decodingErrShuf',{cell(numRec,paramC.numShuffle)});
    
    naiveBayesMean = struct( ...
        'labelN2',{cell(1,numRec)},...
        'PosteriorN2',{cell(1,numRec)},...
        'CostN2',{cell(1,numRec)},...
        'decodingErr',{cell(1,numRec)},...
        ...
        'labelN2Shuf',{cell(1,numRec)},...
        'PosteriorN2Shuf',{cell(1,numRec)},...
        'decodingErrShuf',{cell(1,numRec)});
    
    if(exist([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']))
        load([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
    end
            
    for r = 2:numRec
        disp(['rec' num2str(r) ' ' filenames(r,:)])
        
        fullPathSpike = [paths(r,:) filenames(r,:) '_alignedSpikesPerNPerT_msess' ...
            num2str(mazeSess(r)) '_Run1.mat'];
        if(exist(fullPathSpike) == 0)
            disp('The _alignedSpikesPerNPerT file does not exist');
            return;
        end
        load(fullPathSpike,'trialsRunSpikes');
                    
        fileNamePeakFR = [filenames(r,:) '_PeakFRAligned_msess' num2str(mazeSess(r)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(r,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'trialNoNonStimGood');
                
        if(length(trialNoNonStimGood) < paramC.minTrNum)
            disp(['Only ' num2str(length(trialNoNonStimGood)) ...
                ' trials are good trials in recording ' filenames(r,:)]);
            continue;
        end
        
        % get the indices of pyramidal neurons from one recording
        ind = PyrTask == task & PyrRec == r;
        indNeu = PyrNeu(ind);
        
        % only consider good trials
        trialNo = length(trialNoNonStimGood);
        neuronNo = length(indNeu);
                
        % check that there is enough number of neurons in the recording
        if(neuronNo <= paramC.minNoNeurons)
            disp(['There are only ' num2str(neuronNo) ' neurons in this recording']);
            continue;
        end
        
        % collect basic information about the session
        naiveBayes.trialNo{r} = trialNoNonStimGood;
        naiveBayes.indNeu{r} = indNeu;
        naiveBayes.task(r) = task;
        
        %% calculate filtered spike array for each neuron over good trials, separating training and testing set
        filteredSpikeNorm2 = zeros(neuronNo*timeBinRatio,trialNo*nBins/timeBinRatio);
        filteredSpikeArrayRunNorm2 = cell(1,neuronNo);        
        if(r == 62)
            continue;
        end
        
        for i  = 1:neuronNo
            disp(['Neuron ' num2str(indNeu(i))]);   
            %% filter spikes aligned to start run
            spikeArray = zeros(length(trialNoNonStimGood),nBins+2*lenGaussKernel);
            for j = 1:trialNo
                indTime = trialsRunSpikes.Time{indNeu(i),trialNoNonStimGood(j)} <= nMaxSample;
                if(isempty(indTime))
                    continue;
                end
                spikeTime = trialsRunSpikes.Time{indNeu(i),trialNoNonStimGood(j)}(indTime);  
                spikeTrain = hist(spikeTime,paramC.timeStep);
                spikeArray(j,:) = [spikeTrain(nBins-lenGaussKernel+1:nBins)...
                            spikeTrain spikeTrain(1:lenGaussKernel)];   
            end
            filteredSpikeTmp = conv2(spikeArray,paramC.gaussFilt);
            filteredSpikeTmp = ...
                    filteredSpikeTmp(:,floor(lenGaussKernel/2)+lenGaussKernel+1:...
                        (end-2*lenGaussKernel+floor(lenGaussKernel/2)+1));     
            filteredSpikeArrayRun = filteredSpikeTmp./paramC.timeBin;
            filteredSpikeArrayRunNorm2{i} = zscore(filteredSpikeArrayRun,0,2);
            
            % reshape the filtered spike array for training data
            tmp = filteredSpikeArrayRunNorm2{i}';
            tmp1 = reshape(tmp,timeBinRatio,[],size(tmp,2));
            tmp = reshape(tmp1,timeBinRatio,[]);
            filteredSpikeNorm2((i-1)*timeBinRatio+1:i*timeBinRatio,:) = tmp;
        end
        
        % record the training and testing data
        naiveBayes.filteredSpikeNorm2Train{r} = filteredSpikeNorm2';
        
        timeTmp = repmat(paramC.timeStep1'/sampleFq,1,trialNo);
        naiveBayes.timeTrain{r} = timeTmp(:);
        
        %% calculate shuffled filtered spike array
        shufMeanArray = neuActShuffle(filteredSpikeArrayRunNorm2,paramC.numShuffle,timeBinRatio);
                
        %% naive bayes classification, train on 50% data and test on the other 50%      
%         gpuSpikeNorm = gpuArray(filteredSpikeNorm2');
        gpuTime = naiveBayes.timeTrain{r};
        
        c = cvpartition(size(filteredSpikeNorm2,2), 'KFold', 10);
        naiveBayes.mdlNorm2{r} = fitcnb(filteredSpikeNorm2',gpuTime,'CVPartition', c);
        [naiveBayes.labelN2{r},naiveBayes.PosteriorN2{r},naiveBayes.CostN2{r}] = ...
             kfoldPredict(naiveBayes.mdlNorm2{r});
        naiveBayes.cmNorm2{r} = confusionchart(gpuTime,naiveBayes.labelN2{r});
        naiveBayes.decodingErr{r} = naiveBayes.labelN2{r}-gpuTime;
        save([pathAnal filenames(r,:) '_cmNorm2.fig']);
        print('-painters', '-dpdf', [pathAnal filenames(r,:) '_cmNorm2'], '-r600');
        
        %% calculate mean of classification results
        nBins1 = nBins/timeBinRatio;
        labelN2Tmp = reshape(naiveBayes.labelN2{r},nBins1,trialNo);
        naiveBayesMean.labelN2{r} = mean(labelN2Tmp,2);
        PosteriorN2Tmp = reshape(naiveBayes.PosteriorN2{r},nBins1,trialNo,nBins1);
        naiveBayesMean.PosteriorN2{r} = squeeze(mean(PosteriorN2Tmp,2));
        CostN2Tmp = reshape(naiveBayes.CostN2{r},nBins1,trialNo,nBins1);
        naiveBayesMean.CostN2{r} = squeeze(mean(CostN2Tmp,2));
        decodingErrTmp = reshape(naiveBayes.decodingErr{r},nBins1,trialNo);
        naiveBayesMean.decodingErr{r} = mean(decodingErrTmp,2);
        
        %% naive bayes classification on shuffled data
        naiveBayesMean.labelN2Shuf{r} = zeros(nBins1,1);
        naiveBayesMean.PosteriorN2Shuf{r} = zeros(nBins1,nBins1);
        naiveBayesMean.decodingErrShuf{r} = zeros(nBins1,1);
        
        labelN2Shuf = cell(1,paramC.numShuffle);
        PosteriorN2Shuf = cell(1,paramC.numShuffle);
        decodingErrShuf = cell(1,paramC.numShuffle);
        parfor n = 1:paramC.numShuffle
%             gpuShufArray = gpuArray(shufMeanArray{n});
            mdlNorm2Shuf = fitcnb(shufMeanArray{n},gpuTime,'CVPartition', c);
            [labelN2Shuf{n},PosteriorN2Shuf{n}] = ...
                kfoldPredict(mdlNorm2Shuf);
            decodingErrShuf{n} = labelN2Shuf{n}-gpuTime;
        end
        
        naiveBayes.labelN2Shuf(r,:) = labelN2Shuf;
        naiveBayes.PosteriorN2Shuf(r,:) = PosteriorN2Shuf;
        naiveBayes.decodingErrShuf(r,:) = decodingErrShuf;
        
        for n = 1:paramC.numShuffle
            labelN2Tmp = reshape(naiveBayes.labelN2Shuf{r,n},nBins1,trialNo);
            naiveBayesMean.labelN2Shuf{r} = naiveBayesMean.labelN2Shuf{r} + mean(labelN2Tmp,2);
            PosteriorN2Tmp = reshape(naiveBayes.PosteriorN2Shuf{r,n},nBins1,trialNo,nBins1);
            naiveBayesMean.PosteriorN2Shuf{r} = naiveBayesMean.PosteriorN2Shuf{r} + squeeze(mean(PosteriorN2Tmp,2));
            decodingErrTmp = reshape(naiveBayes.decodingErrShuf{r,n},nBins1,trialNo);
            naiveBayesMean.decodingErrShuf{r} = naiveBayesMean.decodingErrShuf{r} + mean(decodingErrTmp,2);
        end
        
        %% calculate mean of classification results for shuffled data
        naiveBayesMean.labelN2Shuf{r} = naiveBayesMean.labelN2Shuf{r}/paramC.numShuffle;
        naiveBayesMean.PosteriorN2Shuf{r} = naiveBayesMean.PosteriorN2Shuf{r}/paramC.numShuffle;
        naiveBayesMean.decodingErrShuf{r} = naiveBayesMean.decodingErrShuf{r}/paramC.numShuffle;
        
        save([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat'],'naiveBayes','naiveBayesMean','paramC','-v7.3');
    end
end

function shufMeanArray = neuActShuffle(filteredSpikeArray,numShuffle,timeBinRatio)
    
    numArr = length(filteredSpikeArray);
    rowArray = size(filteredSpikeArray{1},1);
    colArray = size(filteredSpikeArray{1},2); 
    shufMeanArray = cell(1,numShuffle); 
    parfor i = 1:numShuffle 
        shufMeanArray{i} = zeros(rowArray*colArray/timeBinRatio,numArr*timeBinRatio);
        for n = 1:numArr
            shufSpikeArrayTmp = zeros(rowArray,colArray);
            randShift = randi(floor(colArray/2),1,rowArray)-floor(colArray/2);
            for j = 1:rowArray
                shiftTmp = circshift(filteredSpikeArray{n}(j,:)',randShift(j));
                shufSpikeArrayTmp(j,:) = shiftTmp';
            end
            tmp = shufSpikeArrayTmp';
            tmp1 = reshape(tmp,timeBinRatio,[],size(tmp,2));
            tmp = reshape(tmp1,timeBinRatio,[])';
            shufMeanArray{i}(:,(n-1)*timeBinRatio+1:n*timeBinRatio) = tmp;
        end
    end
end