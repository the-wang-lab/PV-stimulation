function plotPolarPlot(x1,x2,ti,fn,pathAnal,p)
    [figNew,pos] = CreateFig();
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [234 131 114;...
        163 207 98]/255;
    
    polarhistogram(x1,0:pi/18:2*pi,'Normalization','probability','DisplayStyle','bar',....
        'FaceAlpha',0.5,'FaceColor',colorArr(2,:),'EdgeColor',[0.5 0.5 0.5]);
    hold on;
    if(~isempty(x2))
        polarhistogram(x2,0:pi/18:2*pi,'Normalization','probability','DisplayStyle','bar',....
            'FaceAlpha',0.5,'FaceColor',colorArr(1,:),'EdgeColor',[0.5 0.5 0.5]);
        title([ti ' p = ' num2str(p)])  
    else
        title(ti)
    end
    
    fileName1 = [pathAnal fn];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end