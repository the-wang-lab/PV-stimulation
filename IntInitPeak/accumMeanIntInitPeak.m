function FRProfileMean = accumMeanIntInitPeak(avgFRProfile,timeStep)
       
    % baseline
    indFRBaseline = find(timeStep >= -3 & timeStep < -2);
    FRProfileMean.indFRBaseline = indFRBaseline;
    FRProfileMean.meanAvgFRProfileBaseline =  mean(avgFRProfile(:,indFRBaseline),2);
    
    % -1.5- -0.5 sec
    indFRBefRun = find(timeStep >= -1.5 & timeStep < -0.5);  
    FRProfileMean.indFRBefRun = indFRBefRun;
    FRProfileMean.meanAvgFRProfileBefRun = mean(avgFRProfile(:,indFRBefRun),2);
    
    % 0.5-1.5 sec
    indFR0to1 = find(timeStep >= 0.5 & timeStep < 1.5);  
    FRProfileMean.indFR0to1 = indFR0to1;
    FRProfileMean.meanAvgFRProfile0to1 = mean(avgFRProfile(:,indFR0to1),2);
    
    % 3-5 sec
    indFR1to5 = find(timeStep >= 3 & timeStep < 5);  
    FRProfileMean.indFR1to5 = indFR1to5;
    FRProfileMean.meanAvgFRProfile1to5 = mean(avgFRProfile(:,indFR1to5),2);
    
    % perc change from 0.5-1.5 s to baseline
    FRProfileMean.percChange0to1VsBL = FRProfileMean.meanAvgFRProfile0to1...
        ./FRProfileMean.meanAvgFRProfileBaseline;
    
    % perc change -1.5- -0.5 s to baseline
    FRProfileMean.percChangeBefRunVsBL = FRProfileMean.meanAvgFRProfileBefRun...
        ./FRProfileMean.meanAvgFRProfileBaseline;
    
    % perc change 0.5 to 1.5 s to -1.5- -0.5 s 
    FRProfileMean.percChange0to1VsBefRun = FRProfileMean.meanAvgFRProfile0to1...
        ./FRProfileMean.meanAvgFRProfileBefRun;
    
    % perc change from 0.5-1.5 s to 3-5s
    FRProfileMean.percChange0to1Vs1to5 = FRProfileMean.meanAvgFRProfile0to1...
        ./FRProfileMean.meanAvgFRProfile1to5;
    
    % perc change -1.5- -0.5 s to 3-5s
    FRProfileMean.percChangeBefRunVs1to5 = FRProfileMean.meanAvgFRProfileBefRun...
        ./FRProfileMean.meanAvgFRProfile1to5;
end
