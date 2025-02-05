function comp3TimeSequences(dataX,dataY,dataZ,timeStep,xlim,ylim,xlab,ylab,path,filename)

    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.color_areaZ = [192 221 173]./255;    % Green theme
    options.color_lineZ = [112 173  71]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = timeStep;
    options.x_axisY = timeStep;
    options.x_axisZ = timeStep;

    plot_areaerrorbarXYZ(dataX, dataY, dataZ,options);
    
    set(gca,'XLim',xlim,'YLim',ylim,'FontSize',12);
    plot([0 0],ylim,'r-');
    
    % labels
    xlabel(xlab);
    ylabel(ylab);
    
    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');
    
end
