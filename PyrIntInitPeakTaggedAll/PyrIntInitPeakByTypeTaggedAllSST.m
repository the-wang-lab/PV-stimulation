function InitAll = PyrIntInitPeakByTypeTaggedAllSST(autoCorrIntTag,modInt1AL,minNumTr,minNumTrBad)

    cellType = 2;
    indNeu = [];
    indNeuTag = [];
    for i = 1:length(autoCorrIntTag.task)
        indNeuTmp = find(modInt1AL.task == autoCorrIntTag.task(i) &...
                modInt1AL.indRec == autoCorrIntTag.indRec(i) &...
                modInt1AL.indNeu == autoCorrIntTag.indNeu(i) &...
                autoCorrIntTag.cellType(i) == cellType);  %% added cell type on 8/12/2022 
        if(~isempty(indNeuTmp))
            indNeu = [indNeu indNeuTmp];
            indNeuTag = [indNeuTag i];
        end
    end
    InitAll.taskInt = autoCorrIntTag.task(indNeuTag);
    InitAll.indRecInt = autoCorrIntTag.indRec(indNeuTag);
    InitAll.indNeuInt = autoCorrIntTag.indNeu(indNeuTag);
    InitAll.cellTypeInt = autoCorrIntTag.cellType(indNeuTag);
    InitAll.idxC2Int = autoCorrIntTag.idxC2(indNeuTag);
    
    InitAll.avgFRProfileInt = modInt1AL.avgFRProfileGoodAll(indNeu,:);
    InitAll.avgFRProfileBadInt = modInt1AL.avgFRProfileBadAll(indNeu,:);
    InitAll.numTrGoodInt = modInt1AL.numTrGood(indNeu);
    InitAll.numTrBadInt = modInt1AL.numTrBad(indNeu);
    
    InitAll.goodNeuInt = find(InitAll.numTrGoodInt >= minNumTr & InitAll.numTrBadInt >= minNumTrBad);
    
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