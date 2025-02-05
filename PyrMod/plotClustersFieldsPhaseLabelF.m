function plotClustersFieldsPhaseLabelF(pathAnal,x,y,idx,xfF,yfF,xfNoF,yfNoF,indField,xl,yl,ti,fileN,colorArr)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field'],colorArr);
%     plot([0 2*pi],[0 2*pi],'k-')
    h = plot(xfF,yfF,'k+');
    set(h,'MarkerSize',5);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    if(sum(~indField) > 0)
        plotClusters(x(~indField),y(~indField),...
            idx(~indField),xl,yl,[ti ' - no field']);
    %     plot([0 2*pi],[0 2*pi],'k-')
        h = plot(xfNoF,yfNoF,'k+');
        set(h,'MarkerSize',5);

        fileName1 = [pathAnal fileN 'NoField'];
        saveas(gcf,fileName1);
        print('-painters', '-dpdf', fileName1, '-r600')
    end
end