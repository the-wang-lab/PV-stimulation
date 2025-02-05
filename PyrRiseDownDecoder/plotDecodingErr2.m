function plotDecodingErr2(decErr,decErrStim,decErrShuf,time,pStim,pShuf,fileName,pathAnal,ylimit,yl,tit) 

    if(nargin == 7)
        tit = [];
    end
            
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.color_areaZ = [192 221 173]./255;    % Green theme
    options.color_lineZ = [112 173  71]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = time;
    options.x_axisY = time;
    options.x_axisZ = time;
    
    plot_areaerrorbarXYZ(decErr, decErrStim, decErrShuf,options);
    
    hold on;
    minX = min(mean(decErr)-std(decErr)/sqrt(size(decErr,1)));
    minY = min(mean(decErrStim)-std(decErrStim)/sqrt(size(decErrStim,1)));
    minZ = min(mean(decErrShuf)-std(decErrShuf)/sqrt(size(decErrShuf,1)));
    
    maxX = max(mean(decErr)+std(decErr)/sqrt(size(decErr,1)));
    maxY = max(mean(decErrStim)+std(decErrStim)/sqrt(size(decErrStim,1)));
    maxZ = max(mean(decErrShuf)+std(decErrShuf)/sqrt(size(decErrShuf,1)));
    
    maxErr = max([maxX maxY maxZ]);
    for i = 1:length(time)
         if(pStim(i) < 0.05)
            h = plot(time(i),maxErr+0.1,'k.');
            set(h,'MarkerSize',7);
        end
        
        if(pShuf(i) < 0.05)
            h = plot(time(i),maxErr+0.25,'y.');
            set(h,'MarkerSize',7);
        end
        
        if(pStim(i) < 0.01)
            h = plot(time(i),maxErr+0.1,'g.');
            set(h,'MarkerSize',7);
        end
        
        if(pShuf(i) < 0.01)
            h = plot(time(i),maxErr+0.25,'r.');
            set(h,'MarkerSize',7);
        end
    end
        
    set(gca,'XLim',[min(time) max(time)]);
    
    if(~isempty(ylimit))
        set(gca,'YLim',[ylimit(1) ylimit(2)+0.35]);
    else
        set(gca,'YLim',[min([minX minY minZ])*0.95 ...
        max([maxX maxY maxZ])+0.35]);
    end
    xlabel('Real time (s)')
    if(~isempty(yl))
        ylabel(yl);
    else
        ylabel('Decoded time (s)')
    end
    title(tit);
        
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end
