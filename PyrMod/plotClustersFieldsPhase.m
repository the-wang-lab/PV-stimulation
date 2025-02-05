function plotClustersFieldsPhase(pathAnal,x,y,idx,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
    plot([0 2*pi],[0 2*pi],'k-')
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    if(sum(~indField) > 0)
        plotClusters(x(~indField),y(~indField),...
            idx(~indField),xl,yl,[ti ' - no field']);
        plot([0 2*pi],[0 2*pi],'k-')

        fileName1 = [pathAnal fileN 'NoField'];
        saveas(gcf,fileName1);
        print('-painters', '-dpdf', fileName1, '-r600')
    end
end
