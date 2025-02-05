function PyrTrough = troughDetectionPyr(timeStepRun,avgFRProfile,idx_Time,idx_TimeWin)
%% detect the first significant trough within the avgFRProfile segment
% timeStepRun: time steps
% avgFRProfile: average firing rate profile over time, each row represent one neuron
% idx_Time: the time step indices during which the trough should be detected
% idx_TimeWin: the time step indices during which the trough should be considered


    numShuffles = 500;
    pSig = 99;
    
    % define PyrPeak struct
    PyrTrough = struct('idx_Time',idx_Time,...
                     'idx_TimeWin',idx_Time,...
                     'loc',zeros(1,size(avgFRProfile,1)),... peak index
                     'amp',zeros(1,size(avgFRProfile,1)),... peak amplitude
                     'time',zeros(1,size(avgFRProfile,1))); % peak time
    % pyrRise
    for i = 1:size(avgFRProfile,1)
        % find peaks in the avgFRProfile
        data = -avgFRProfile(i,idx_Time);
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
            loc = idx_Time(locs(significantPeak));
            amp = -peaks(significantPeak);
            time = timeStepRun(loc);
            sigPeakInWindow = find(loc >= idx_TimeWin(1) & ...
                loc <= idx_TimeWin(end));
            if(~isempty(sigPeakInWindow)) % if the significant peak is within the window idx_TimeWin
                PyrTrough.loc(i) = loc(sigPeakInWindow(1));
                PyrTrough.amp(i) = amp(sigPeakInWindow(1));
                PyrTrough.time(i) = time(sigPeakInWindow(1));
            else
                [peakVal_Max,idxMax] = max(-avgFRProfile(i,idx_TimeWin));
                PyrTrough.loc(i) = idx_TimeWin(idxMax(1));
                PyrTrough.amp(i) = -peakVal_Max;
                PyrTrough.time(i) = timeStepRun(PyrTrough.loc(i));
            end
        else % if no significant peak, use max to estimate the peak location
            [peakVal_Max,idxMax] = max(-avgFRProfile(i,idx_TimeWin));
            PyrTrough.loc(i) = idx_TimeWin(idxMax(1));
            PyrTrough.amp(i) = -peakVal_Max;
            PyrTrough.time(i) = timeStepRun(PyrTrough.loc(i));
        end
    end
end