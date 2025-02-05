function PyrNaiveBayesEncoderAllRecWithCrossValSTD0p2(upDown,taskSel)

    if(taskSel == 2)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderALPLWithCrossValSTD0p2\'];
    elseif(taskSel == 3)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderALWithCrossValSTD0p2\'];
    end
    if(upDown == 1) % PyrUp
        pathAnal = [pathAnal 'PyrUp\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
        end
%         if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRiseAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesAL = naiveBayes;
            naiveBayesMeanAL = naiveBayesMean;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRisePL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesPL = naiveBayes;
            naiveBayesMeanPL = naiveBayesMean;
%         end
    elseif(upDown == 2) % PyrDown
        pathAnal = [pathAnal 'PyrDown\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
        end
%         if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrDownAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesAL = naiveBayes;
            naiveBayesMeanAL = naiveBayesMean;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrDownPL\'];
            if(exist([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']))
                load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
                naiveBayesPL = naiveBayes;
                naiveBayesMeanPL = naiveBayesMean;
            else
                naiveBayesPL = [];
                naiveBayesMeanPL = [];
            end
%         end
    elseif(upDown == 3) % PyrOther
        pathAnal = [pathAnal 'PyrOther\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
        end
        if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrOtherAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesAL = naiveBayes;
            naiveBayesMeanAL = naiveBayesMean;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrOtherPL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesPL = naiveBayes;
            naiveBayesMeanPL = naiveBayesMean;
        end
    else % PyrUp and PyrDown
        pathAnal = [pathAnal 'PyrRiseDown\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
        end
%         if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRiseDownAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
            naiveBayesAL = naiveBayes;
            naiveBayesMeanAL = naiveBayesMean;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRiseDownPL\'];
            if(exist([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']))
                load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
                naiveBayesPL = naiveBayes;
                naiveBayesMeanPL = naiveBayesMean;
            else
                naiveBayesPL = [];
                naiveBayesMeanPL = [];
            end
%         end
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    if(exist('naiveBayesMeanAll') == 0)
        naiveBayesMeanAll = accumNaiveBayesEncoderTypes(naiveBayesMeanAL,naiveBayesMeanPL,...
            naiveBayesAL,naiveBayesPL,taskSel);
        for i = 1:length(naiveBayesMeanAL.labelN2)
            if(~isempty(naiveBayesMeanAL.labelN2{i}))
                naiveBayesMeanAll.time = naiveBayesAL.timeTrain{i}(1:length(naiveBayesMeanAL.labelN2{i}));
                break;
            end
        end        

        naiveBayesMeanAllMean = calMeanNaiveBayes(naiveBayesMeanAll);

        save([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanAll','naiveBayesMeanAllMean');
    end
    
    for i = 1:size(naiveBayesMeanAll.labelN2,2) % changed 1/1/2025, added PosteriorN2 transpose
        plotPosterior(squeeze(naiveBayesMeanAll.PosteriorN2(:,:,i))',naiveBayesMeanAll.time, ...
            ['Mean posterior recording ' num2str(naiveBayesMeanAll.recNo(i)) ' task ' num2str(naiveBayesMeanAll.task(i))],...
            ['MeanPosterior' num2str(naiveBayesMeanAll.recNo(i)) 'Task ' num2str(naiveBayesMeanAll.task(i))],pathAnal); 
    end
    
    % changed 1/1/2025, added PosteriorN2 transpose
    plotPosterior(naiveBayesMeanAllMean.PosteriorN2',naiveBayesMeanAll.time, ...
        'Mean posterior all recordings','MeanPosteriorAll',pathAnal); 
        
    plotDecodingErr1(naiveBayesMeanAll.labelN2,naiveBayesMeanAll.labelN2Shuf,...
        naiveBayesMeanAll.time, naiveBayesMeanAll.decodingErrPrs,...
        'MeanDecodeTimeDataVsShuf',pathAnal,[0 5.2]); 
    
    plotDecodingErr1(naiveBayesMeanAll.decodingErr,naiveBayesMeanAll.decodingErrShuf,...
        naiveBayesMeanAll.time, naiveBayesMeanAll.decodingErrPrs,...
        'MeanDecodeErrDataVsShuf',pathAnal,[-2.5 2.7]); 
end

function naiveBayesMeanAll = accumNaiveBayesEncoderTypes(naiveBayesMeanAL,naiveBayesMeanPL,...
        naiveBayesAL,naiveBayesPL,taskSel)
    numRecAL = length(naiveBayesMeanAL.labelN2);
    if(~isempty(naiveBayesMeanPL))
        numRecPL = length(naiveBayesMeanPL.labelN2);
    else
        numRecPL = 0;
    end
    if(taskSel == 3)
        numRec = numRecAL;
    else
        numRec = numRecAL+numRecPL;
    end
    for i = 1:numRecAL
        if(~isempty(naiveBayesMeanAL.labelN2{i}))
            nBins = length(naiveBayesMeanAL.labelN2{i});
            break;
        end
    end

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
        'labelN2Shuf',zeros(nBins,numRec),...
        'PosteriorN2Shuf',zeros(nBins,nBins,numRec),...
        'decodingErrShuf',zeros(nBins,numRec),...
        ...
        'decodingErrPrs',zeros(1,nBins));

    numRecActual = 1;
    for i = 1:numRecAL
        if(~isempty(naiveBayesMeanAL.labelN2{i}) & sum(isnan(naiveBayesMeanAL.PosteriorN2{i}(:))) == 0)
            naiveBayesMeanAll.recNo(numRecActual) = i;
            naiveBayesMeanAll.numNeu(numRecActual) = length(naiveBayesAL.indNeu{i});
            naiveBayesMeanAll.numTr(numRecActual) = length(naiveBayesAL.trialNo{i});
            naiveBayesMeanAll.task(numRecActual) = 2;
            naiveBayesMeanAll.labelN2(:,numRecActual) = naiveBayesMeanAL.labelN2{i};
            naiveBayesMeanAll.PosteriorN2(:,:,numRecActual) = naiveBayesMeanAL.PosteriorN2{i};
            naiveBayesMeanAll.CostN2(:,:,numRecActual) = naiveBayesMeanAL.CostN2{i};
            naiveBayesMeanAll.decodingErr(:,numRecActual) = naiveBayesMeanAL.decodingErr{i};

            naiveBayesMeanAll.labelN2Shuf(:,numRecActual) = naiveBayesMeanAL.labelN2Shuf{i};
            naiveBayesMeanAll.PosteriorN2Shuf(:,:,numRecActual) = naiveBayesMeanAL.PosteriorN2Shuf{i};
            naiveBayesMeanAll.decodingErrShuf(:,numRecActual) = naiveBayesMeanAL.decodingErrShuf{i};
        
            numRecActual = numRecActual+1;
        end
    end
    
    if(taskSel == 2)
        for i = 1:numRecPL
            if(~isempty(naiveBayesMeanPL.labelN2{i}) & sum(isnan(naiveBayesMeanAL.PosteriorN2{i}(:))) == 0)
                naiveBayesMeanAll.recNo(numRecActual) = i;
                naiveBayesMeanAll.numNeu(numRecActual) = length(naiveBayesPL.indNeu{i});
                naiveBayesMeanAll.numTr(numRecActual) = length(naiveBayesPL.trialNo{i});
                naiveBayesMeanAll.task(numRecActual) = 3;
                naiveBayesMeanAll.labelN2(:,numRecActual) = naiveBayesMeanPL.labelN2{i};
                naiveBayesMeanAll.PosteriorN2(:,:,numRecActual) = naiveBayesMeanPL.PosteriorN2{i};
                naiveBayesMeanAll.CostN2(:,:,numRecActual) = naiveBayesMeanPL.CostN2{i};
                naiveBayesMeanAll.decodingErr(:,numRecActual) = naiveBayesMeanPL.decodingErr{i};

                naiveBayesMeanAll.labelN2Shuf(:,numRecActual) = naiveBayesMeanPL.labelN2Shuf{i};
                naiveBayesMeanAll.PosteriorN2Shuf(:,:,numRecActual) = naiveBayesMeanPL.PosteriorN2Shuf{i};
                naiveBayesMeanAll.decodingErrShuf(:,numRecActual) = naiveBayesMeanPL.decodingErrShuf{i};

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
    
    naiveBayesMeanAll.labelN2Shuf = naiveBayesMeanAll.labelN2Shuf(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2Shuf = naiveBayesMeanAll.PosteriorN2Shuf(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrShuf = naiveBayesMeanAll.decodingErrShuf(:,1:numRecActual-1);
    
    for i = 1:nBins
        naiveBayesMeanAll.decodingErrPrs(i) = ranksum(naiveBayesMeanAll.decodingErr(i,:), naiveBayesMeanAll.decodingErrShuf(i,:));
    end
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
    
    for i = 1:length(naiveBayesMeanAllMean.labelN2)
        naiveBayesMeanAllMean.pLabelN2(i) = ranksum(naiveBayesMeanAll.labelN2(i,:),...
                naiveBayesMeanAll.labelN2Shuf(i,:)); 
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


