function plotIndFRProfileProvOrder(timeStepRun,avgFRProfile,yl,fileName,pathAnal,indOrd)
    if(isempty(avgFRProfile))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400]);
    numNeurons = size(avgFRProfile,1);
    
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile(indOrd,:));
%     set(h,'LineWidth',0.1)
    set(gca,'XLim',[-1 4]);
%     if(~isempty(ylimit))
%         set(gca,'YLim',ylimit);
%     else
%         set(gca,'YLim',[min(avgFRProfile(:)) max(avgFRProfile(:))]);
%     end
    xlabel('Time (s)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end
