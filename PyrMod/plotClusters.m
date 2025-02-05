function plotClusters(x,y,idx,xl,yl,ti)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])

    % only for plotting two clusters with fields
    colorArr = [163 207 98;...
                234 131 114;...
                163 207 98]/255;
            
%     colorArr = [0.5 0.5 0.9;...
%         0.9 0.5 0.5;...
%         0.3 0.3 0.7;...
%         0.7 0.3 0.3;...
%         0.5 0.9 0.5;...
%         0.2 0.5 0.8;...
%         0.2 0.8 0.5;...
%         0.8 0.5 0.2;...
%         0.3 0.7 0.3];
    hold on;
    for i = 1:max(idx)
        indTmp = idx == i;
        h = plot(x(indTmp),y(indTmp),'.');
        set(h,'MarkerSize',8,'Color',colorArr(mod(i,6)+1,:));
    end
%     h = plot(xt,yt,'k+');
%     set(h,'MarkerSize',7);
    maxX = max(x);
    maxY = max(y);
    minX = min(x);
    minY = min(y);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    title(ti);
end