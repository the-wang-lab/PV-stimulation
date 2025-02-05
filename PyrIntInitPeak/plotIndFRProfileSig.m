function plotIndFRProfileSig(timeStepRun,avgFRProfile,...
    idxRise,idxDown,idxOther,yl,fileName,pathAnal,ylimit,indT,indT1)
    if(isempty(avgFRProfile))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400]);
            
    % PyrRise
    indMax1 = mean(avgFRProfile(idxRise,indT1)');
    indMax2 = mean(avgFRProfile(idxRise,indT)');
    indMax = indMax1./indMax2;
    [~,indOrd] = sort(indMax,'descend');
    avgFRProfileRise = avgFRProfile(idxRise(indOrd),:);
    
    % PyrOther
    indMax1 = mean(avgFRProfile(idxOther,indT1)');
    indMax2 = mean(avgFRProfile(idxOther,indT)');
    indMax = indMax1./indMax2;
    [~,indOrd] = sort(indMax,'descend');
    avgFRProfileOther = avgFRProfile(idxOther(indOrd),:);
    
    % PyrDown
    indMax1 = mean(avgFRProfile(idxDown,indT1)');
    indMax2 = mean(avgFRProfile(idxDown,indT)');
    indMax = indMax1./indMax2;
    [~,indOrd] = sort(indMax,'descend');
    avgFRProfileDown = avgFRProfile(idxDown(indOrd),:);
    
    avgFRProfile = [avgFRProfileRise;avgFRProfileOther;avgFRProfileDown];
    numNeurons = size(avgFRProfile,1);
    
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile);
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
