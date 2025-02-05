function PyrNaiveBayesEncoderAllRecMaxProbWithCrossVal(upDown,taskSel)

    if(taskSel == 2)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderALPLWithCrossVal\'];
    elseif(taskSel == 3)
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderALWithCrossVal\'];
    end
    if(upDown == 1) % PyrUp
        pathAnal = [pathAnal 'PyrUp\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']);
        end
        if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrRiseAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbAL = naiveBayesMaxProb;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrRisePL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbPL = naiveBayesMaxProb;
        end
    elseif(upDown == 2) % PyrDown
        pathAnal = [pathAnal 'PyrDown\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']);
        end
        if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrDownAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbAL = naiveBayesMaxProb;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrDownPL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbPL = naiveBayesMaxProb;
        end
    else % PyrOther
        pathAnal = [pathAnal 'PyrOther\'];
        if(exist([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat']);
        end
        if(exist('naiveBayesMeanAll') == 0)
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrOtherAL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbAL = naiveBayesMaxProb;
            pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossVal\PyrOtherPL\'];
            load([pathAnal0 'NaiveBayesDecoderPyrMaxProb.mat']);
            naiveBayesMaxProbPL = naiveBayesMaxProb;
        end
    end
    
    load([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanAll');
    
    if(exist('naiveBayesMaxProbAll') == 0)
        naiveBayesMaxProbAll = accumNaiveBayesEncoderTypes(naiveBayesMaxProbAL,naiveBayesMaxProbPL,...
            naiveBayesMeanAll,taskSel);
        naiveBayesMaxProbAll.time = naiveBayesMeanAll.time;

        naiveBayesMaxProbAllMean = calMeanNaiveBayes(naiveBayesMaxProbAll);

        save([pathAnal 'NaiveBayesDecoderPyrMaxProbAll.mat'],'naiveBayesMaxProbAll','naiveBayesMaxProbAllMean');
    end
    
    plotDecodingErr(naiveBayesMaxProbAll.labelN2,naiveBayesMaxProbAll.labelN2Shuf,...
        naiveBayesMaxProbAll.time, ...
        'MeanDecodeTimeDataVsShufMaxProb',pathAnal,[0 5]); 
end

function naiveBayesMaxProbAll = accumNaiveBayesEncoderTypes(naiveBayesMaxProbAL,naiveBayesMaxProbPL,...
        naiveBayesMeanAll,taskSel)
    numRecAL = length(naiveBayesMaxProbAL.labelN2);
    numRecPL = length(naiveBayesMaxProbPL.labelN2);
    if(taskSel == 3)
        numRec = numRecAL;
    else
        numRec = numRecAL+numRecPL;
    end
    nBins = length(naiveBayesMaxProbAL.labelN2{1});

    naiveBayesMaxProbAll = struct( ...
        'recNo',naiveBayesMeanAll.recNo,...
        'task',naiveBayesMeanAll.task,... % no cue - 1, AL - 2, PL - 3
        'numNeu',naiveBayesMeanAll.numNeu,...
        'numTr',naiveBayesMeanAll.numTr,...
        ...
        'labelN2',zeros(nBins,numRec),...
        'decodingErr',zeros(nBins,numRec),...
        ...
        'labelN2Shuf',zeros(nBins,numRec),...
        'decodingErrShuf',zeros(nBins,numRec));

    numRecActual = 1;
    for i = 1:numRecAL
        if(sum(isnan(naiveBayesMaxProbAL.labelN2{i}))== 0)
            naiveBayesMaxProbAll.labelN2(:,numRecActual) = naiveBayesMaxProbAL.labelN2{i};
            naiveBayesMaxProbAll.decodingErr(:,numRecActual) = naiveBayesMaxProbAL.decodingErr{i};

            naiveBayesMaxProbAll.labelN2Shuf(:,numRecActual) = naiveBayesMaxProbAL.labelN2Shuf{i};
            naiveBayesMaxProbAll.decodingErrShuf(:,numRecActual) = naiveBayesMaxProbAL.decodingErrShuf{i};
        
            numRecActual = numRecActual+1;
        end
    end
    
    if(taskSel == 2)
        for i = 1:numRecPL
            if(sum(isnan(naiveBayesMaxProbPL.labelN2{i})) == 0)
                naiveBayesMaxProbAll.labelN2(:,numRecActual) = naiveBayesMaxProbPL.labelN2{i};
                naiveBayesMaxProbAll.decodingErr(:,numRecActual) = naiveBayesMaxProbPL.decodingErr{i};

                naiveBayesMaxProbAll.labelN2Shuf(:,numRecActual) = naiveBayesMaxProbPL.labelN2Shuf{i};
                naiveBayesMaxProbAll.decodingErrShuf(:,numRecActual) = naiveBayesMaxProbPL.decodingErrShuf{i};

                numRecActual = numRecActual+1;
            end
        end
    end
            
    naiveBayesMaxProbAll.labelN2 = naiveBayesMaxProbAll.labelN2(:,1:numRecActual-1);
    naiveBayesMaxProbAll.decodingErr = naiveBayesMaxProbAll.decodingErr(:,1:numRecActual-1);
    
    naiveBayesMaxProbAll.labelN2Shuf = naiveBayesMaxProbAll.labelN2Shuf(:,1:numRecActual-1);
    naiveBayesMaxProbAll.decodingErrShuf = naiveBayesMaxProbAll.decodingErrShuf(:,1:numRecActual-1);
end

function naiveBayesMaxProbAllMean = calMeanNaiveBayes(naiveBayesMaxProbAll)
    naiveBayesMaxProbAllMean.labelN2 = mean(naiveBayesMaxProbAll.labelN2,2);
    naiveBayesMaxProbAllMean.decodingErr = mean(naiveBayesMaxProbAll.decodingErr,2);
    
    naiveBayesMaxProbAllMean.labelN2Shuf = mean(naiveBayesMaxProbAll.labelN2Shuf,2);
    naiveBayesMaxProbAllMean.decodingErrShuf = mean(naiveBayesMaxProbAll.decodingErrShuf,2);
    
    for i = 1:length(naiveBayesMaxProbAllMean.labelN2)
        naiveBayesMaxProbAllMean.pLabelN2(i) = ranksum(naiveBayesMaxProbAll.labelN2(i,:),...
                naiveBayesMaxProbAll.labelN2Shuf(i,:)); 
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
    colormap hot
    colorbar
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end

function plotDecodingErr(decErr,decErrShuf,time,fileName,pathAnal,ylimit) 
            
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = time;
    options.x_axisY = time;
    plot_areaerrorbarXY(decErr', decErrShuf',...
        options);
    hold on;
    minX = min(mean(decErr)-std(decErr)/sqrt(size(decErr,1)));
    minY = min(mean(decErrShuf)-std(decErrShuf)/sqrt(size(decErrShuf,1)));
    maxX = max(mean(decErr)+std(decErr)/sqrt(size(decErr,1)));
    maxY = max(mean(decErrShuf)+std(decErrShuf)/sqrt(size(decErrShuf,1)));
    
    set(gca,'XLim',[min(time) max(time)]);
    
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[min([minX minY])*0.95 ...
        max([maxX maxY])*1.05]);
    end
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    
%     h = plot(time,decErr);
%     set(h,'Color',[0.8 0.8 0.8]);
%     hold
%     h = plot(time,decErrShuf);
%     set(h,'Color',[0.4 0.4 0.4]);
%     xlabel('Real time (s)')
%     ylabel('Decoded time (s)')
%     legend('Data','Shuf')
%     set(gca,'FontSize',10,'XLim',[min(time) max(time)])
%     title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

