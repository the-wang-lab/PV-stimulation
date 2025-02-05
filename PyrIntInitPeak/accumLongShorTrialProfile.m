function modPyr2 = accumLongShorTrialProfile(paths,filenames,mazeSess,autoCorrPyrAll,minFR,maxFR,task,sampleFq)
% accumulate the firing rate profiles separately for trials where the
% reward is given around 180 cm vs 200cm

    numRec = size(paths,1);
    modPyr2 = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                        'indRec',[],... % recording index
                        'indNeu',[],... % neuron indices
                        ...
                        'indTrShort',[],... % the indices of short trials
                        'indTrLong',[],... % the indices of long trials
                        'numShortTr',[],... % number of short trials
                        'numLongTr',[],... % number of long trials
                        'rewardDistShort',[],...
                        'rewardDistLong',[],...
                        'rewardIndShort',[],...
                        'rewardIndLong',[],...
                        ...
                        'timeStepSpeed',[],...
                        'speedHistShort',[],...
                        'speedHistLong',[],...
                        ...
                        'timeStepRun',[],...                        
                        'avgFRProfileShort',[],...% average firing rate profile short trials
                        'avgFRProfileLong',[]);% average firing rate profile long trials
                    
    for i = 1:numRec
        disp(['rec' num2str(i)])   
        
        %% load files
        % load behavior file
        fileNameInfo = [filenames(i,:) '_Info.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr','beh'); 
        
        % load aligned to run file
        fullPath = fullfile(paths(i,:), [filenames(i,:) '_alignRun_msess' num2str(mazeSess(i)) '.mat']);
        load(fullPath);

        % load trial numbers for good non stim trials
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];
        if(exist(fullPath) == 0)
            disp('The peak firing rate aligned to run file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood');
        
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct');
        
        % load the convolved spike array
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath);
            
        % load firing rate file
        fullPathFR = [filenames(i,:) '_FR_Run1.mat'];
        fullPath = [paths(i,:) fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFR = mFRStructSess{mazeSess(i)};
        else
            mFR = mFRStruct;
        end
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        % identify pyramidal neurons
        indNeu = find(mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1);
                
        indTmp = find(autoCorrPyrAll.task == task & autoCorrPyrAll.indRec == i);
        if(length(indTmp) ~= length(indNeu))
            disp(['the number of neurons in recording task = ' num2str(task) ' rec. no. = ' num2str(i)...
                    'does not match that in the autoCorrPyrAll struct.']);
        end
        
        if(length(pFRNonStimGoodStruct.indLapList) ~= length(trialNoNonStimGood))
            disp([ 'rec' num2str(i) ' has unequal number of trials for pFRNonStimGoodStruct.indLapList and trialNoNonStimGood']);
        end
        
        if(length(trialNoNonStimGood) < paramF.minNumTr)
            disp([ 'rec' num2str(i) ' has less than ' num2str(paramF.minNumTr) ' control trials']);
            continue;
        end
       
        modPyr2.task = [modPyr2.task task*ones(1,length(indNeu))];
        modPyr2.indRec = [modPyr2.indRec i*ones(1,length(indNeu))];
        modPyr2.indNeu = [modPyr2.indNeu indNeu]; 
        
        %% find long and short trials
        % Extract trialsRun fields
        pumpLfpInd = trialsRun.pumpLfpInd;
        startLfpInd = trialsRun.startLfpInd;
        xMM = trialsRun.xMM;

        % Process data trial by trial
        rewardDist = zeros(1,length(trialNoNonStimGood));
        rewardInd = zeros(1, length(trialNoNonStimGood));
        for trialIdx = 1:length(trialNoNonStimGood)
            if(~isempty(pumpLfpInd{trialNoNonStimGood(trialIdx)}) ...
                    & ~isempty(xMM{trialNoNonStimGood(trialIdx)}))
                % reward distance of each trial
                rewardDist(trialIdx) = xMM{trialNoNonStimGood(trialIdx)}...
                    (pumpLfpInd{trialNoNonStimGood(trialIdx)}(1) - startLfpInd(trialNoNonStimGood(trialIdx)));
                % reward index of each trial
                rewardInd(trialIdx) = pumpLfpInd{trialNoNonStimGood(trialIdx)}(1) ...
                    - startLfpInd(trialNoNonStimGood(trialIdx));
            end
        end
        
        indLongTr = find(rewardDist > 1950);
        indShortTr = find(rewardDist < 1850 & rewardDist > 1000);
        
        % Record the reward locations for short and long trials
        modPyr2.indTrShort{i} = trialNoNonStimGood(indShortTr);
        modPyr2.indTrLong{i} = trialNoNonStimGood(indLongTr);
        modPyr2.numShortTr(i) = length(indShortTr);
        modPyr2.numLongTr(i) = length(indLongTr);
        modPyr2.rewardDistShort{i} = rewardDist(indShortTr);
        modPyr2.rewardDistLong{i} = rewardDist(indLongTr);
        modPyr2.rewardIndShort{i} = rewardInd(indShortTr);
        modPyr2.rewardIndLong{i} = rewardInd(indLongTr);
        
        % Calculate the mean speed within each time bin
        sampleFqSpeed = 250;
        modPyr2.timeStepSpeed = timeStepRun(1)/sampleFq:1/250:timeStepRun(end)/sampleFq;
        [modPyr2.speedHistShort{i},modPyr2.speedHistLong{i}] = calculate_speed_histograms...
            (trialsRun, modPyr2.timeStepSpeed, sampleFqSpeed,modPyr2.indTrShort{i},modPyr2.indTrLong{i});
                
        % Calculate the averaged profile for short and long trials
        for n = 1:length(indNeu)
            FRProfileShort = filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood(indShortTr),:);
            FRProfileLong = filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood(indLongTr),:);
            if(modPyr2.numShortTr(i) == 1)
                modPyr2.avgFRProfileShort = [modPyr2.avgFRProfileShort; FRProfileShort];
            elseif(modPyr2.numShortTr(i) == 0)
                modPyr2.avgFRProfileShort = [modPyr2.avgFRProfileShort; zeros(1,size(filteredSpikeArrayRunOnSet{indNeu(n)},2))];
            else
                modPyr2.avgFRProfileShort = [modPyr2.avgFRProfileShort; mean(FRProfileShort)];
            end
            
            if(modPyr2.numLongTr(i) == 1)
                modPyr2.avgFRProfileLong = [modPyr2.avgFRProfileLong; FRProfileLong];
            elseif(modPyr2.numLongTr(i) == 0)
                modPyr2.avgFRProfileLong = [modPyr2.avgFRProfileLong; zeros(1,size(filteredSpikeArrayRunOnSet{indNeu(n)},2))];
            else
                modPyr2.avgFRProfileLong = [modPyr2.avgFRProfileLong; mean(FRProfileLong)];
            end
        end
        
    end
    
    modPyr2.timeStepRun = timeStepRun/sampleFq;
    modPyr2.indLongTr = indLongTr;
    modPyr2.indShortTr = indShortTr;
    
