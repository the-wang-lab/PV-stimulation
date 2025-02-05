function plotDistributionsTwo(data1,data2,p,path,filename,xl,yl)
    
    % Plot the distributions
    % Plot the output over inputs
    [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = 'Tau distr.';     
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 350 350],'Name',figTitle)
        
    hold on;
    histogram(data1, 'Normalization', 'probability', 'DisplayName', 'Ctrl', 'FaceAlpha', 0.3,...
        'EdgeColor', 'none', 'BinEdges', 0:0.2:max([data1 data2]));
    histogram(data2, 'Normalization', 'probability', 'DisplayName', 'Stim', 'FaceAlpha', 0.3,...
        'EdgeColor', 'none', 'BinEdges', 0:0.2:max([data1 data2]));
    xlabel(xl);
    ylabel(yl);
    legend;
    
    text(0.2*max([data1,data2]), 0.05, sprintf('p-value = %.2e', p),...
        'FontSize', 12);
    
    hold off;
    
    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');
end