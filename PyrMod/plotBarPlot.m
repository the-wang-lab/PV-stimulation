function plotBarPlot(x1,x2,yl,fn,pathAnal,ylimit,p,colorSel)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400])
    if(colorSel == 0)
        colorArr = [...
                234 131 114,...
                163 207 98]/255;
    elseif(colorSel == 1) 
        colorArr = [63 79 37;... 
            163 207 98]/255;
    else  
        colorArr = [116 53 61;...
            234 131 114]/255;
    end
    meanx1 = mean(x1);
    meanx2 = mean(x2);
    sem1 = std(x1)/sqrt(size(x1,1));
    sem2 = std(x2)/sqrt(size(x2,1));
    hold on;
    h = bar(1,meanx1,0.6,'FaceColor',colorArr(1,:));
    set(h,'FaceAlpha',0.5);
    h = bar(2,meanx2,0.6,'FaceColor',colorArr(2,:));
    set(h,'FaceAlpha',0.5);
    h = errorbar(1,meanx1,sem1,'LineWidth',1,'Marker','.','Color','k');    
    h = errorbar(2,meanx2,sem2,'LineWidth',1,'Marker','.','Color','k');
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    end
    ylabel(yl);
    title(['p = ' num2str(p)]);
    
    fileName1 = [pathAnal fn];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end
