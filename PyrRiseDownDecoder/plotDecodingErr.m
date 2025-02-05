function plotDecodingErr(decErr,decErrShuf,time,fileName,pathAnal,ylimit) 
            
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = time;
    options.x_axisY = time;
    plot_areaerrorbarXY(decErr', decErrShuf',...
        options);
    hold on;
    minX = min(mean(decErr)-std(decErr)/sqrt(size(decErr,1)));
    minY = min(mean(decErrShuf)-std(decErrShuf)/sqrt(size(decErrShuf,1)));
    maxX = max(mean(decErr)+std(decErr)/sqrt(size(decErr,1)));
    maxY = max(mean(decErrShuf)+std(decErrShuf)/sqrt(size(decErrShuf,1)));
    
    set(gca,'XLim',[min(time) max(time)]);
    
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[min([minX minY])*0.95 ...
        max([maxX maxY])*1.05]);
    end
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    
%     h = plot(time,decErr);
%     set(h,'Color',[0.8 0.8 0.8]);
%     hold
%     h = plot(time,decErrShuf);
%     set(h,'Color',[0.4 0.4 0.4]);
%     xlabel('Real time (s)')
%     ylabel('Decoded time (s)')
%     legend('Data','Shuf')
%     set(gca,'FontSize',10,'XLim',[min(time) max(time)])
%     title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end
