function plotAvgFRProfile1(timeStepRun,avgFRProfile,yl,fileName,pathAnal,xlimit,ylimit)
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_area = [27 117 187]./255;    % Blue theme
    options.color_line = [ 39 169 225]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axis = timeStepRun;
    plot_areaerrorbar(avgFRProfile,options);
    hold on;
    h = plot([0 0],[min(mean(avgFRProfile)-std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*0.95 ...
        max(mean(avgFRProfile)+std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*1.05],'r-');
    set(h,'LineWidth',1)
%     set(gca,'XLim',[timeStepRun(1) 7]);
    set(gca,'XLim',xlimit);
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[min(mean(avgFRProfile)-std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*0.95 ...
        max(mean(avgFRProfile)+std(avgFRProfile)/sqrt(size(avgFRProfile,1)))*1.05]);
    end
    xlabel('Time (s)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end
