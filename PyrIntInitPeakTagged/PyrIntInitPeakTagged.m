function PyrIntInitPeakTagged()
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
    
    pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakTagged\';
    if(exist([pathAnal 'initPeakAllPyrIntTaggedRec.mat']))
        load([pathAnal 'initPeakAllPyrIntTaggedRec.mat']);
    end
    
    if(exist('InitAllTag') == 0)
        InitAllTag = PyrIntInitPeakByTypeTagged(autoCorrIntTag,modInt1AL);

        %% Interneuron rise and down
        for i = 1:max(InitAllTag.idxC2Int)
            idxCTmp = find(InitAllTag.idxC2Int == i);
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
            IntRiseTag.idxRiseBad{i} = [];
            IntRiseTag.idxRiseBadBad{i} = [];
            IntRiseTag.taskBad{i} = [];
            IntRiseTag.indRecBad{i} = [];
            IntRiseTag.indNeuBad{i} = [];
            for j = 1:length(indOrdTmp)
                idxBad = find(InitAllTag.taskIntBad == IntRiseTag.task{i}(j) & InitAllTag.indRecIntBad == IntRiseTag.indRec{i}(j) ...
                    & InitAllTag.indNeuIntBad == IntRiseTag.indNeu{i}(j));
                if(length(idxBad) == 1)
                    idxBad1 = IntRiseTag.idxRise{i}(j);
                    IntRiseTag.idxRiseBadBad{i} = [IntRiseTag.idxRiseBadBad{i} idxBad];
                    IntRiseTag.idxRiseBad{i} = [IntRiseTag.idxRiseBad{i} idxBad1];
                    IntRiseTag.taskBad{i} = [IntRiseTag.taskBad{i} InitAllTag.taskIntBad(idxBad)];
                    IntRiseTag.indRecBad{i} = [IntRiseTag.indRecBad{i} InitAllTag.indRecIntBad(idxBad)];
                    IntRiseTag.indNeuBad{i} = [IntRiseTag.indNeuBad{i} InitAllTag.indNeuIntBad(idxBad)];
                end
            end
            
            %% neurons with FR decrease around 0
            indOrdTmp = idxCTmp(indOrdInt(idxInt1:end));
            idxNanTmp = idxNan(idxInt1:end);
            idxInfTmp = idxInf(idxInt1:end);
            indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
            IntDownTag.idxDown{i} = indOrdTmp;
            IntDownTag.task{i} = InitAllTag.taskInt(indOrdTmp);
            IntDownTag.indRec{i} = InitAllTag.indRecInt(indOrdTmp);
            IntDownTag.indNeu{i} = InitAllTag.indNeuInt(indOrdTmp);
            IntDownTag.idxDownBad{i} = [];
            IntDownTag.idxDownBadBad{i} = [];
            IntDownTag.taskBad{i} = [];
            IntDownTag.indRecBad{i} = [];
            IntDownTag.indNeuBad{i} = [];
            for j = 1:length(indOrdTmp)
                idxBad = find(InitAllTag.taskIntBad == IntDownTag.task{i}(j) & InitAllTag.indRecIntBad == IntDownTag.indRec{i}(j) ...
                    & InitAllTag.indNeuIntBad == IntDownTag.indNeu{i}(j));
                if(length(idxBad) == 1)
                    idxBad1 = IntDownTag.idxDown{i}(j);
                    IntDownTag.idxDownBadBad{i} = [IntDownTag.idxDownBadBad{i} idxBad];
                    IntDownTag.idxDownBad{i} = [IntDownTag.idxDownBad{i} idxBad1];
                    IntDownTag.taskBad{i} = [IntDownTag.taskBad{i} InitAllTag.taskIntBad(idxBad)];
                    IntDownTag.indRecBad{i} = [IntDownTag.indRecBad{i} InitAllTag.indRecIntBad(idxBad)];
                    IntDownTag.indNeuBad{i} = [IntDownTag.indNeuBad{i} InitAllTag.indNeuIntBad(idxBad)];
                end
            end
        end

        %% for all the interneurons
        for i = 1:max(InitAllTag.idxC2Int)
            FRProfileMeanIntTag.Rise{i} = accumMeanPVStim(InitAllTag.avgFRProfileInt(IntRiseTag.idxRise{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanIntTag.Down{i} = accumMeanPVStim(InitAllTag.avgFRProfileInt(IntDownTag.idxDown{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanIntTag.RiseBad{i} = accumMeanPVStim(InitAllTag.avgFRProfileBadInt(IntRiseTag.idxRiseBadBad{i},:),modInt1NoCue.timeStepRun);
            FRProfileMeanIntTag.DownBad{i} = accumMeanPVStim(InitAllTag.avgFRProfileBadInt(IntDownTag.idxDownBadBad{i},:),modInt1NoCue.timeStepRun);

            FRProfileMeanIntStatTag.Rise{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.Rise{i});
            FRProfileMeanIntStatTag.Down{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.Down{i});

            FRProfileMeanIntStatTag.RiseBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.RiseBad{i});
            FRProfileMeanIntStatTag.DownBad{i} = accumMeanPyrIntInitPeakStatC(FRProfileMeanIntTag.DownBad{i});

            % compare good and bad trials
            if(length(IntRiseTag.idxRise{i}) ~= 0 && length(IntRiseTag.idxRiseBadBad{i}) ~= 0)
                FRProfileMeanIntStatTag.RiseGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanIntTag.Rise{i},FRProfileMeanIntTag.RiseBad{i});
        %         FRProfileMeanIntStatTag.DownGoodBad{i} = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanIntTag.Down{i},FRProfileMeanIntTag.DownBad{i});
            end
        end

        save([pathAnal 'initPeakAllPyrIntTaggedRec.mat'],'InitAllTag',...
            'IntRiseTag','IntDownTag',...
            'FRProfileMeanIntTag','FRProfileMeanIntStatTag','-v7.3'); 
    end
    
    %% plot depth of rise and down pyramidal neurons
    colorSel = 0;
    
    plotIntNeuRiseDownTagged(pathAnal,modInt1NoCue.timeStepRun,...
            InitAllTag,IntRiseTag,IntDownTag,FRProfileMean,FRProfileMeanIntTag,FRProfileMeanIntStatTag,colorSel,[{'Good'} {'Bad'}]);

end





