function plotStackedBar(x,y,yl,fileN,pathAnal)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])

    % only for plotting two clusters with fields
    colorArr = [...
                163 207 98;...
                234 131 114]/255;
    a = [1 nan];
    b = [x,y;nan(1,2)];
    h = bar(a,b,'stacked');
    h(1).FaceColor = colorArr(1,:);
    h(1).BarWidth = 0.5;
    h(2).FaceColor = colorArr(2,:);
    h(2).BarWidth = 0.5;
    ylabel(yl);
    set(gca,'XLim',[0 2])
    
    fileName1 = [pathAnal fileN];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end