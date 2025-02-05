function plotMeanFRProfilePyrVsInt(timeStepRun,avgFRProfilex,avgFRProfiley,yl,fileName,pathAnal,ylimit)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 200]);
    
    h = plot(timeStepRun,avgFRProfilex);
    set(h,'LineWidth',1, 'Color',[ 39 169 225]./255);
    hold on;
    h = plot(timeStepRun,avgFRProfiley);
    set(h,'LineWidth',1, 'Color',[167 169  171]./255);
    
    if(~isempty(ylimit))
        h = plot([0 0],ylimit,'r-');
    else
        h = plot([0 0],[0 1],'r-');
    end
    set(h,'LineWidth',1)
    set(gca,'XLim',[-1 4]);
    
    xlabel('Time (s)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end