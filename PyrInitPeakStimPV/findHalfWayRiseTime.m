function time50percAvgFR = findHalfWayRiseTime(avgFRProfile,timeStep,riseDown,splitTime)

    % time crossing 90%
    indFRBef = find(timeStep >= -1 & timeStep < splitTime);
    indFRAft = find(timeStep >= splitTime & timeStep < 1.5);
        
    time50percAvgFR = zeros(1,size(avgFRProfile,1));
    for i = 1:size(avgFRProfile,1)
        avgFRProfileTmp = smooth(avgFRProfile(i,:),200);
        if(riseDown == 1)  % rise neurons
            [minFR,indMinFR] = min(avgFRProfileTmp(indFRBef));
            [maxFR,indMaxFR] = max(avgFRProfileTmp(indFRAft));
            halfWay = minFR + (maxFR-minFR)*0.9;
        else % down neurons
            [maxFR,indMaxFR] = max(avgFRProfileTmp(indFRBef));
            [minFR,indMinFR] = min(avgFRProfileTmp(indFRAft));
            halfWay = maxFR - (maxFR-minFR)*0.9;
        end
        if(riseDown == 1) % rise neurons, finding the 50% time point as the firing rate profile ramps up
            ind = find(avgFRProfileTmp(indFRBef(indMinFR):indFRAft(indMaxFR))>= halfWay,1);
            time50percAvgFR(i) = timeStep(indFRBef(indMinFR)+ind-1);
        else % down neurons, finding the 50% time point as the firing rate profile ramps down
            ind = find(avgFRProfileTmp(indFRBef(indMaxFR):indFRAft(indMinFR))<= halfWay,1);
            time50percAvgFR(i) = timeStep(indFRBef(indMaxFR)+ind-1);
        end
    end
    
end

