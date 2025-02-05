function NaiveBayesClassifier(paths,filenames,mazeSess,upDown,task,onlyRun)
% use a subpopulation of neurons to predit time or distance

    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakNoFNeuALPL\'];
    if(upDown == 1) % PyrUp
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrRise');
        PyrInd = PyrRise.idxRise;
        PyrTask = PyrRise.task;
        PyrRec = PyrRise.indRec;
        PyrNeu = PyrRise.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrRiseNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrRiseAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrRisePL\'];
        end
    elseif(upDown == 2) % PyrDown
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrDown');
        PyrInd = PyrDown.idxDown;
        PyrTask = PyrDown.task;
        PyrRec = PyrDown.indRec;
        PyrNeu = PyrDown.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrDownNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrDownAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrDownPL\'];
        end
    else % PyrOther
        load([pathAnal0 'initPeakPyrIntAllRecNoFNeu.mat'],'PyrOther');
        PyrInd = PyrOther.idxOther;
        PyrTask = PyrOther.task;
        PyrRec = PyrOther.indRec;
        PyrNeu = PyrOther.indNeu;
        if(task == 1)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrOtherNoCue\'];
        elseif(task == 2)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrOtherAL\'];
        elseif(task == 3)
            pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrOtherPL\'];
        end
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
              
    GlobalConstFq;
    
    paramC.minNumNeu = 15;
    paramC.minTrNum = 25;
    paramC.trialLenT = 5; %sec
    paramC.timeBin = 0.2; %sec
    std0 = 0.1/paramC.timeBin;
    paramC.gaussFilt = gaussFilter(12*std0, std0);
    lenGaussKernel = length(paramC.gaussFilt);
    normFactor = sum(paramC.gaussFilt);
    paramC.gaussFilt = paramC.gaussFilt./normFactor;
    paramC.numShuffle = 50;
    
    nMaxSample = paramC.trialLenT*sampleFq;
    nSamplePerBin = paramC.timeBin*sampleFq;
    paramC.timeStep = floor(nSamplePerBin/2):nSamplePerBin:nMaxSample;
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
        'CVMdlNorm2',{cell(1,numRec)},...
        'LossNorm2',{cell(1,numRec)},...
        'labelN2',{cell(1,numRec)},...
        'PosteriorN2',{cell(1,numRec)},...
        'CostN2',{cell(1,numRec)},...
        'decodingErr',{cell(1,numRec)},...
        'cmNorm2',{cell(1,numRec)},...
        ...
        'labelN2Shuf',{cell(numRec,paramC.numShuffle)},...
        'PosteriorN2Shuf',{cell(numRec,paramC.numShuffle)},...
        'decodingErrShuf',{cell(numRec,paramC.numShuffle)},...
        'LossNorm2Shuf',{cell(numRec,paramC.numShuffle)});
    
    naiveBayesMean = struct( ...
        'labelN2',{cell(1,numRec)},...
        'PosteriorN2',{cell(1,numRec)},...
        'CostN2',{cell(1,numRec)},...
        'decodingErr',{cell(1,numRec)},...
        ...
        'labelN2Shuf',{cell(1,numRec)},...
        'PosteriorN2Shuf',{cell(1,numRec)},...
        'decodingErrShuf',{cell(1,numRec)},...
        'LossNorm2Shuf',{cell(1,numRec)},...
        'LossNorm2ShufStd',{cell(1,numRec)});
            
    for r = 1:numRec
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
        
        ind = PyrTask == task & PyrRec == r;
        indNeu = PyrNeu(ind);
        
        trialNo = length(trialNoNonStimGood);
        neuronNo = length(indNeu);
        
        naiveBayes.trialNo{r} = trialNoNonStimGood;
        naiveBayes.indNeu{r} = indNeu;
        naiveBayes.task(r) = task;
        
        %% calculate filtered spike array for each neuron over all good trials
%         filteredSpikeArrayRun = cell(1,neuronNo);
%         filteredSpikeArrayRunNorm1 = cell(1,neuronNo);
        filteredSpikeArrayRunNorm2 = cell(1,neuronNo);
