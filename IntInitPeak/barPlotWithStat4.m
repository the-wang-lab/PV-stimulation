function barPlotWithStat4(ind,x,y,ylab,tit,rankXY,fn,pathAnal,colorSel,labels,yrange)
    if(nargin < 11)
        yrange = [];
    end
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
%     h = plot([1.1 2.1],data(:,1:2),'k.-');
%     set(h,'MarkerSize',6,'LineWidth',1,'Color',[0.7 0.7 0.7]);
    if(length(rankXY) == 1)
        text(0.5,1.1*max(x+y),num2str(rankXY,'p = %e'));
    else
        text(0.5,1.1*max(x+y),num2str(rankXY,'p = %e\n%e'));
    end

    ylabel(ylab);
    if(~isempty(tit))
        title(tit);
    end
    if(isempty(yrange))
        set(gca,'fontSize',12,'YLim',[min(x-y) 1.1*max(x+y)])
    else
        set(gca,'fontSize',12,'YLim',yrange)
    end 
          
    fileName1 = [pathAnal fn];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

