function plotConditions(x1,y1,x2,y2,x3,y3,xl,yl,ti)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [0.5 0.5 0.9;...
                0.9 0.5 0.5;...
                0.2 0.8 0.5];
    h = plot(x1,y1,'o');
    set(h,'MarkerSize',6,'Color',colorArr(1,:));
    hold on;
    h = plot(x2,y2,'o');
    set(h,'MarkerSize',6,'Color',colorArr(2,:));
    h = plot(x3,y3,'o');
    set(h,'MarkerSize',6,'Color',colorArr(3,:));
    maxX = max([x1,x2,x3]);
    maxY = max([y1,y2,y3]);
    minX = min([x1,x2,x3]);
    minY = min([y1,y2,y3]);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    title(ti)
    legend('NoCue','AL','PL')
end