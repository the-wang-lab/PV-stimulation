function InitAll = PyrIntInitPeakDistByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                modInt1NoCue,modInt1AL,modInt1PL)

    if(taskSel == 1)   
        InitAll.task = [modPyr1NoCue.taskGood modPyr1AL.taskGood modPyr1PL.taskGood];
        InitAll.taskBad = [modPyr1NoCue.taskBad modPyr1AL.taskBad modPyr1PL.taskBad];
        InitAll.indRec = [modPyr1NoCue.indRecGood modPyr1AL.indRecGood modPyr1PL.indRecGood];
        InitAll.indRecBad = [modPyr1NoCue.indRecBad modPyr1AL.indRecBad modPyr1PL.indRecBad];
        InitAll.indNeu = [modPyr1NoCue.indNeuGood modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
        InitAll.indNeuBad = [modPyr1NoCue.indNeuBad modPyr1AL.indNeuBad modPyr1PL.indNeuBad];
        InitAll.avgFRProfileDist = [modPyr1NoCue.avgFRProfileDistGood; modPyr1AL.avgFRProfileDistGood; modPyr1PL.avgFRProfileDistGood];
        InitAll.avgFRProfileDistBad = [modPyr1NoCue.avgFRProfileDistBad; modPyr1AL.avgFRProfileDistBad; modPyr1PL.avgFRProfileDistBad];
        InitAll.taskInt = [modInt1NoCue.taskGood modInt1AL.taskGood modInt1PL.taskGood];
        InitAll.taskIntBad = [modInt1NoCue.taskBad modInt1AL.taskBad modInt1PL.taskBad];
        InitAll.indRecInt = [modInt1NoCue.indRecGood modInt1AL.indRecGood modInt1PL.indRecGood];
        InitAll.indRecIntBad = [modInt1NoCue.indRecBad modInt1AL.indRecBad modInt1PL.indRecBad];
        InitAll.indNeuInt = [modInt1NoCue.indNeuGood modInt1AL.indNeuGood modInt1PL.indNeuGood];
        InitAll.indNeuIntBad = [modInt1NoCue.indNeuBad modInt1AL.indNeuBad modInt1PL.indNeuBad];
        InitAll.avgFRProfileDistInt = [modInt1NoCue.avgFRProfileDistGood; modInt1AL.avgFRProfileDistGood; modInt1PL.avgFRProfileDistGood];
        InitAll.avgFRProfileDistBadInt = [modInt1NoCue.avgFRProfileDistBad; modInt1AL.avgFRProfileDistBad; modInt1PL.avgFRProfileDistBad];
    elseif(taskSel == 2)
        InitAll.task = [modPyr1AL.taskGood modPyr1PL.taskGood];
        InitAll.taskBad = [modPyr1AL.taskBad modPyr1PL.taskBad];
        InitAll.indRec = [modPyr1AL.indRecGood modPyr1PL.indRecGood];
        InitAll.indRecBad = [modPyr1AL.indRecBad modPyr1PL.indRecBad];
        InitAll.indNeu = [modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
        InitAll.indNeuBad = [modPyr1AL.indNeuBad modPyr1PL.indNeuBad];
        InitAll.avgFRProfileDist = [modPyr1AL.avgFRProfileDistGood; modPyr1PL.avgFRProfileDistGood];
        InitAll.avgFRProfileDistBad = [modPyr1AL.avgFRProfileDistBad; modPyr1PL.avgFRProfileDistBad];
        InitAll.taskInt = [modInt1AL.taskGood modInt1PL.taskGood];
        InitAll.taskIntBad = [modInt1AL.taskBad modInt1PL.taskBad];
        InitAll.indRecInt = [modInt1AL.indRecGood modInt1PL.indRecGood];
        InitAll.indRecIntBad = [modInt1AL.indRecBad modInt1PL.indRecBad];
        InitAll.indNeuInt = [modInt1AL.indNeuGood modInt1PL.indNeuGood];
        InitAll.indNeuIntBad = [modInt1AL.indNeuBad modInt1PL.indNeuBad];
        InitAll.avgFRProfileDistInt = [modInt1AL.avgFRProfileDistGood; modInt1PL.avgFRProfileDistGood];
        InitAll.avgFRProfileDistBadInt = [modInt1AL.avgFRProfileDistBad; modInt1PL.avgFRProfileDistBad];
        %% find the FRprofile of matching cells in the avgFRProfileDist for bad trials    
        InitAll.avgFRProfileDistBadAll =  []; % the avgFRProfileDist in the bad trials which correspond to those neurons in the good trials
        InitAll.avgFRProfileBadAll =  []; % the avgFRProfile in the bad trials which correspond to those neurons in the good trials
        recAL = unique(modPyr1AL.indRec);
        for i = 1:length(recAL)
            indRecGood = find(modPyr1AL.indRecGood == recAL(i));
            if(~isempty(indRecGood))
                indRec = find(modPyr1AL.indRec == recAL(i));
                if(length(indRecGood) == length(indRec))
                    InitAll.avgFRProfileDistBadAll = [InitAll.avgFRProfileDistBadAll; modPyr1AL.avgFRProfileDistBadAll(indRec,:)];
                    InitAll.avgFRProfileBadAll = [InitAll.avgFRProfileBadAll; modPyr1AL.avgFRProfileBadAll(indRec,:)];
                end
            end
        end
        
        recPL = unique(modPyr1PL.indRec);
        for i = 1:length(recPL)
            indRecGood = find(modPyr1PL.indRecGood == recPL(i));
            if(~isempty(indRecGood))
                indRec = find(modPyr1PL.indRec == recAL(i));
                if(length(indRecGood) == length(indRec))
                    InitAll.avgFRProfileDistBadAll = [InitAll.avgFRProfileDistBadAll; modPyr1PL.avgFRProfileDistBadAll(indRec,:)];
                    InitAll.avgFRProfileBadAll = [InitAll.avgFRProfileBadAll; modPyr1PL.avgFRProfileBadAll(indRec,:)];
                end
            end
        end
    elseif(taskSel == 3)
        InitAll.task = modPyr1AL.taskGood;
        InitAll.taskBad = modPyr1AL.taskBad;
        InitAll.indRec = modPyr1AL.indRecGood;
        InitAll.indRecBad = modPyr1AL.indRecBad;
        InitAll.indNeu = modPyr1AL.indNeuGood;
        InitAll.indNeuBad = modPyr1AL.indNeuBad;
        InitAll.avgFRProfileDist = modPyr1AL.avgFRProfileDistGood;
        InitAll.avgFRProfileDistBad = modPyr1AL.avgFRProfileDistBad;
        InitAll.taskInt = modInt1AL.taskGood;
        InitAll.taskIntBad = modInt1AL.taskBad;
        InitAll.indRecInt = modInt1AL.indRecGood;
        InitAll.indRecIntBad = modInt1AL.indRecBad;
        InitAll.indNeuInt = modInt1AL.indNeuGood;
        InitAll.indNeuIntBad = modInt1AL.indNeuBad;
        InitAll.avgFRProfileDistInt = modInt1AL.avgFRProfileDistGood;
        InitAll.avgFRProfileDistBadInt = modInt1AL.avgFRProfileDistBad;    
    elseif(taskSel == 4)
        InitAll.task = modPyr1NoCue.taskGood;
        InitAll.taskBad = modPyr1NoCue.taskBad;
        InitAll.indRec = modPyr1NoCue.indRecGood;
        InitAll.indRecBad = modPyr1NoCue.indRecBad;
        InitAll.indNeu = modPyr1NoCue.indNeuGood;
        InitAll.indNeuBad = modPyr1NoCue.indNeuBad;
        InitAll.avgFRProfileDist = modPyr1NoCue.avgFRProfileDistGood;
        InitAll.avgFRProfileDistBad = modPyr1NoCue.avgFRProfileDistBad;
        InitAll.taskInt = modInt1NoCue.taskGood;
        InitAll.taskIntBad = modInt1NoCue.taskBad;
        InitAll.indRecInt = modInt1NoCue.indRecGood;
        InitAll.indRecIntBad = modInt1NoCue.indRecBad;
        InitAll.indNeuInt = modInt1NoCue.indNeuGood;
        InitAll.indNeuIntBad = modInt1NoCue.indNeuBad;
        InitAll.avgFRProfileDistInt = modInt1NoCue.avgFRProfileDistGood;
        InitAll.avgFRProfileDistBadInt = modInt1NoCue.avgFRProfileDistBad; 
    else
        ind = modPyr1AL.taskGood == 2 & modPyr1AL.indRecGood > 0 & ...
            modPyr1AL.indRecGood <= 10;
        indBad = modPyr1AL.taskBad == 2 & modPyr1AL.indRecBad > 0 & ...
            modPyr1AL.indRecBad <= 10;
        
        indInt = modInt1AL.taskGood == 2 & modInt1AL.indRecGood > 0 & ...
            modInt1AL.indRecGood <= 10;
        indIntBad = modInt1AL.taskBad == 2 & modInt1AL.indRecBad > 0 & ...
            modInt1AL.indRecBad <= 10;
        
        InitAll.task = modPyr1AL.taskGood(ind);
        InitAll.taskBad = modPyr1AL.taskBad(indBad);
        InitAll.indRec = modPyr1AL.indRecGood(ind);
        InitAll.indRecBad = modPyr1AL.indRecBad(indBad);
        InitAll.indNeu = modPyr1AL.indNeuGood(ind);
        InitAll.indNeuBad = modPyr1AL.indNeuBad(indBad);
        InitAll.avgFRProfileDist = modPyr1AL.avgFRProfileDistGood(ind,:);
        InitAll.avgFRProfileDistBad = modPyr1AL.avgFRProfileDistBad(indBad,:);
        InitAll.taskInt = modInt1AL.taskGood(indInt);
        InitAll.taskIntBad = modInt1AL.taskBad(indIntBad);
        InitAll.indRecInt = modInt1AL.indRecGood(indInt);
        InitAll.indRecIntBad = modInt1AL.indRecBad(indIntBad);
        InitAll.indNeuInt = modInt1AL.indNeuGood(indInt);
        InitAll.indNeuIntBad = modInt1AL.indNeuBad(indIntBad);
        InitAll.avgFRProfileDistInt = modInt1AL.avgFRProfileDistGood(indInt,:);
        InitAll.avgFRProfileDistBadInt = modInt1AL.avgFRProfileDistBad(indIntBad,:); 
    end
    
    %% normalization
    InitAll.avgFRProfileDistNorm = zeros(size(InitAll.avgFRProfileDist,1),size(InitAll.avgFRProfileDist,2));
    for i = 1:size(InitAll.avgFRProfileDist,1)
        if(max(InitAll.avgFRProfileDist(i,:)) ~= 0)
            InitAll.avgFRProfileDistNorm(i,:) = InitAll.avgFRProfileDist(i,:)/max(InitAll.avgFRProfileDist(i,:));
        end
    end
    
    InitAll.avgFRProfileDistNormBad = zeros(size(InitAll.avgFRProfileDistBad,1),size(InitAll.avgFRProfileDistBad,2));
    for i = 1:size(InitAll.avgFRProfileDistBad,1)
        if(max(InitAll.avgFRProfileDistBad(i,:)) ~= 0)
            InitAll.avgFRProfileDistNormBad(i,:) = InitAll.avgFRProfileDistBad(i,:)/max(InitAll.avgFRProfileDistBad(i,:));
        end
    end
    
    if(isfield(InitAll,'avgFRProfileDistBadAll'))
        InitAll.avgFRProfileDistBadAllNorm = zeros(size(InitAll.avgFRProfileDistBadAll,1),size(InitAll.avgFRProfileDistBadAll,2));
        for i = 1:size(InitAll.avgFRProfileDistBadAll,1)
            if(max(InitAll.avgFRProfileDistBadAll(i,:)) ~= 0)
                InitAll.avgFRProfileDistBadAllNorm(i,:) = InitAll.avgFRProfileDistBadAll(i,:)/max(InitAll.avgFRProfileDistBadAll(i,:));
            end
        end
    end
    
    InitAll.avgFRProfileDistNormInt = zeros(size(InitAll.avgFRProfileDistInt,1),size(InitAll.avgFRProfileDistInt,2));
    for i = 1:size(InitAll.avgFRProfileDistInt,1)
        if(max(InitAll.avgFRProfileDistInt(i,:)) ~= 0)
            InitAll.avgFRProfileNormDistInt(i,:) = InitAll.avgFRProfileDistInt(i,:)/max(InitAll.avgFRProfileDistInt(i,:));
        end
    end
    
    InitAll.avgFRProfileDistNormBadInt = zeros(size(InitAll.avgFRProfileDistBadInt,1),size(InitAll.avgFRProfileDistBadInt,2));
    for i = 1:size(InitAll.avgFRProfileDistBadInt,1)
        if(max(InitAll.avgFRProfileDistBadInt(i,:)) ~= 0)
            InitAll.avgFRProfileDistNormBadInt(i,:) = InitAll.avgFRProfileDistBadInt(i,:)/max(InitAll.avgFRProfileDistBadInt(i,:));
        end
    end
end