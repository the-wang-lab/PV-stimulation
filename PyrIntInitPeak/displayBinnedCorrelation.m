function displayBinnedCorrelation(x,y,xBinned,yBinned,yError,model,xl,yl,path,filename)

    % Plot the output over inputs
    [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = '';     
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 350 350],'Name',figTitle)
        
    % Plot results
    scatter(x, y, 10, 'k', 'filled', 'MarkerFaceAlpha', 0.2);  % Raw x and y scatter
    hold on;
    errorbar(xBinned, yBinned, yError, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'LineWidth', 1.5);  % Error bars
    plot(xBinned, model.Fitted, 'r-', 'LineWidth', 2);  % Fitted line
    xlabel(xl);
    ylabel(yl);
    title(sprintf('y=%.2ex + %.2e, p=%.2e, R=%.3f', model.Coefficients.Estimate(2), ...
        model.Coefficients.Estimate(1), model.Coefficients.pValue(2)), model.Rsquared.Adjusted);
    legend('Raw Data', 'Binned Means with Error Bars', 'Linear Fit', 'Location', 'Best');
    hold off;

    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');