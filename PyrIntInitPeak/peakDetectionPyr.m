function PyrPeak = peakDetectionPyr(timeStepRun,avgFRProfile,idx_Time)
%% detect the first significant peak within the avgFRProfile segment
% timeStepRun: time steps
% avgFRProfile: average firing rate profile over time, each row represent one neuron
% idx_Time: the time step indices during which the peak should be detected

    numShuffles = 500;
    pSig = 99;
    
    % define PyrPeak struct
    PyrPeak = struct('idx_Time',idx_Time,...
                     'loc',zeros(1,size(avgFRProfile,1)),... peak index
                     'amp',zeros(1,size(avgFRProfile,1)),... peak amplitude
                     'time',zeros(1,size(avgFRProfile,1))); % peak time
    % pyrRise
    for i = 1:size(avgFRProfile,1)
        % find peaks in the avgFRProfile
        data = avgFRProfile(i,idx_Time);
        [peaks,locs,width,proms] = findpeaks(data);
        
        % Shuffle data and find peaks in each shuffled dataset
        peaksShuffledData = zeros(numShuffles,length(peaks));
        for n = 1:numShuffles
            shuffledData = data(randperm(length(data))); % Shuffle data
            peaksShuffledData(n,:) = shuffledData(locs);            
        end
        
        % Determine significance threshold
        peaksShufThresh = prctile(peaksShuffledData,pSig);
        
        % Compare actual peaks to threshold
        significantPeak = find(peaks > peaksShufThresh);
        
        % Record the peak location
        if(~isempty(significantPeak))
            PyrPeak.loc(i) = idx_Time(locs(significantPeak(1)));
            PyrPeak.amp(i) = peaks(significantPeak(1));
            PyrPeak.time(i) = timeStepRun(PyrPeak.loc(i));
        else % if no significant peak, use max to estimate the peak location
            [peakVal_Max,idxMax] = max(data);
            PyrPeak.loc(i) = idx_Time(idxMax(1));
            PyrPeak.amp(i) = peakVal_Max;
            PyrPeak.time(i) = timeStepRun(PyrPeak.loc(i));
        end
    end
end