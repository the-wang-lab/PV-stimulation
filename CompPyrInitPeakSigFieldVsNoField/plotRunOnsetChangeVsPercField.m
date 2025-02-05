function plotRunOnsetChangeVsPercField(pathAnal,Pyrlm)
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercRisePerRec',Pyrlm.Rise,...
        'Perc neuron with field per rec.','Perc rise neuron per rec');
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercDownPerRec',Pyrlm.Down,...
        'Perc neuron with field per rec.','Perc down neuron per rec');
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercOtherPerRec',Pyrlm.Other,...
        'Perc neuron with field per rec.','Perc other neuron per rec');
    
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercRisePerRec',Pyrlm.RiseField,...
        'Perc rise neuron with field per rec.','Perc rise neuron per rec');
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercDownPerRec',Pyrlm.DownField,...
        'Perc down neuron with field per rec.','Perc down neuron per rec');
    
    plotLinearReg(pathAnal,'PyrlmPercFieldNonZeroPerRecVsPercDownPerRec',Pyrlm.DownFieldNonZero,...
        'Perc down neuron with field per rec. (> 0 field)','Perc down neuron per rec');
    
    plotLinearReg(pathAnal,'PyrlmPercFieldPerRecVsPercOtherPerRec',Pyrlm.OtherField,...
        'Perc other neuron with field per rec.','Perc other neuron per rec');
end

function plotLinearReg(pathAnal,fileName,lm,xl,yl)
    figure;
    h = plot(lm);
    set(h(1),'Marker','o','MarkerSize',8,'MarkerEdgeColor','k');
    xlabel(xl);
    ylabel(yl);
    set(gca,'FontSize',12)
    title(['px1 = ' num2str(lm.Coefficients.pValue(2))]);
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end