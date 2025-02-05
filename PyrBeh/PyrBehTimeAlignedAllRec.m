function PyrBehTimeAlignedAllRec(onlyRun,task)

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(task == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalBehTime\'];
    elseif(task == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalBehTimeALPL\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalBehTimeAL\'];
    end
    
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    
    if(exist([pathAnal0 'behTimeAllRec.mat']))
        load([pathAnal0 'behTimeAllRec.mat']);
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    if(task == 2 && exist('behAlignedNoCue') == 0)
        disp('No cue')
        behAlignedNoCue = accumBehTime(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,1,onlyRun);
        disp('Active licking')
        behAlignedAL = accumBehTime(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,2,onlyRun);
        disp('Passive licking')
        behAlignedPL = accumBehTime(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,3,onlyRun);
        save([pathAnal0 'behTimeAllRec.mat'],'behAlignedNoCue','behAlignedAL','behAlignedPL'); 
    end
    
    behAligned.indRecNoCue = unique(autoCorrPyrNoCue.indRec(autoCorrPyrNoCue.task == 1));
    behAligned.indRecNoCueField = unique(autoCorrPyrNoCue.indRec(autoCorrPyrNoCue.task == 1 &...
        modAlignedPyrNoCue.nNeuWithField > 1));
    behAligned.indRecNoCueNoField = unique(autoCorrPyrNoCue.indRec(autoCorrPyrNoCue.task == 1 &...
        modAlignedPyrNoCue.nNeuWithField == 0));
    
    behAligned.indRecAL = unique(autoCorrPyrAL.indRec(autoCorrPyrAL.task == 2));
    behAligned.indRecALField = unique(autoCorrPyrAL.indRec(autoCorrPyrAL.task == 2 &...
        modAlignedPyrAL.nNeuWithField > 1));
    behAligned.indRecALNoField = unique(autoCorrPyrAL.indRec(autoCorrPyrAL.task == 2 &...
        modAlignedPyrAL.nNeuWithField == 0));
    
    behAligned.indRecPL = unique(autoCorrPyrPL.indRec(autoCorrPyrPL.task == 3));
    behAligned.indRecPLField = unique(autoCorrPyrPL.indRec(autoCorrPyrPL.task == 3 &...
        modAlignedPyrPL.nNeuWithField > 1));
    behAligned.indRecPLNoField = unique(autoCorrPyrPL.indRec(autoCorrPyrPL.task == 3 &...
        modAlignedPyrPL.nNeuWithField == 0));
    
    behAlignedMeanField = accumMeanBehTime(behAlignedNoCue,behAlignedAL,behAlignedPL,behAligned,task);
    behAlignedMeanFieldStat = accumMeanBehTimeStat(behAlignedMeanField,behAlignedNoCue.spaceStepsLick,...
        behAlignedNoCue.spaceStepsSpeed);
    
    behAlignedMean = accumMeanBehTimeGoodBad(behAlignedNoCue,behAlignedAL,behAlignedPL,task);
    
    behAlignedMeanStat = accumMeanBehTimeStatGoodBad(behAlignedMean,...
        behAlignedNoCue.spaceStepsLick,behAlignedNoCue.spaceStepsSpeed);
        
    save([pathAnal 'behTimeAllRecSel.mat'],'behAligned','behAlignedMean',...
            'behAlignedMeanField','behAlignedMeanFieldStat',...
            'behAlignedMeanStat');  
            
    plotLick(pathAnal,behAlignedNoCue.spaceStepsLick,...
        behAlignedMeanField.meanLickPerRecField,...
        behAlignedMeanField.meanLickPerRecNoField,[{'Field'} {'No Field'}],...
        [pathAnal 'MeanLickVsTime-Field-NoField']);
    
    plotSpeed(pathAnal,behAlignedNoCue.spaceStepsSpeed,...
        behAlignedMeanField.speedTraceNonStimGoodPerRecField,...
        behAlignedMeanField.speedTraceNonStimGoodPerRecNoField,[{'Field'} {'No Field'}],...
        [pathAnal 'SpeedVsTimeGood-Field-NoField']);
    plotLick(pathAnal,behAlignedNoCue.spaceStepsLick,...
        behAlignedMeanField.lickTraceNonStimGoodPerRecField,...
        behAlignedMeanField.lickTraceNonStimGoodPerRecNoField,[{'Field'} {'No Field'}],...
        [pathAnal 'LickVsTimeGood-Field-NoField']);
    
    plotSpeed(pathAnal,behAlignedNoCue.spaceStepsSpeed,...
        behAlignedMeanField.meanSpeedNonStimGoodPerRecField,...
        behAlignedMeanField.meanSpeedNonStimGoodPerRecNoField,[{'Field'} {'No Field'}],...
        [pathAnal 'MeanSpeedVsTimeGood-Field-NoField']);
    plotLick(pathAnal,behAlignedNoCue.spaceStepsLick,...
        behAlignedMeanField.meanLickNonStimGoodPerRecField,...
        behAlignedMeanField.meanLickNonStimGoodPerRecNoField,[{'Field'} {'No Field'}],...
        [pathAnal 'MeanLickVsTimeGood-Field-NoField']);
    
    colorSel = 0;
    plotBehTimeAlignedMean(pathAnal,behAlignedMeanField,behAlignedMeanFieldStat,colorSel);
            
%     pause;
    close all;
    
    plotSpeed(pathAnal,behAlignedNoCue.spaceStepsSpeed,...
        behAlignedMean.speedTraceNonStimGoodPerRec,...
        behAlignedMean.speedTraceNonStimBadPerRec,[{'Good'} {'Bad'}],...
        [pathAnal 'SpeedVsTime-GoodBad']);
    plotLick(pathAnal,behAlignedNoCue.spaceStepsLick,...
        behAlignedMean.lickTraceNonStimGoodPerRec,...
        behAlignedMean.lickTraceNonStimBadPerRec,[{'Good'} {'Bad'}],...
        [pathAnal 'LickVsTime-GoodBad']);
    plotSpeed(pathAnal,behAlignedNoCue.spaceStepsSpeed,...
        behAlignedMean.meanSpeedPerRecNonStimGood,...
        behAlignedMean.meanSpeedPerRecNonStimBad,[{'Good'} {'Bad'}],...
        [pathAnal 'MeanSpeedVsTime-GoodBad']);
    plotLick(pathAnal,behAlignedNoCue.spaceStepsLick,...
        behAlignedMean.meanLickPerRecNonStimGood,...
        behAlignedMean.meanLickPerRecNonStimBad,[{'Good'} {'Bad'}],...
        [pathAnal 'MeanLickVsTime-GoodBad']);
    colorSel = 0;
    plotBehAlignedMeanGoodBad(pathAnal,behAlignedMean,behAlignedMeanStat,colorSel);
    
    plotBehTimeAlignedMeanGoodBadBar(pathAnal,behAlignedMean,behAlignedMeanStat,colorSel);
    pause;
    close all;
end

function histStopTime(pathAnal,fileName1,data,timeBin,xl,xlim)
    handle     = figure;
    set(handle,'OuterPosition',...
        [500 500 280 280])
    [counts,centers] = hist(data,min(data):timeBin:max(data)+timeBin);
    bar(centers, counts/length(data),'FaceColor',[0.3 .3 .3],'EdgeColor',[0.3 .3 .3]);
    set(gca,'XLim',xlim,'FontSize',12);
    xlabel(xl);
    ylabel('Prob.')
    if(~isempty(xlim))
        tmp = data <= xlim(2);
        percDataInc = sum(tmp)/length(tmp);
    else
        percDataInc = 1;
    end
    title(['Mean = ' num2str(mean(data)) ', ' num2str(percDataInc*100) '%']);
    saveas(gcf,[pathAnal fileName1]);
    print('-painters', '-dpdf', [pathAnal fileName1], '-r600')
end

function plotLick(pathAnal,spaceStepsLick,lickField,lickNoField,leg,fileName1)
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
    options.x_axisX = spaceStepsLick/1250;
    options.x_axisY = spaceStepsLick/1250;
    plot_areaerrorbarXY(lickField, lickNoField,...
        options);
    set(gca,'XLim',[0 4]);
    xlabel('Time (s)')
    ylabel('Num. licks')
    legend('',leg{1},'',leg{2})
    
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

function plotSpeed(pathAnal,spaceStepsSpeed,speedField,speedNoField,leg,fileName1)
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
    options.x_axisX = spaceStepsSpeed/1250;
    options.x_axisY = spaceStepsSpeed/1250;
    plot_areaerrorbarXY(speedField, speedNoField,...
        options);
    set(gca,'XLim',[0 4]);
    xlabel('Time (s)')
    ylabel('Speed (cm/s) ')
    legend('',leg{1},'',leg{2})
        
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end









