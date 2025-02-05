function InitAll = PyrIntInitPeakByTypeTagged(autoCorrIntTag,modInt1AL)

    cellType = 1; % PV
    indNeu = [];
    indNeuBad = [];
    indNeuTag = [];
    indNeuTagBad = [];
    for i = 1:length(autoCorrIntTag.task)
        indNeuTmp = find(modInt1AL.taskGood == autoCorrIntTag.task(i) &...
                modInt1AL.indRecGood == autoCorrIntTag.indRec(i) &...
                modInt1AL.indNeuGood == autoCorrIntTag.indNeu(i) &...
                autoCorrIntTag.cellType(i) == cellType);  %% added cell type on 8/12/2022
        if(~isempty(indNeuTmp))
            indNeu = [indNeu indNeuTmp];
            indNeuTag = [indNeuTag i];
        end
        
        indNeuTmp = find(modInt1AL.taskBad == autoCorrIntTag.task(i) &...
                modInt1AL.indRecBad == autoCorrIntTag.indRec(i) &...
                modInt1AL.indNeuBad == autoCorrIntTag.indNeu(i) &...
                autoCorrIntTag.cellType(i) == cellType);   %% added cell type on 8/12/2022
        if(~isempty(indNeuTmp))
            indNeuBad = [indNeuBad indNeuTmp];
            indNeuTagBad = [indNeuTagBad i];
        end
    end
    InitAll.taskInt = autoCorrIntTag.task(indNeuTag);
    InitAll.taskIntBad = autoCorrIntTag.task(indNeuTagBad);
    InitAll.indRecInt = autoCorrIntTag.indRec(indNeuTag);
    InitAll.indRecIntBad = autoCorrIntTag.indRec(indNeuTagBad);
    InitAll.indNeuInt = autoCorrIntTag.indNeu(indNeuTag);
    InitAll.indNeuIntBad = autoCorrIntTag.indNeu(indNeuTagBad);
    InitAll.cellTypeInt = autoCorrIntTag.cellType(indNeuTag);
    InitAll.cellTypeIntBad = autoCorrIntTag.cellType(indNeuTagBad);
    InitAll.idxC2Int = autoCorrIntTag.idxC2(indNeuTag);
    InitAll.idxC2IntBad = autoCorrIntTag.idxC2(indNeuTagBad);
    
    InitAll.avgFRProfileInt = modInt1AL.avgFRProfileGood(indNeu,:);
    InitAll.avgFRProfileBadInt = modInt1AL.avgFRProfileBad(indNeuBad,:);
        
    %% normalization
    InitAll.avgFRProfileNormInt = zeros(size(InitAll.avgFRProfileInt,1),size(InitAll.avgFRProfileInt,2));
    for i = 1:size(InitAll.avgFRProfileInt,1)
        if(max(InitAll.avgFRProfileInt(i,:)) ~= 0)
            InitAll.avgFRProfileNormInt(i,:) = InitAll.avgFRProfileInt(i,:)/max(InitAll.avgFRProfileInt(i,:));
        end
    end

    InitAll.avgFRProfileNormBadInt = zeros(size(InitAll.avgFRProfileBadInt,1),size(InitAll.avgFRProfileBadInt,2));
    for i = 1:size(InitAll.avgFRProfileBadInt,1)
        if(max(InitAll.avgFRProfileBadInt(i,:)) ~= 0 && sum(isnan(InitAll.avgFRProfileBadInt(i,:))) == 0)
            InitAll.avgFRProfileNormBadInt(i,:) = InitAll.avgFRProfileBadInt(i,:)/max(InitAll.avgFRProfileBadInt(i,:));
        end
    end
end