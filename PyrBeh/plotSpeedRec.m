function plotSpeedRec(pathAnal,spaceStepsSpeed,data_meanX,errorX,xli,fileName)
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = spaceStepsSpeed;
    options.x_axisY = spaceStepsSpeed;
    figure(options.handle);
    x_vectorX = [options.x_axisX, fliplr(options.x_axisX)];
    patch = fill(x_vectorX, [data_meanX+errorX,fliplr(data_meanX-errorX)], options.color_areaX);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', options.alpha);
    hold on;
    plot(options.x_axisX, data_meanX, 'color', options.color_lineX, ...
        'LineWidth', options.line_width);
    set(gca,'XLim',xli);
    xlabel('Time (s)')
    ylabel('Speed (cm/s) ')
    
    fileName1 = [pathAnal ...
        'SpeedVsDist-' fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end