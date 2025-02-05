function PyrNaiveBayesEncoderAllRecWithCrossValSTD0p2Stim(upDown)

    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\'];
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1');
    end

    if(upDown == 1) % PyrUp
        pathAnal = [pathAnal 'PyrUpAL\'];
    elseif(upDown == 2) % PyrDown
        pathAnal = [pathAnal 'PyrDownAL\'];
    elseif(upDown == 3) % PyrOther
        pathAnal = [pathAnal 'PyrOtherAL\'];
    else % PyrUp and PyrDown
        pathAnal = [pathAnal 'PyrRiseDownAL\'];
        
    end
    if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
        load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
    end
    if(exist('naiveBayesMeanAll') == 0)
        load([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat'],'recNo','paramC');
    end
            
    GlobalConstFq;
    
    if(exist('naiveBayesMeanAll') == 0)
    %% accumulate the decoding information from each recording
        naiveBayesMeanAll = accumNaiveBayesEncoderTypes(recNo, pathAnal, paramC.nBins);
         
        save([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanAll');
    end
        
    numCond = length(PyrStim1.FRProfile1);
    for cond = 1:numCond
        naiveBayesMeanStimAll{cond}.actOrInact = PyrStim1.FRProfile1{cond}.actOrInact;
        naiveBayesMeanStimAll{cond}.pulseMethod = PyrStim1.FRProfile1{cond}.pulseMethod;
        naiveBayesMeanStimAll{cond}.stimLoc = PyrStim1.FRProfile1{cond}.stimLoc;
        if(upDown == 1)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrRise);
        elseif(upDown == 2)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrDown);
        elseif(upDown == 3)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrOther);
        else
            indRec = unique([PyrStim1.FRProfile1{cond}.indRecPyrRise PyrStim1.FRProfile1{cond}.indRecPyrDown]);
        end
        [~,iRecNo] = intersect(naiveBayesMeanAll.recNo,indRec);
        iRecNo = iRecNo(naiveBayesMeanAll.pulseMeth(iRecNo) == naiveBayesMeanStimAll{cond}.pulseMethod);
        naiveBayesMeanStimAll{cond}.recNo = naiveBayesMeanAll.recNo(iRecNo);

        naiveBayesMeanStimAll{cond}.numNeu = naiveBayesMeanAll.numNeu(iRecNo);
        naiveBayesMeanStimAll{cond}.numTr = naiveBayesMeanAll.numTr(iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2 = naiveBayesMeanAll.labelN2(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2 = naiveBayesMeanAll.PosteriorN2(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.CostN2 = naiveBayesMeanAll.CostN2(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErr = naiveBayesMeanAll.decodingErr(:,iRecNo);

        naiveBayesMeanStimAll{cond}.numTrStim = naiveBayesMeanAll.numTrStim(iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2Stim = naiveBayesMeanAll.labelN2Stim(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2Stim = naiveBayesMeanAll.PosteriorN2Stim(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrStim = naiveBayesMeanAll.decodingErrStim(:,iRecNo);

        naiveBayesMeanStimAll{cond}.labelN2Shuf = naiveBayesMeanAll.labelN2Shuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2Shuf = naiveBayesMeanAll.PosteriorN2Shuf(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrShuf = naiveBayesMeanAll.decodingErrShuf(:,iRecNo);

        naiveBayesMeanStimMean{cond} = calMeanNaiveBayes(naiveBayesMeanStimAll{cond});            
    end
    save([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanStimAll','naiveBayesMeanStimMean','-append');

    
    for i = 1:size(naiveBayesMeanAll.labelN2,2)
        plotPosterior(naiveBayesMeanAll.PosteriorN2(:,:,i),naiveBayesMeanAll.time, ...
            ['Mean posterior recording ' num2str(naiveBayesMeanAll.recNo(i)) ' task ' num2str(naiveBayesMeanAll.task(i)) ' Ctrl'],...
            ['MeanPosteriorCtrl' num2str(naiveBayesMeanAll.recNo(i))],pathAnal); 
        
        plotPosterior(naiveBayesMeanAll.PosteriorN2Stim(:,:,i),naiveBayesMeanAll.time, ...
            ['Mean posterior recording ' num2str(naiveBayesMeanAll.recNo(i)) ' task ' num2str(naiveBayesMeanAll.task(i)) ' Stim'],...
            ['MeanPosteriorStim' num2str(naiveBayesMeanAll.recNo(i))],pathAnal); 
    end
    
    for cond = 1:numCond
        % posterior prob for ctrl recordings
        plotPosterior(naiveBayesMeanStimMean{cond}.PosteriorN2,naiveBayesMeanAll.time, ...
            ['Mean posterior ctrl recordings cond ' num2str(cond)],['MeanPosteriorCtrl_Cond' num2str(cond)],pathAnal);
        
        % posterior prob for stim recordings, trained with ctrl recordings
        plotPosterior(naiveBayesMeanStimMean{cond}.PosteriorN2Stim,naiveBayesMeanAll.time, ...
            ['Mean posterior stim recordings cond ' num2str(cond)],['MeanPosteriorStim_Cond' num2str(cond)],pathAnal);
        
        % posterior prob for ctrl recordings with mean label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2,naiveBayesMeanStimMean{cond}.labelN2,...
            naiveBayesMeanAll.time,['Mean posterior ctrl recordings cond ' num2str(cond)],...
            ['MeanPosteriorMeanLabelCtrl_Cond' num2str(cond)],pathAnal); 
        
        % posterior prob for stim recordings with mean label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2Stim,naiveBayesMeanStimMean{cond}.labelN2Stim,...
            naiveBayesMeanAll.time,['Mean posterior stim recordings cond ' num2str(cond)],...
            ['MeanPosteriorMeanLabelStim_Cond' num2str(cond)],pathAnal); 

        % comparing decoded labels among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.labelN2',naiveBayesMeanStimAll{cond}.labelN2Stim',...
            naiveBayesMeanStimAll{cond}.labelN2Shuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.pLabelN2CtrlStim,naiveBayesMeanStimMean{cond}.pLabelN2CtrlShuf,...
            ['MeanDecodeTimeDataVsShufStim_Cond' num2str(cond)],pathAnal,[0 5.2],'Decoding time (s)',['Cond' num2str(cond)]); 
        
        % comparing decoded error among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.decodingErr',naiveBayesMeanStimAll{cond}.decodingErrStim',...
            naiveBayesMeanStimAll{cond}.decodingErrShuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.decodingErrPrsCtrlStim,naiveBayesMeanStimMean{cond}.decodingErrPrsCtrlShuf,...
            ['MeanDecodeErrDataVsShufStim_Cond' num2str(cond)],pathAnal,[-2.5 2.9],'Decoding error (s)',['Cond' num2str(cond)]); 
    end
        
end

function naiveBayesMeanAll = accumNaiveBayesEncoderTypes(recNo,pathAnal,nBins)
    numRec = length(recNo);
    
    naiveBayesMeanAll = struct( ...
            'recNo',zeros(1,numRec),...
            'task',zeros(1,numRec),... % no cue - 1, AL - 2, PL - 3
            'numNeu',zeros(1,numRec),...
            'numTr',zeros(1,numRec),...
            ...
            'labelN2',zeros(nBins,numRec),...
            'PosteriorN2',zeros(nBins,nBins,numRec),...
            'CostN2',zeros(nBins,nBins,numRec),...
            'decodingErr',zeros(nBins,numRec),...
            ...
            'numTrStim',zeros(1,numRec),...
            'pulseMeth',zeros(1,numRec),...
            'labelN2Stim',zeros(nBins,numRec),...
            'PosteriorN2Stim',zeros(nBins,nBins,numRec),...
            'decodingErrStim',zeros(nBins,numRec),...
            ...
            'labelN2Shuf',zeros(nBins,numRec),...
            'PosteriorN2Shuf',zeros(nBins,nBins,numRec),...
            'decodingErrShuf',zeros(nBins,numRec));

    numRecActual = 1;
    for i = 1:numRec
        if(exist([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal' num2str(recNo(i)) '.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal' num2str(recNo(i)) '.mat'],'naiveBayes','naiveBayesMean');
        else
            continue;
        end
        
        if(~isempty(naiveBayesMean.labelN2))
            naiveBayesMeanAll.time = naiveBayes.timeTrain(1:length(naiveBayesMean.labelN2));
        end
    
        for j = 1:length(naiveBayesMean.pulseMeth)
            if(~isempty(naiveBayesMean.labelN2) & sum(isnan(naiveBayesMean.PosteriorN2(:))) == 0 ...
                    & ~isempty(naiveBayesMean.labelN2Stim{j}) ...
                    & sum(isnan(naiveBayesMean.PosteriorN2Stim{j}(:))) == 0)
                naiveBayesMeanAll.recNo(numRecActual) = recNo(i);
                naiveBayesMeanAll.numNeu(numRecActual) = length(naiveBayes.indNeu);
                naiveBayesMeanAll.numTr(numRecActual) = length(naiveBayes.trialNo);
                naiveBayesMeanAll.task(numRecActual) = 2;
                naiveBayesMeanAll.labelN2(:,numRecActual) = naiveBayesMean.labelN2;
                naiveBayesMeanAll.PosteriorN2(:,:,numRecActual) = naiveBayesMean.PosteriorN2;
                naiveBayesMeanAll.CostN2(:,:,numRecActual) = naiveBayesMean.CostN2;
                naiveBayesMeanAll.decodingErr(:,numRecActual) = naiveBayesMean.decodingErr;

                naiveBayesMeanAll.numTrStim(numRecActual) = length(naiveBayes.trialNoStim{j});
                naiveBayesMeanAll.pulseMeth(numRecActual) = naiveBayesMean.pulseMeth(j);
                naiveBayesMeanAll.labelN2Stim(:,numRecActual) = naiveBayesMean.labelN2Stim{j};
                naiveBayesMeanAll.PosteriorN2Stim(:,:,numRecActual) = naiveBayesMean.PosteriorN2Stim{j};
                naiveBayesMeanAll.decodingErrStim(:,numRecActual) = naiveBayesMean.decodingErrStim{j};

                naiveBayesMeanAll.labelN2Shuf(:,numRecActual) = naiveBayesMean.labelN2Shuf;
                naiveBayesMeanAll.PosteriorN2Shuf(:,:,numRecActual) = naiveBayesMean.PosteriorN2Shuf;
                naiveBayesMeanAll.decodingErrShuf(:,numRecActual) = naiveBayesMean.decodingErrShuf;

                numRecActual = numRecActual+1;
            end
        end
    end

    naiveBayesMeanAll.recNo = naiveBayesMeanAll.recNo(1:numRecActual-1);
    naiveBayesMeanAll.numNeu = naiveBayesMeanAll.numNeu(1:numRecActual-1);
    naiveBayesMeanAll.numTr = naiveBayesMeanAll.numTr(1:numRecActual-1);
    naiveBayesMeanAll.task = naiveBayesMeanAll.task(1:numRecActual-1);
    naiveBayesMeanAll.labelN2 = naiveBayesMeanAll.labelN2(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2 = naiveBayesMeanAll.PosteriorN2(:,:,1:numRecActual-1);
    naiveBayesMeanAll.CostN2 = naiveBayesMeanAll.CostN2(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErr = naiveBayesMeanAll.decodingErr(:,1:numRecActual-1);

    naiveBayesMeanAll.numTrStim = naiveBayesMeanAll.numTrStim(1:numRecActual-1);
    naiveBayesMeanAll.pulseMeth = naiveBayesMeanAll.pulseMeth(1:numRecActual-1);
    naiveBayesMeanAll.labelN2Stim = naiveBayesMeanAll.labelN2Stim(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2Stim = naiveBayesMeanAll.PosteriorN2Stim(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrStim = naiveBayesMeanAll.decodingErrStim(:,1:numRecActual-1);

    naiveBayesMeanAll.labelN2Shuf = naiveBayesMeanAll.labelN2Shuf(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2Shuf = naiveBayesMeanAll.PosteriorN2Shuf(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrShuf = naiveBayesMeanAll.decodingErrShuf(:,1:numRecActual-1);

end

function [naiveBayesMeanAllMean] = calMeanNaiveBayes(naiveBayesMeanAll)
    naiveBayesMeanAllMean.labelN2 = mean(naiveBayesMeanAll.labelN2,2);
    naiveBayesMeanAllMean.PosteriorN2 = mean(naiveBayesMeanAll.PosteriorN2,3);
    naiveBayesMeanAllMean.CostN2 = mean(naiveBayesMeanAll.CostN2,3);
    naiveBayesMeanAllMean.decodingErr = mean(naiveBayesMeanAll.decodingErr,2);
    naiveBayesMeanAllMean.decodingErrSEM = std(naiveBayesMeanAll.decodingErr,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    
    naiveBayesMeanAllMean.labelN2Shuf = mean(naiveBayesMeanAll.labelN2Shuf,2);
    naiveBayesMeanAllMean.PosteriorN2Shuf = mean(naiveBayesMeanAll.PosteriorN2Shuf,3);
    naiveBayesMeanAllMean.decodingErrShuf = mean(naiveBayesMeanAll.decodingErrShuf,2);
    naiveBayesMeanAllMean.decodingErrShufSEM = std(naiveBayesMeanAll.decodingErrShuf,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    
    naiveBayesMeanAllMean.labelN2Stim = mean(naiveBayesMeanAll.labelN2Stim,2);
    naiveBayesMeanAllMean.PosteriorN2Stim = mean(naiveBayesMeanAll.PosteriorN2Stim,3);
    naiveBayesMeanAllMean.decodingErrStim = mean(naiveBayesMeanAll.decodingErrStim,2);
    naiveBayesMeanAllMean.decodingErrStimSEM = std(naiveBayesMeanAll.decodingErrStim,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    
    for i = 1:length(naiveBayesMeanAllMean.labelN2)
        naiveBayesMeanAllMean.pLabelN2CtrlShuf(i) = ranksum(naiveBayesMeanAll.labelN2(i,:),...
                naiveBayesMeanAll.labelN2Shuf(i,:));
            
        naiveBayesMeanAllMean.pLabelN2CtrlStim(i) = ranksum(naiveBayesMeanAll.labelN2(i,:),...
                naiveBayesMeanAll.labelN2Stim(i,:));
            
        naiveBayesMeanAllMean.decodingErrPrsCtrlShuf(i) = ranksum(naiveBayesMeanAll.decodingErr(i,:),...
                naiveBayesMeanAll.decodingErrShuf(i,:));
        naiveBayesMeanAllMean.decodingErrPrsCtrlStim(i) = ranksum(naiveBayesMeanAll.decodingErr(i,:),...
                naiveBayesMeanAll.decodingErrStim(i,:));
    end
    
end

function plotPosterior(PosteriorP,time,title1,fileName,pathAnal) 
    if(isempty(PosteriorP))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400]);
        
    h = imagesc(time',time',PosteriorP);
    set(gca,'YDir','normal')
    colormap hot
    colorbar
    hold on;
    [~,indMaxPosterior] = max(PosteriorP);
    h = plot(time,time(indMaxPosterior));
    set(h,'LineWidth', 2, 'Color',[1 1 1]);
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end

function plotPosteriorWLabel(PosteriorP,label,time,title1,fileName,pathAnal) 
    if(isempty(PosteriorP))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400]);
        
    h = imagesc(time',time',PosteriorP);
    set(gca,'YDir','normal')
    colormap hot
    colorbar
    hold on;
    h = plot(time,label);
    set(h,'LineWidth', 2, 'Color',[1 1 1]);
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end


