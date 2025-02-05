function plotComp(x,y,xl,yl)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    h = plot(x,y,'o');
    set(h,'MarkerSize',6,'Color',[0.5 0.5 0.9]);
    maxX = max(x);
    maxY = max(y);
    minX = min(x);
    minY = min(y);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
end