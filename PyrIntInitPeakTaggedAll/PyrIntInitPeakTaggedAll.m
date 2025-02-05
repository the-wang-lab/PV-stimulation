function PyrIntInitPeakTaggedAll()
% compare Pyramidal neurons and PV interneurons on their initial peak (including all the recordings where the number of good trials >= minNumTr...
% regardless of the number of bad trials), If there is 0 bad trials, then
% avgProfile is a zero vector. This is good for comparing good and bad
% trials using color coded firing rate map, but not for calculating the
% firing rate change and comparing avgProfile. Use PyrIntInitPeak for that (where the neurons with >= minNumTr bad trials are considered)
    
    pathAnalInt0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    
    if(exist([pathAnalInt0 'autoCorrIntAllRec.mat']))
        load([pathAnalInt0 'autoCorrIntAllRec.mat']);
        load([pathAnalInt0 'initPeakIntAllRec.mat']);
    end
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakTaggedAll\';
    if(exist([pathAnal 'initPeakAllPyrIntTaggedRec.mat']))
        load([pathAnal 'initPeakAllPyrIntTaggedRec.mat']);
    end
    
    if(exist('InitAllTag') == 0)
        minNumTrBad = 0;
        minNumTr = 15; % should be the same as paramF.minNumTr used inFieldDetectionAligned
        InitAllTag = PyrIntInitPeakByTypeTaggedAll(autoCorrIntTag,modInt1AL,minNumTr,minNumTrBad);

        %% Interneuron rise and down
        for i = 1:max(InitAllTag.idxC2Int)
            idxCTmp = find(InitAllTag.idxC2Int == i);
            idxCTmp = intersect(idxCTmp,InitAllTag.goodNeuInt);
            mean0to1Int = mean(InitAllTag.avgFRProfileInt(idxCTmp,FRProfileMean.indFR0to1),2);
            meanBefRunInt = mean(InitAllTag.avgFRProfileInt(idxCTmp,FRProfileMean.indFRBefRun),2);
            ratio0to1BefRunInt = mean0to1Int./meanBefRunInt;
            [ratio0to1BefRunIntOrd,indOrdInt] = sort(ratio0to1BefRunInt,'descend');
        %     idxInt = find(ratio0to1BefRunIntOrd < 1.25,1);
        %     idxInt1 = find(ratio0to1BefRunIntOrd >= 0.8,1,'last');

        %     idxInt = find(ratio0to1BefRunIntOrd < 2,1);
        %     idxInt1 = find(ratio0to1BefRunIntOrd >= 0.5,1,'last');

            idxNan = isnan(ratio0to1BefRunIntOrd);
            idxInf = isinf(ratio0to1BefRunIntOrd);
            idxInt = find(ratio0to1BefRunIntOrd < 1.5,1);
            idxInt1 = find(ratio0to1BefRunIntOrd >= 2/3,1,'last');

            %% neurons with FR increase around 0
            indOrdTmp = idxCTmp(indOrdInt(1:idxInt));
            idxNanTmp = idxNan(1:idxInt);
            idxInfTmp = idxInf(1:idxInt);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntRiseTag.idxRise{i} = indOrdTmp;
            IntRiseTag.task{i} = InitAllTag.taskInt(indOrdTmp);
            IntRiseTag.indRec{i} = InitAllTag.indRecInt(indOrdTmp);
            IntRiseTag.indNeu{i} = InitAllTag.indNeuInt(indOrdTmp);
            
            %% neurons with FR decrease around 0
            indOrdTmp = idxCTmp(indOrdInt(idxInt1:end));
            idxNanTmp = idxNan(idxInt1:end);
            idxInfTmp = idxInf(idxInt1:end);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntDownTag.idxDown{i} = indOrdTmp;
            IntDownTag.task{i} = InitAllTag.taskInt(indOrdTmp);
            IntDownTag.indRec{i} = InitAllTag.indRecInt(indOrdTmp);
            IntDownTag.indNeu{i} = InitAllTag.indNeuInt(indOrdTmp);
        end

        %% for all the interneurons
        for i = 1:max(InitAllTag.idxC2Int)
            FRProfileMeanIntTag.Rise{i} = accumMeanPVStim(InitAllTag.avgFRProfileInt(IntRiseTag.idxRise{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanIntTag.Down{i} = accumMeanPVStim(InitAllTag.avgFRProfileInt(IntDownTag.idxDown{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanIntTag.RiseBad{i} = accumMeanPVStim(InitAllTag.avgFRProfileBadInt(IntRiseTag.idxRise{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanIntTag.DownBad{i} = accumMeanPVStim(InitAllTag.avgFRProfileBadInt(IntDownTag.idxDown{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanIntStatTag.Rise{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.Rise{i});
            FRProfileMeanIntStatTag.Down{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.Down{i});

            FRProfileMeanIntStatTag.RiseBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.RiseBad{i});
            FRProfileMeanIntStatTag.DownBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.DownBad{i});

            % compare good and bad trials
            if(length(IntRiseTag.idxRise{i}) ~= 0)
                FRProfileMeanIntStatTag.RiseGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanIntTag.Rise{i},FRProfileMeanIntTag.RiseBad{i});
        %         FRProfileMeanIntStatTag.DownGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanIntTag.Down{i},FRProfileMeanIntTag.DownBad{i});
            end
        end

        save([pathAnal 'initPeakAllPyrIntTaggedRec.mat'],'InitAllTag',...
            'IntRiseTag','IntDownTag',...
            'FRProfileMeanIntTag','FRProfileMeanIntStatTag',...
            'minNumTr','-v7.3'); 
    end
    
    %% plot depth of rise and down pyramidal neurons
    colorSel = 0;
    
    plotIntNeuRiseDownTaggedAll(pathAnal,modInt1NoCue.timeStepRun,...
            InitAllTag,IntRiseTag,IntDownTag,FRProfileMean,FRProfileMeanIntTag,FRProfileMeanIntStatTag,colorSel,[{'Good'} {'Bad'}]);

    pathAnalTmp = 'Z:\Yingxue\Draft\PV\interneuron\';
    load([pathAnalTmp 'autoCorrIntAllRec.mat'],'cluPV');
    plotIntNeuRiseDownTaggedAllPVNonPV(pathAnal,modInt1NoCue.timeStepRun,...
            InitAllTag,FRProfileMean,cluPV);
end