end

% speed: vector containing the speed at each time point
% binned_time: vector containing the time at the middle of each bin
% sampling_rate: the desired sampling rate for speed calculation (default: 400 Hz)
function binned_speed = calculate_binned_speed(speed, timeStepRun, sampling_rate)
    % Original sampling rate is assumed to be 1250 Hz
    original_rate = 1250;
    decimation_factor = original_rate / sampling_rate;

    % Calculate mean speed within each time bin
    num_bins = length(timeStepRun); % Number of bins provided by binned_time
    binned_speed = zeros(1,num_bins);

    for bin_idx = 1:num_bins
        bin_start = (bin_idx - 1) * decimation_factor + 1;
        bin_end = min(bin_idx * decimation_factor, length(speed)); % Ensure no index exceeds bounds
        if(bin_end == 0)
            return;
        end
        if(bin_start > length(speed))
            break;
        end
        binned_speed(bin_idx) = mean(speed(bin_start:bin_end));
    end
    binned_speed(binned_speed < 0) = 0;
end

function [speedHistShort,speedHistLong] = calculate_speed_histograms(trials, timeStepRun, sampling_rate, indShortTr, indLongTr)
    speedHist = zeros(length(trials.startLfpInd),length(timeStepRun));
    for i = 1:length(trials.startLfpInd)
        speedCurr = [trials.speed_MMsecBef{i}; trials.speed_MMsec{i}];
        speedHist(i,:) = calculate_binned_speed(speedCurr, timeStepRun, sampling_rate);
    end
    speedHistShort = speedHist(indShortTr,:);
    speedHistLong = speedHist(indLongTr,:);
end
