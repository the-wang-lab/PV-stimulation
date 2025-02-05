function plotDistri(x,y,histBins,xl,leg,pathAnal,fileN,xlimit,titlef)
    
    if nargin == 8
        titlef = [];
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [163 207 98;...
                234 131 114]/255;
    hold on;
    hx = hist(x,histBins);
    hy = hist(y,histBins);
    h = plot(histBins,hx/sum(hx),'-');
    set(h,'LineWidth',2,'Color',colorArr(1,:));
    h = plot(histBins,hy/sum(hy),'-');
    set(h,'LineWidth',2,'Color',colorArr(2,:));
    if(~isempty(xlimit))
        set(gca,'xLim',xlimit);
    end
    xlabel(xl);
    ylabel('Probability');
    legend(leg);
    title(titlef);
    
    fileName1 = [pathAnal fileN];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end