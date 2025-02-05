function plotCtrlVsStim(data1,data2,p,path,filename,xl,yl)

    % Plot the distributions
    % Plot the output over inputs
    [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = 'Tau distr.';     
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 350 350],'Name',figTitle)
    
    hold on;
    h = plot(data1,data2,'.');
    set(h,'MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    
    h = plot([0 max([data1,data2])],[0 max([data1,data2])],'r:');
    
    text(0.5*max([data1,data2]), 0.5*max([data1,data2]), ['p-value = ' num2str(p)],...
        'FontSize', 12);
    
    xlabel(xl);
    ylabel(yl);
    hold off;
    set(gca,'FontSize',12,'XLim',[0 max([data1,data2])],'YLim',[0 max([data1,data2])]);
        
    % Save the figure as both .fig and .pdf
    savefig([path filename '.fig']);
    print('-painters', '-dpdf', [path filename], '-r600');
end

