function plot3TimeTracesMean(x,y,z,timeStep,xlim,ylim,xlab,ylab,path,filename)
    handle = figure;
    set(handle,'OuterPosition',...
        [500 500 350 350])
    
    color_lineX = [ 39 169 225]./255;
    color_lineY = [167 169  171]./255;
    color_lineZ = [112 173  71]./255;
    line_width = 1;
    
    hold on;
    plot(timeStep,x,'LineWidth', line_width, 'Color', color_lineX);
    plot(timeStep,y,'LineWidth', line_width, 'Color', color_lineY);
    plot(timeStep,z,'LineWidth', line_width, 'Color', color_lineZ);
    
    set(gca,'XLim',xlim,'YLim',ylim,'FontSize',12);
    plot([0 0],ylim,'r-');
    
    % labels
    xlabel(xlab);
    ylabel(ylab);
    
    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');
end
