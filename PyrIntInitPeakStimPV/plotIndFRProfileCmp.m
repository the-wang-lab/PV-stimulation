function plotIndFRProfileCmp(timeStepRun,avgFRProfile,avgFRProfile1,yl,fileName,pathAnal,ylimit,ordMethod,indT,indT1)
    if(isempty(avgFRProfile))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 450 400]);
    numNeurons = size(avgFRProfile,1);
    if(ordMethod == 1)
        [~,indMax] = max(avgFRProfile');
    elseif(ordMethod == 2)
        indMax = mean(avgFRProfile(:,indT)');
    elseif(ordMethod == 3)
        indMax = mean(avgFRProfile(:,indT)');
    elseif(ordMethod == 4)
        indMax1 = mean(avgFRProfile(:,indT1)');
        indMax2 = mean(avgFRProfile(:,indT)');
        indMax = indMax1./indMax2;
    elseif(ordMethod == 5)
        indTmp = timeStepRun > 0;
        [~,indMax] = max(avgFRProfile(:,indTmp)');
    end
    if(ordMethod == 4 | ordMethod == 5)
        [~,indOrd] = sort(indMax,'descend');
    else
        [~,indOrd] = sort(indMax);
    end
    subplot(1,2,1)
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile(indOrd,:));
%     set(h,'LineWidth',0.1)
    set(gca,'XLim',[-1 4],'CLim',[0 1]);
%     if(~isempty(ylimit))
%         set(gca,'YLim',ylimit);
%     else
%         set(gca,'YLim',[min(avgFRProfile(:)) max(avgFRProfile(:))]);
%     end
    xlabel('Time (s)')
    ylabel(yl)
    
    subplot(1,2,2)
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile1(indOrd,:));
%     set(h,'LineWidth',0.1)
    set(gca,'XLim',[-1 4],'CLim',[0 1]);
%     if(~isempty(ylimit))
%         set(gca,'YLim',ylimit);
%     else
%         set(gca,'YLim',[min(avgFRProfile(:)) max(avgFRProfile(:))]);
%     end
    xlabel('Time (s)')
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end