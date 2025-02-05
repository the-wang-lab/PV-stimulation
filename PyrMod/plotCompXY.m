function plotCompXY(x,y,fileN,pathAnal,xl,yl,ti)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
        
    h = plot(x,y,'k+');
    set(h,'MarkerSize',9);
    hold on;
    minXY = min([x,y]);
    maxXY = max([x,y]);
    plot([minXY maxXY],[minXY maxXY],'r-');
    
    xlabel(xl);
    ylabel(yl);
    title(ti);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end