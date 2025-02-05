function plotCompC(x,y,xt,yt,xl,yl,idx,ti,xlimit,ylimit)
    if(nargin == 8)
        xlimit = [];
        ylimit = [];
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [51/255 102/255 255/255;...      
                218/255 179/255 255/255;...                
                255/255 100/255 100/255;...   
                0.9 0.9 0.3;...
                0.3 0.9 0.3;...
                59/255 113/255 86/255;...           
                0.2 0.8 0.5;...
                0.8 0.5 0.2;...
                0.3 0.7 0.3];
    hold on;
    for i = 1:max(idx)
        indTmp = idx == i;
        disp(['Cluster' num2str(i) ' has ' num2str(sum(indTmp)) ' components']);
        h = plot(x(indTmp),y(indTmp),'.');
        set(h,'MarkerSize',11,'Color',colorArr(mod(i,max(idx))+1,:));
    end
    h = plot(xt,yt,'k+');
    set(h,'MarkerSize',9);
    if(isempty(xlimit))
        maxX = max(x);
        minX = min(x);        
    else
        maxX = xlimit(2);
        minX = xlimit(1);
    end
    if(isempty(ylimit))
        maxY = max(y);
        minY = min(y);        
    else
        maxY = ylimit(2);
        minY = ylimit(1);
    end
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    title(ti);
end