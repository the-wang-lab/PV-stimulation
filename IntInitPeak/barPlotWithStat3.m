function barPlotWithStat3(ind,x,y,xdata,ydata,ylab,tit,rankXY,fn,pathAnal,colorSel,labels,xl)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400])
    if(colorSel == 0)
        colorArr = [163 207 98;...
                234 131 114]/255;                
    elseif(colorSel == 1)            
        colorArr = [163 207 98;... 
            63 79 37]/255;
    else  
        colorArr = [234 131 114;...
                116 53 61]/255;
    end
    
    h = bar(ind,x);
    set(gca,'xticklabel',labels);
    h.FaceColor = 'flat';
    h.CData = colorArr;
    hold on;
    h = errorbar(ind,x,y,'.');
    set(h,'Color',[0 0 0],'lineWidth',1.5);
    h = plot(1.1*ones(1,length(xdata)),xdata,'k.');
    set(h,'MarkerSize',7,'LineWidth',1,'Color',[0.7 0.7 0.7]);
    h = plot(2.1*ones(1,length(ydata)),ydata,'k.');
    set(h,'MarkerSize',7,'LineWidth',1,'Color',[0.7 0.7 0.7]);
    text(1,1.1*max([xdata(:); ydata(:)]),num2str(rankXY,'p = %f'));

    ylabel(ylab);
    if(~isempty(tit))
        title(tit);
    end
    data = [xdata(:); ydata(:)];
    if(max(data(:)) > 0)
        set(gca,'fontSize',10,'YLim',[min(data(:)) 1.1*max(data(:))])
    elseif((max(data(:)) < 0))
        set(gca,'fontSize',10,'YLim',[1.1*min(data(:)) max(data(:))])
    else
        set(gca,'fontSize',10,'YLim',[min(data(:)) 1])
    end
    
    if(nargin == 13)
       set(gca,'YLim',xl) 
    end
    
    
    fileName1 = [pathAnal fn];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

