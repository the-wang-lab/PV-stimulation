function plotPosterior(PosteriorP,time,title1,fileName,pathAnal) 
    if(isempty(PosteriorP))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400]);
        
    h = imagesc(time',time',PosteriorP);
    set(gca,'YDir','normal')
    colormap hot
    colorbar
    hold on;
    [~,indMaxPosterior] = max(PosteriorP);
    h = plot(time,time(indMaxPosterior));
    set(h,'LineWidth', 2, 'Color',[1 1 1]);
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end