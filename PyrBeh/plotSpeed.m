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
    options.x_axisX = spaceStepsSpeed/10;
    options.x_axisY = spaceStepsSpeed/10;
    plot_areaerrorbarXY(speedField, speedNoField,...
        options);
    set(gca,'XLim',[0 180]);
    xlabel('Dist (cm)')
    ylabel('Speed (cm/s) ')
    legend('',leg{1},'',leg{2})
        
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end