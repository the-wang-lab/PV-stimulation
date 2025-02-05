function FRProfileMean = accumMeanPVStim(avgFRProfile,timeStep)
    
    % overall
    indFRAll = find(timeStep >= -1 & timeStep < 4);
    FRProfileMean.indFRAll = indFRAll;
    FRProfileMean.meanAvgFRProfileAll =  mean(avgFRProfile(:,indFRAll),2);
    
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
    
    % 0-1 sec
    indFR0to1st = find(timeStep >= 0 & timeStep < 1);  
    FRProfileMean.indFR0to1st = indFR0to1st;
    FRProfileMean.meanAvgFRProfile0to1st = mean(avgFRProfile(:,indFR0to1st),2);
    
    % 1.5-3 sec
    indFR1to3 = find(timeStep >= 1.5 & timeStep < 3);  
    FRProfileMean.indFR1to3 = indFR1to3;
    FRProfileMean.meanAvgFRProfile1to3 = mean(avgFRProfile(:,indFR1to3),2);
    
    % 0-3 sec
    indFR0to3 = find(timeStep >= 0.5 & timeStep < 3); % changed from 0 to 0.5 on 1/6/2024 
    FRProfileMean.indFR0to3 = indFR0to3;
    FRProfileMean.meanAvgFRProfile0to3 = mean(avgFRProfile(:,indFR0to3),2);
    
    % 0-2 sec, added on 1/6/2024
    indFR0to2 = find(timeStep >= 0.5 & timeStep < 2); 
    FRProfileMean.indFR0to2 = indFR0to2;
    FRProfileMean.meanAvgFRProfile0to2 = mean(avgFRProfile(:,indFR0to2),2);
    
    % 3-4 sec
    indFR3to4 = find(timeStep >= 3 & timeStep < 4);  
    FRProfileMean.indFR3to4 = indFR3to4;
    FRProfileMean.meanAvgFRProfile3to4 = mean(avgFRProfile(:,indFR3to4),2);
    
    % 3-5 sec
    indFR3to5 = find(timeStep >= 2.5 & timeStep < 4);   % changed to 5 from 4, and from 2 to 2.5 on 1/6/2024
    FRProfileMean.indFR3to5 = indFR3to5;
    FRProfileMean.meanAvgFRProfile3to5 = mean(avgFRProfile(:,indFR3to5),2);
    
    % perc change from 0.5-1.5 s to baseline
    FRProfileMean.percChange0to1VsBL = FRProfileMean.meanAvgFRProfile0to1...
        ./FRProfileMean.meanAvgFRProfileBaseline;
    
    % perc change -1.5- -0.5 s to baseline
    FRProfileMean.percChangeBefRunVsBL = FRProfileMean.meanAvgFRProfileBefRun...
        ./FRProfileMean.meanAvgFRProfileBaseline;
    
    % perc change 0.5 to 1.5 s to -1.5- -0.5 s 
    FRProfileMean.percChangeBefRunVs0to1 = FRProfileMean.meanAvgFRProfile0to1...
        ./FRProfileMean.meanAvgFRProfileBefRun;
    
    % perc change from 0.5-1.5 s to 1.5-3s
    FRProfileMean.percChange0to1Vs1to3 = FRProfileMean.meanAvgFRProfile1to3...
        ./FRProfileMean.meanAvgFRProfile0to1;
    
    % perc change -1.5- -0.5 s to 1.5-3s
    FRProfileMean.percChangeBefRunVs1to3 = FRProfileMean.meanAvgFRProfile1to3...
        ./FRProfileMean.meanAvgFRProfileBefRun;
    
    % perc change from 0.5-1.5 s to 3-5s
    FRProfileMean.percChange0to1Vs3to5 = FRProfileMean.meanAvgFRProfile3to5...
        ./FRProfileMean.meanAvgFRProfile0to1;
    
    % perc change -1.5- -0.5 s to 3-5s
    FRProfileMean.percChangeBefRunVs3to5 = FRProfileMean.meanAvgFRProfile3to5...
        ./FRProfileMean.meanAvgFRProfileBefRun;
    
    %% relative change
    % rel change from 0.5-1.5 s to baseline
    FRProfileMean.relChange0to1VsBL = ...
        (FRProfileMean.meanAvgFRProfile0to1 - FRProfileMean.meanAvgFRProfileBaseline)...
        ./(FRProfileMean.meanAvgFRProfile0to1 + FRProfileMean.meanAvgFRProfileBaseline);
    
    % rel change -1.5- -0.5 s to baseline
    FRProfileMean.relChangeBefRunVsBL = ...
        (FRProfileMean.meanAvgFRProfileBefRun - FRProfileMean.meanAvgFRProfileBaseline)...
        ./(FRProfileMean.meanAvgFRProfileBefRun + FRProfileMean.meanAvgFRProfileBaseline);
    
    % rel change 0.5 to 1.5 s to -1.5- -0.5 s 
    FRProfileMean.relChangeBefRunVs0to1 = ...
        (FRProfileMean.meanAvgFRProfile0to1 - FRProfileMean.meanAvgFRProfileBefRun)...
        ./(FRProfileMean.meanAvgFRProfile0to1 + FRProfileMean.meanAvgFRProfileBefRun);
    
    % rel change from 0.5-1.5 s to 1.5-3s
    FRProfileMean.relChange0to1Vs1to3 = ...
        (FRProfileMean.meanAvgFRProfile0to1 - FRProfileMean.meanAvgFRProfile1to3)...
        ./(FRProfileMean.meanAvgFRProfile0to1 + FRProfileMean.meanAvgFRProfile1to3);
       
    % relative change -1.5- -0.5 s to 1.5-3s
    FRProfileMean.relChangeBefRunVs1to3 = ...
        (FRProfileMean.meanAvgFRProfile1to3 - FRProfileMean.meanAvgFRProfileBefRun)...
        ./(FRProfileMean.meanAvgFRProfile1to3 + FRProfileMean.meanAvgFRProfileBefRun);
    
    % rel change from 0.5-1.5 s to 3-5s
    FRProfileMean.relChange0to1Vs3to5 = ...
        (FRProfileMean.meanAvgFRProfile3to5 - FRProfileMean.meanAvgFRProfile0to1)...
        ./(FRProfileMean.meanAvgFRProfile3to5 + FRProfileMean.meanAvgFRProfile0to1);
    
    % rel change -1.5- -0.5 s to 3-5s
    FRProfileMean.relChangeBefRunVs3to5 = ...
        (FRProfileMean.meanAvgFRProfile3to5 - FRProfileMean.meanAvgFRProfileBefRun)...
        ./(FRProfileMean.meanAvgFRProfile3to5 + FRProfileMean.meanAvgFRProfileBefRun);
    
end