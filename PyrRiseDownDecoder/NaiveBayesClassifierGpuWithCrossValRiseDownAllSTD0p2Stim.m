function NaiveBayesClassifierGpuWithCrossValRiseDownAllSTD0p2Stim(paths,filenames,mazeSess,upDown,task,onlyRun)
% use a subpopulation of neurons to predit time or distance

    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    if(upDown == 1) % PyrUp
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrRise');
        PyrInd = PyrRise.idxRise';
        PyrRec = PyrRise.indRec;
        PyrNeu = PyrRise.indNeu;
        PyrPulseMeth = PyrRise.pulseMethod;
        PyrStimLoc = PyrRise.stimLoc;
        PyrActOrInact = PyrRise.actOrInact;
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\PyrRiseAL\'];
    elseif(upDown == 2) % PyrDown
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrDown');
        PyrInd = PyrDown.idxDown';
        PyrRec = PyrDown.indRec;
        PyrNeu = PyrDown.indNeu;
        PyrPulseMeth = PyrDown.pulseMethod;
        PyrStimLoc = PyrDown.stimLoc;
        PyrActOrInact = PyrDown.actOrInact;
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\PyrDownAL\'];
    elseif(upDown == 3) % PyrOther
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrOther');
        PyrInd = PyrOther.idxOther';
        PyrRec = PyrOther.indRec;
        PyrNeu = PyrOther.indNeu;        
        PyrPulseMeth = PyrOther.pulseMethod;
        PyrStimLoc = PyrOther.stimLoc;
        PyrActOrInact = PyrOther.actOrInact;
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\PyrOtherAL\'];
    else % PyrUp and PyrDown
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrRise','PyrDown');
        PyrInd = [PyrRise.idxRise; PyrDown.idxDown]';
        PyrRec = [PyrRise.indRec PyrDown.indRec];
        PyrNeu = [PyrRise.indNeu PyrDown.indNeu];
        PyrPulseMeth = [PyrRise.pulseMethod PyrDown.pulseMethod];
        PyrStimLoc = [PyrRise.stimLoc PyrDown.stimLoc]; 
        PyrActOrInact = [PyrRise.actOrInact PyrDown.actOrInact];
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\PyrRiseDownAL\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    GlobalConstFq;
    pathAnal1 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSig\2\'];
    if(exist([pathAnal1 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']))
        load([pathAnal1 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat'],'modPyr1AL');
    end
    
    %% label recordings to be excluded
    indInclRec = ones(1,length(modPyr1AL.indRec));
    for i = 1:length(excludeRec)
        ind = modPyr1AL.indRec == excludeRec(i);
        indInclRec(ind) = 0;
    end
    ind = modPyr1AL.indDriftRec & indInclRec;
    isField = modPyr1AL.isNeuWithFieldAlignedGoodNonStim(ind); % whether the neuron has a firing field
    indRec = modPyr1AL.indRec(ind); % recording index
    indNeu0 = modPyr1AL.indNeu(ind); % neuron indices trials
    
    pathAnal2 = ['Z:\Yingxue\Draft\PV\Pyramidal\'];
    if(exist([pathAnal2 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']))
        load([pathAnal2 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat'],'modPyr1SigAL');
    end
    
    %% define parameters for decoding
    paramC.timeBin = 0.002; %sec, data processing sampling rate
    paramC.timeBin1 = 0.1; %sec, decoding time bin
    timeBinRatio = round(paramC.timeBin1/paramC.timeBin); 
    paramC.timeBinRatio = round(paramC.timeBin1/paramC.timeBin); % how many samples there are in each decoding time bin 
    
    std0 = 0.2/paramC.timeBin; %0.2, window of gaussian smoothing 
    paramC.gaussFilt = gaussFilter(12*std0, std0); % gaussian filter
    lenGaussKernel = length(paramC.gaussFilt);
    normFactor = sum(paramC.gaussFilt);
    paramC.gaussFilt = paramC.gaussFilt./normFactor; % normalized gaussian filter
    
    paramC.trialLenT = ceil(5/paramC.timeBin1)*paramC.timeBin1; %sec, define max decoding time 
    paramC.numShuffle = 50; % number of shuffles
    paramC.minNoNeurons = 20; % mininum number neurons per recording
    paramC.minTrNum = 30; % min number of trials per recording 
    
    % calculate the processing time steps for each trial
    nMaxSample = paramC.trialLenT*sampleFq; 
    nSamplePerBin = paramC.timeBin*sampleFq;
    if(floor(nSamplePerBin/2) ~= 0)
        paramC.timeStep = floor(nSamplePerBin/2):nSamplePerBin:nMaxSample;
    else
        paramC.timeStep = 1:nSamplePerBin:nMaxSample;
    end
    nBins = length(paramC.timeStep);
    paramC.nBins = length(paramC.timeStep)/timeBinRatio; % number of time bins per trial
    
    % calculating the decoding time steps for each trial
    nSamplePerBin = paramC.timeBin1*sampleFq;
    paramC.timeStep1 = floor(nSamplePerBin/2):nSamplePerBin:nMaxSample;
    
    % number of total recordings      
    recNo = unique(PyrRec);
    numRec = length(recNo);
   
    save([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat'],'recNo','paramC');
                   
    for r = 1:numRec
        disp(['rec' num2str(recNo(r)) ' ' filenames(recNo(r),:)])
        
        % initiate decoding data structs
        naiveBayes = struct( ...
            'recNo',recNo(r),...
            'trialNo',[],...
            'trialNoStim',[],...
            'indNeu',[],...
            ...
            'filteredSpikeNorm2Train',[],...
            'filteredSpikeNorm2Stim',[],...
            'timeTrain',[],...
            'timeStim',[],...
            ...
            'mdlNorm2',[],...
            'labelN2',[],...
            'PosteriorN2',[],...
            'CostN2',[],...
            'decodingErr',[],...
            'cmNorm2',[],...
            ...
            'labelN2MeanShuf',[],...
            'labelN2ModeShuf',[],...
            'labelN2PostShuf',[],...
            'decodingErrMeanShuf',[],...
            'decodingErrModeShuf',[],...
            'decodingErrPostShuf',[],...
            ...
            'labelN2Stim',[],...
            'PosteriorN2Stim',[],...
            'decodingErrStim',[]);
        

        naiveBayesMean = struct( ...
            'labelN2',[],...
            'labelN2Post',[],...
            'PosteriorN2',[],...
            'CostN2',[],...
            'decodingErrMean',[],...
            'decodingErrMode',[],...
            'decodingErrPost',[],...
            ...
            'labelN2MeanShuf',[],...
            'labelN2ModeShuf',[],...
            'labelN2PostShuf',[],...
            'PosteriorN2Shuf',[],...
            'decodingErrMeanShuf',[],...
            'decodingErrModeShuf',[],...
            'decodingErrPostShuf',[],...
            ...
            'labelN2Stim',[],...
            'labelN2PostStim',[],...
            'PosteriorN2Stim',[],...
            'decodingErrMeanStim',[],...
            'decodingErrModeStim',[],...
            'decodingErrPostStim',[]);

        if(recNo(r) == 45)
            continue;
        end
        
        % loading relevant files
        fullPathSpike = [paths(recNo(r),:) filenames(recNo(r),:) '_alignedSpikesPerNPerT_msess' ...
            num2str(mazeSess(recNo(r))) '_Run1.mat'];
        if(exist(fullPathSpike) == 0)
            disp('The _alignedSpikesPerNPerT file does not exist');
            return;
        end
        load(fullPathSpike,'trialsRunSpikes');
        
        fileNamePeakFR = [filenames(recNo(r),:) '_PeakFRAligned_msess' num2str(mazeSess(recNo(r))) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(recNo(r),:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'trialNoStim','pulseMeth');
                    
        % check there is enough number of tirals in this recording
        trialNo = length(modPyr1SigAL.trialNoCtrlGood{recNo(r)});
        if(trialNo < paramC.minTrNum)
            disp(['Only ' num2str(length(modPyr1SigAL.trialNoCtrlGood{recNo(r)})) ...
                ' trials are good trials in recording ' filenames(recNo(r),:)]);
            continue;
        end
        
        % get the indices of pyramidal neurons from one recording, without
        % field
        ind = PyrRec == recNo(r);
        indNonF = indRec == recNo(r) & isField == 0; 
        indNeu = intersect(PyrNeu(ind),indNeu0(indNonF)); 
        % only consider good control trials (including nonstim and 2nd stim ctrl)
        neuronNo = length(indNeu);
                
        % check that there is enough number of neurons in the recording
        if(neuronNo <= paramC.minNoNeurons)
            disp(['There are only ' num2str(neuronNo) ' neurons in this recording']);
            continue;
        end
        
        % collect basic information about the session
        naiveBayes.trialNo = modPyr1SigAL.trialNoCtrlGood{recNo(r)};
        naiveBayes.trialNoStim = trialNoStim;
        naiveBayes.indNeu = indNeu;
        
        %% calculate filtered spike array for each neuron over good trials, separating training and testing set
        % control trials
        filteredSpikeNorm2 = zeros(neuronNo*timeBinRatio,trialNo*nBins/timeBinRatio);
        for i  = 1:neuronNo
            disp(['Neuron ' num2str(indNeu(i))]);   
            % filter spikes aligned to start run
            spikeArray = zeros(trialNo,nBins+2*lenGaussKernel);
            for j = 1:trialNo
                indTime = trialsRunSpikes.Time{indNeu(i),naiveBayes.trialNo(j)} <= nMaxSample;
                if(isempty(indTime))
                    continue;
                end
                spikeTime = trialsRunSpikes.Time{indNeu(i),naiveBayes.trialNo(j)}(indTime);  
                spikeTrain = hist(spikeTime,paramC.timeStep);
                spikeArray(j,:) = [spikeTrain(nBins-lenGaussKernel+1:nBins)...
                            spikeTrain spikeTrain(1:lenGaussKernel)];   
            end
            filteredSpikeTmp = conv2(spikeArray,paramC.gaussFilt);
            filteredSpikeTmp = ...
                    filteredSpikeTmp(:,floor(lenGaussKernel/2)+lenGaussKernel+1:...
                        (end-2*lenGaussKernel+floor(lenGaussKernel/2)+1));     
            filteredSpikeArrayRun = filteredSpikeTmp./paramC.timeBin;
            filteredSpikeArrayRunNorm2 = zscore(filteredSpikeArrayRun,0,2);

            % reshape the filtered spike array for training data
            tmpF = filteredSpikeArrayRunNorm2';
            tmp1 = reshape(tmpF,timeBinRatio,[],size(tmpF,2));
            tmp = reshape(tmp1,timeBinRatio,[]);
            filteredSpikeNorm2((i-1)*timeBinRatio+1:i*timeBinRatio,:) = tmp;
        end
        clear filteredSpikeArrayRunNorm2;
                
        % stim trials
        filteredSpikeNorm2Stim = cell(1,length(pulseMeth));
        for p = 1:length(pulseMeth)
            filteredSpikeNorm2Stim{p} = zeros(neuronNo*timeBinRatio,length(trialNoStim{p})*nBins/timeBinRatio);
            for i = 1:neuronNo            
%                 disp(['Pulse method = ' num2str(pulseMeth(n))]);
                spikeArray = zeros(length(trialNoStim{p}),nBins+2*lenGaussKernel);
                for j = 1:length(trialNoStim{p})
                    indTime = trialsRunSpikes.Time{indNeu(i),trialNoStim{p}(j)} <= nMaxSample;
                    if(isempty(indTime))
                        continue;
                    end
                    spikeTime = trialsRunSpikes.Time{indNeu(i),trialNoStim{p}(j)}(indTime);  
                    spikeTrain = hist(spikeTime,paramC.timeStep);
                    spikeArray(j,:) = [spikeTrain(nBins-lenGaussKernel+1:nBins)...
                                spikeTrain spikeTrain(1:lenGaussKernel)];   
                end
                filteredSpikeTmp = conv2(spikeArray,paramC.gaussFilt);
                filteredSpikeTmp = ...
                        filteredSpikeTmp(:,floor(lenGaussKernel/2)+lenGaussKernel+1:...
                            (end-2*lenGaussKernel+floor(lenGaussKernel/2)+1));     
                filteredSpikeArrayRun = filteredSpikeTmp./paramC.timeBin;
                filteredSpikeArrayRunNorm2 = zscore(filteredSpikeArrayRun,0,2);

                % reshape the filtered spike array for training data
                tmpF = filteredSpikeArrayRunNorm2';
                tmp1 = reshape(tmpF,timeBinRatio,[],size(tmpF,2));
                tmp = reshape(tmp1,timeBinRatio,[]);
                filteredSpikeNorm2Stim{p}((i-1)*timeBinRatio+1:i*timeBinRatio,:) = tmp;
            end
            filteredSpikeNorm2Stim{p} = filteredSpikeNorm2Stim{p}';
            clear filteredSpikeArrayRunNorm2;
        end

        % record the training and testing data
        naiveBayes.filteredSpikeNorm2Train = filteredSpikeNorm2';
        naiveBayes.filteredSpikeNorm2Stim = filteredSpikeNorm2Stim;

        % construct decoding time steps over trials
        tStep = paramC.timeStep1'/sampleFq;
        timeTmp = repmat(tStep,1,trialNo);
        naiveBayes.timeTrain = timeTmp(:);
        for p = 1:length(pulseMeth)
            timeTmp = repmat(tStep,1,length(trialNoStim{p}));
            naiveBayes.timeTrainStim{p} = timeTmp(:);
        end

        %% naive bayes classification, train on 50% data and test on the other 50%      
%         gpuSpikeNorm = gpuArray(filteredSpikeNorm2');
        gpuTime = naiveBayes.timeTrain;
        kf = 10;
        naiveBayes.mdlNorm2 = fitcnb(filteredSpikeNorm2',gpuTime,'KFold', kf);
        [naiveBayes.labelN2,naiveBayes.PosteriorN2,naiveBayes.CostN2] = ...
             kfoldPredict(naiveBayes.mdlNorm2);
        naiveBayes.cmNorm2 = confusionchart(gpuTime,naiveBayes.labelN2);
        naiveBayes.decodingErr = naiveBayes.labelN2-gpuTime;
%         save([pathAnal filenames(recNo(r),:) '_cmNorm2.fig']);
        print('-painters', '-dpdf', [pathAnal filenames(recNo(r),:) '_cmNorm2'], '-r600');

        %% calculate mean of classification results
        nBins1 = paramC.nBins;
        labelN2Tmp = reshape(naiveBayes.labelN2,nBins1,trialNo);
        naiveBayesMean.labelN2 = mode(labelN2Tmp,2); % label calculated based on mode
        PosteriorN2Tmp  = reshape(naiveBayes.PosteriorN2,nBins1,trialNo,nBins1);
        naiveBayesMean.PosteriorN2 = squeeze(mean(PosteriorN2Tmp,2));% rows are the actual time, columns are the decoded time
        [~,maxIdxPoster] = max(naiveBayesMean.PosteriorN2'); % changed on 1/25/2025, add matrix transpose
        naiveBayesMean.labelN2Post = tStep(maxIdxPoster); % label calculated based on mean posteriorN2
        CostN2Tmp = reshape(naiveBayes.CostN2,nBins1,trialNo,nBins1);
        naiveBayesMean.CostN2 = squeeze(mean(CostN2Tmp,2));
        decodingErrTmp = reshape(naiveBayes.decodingErr,nBins1,trialNo);
        naiveBayesMean.decodingErrMean = mean(decodingErrTmp,2); % decoding error calculated based on mean of labelN2
        naiveBayesMean.decodingErrMode = mode(decodingErrTmp,2); % decoding error calculated based on mode of labelN2
        naiveBayesMean.decodingErrPost = naiveBayesMean.labelN2Post-tStep; % decoding error calculated based on max posterior prob. averagd across trials
                
        %% predict the shuffled data
        timeSt = length(paramC.timeStep1);
        
        % Preallocate matrices outside the loop
        labelN2MeanShuf = zeros(nBins1, paramC.numShuffle);
        labelN2ModeShuf = zeros(nBins1, paramC.numShuffle);
        labelN2PostShuf = zeros(nBins1, paramC.numShuffle);
        decodingErrMeanShuf = zeros(nBins1, paramC.numShuffle);
        decodingErrModeShuf = zeros(nBins1, paramC.numShuffle);
        decodingErrPostShuf = zeros(nBins1, paramC.numShuffle);
        PosteriorN2Shuf = zeros(nBins1, nBins1, paramC.numShuffle);
                
        parfor n = 1:paramC.numShuffle    
            % Initialize variables within the parfor loop
            shufInd = zeros(1,timeSt*trialNo);
            predictions = zeros(nBins1*trialNo, kf);
            posteriors = zeros(nBins1*trialNo,nBins1,kf);
                        
            % Vectorized shuffle index generation            
            for m = 1:trialNo
                idx_start = (m-1) * timeSt + 1;
                idx_end = idx_start + timeSt - 1;
                shufInd(idx_start:idx_end) = randperm(timeSt)+(m-1)*timeSt;                
            end
            shufSpikeNorm = filteredSpikeNorm2(:,shufInd);
            
            % Vectorized predictions and posteriors calculation
            for i = 1:kf
                trainedModel =  naiveBayes.mdlNorm2.Trained{i};
                [pred, posterior] = predict(trainedModel, shufSpikeNorm');
                predictions(:, i) = pred;
                posteriors(:, :, i) = posterior;
            end
            
            % Majority vote for ensemble prediction
            labelN2Tmp = mode(predictions, 2);
            labelN2Tmp1 = reshape(labelN2Tmp,nBins1,trialNo);
            labelN2MeanShuf(:,n) = mean(labelN2Tmp1,2); % label calculated based on mean. use mode will result in mostly max time
            labelN2ModeShuf(:,n) = mode(labelN2Tmp1,2); % label calculated based on mode

            % Average posterior probabilities
            PosteriorN2Tmp = mean(posteriors, 3);
            PosteriorN2Tmp = reshape(PosteriorN2Tmp,nBins1,trialNo,nBins1);
            meanPosteriorTmp = squeeze(mean(PosteriorN2Tmp,2));
            PosteriorN2Shuf(:,:,n) = meanPosteriorTmp;
                        
            % Calculate label based on mean Posterior
            [~,maxIdxPoster] = max(meanPosteriorTmp'); % changed on 1/25/2025, add matrix transpose
            labelN2PostShuf(:,n) = tStep(maxIdxPoster); % label calculated based on mean posteriorN2
            
            % Calculate decoding error
            decodingErrTmp = labelN2Tmp-gpuTime;
            decodingErrTmp = reshape(decodingErrTmp,nBins1,trialNo);
            decodingErrMeanShuf(:,n) = mean(decodingErrTmp,2); % decoding error calculated based on mean of labelN2
            decodingErrModeShuf(:,n) = mode(decodingErrTmp,2); % decoding error calculated based on mode of labelN2
            decodingErrPostShuf(:,n) = labelN2PostShuf(:,n) - tStep; % decoding error calculated based on max posterior prob. averagd across trials
        end
        
        % Store results in naiveBayes and naiveBayesMean
        naiveBayes.labelN2MeanShuf = labelN2MeanShuf;
        naiveBayes.labelN2ModeShuf = labelN2ModeShuf;
        naiveBayes.labelN2PostShuf = labelN2PostShuf;
        naiveBayes.decodingErrMeanShuf = decodingErrMeanShuf;
        naiveBayes.decodingErrModeShuf = decodingErrModeShuf;
        naiveBayes.decodingErrPostShuf = decodingErrPostShuf;
        
        naiveBayesMean.labelN2MeanShuf = mean(naiveBayes.labelN2MeanShuf,2);
        naiveBayesMean.labelN2ModeShuf = mode(naiveBayes.labelN2ModeShuf,2);
        naiveBayesMean.PosteriorN2Shuf = sum(PosteriorN2Shuf,3)/paramC.numShuffle; 
        [~,maxIdxPoster] = max(naiveBayesMean.PosteriorN2Shuf'); % changed on 1/25/2025, add transpose
        naiveBayesMean.labelN2PostShuf = tStep(maxIdxPoster); % label calculated based on mean posteriorN2
        naiveBayesMean.decodingErrMeanShuf = mean(decodingErrMeanShuf,2); % decoding error calculated based on mean of labelN2
        naiveBayesMean.decodingErrModeShuf = mode(decodingErrModeShuf,2); % decoding error calculated based on mode of labelN2
        naiveBayesMean.decodingErrPostShuf = naiveBayesMean.labelN2PostShuf - tStep; % decoding error calculated based on max posterior prob. averagd across trials
        
        %% naive bayes classification on stim data
        naiveBayes.labelN2Stim = cell(1,length(pulseMeth));
        naiveBayes.PosteriorN2Stim = cell(1,length(pulseMeth));
        naiveBayes.decodingErrStim = cell(1,length(pulseMeth));
        
        naiveBayesMean.pulseMeth = pulseMeth;
        for p = 1:length(pulseMeth)         
            trialNoS = length(trialNoStim{p});
            predictions = zeros(nBins1*trialNoS, kf);
            posteriors = zeros(nBins1*trialNoS,nBins1,kf);

            for i = 1:kf
                trainedModel =  naiveBayes.mdlNorm2.Trained{i};
                [pred, posterior] = predict(trainedModel, filteredSpikeNorm2Stim{p});
                predictions(:, i) = pred;
                posteriors(:, :, i) = posterior;
            end
            
            % Majority vote for ensemble prediction
            labelN2Tmp = mode(predictions, 2);
            naiveBayes.labelN2Stim{p} = reshape(labelN2Tmp,nBins1,trialNoS);

            % Average posterior probabilities
            PosteriorN2Tmp = mean(posteriors, 3);
            naiveBayes.PosteriorN2Stim{p}  = reshape(PosteriorN2Tmp,nBins1,trialNoS,nBins1);
            
            decodingErrTmp = labelN2Tmp-naiveBayes.timeTrainStim{p};
            naiveBayes.decodingErrStim{p} = reshape(decodingErrTmp,nBins1,trialNoS);
            
            %% calculate mean of prediction results
            naiveBayesMean.labelN2Stim{p} = mode(naiveBayes.labelN2Stim{p},2);
            naiveBayesMean.PosteriorN2Stim{p} = squeeze(mean(naiveBayes.PosteriorN2Stim{p},2)); % rows are the actual time, columns are the decoded time
            [~,maxIdxPoster] = max(naiveBayesMean.PosteriorN2Stim{p}'); % changed on 1/25/2025, add transpose
            naiveBayesMean.labelN2PostStim{p} = tStep(maxIdxPoster); % label calculated based on mean posteriorN2
            naiveBayesMean.decodingErrMeanStim{p} = mean(naiveBayes.decodingErrStim{p},2); % decoding error calculated based on mean of labelN2
            naiveBayesMean.decodingErrModeStim{p} = mode(naiveBayes.decodingErrStim{p},2); % decoding error calculated based on mode of labelN2
            naiveBayesMean.decodingErrPostStim{p} = naiveBayesMean.labelN2PostStim{p}-tStep; % decoding error calculated based on max posterior prob. averagd across trials
       
            %% plot errors from ctrl and stim trials
            figure(1)
            plot(naiveBayesMean.decodingErrPost,'k');
            hold on;
            plot(naiveBayesMean.decodingErrPostStim{p},'r');
            hold off;
            ylabel('err')
            title(['Rec.' num2str(recNo(r)) ' pulseMeth' num2str(pulseMeth(p))]);

            clear predictions posteriors
        end
        
        save([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal' num2str(recNo(r)) '.mat'],'naiveBayes','naiveBayesMean','paramC','-v7.3');
    end
end
