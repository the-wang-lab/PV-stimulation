function plotClustersFieldsLabelF(pathAnal,x,y,idx,xfF,yfF,xfNoF,yfNoF,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
    h = plot(xfF,yfF,'k+');
    set(h,'MarkerSize',9);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotClusters(x(~indField),y(~indField),...
        idx(~indField),xl,yl,[ti ' - no field']);
    h = plot(xfNoF,yfNoF,'k+');
    set(h,'MarkerSize',9);
    
    fileName1 = [pathAnal fileN 'NoField'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end