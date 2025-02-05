function plotDataVsLinearFit(input,output,lm,corrCoef,xlab,ylab,path,filename)
%% plot output over input, and overlay the linear fit on the top. Also report the corr-coef and p-value
% lm: linear model generated using fitlm
% corrCoef: correlation coefficient value

    % Predicted values using the linear model
    predictedValues = predict(lm, input);

    % Plot the output over inputs
    [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = 'Spikes vs Time';     
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 350 350],'Name',figTitle)
        
    h = plot(input, output, 'k.'); % Original data points
    set(h,'MarkerSize',6);
    hold on;
    plot(input, predictedValues, 'r-', 'LineWidth', 2); % Linear regression curve
    xlabel(xlab);
    ylabel(ylab);

    % Extract the p-value for the slope and display it on the plot
    slopePValue = lm.Coefficients.pValue(2); % Second coefficient corresponds to the slope
    rsquared = lm.Rsquared.Adjusted;
    text(min(input), max(output), sprintf('r = %.2f p-value = %.2e r2 = %.3f', corrCoef, slopePValue, rsquared),...
        'FontSize', 12);

    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');

    hold off;
end
