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
    options.x_axisX = spaceStepsLick/10;
    options.x_axisY = spaceStepsLick/10;
    plot_areaerrorbarXY(lickField, lickNoField,...
        options);
    set(gca,'XLim',[30 210]);
    xlabel('Dist (cm)')
    ylabel('Num. licks')
    legend('',leg{1},'',leg{2})
    
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end