%         filteredSpike = zeros(neuronNo,trialNo*nBins);
%         filteredSpikeNorm1 = zeros(neuronNo,trialNo*nBins);
        filteredSpikeNorm2 = zeros(neuronNo,trialNo*nBins);
        if(neuronNo <= paramC.minNumNeu)
            disp(['There are only ' num2str(neuronNo) ' neurons in this recording']);
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
%             filteredSpikeArrayRunNorm1{i} = filteredSpikeArrayRun{i}./max(filteredSpikeTmp,[],2);
            filteredSpikeArrayRunNorm2{i} = zscore(filteredSpikeArrayRun,0,2);
            
%             tmp = filteredSpikeArrayRun{i}';
%             filteredSpike(i,:) = tmp(:)';
%             
%             tmp = filteredSpikeArrayRunNorm1{i}';
%             filteredSpikeNorm1(i,:) = tmp(:)';
            
            tmp = filteredSpikeArrayRunNorm2{i}';
            
            filteredSpikeNorm2(i,:) = tmp(:);
        end
        naiveBayes.filteredSpikeNorm2{r} = filteredSpikeNorm2';
        
        timeTmp = repmat(paramC.timeStep'/sampleFq,1,trialNo);
        naiveBayes.time{r} = timeTmp(:);
        
        %% calculate shuffled filtered spike array
        shufMeanArray = neuActShuffle(filteredSpikeArrayRunNorm2,paramC.numShuffle);
                
        %% naive bayes classification
%         mdl = fitcnb(filteredSpike',time);
%         CVMdl = crossval(mdl);
%         Loss = kfoldLoss(CVMdl);
% %         isLabels1 = resubPredict(mdl);
% %         ConfusionMat1 = confusionchart(time,isLabels1);
%         [label,Posterior,Cost] = predict(mdl,filteredSpike');
%         cm = confusionchart(time,label);
%         
%         mdlNorm1 = fitcnb(filteredSpikeNorm1',time);
%         CVMdlNorm1 = crossval(mdlNorm1);
%         LossNorm1 = kfoldLoss(CVMdlNorm1);
% %         isLabels1 = resubPredict(mdl);
% %         ConfusionMat1 = confusionchart(time,isLabels1);
%         [labelN1,PosteriorN1,CostN1] = predict(mdlNorm1,filteredSpikeNorm1');
%         cmNorm1 = confusionchart(time,labelN1);
        
        naiveBayes.mdlNorm2{r} = fitcnb(filteredSpikeNorm2',naiveBayes.time{r},'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus','Kfold',10));
        naiveBayes.LossNorm2{r} = loss(naiveBayes.mdlNorm2{r},filteredSpikeNorm2',...
            naiveBayes.time{r});
        [naiveBayes.labelN2{r},naiveBayes.PosteriorN2{r},naiveBayes.CostN2{r}] = ...
             predict(naiveBayes.mdlNorm2{r},filteredSpikeNorm2');
        naiveBayes.cmNorm2{r} = confusionchart(naiveBayes.time{r},naiveBayes.labelN2{r});
        naiveBayes.decodingErr{r} = naiveBayes.labelN2{r}-naiveBayes.time{r};
        save([pathAnal filenames(r,:) '_cmNorm2.fig']);
        print('-painters', '-dpdf', [pathAnal filenames(r,:) '_cmNorm2'], '-r600');
        
%         naiveBayes.mdlNorm2{r} = fitcnb(filteredSpikeNorm2',naiveBayes.time{r},'CrossVal','on','KFold',10);
%         naiveBayes.CVMdlNorm2{r} = crossval(naiveBayes.mdlNorm2{r});
%         naiveBayes.LossNorm2{r} = kfoldLoss(naiveBayes.mdlNorm2{r});
%         [naiveBayes.labelN2{r},naiveBayes.PosteriorN2{r},naiveBayes.CostN2{r}] = ...
%             kfoldPredict(naiveBayes.mdlNorm2{r});
%         naiveBayes.cmNorm2{r} = confusionchart(naiveBayes.time{r},naiveBayes.labelN2{r});
        
        %% calculate mean of classification results
        labelN2Tmp = reshape(naiveBayes.labelN2{r},nBins,trialNo);
        naiveBayesMean.labelN2{r} = mean(labelN2Tmp,2);
        PosteriorN2Tmp = reshape(naiveBayes.PosteriorN2{r},nBins,trialNo,nBins);
        naiveBayesMean.PosteriorN2{r} = squeeze(mean(PosteriorN2Tmp,2));
        CostN2Tmp = reshape(naiveBayes.CostN2{r},nBins,trialNo,nBins);
        naiveBayesMean.CostN2{r} = squeeze(mean(CostN2Tmp,2));
        decodingErrTmp = reshape(naiveBayes.decodingErr{r},nBins,trialNo);
        naiveBayesMean.decodingErr{r} = mean(decodingErrTmp,2);
        
        %% naive bayes classification on shuffled data
        naiveBayesMean.labelN2Shuf{r} = zeros(nBins,1);
        naiveBayesMean.PosteriorN2Shuf{r} = zeros(nBins,nBins);
        naiveBayesMean.decodingErrShuf{r} = zeros(nBins,1);
        naiveBayesMean.LossNorm2Shuf{r} = zeros(1,paramC.numShuffle);
        for n = 1:paramC.numShuffle
           naiveBayes.LossNorm2Shuf{r}(n) = loss(naiveBayes.mdlNorm2{r},shufMeanArray{n},...
                naiveBayes.time{r});
           [naiveBayes.labelN2Shuf{r,n},naiveBayes.PosteriorN2Shuf{r,n}] = ...
                predict(naiveBayes.mdlNorm2{r},shufMeanArray{n});
            naiveBayes.decodingErrShuf{r,n} = naiveBayes.labelN2Shuf{r,n}-naiveBayes.time{r};
            
            labelN2Tmp = reshape(naiveBayes.labelN2Shuf{r,n},nBins,trialNo);
            naiveBayesMean.labelN2Shuf{r} = naiveBayesMean.labelN2Shuf{r} + mean(labelN2Tmp,2);
            PosteriorN2Tmp = reshape(naiveBayes.PosteriorN2Shuf{r,n},nBins,trialNo,nBins);
            naiveBayesMean.PosteriorN2Shuf{r} = naiveBayesMean.PosteriorN2Shuf{r} + squeeze(mean(PosteriorN2Tmp,2));
            decodingErrTmp = reshape(naiveBayes.decodingErrShuf{r,n},nBins,trialNo);
            naiveBayesMean.decodingErrShuf{r} = naiveBayesMean.decodingErrShuf{r} + mean(decodingErrTmp,2);
        end
        
        %% calculate mean of classification results for shuffled data
        naiveBayesMean.labelN2Shuf{r} = naiveBayesMean.labelN2Shuf{r}/paramC.numShuffle;
        naiveBayesMean.PosteriorN2Shuf{r} = naiveBayesMean.PosteriorN2Shuf{r}/paramC.numShuffle;
        naiveBayesMean.decodingErrShuf{r} = naiveBayesMean.decodingErrShuf{r}/paramC.numShuffle;
        naiveBayesMean.LossNorm2Shuf{r} = mean(naiveBayes.LossNorm2Shuf{r});
        naiveBayesMean.LossNorm2ShufSem{r} = std(naiveBayes.LossNorm2Shuf{r})/sqrt(paramC.numShuffle);
    end
    
    save([pathAnal 'NaiveBayesDecoderPyrPerRec.mat'],'naiveBayes','naiveBayesMean','paramC','-v7.3');
end

function shufMeanArray = neuActShuffle(filteredSpikeArray,numShuffle)
    
    numArr = length(filteredSpikeArray);
    rowArray = size(filteredSpikeArray{1},1);
    colArray = size(filteredSpikeArray{1},2); 
    shufMeanArray = cell(1,numShuffle); 
    parfor i = 1:numShuffle 
        shufMeanArray{i} = zeros(rowArray*colArray,numArr);
        for n = 1:numArr
            shufSpikeArrayTmp = zeros(rowArray,colArray);
            randShift = randi(floor(colArray),1,rowArray)-floor(colArray);
            for j = 1:rowArray
                shiftTmp = circshift(filteredSpikeArray{n}(j,:)',randShift(j));
                shufSpikeArrayTmp(j,:) = shiftTmp';
            end
            tmp = shufSpikeArrayTmp';
            shufMeanArray{i}(:,n) = tmp(:);
        end
    end
end