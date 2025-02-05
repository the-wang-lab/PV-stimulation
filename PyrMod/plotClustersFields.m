function plotClustersFields(pathAnal,x,y,idx,indField,xl,yl,ti,fileN,colorArr)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field'],colorArr);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotClusters(x(~indField),y(~indField),...
        idx(~indField),xl,yl,[ti ' - no field'],colorArr);
        
    fileName1 = [pathAnal fileN 'NoField'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end