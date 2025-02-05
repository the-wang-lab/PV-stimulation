function plotKmeanResult(autoCorr,autoCorrTag,idxTag,titleX,Tagtype,pathAnal)
%% plot kmean results for two different methods
% This function is called by InterneuronPropAllRec

%     plotCompC(autoCorr.refract,autoCorr.burstInd,...
%         autoCorrTag.refract(idxTag),autoCorrTag.burstInd(idxTag),...
%         'refractory (ms)','burst index',autoCorr.idxC,titleX);  
%     fileName1 = [pathAnal 'Interneuron_RefrVsBurst' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
%         autoCorrTag.peakTime(idxTag),autoCorrTag.peakTo40ms(idxTag),...
%         'peak time (ms)','peak to 40-50 ms',autoCorr.idxC,titleX);
%     fileName1 = [pathAnal 'Interneuron_PeakTVsPeakTo40ms' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
%         autoCorrTag.peakTime(idxTag),autoCorrTag.phaseMeanDire(idxTag),...
%         'peak time (ms)','phase mean dire',autoCorr.idxC,titleX);
%     fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDire' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
%         autoCorrTag.peakTime(idxTag),autoCorrTag.minPhaseArr(idxTag),...
%         'peak time (ms)','min phase theta hist',autoCorr.idxC,titleX);
%     fileName1 = [pathAnal 'Interneuron_PeakTVsMinPhaseArr' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
%         autoCorrTag.peakTime(idxTag),autoCorrTag.maxPhaseArr(idxTag),...
%         'peak time (ms)','max phase theta hist',autoCorr.idxC,titleX);
%     fileName1 = [pathAnal 'Interneuron_PeakTVsMaxPhaseArr' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     isHighAmp = autoCorr.isSpikeHighAmp == 1;
%     isHighAmpT = autoCorrTag.isSpikeHighAmp == 1 & idxTag;
%     plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
%         autoCorrTag.peakTime(isHighAmpT),autoCorrTag.relDepthNeuHDef(isHighAmpT),...
%         'peak time (ms)','depth',autoCorr.idxC(isHighAmp),titleX); 
%     fileName1 = [pathAnal 'Interneuron_PeakTVsDepth' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
%     
%     plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
%         autoCorrTag.peakTime(idxTag),autoCorrTag.relDepthNeuHDef(idxTag),...
%         'peak time (ms)','depth',autoCorr.idxC,titleX); 
%     fileName1 = [pathAnal 'Interneuron_PeakTVsDepthAllInt' Tagtype];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
    
    
    %% klustering method 1
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        autoCorrTag.refract(idxTag),autoCorrTag.burstInd(idxTag),...
        'refractory (ms)','burst index',autoCorr.idxC1,[titleX ' meth1']);  
    fileName1 = [pathAnal 'Interneuron_RefrVsBurst1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.peakTo40ms(idxTag),...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC1,[titleX ' meth1']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPeakTo40ms1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.phaseMeanDire(idxTag),...
        'Peak time (ms)','Mean theta phase',autoCorr.idxC1,[titleX ' meth1'],...
        [0 max(autoCorr.peakTime)],[0 2*pi]);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDire1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.minPhaseArr(idxTag),...
        'peak time (ms)','min phase theta hist',autoCorr.idxC1,[titleX ' meth1']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMinPhaseArr1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.maxPhaseArr(idxTag),...
        'peak time (ms)','max phase theta hist',autoCorr.idxC1,[titleX ' meth1']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMaxPhaseArr1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    isHighAmpT = autoCorrTag.isSpikeHighAmp == 1 & idxTag;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        autoCorrTag.peakTime(isHighAmpT),autoCorrTag.relDepthNeuHDef(isHighAmpT),...
        'peak time (ms)','depth',autoCorr.idxC1(isHighAmp),[titleX ' meth1']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepth1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.relDepthNeuHDef(idxTag),...
        'peak time (ms)','depth',autoCorr.idxC1,[titleX ' meth1']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepthAllInt1' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    %% klustering method 2
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        autoCorrTag.refract(idxTag),autoCorrTag.burstInd(idxTag),...
        'refractory (ms)','burst index',autoCorr.idxC2,[titleX ' meth2']);  
    fileName1 = [pathAnal 'Interneuron_RefrVsBurst2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.peakTo40ms(idxTag),...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC2,[titleX ' meth2']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPeakTo40ms2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.phaseMeanDire(idxTag),...
        'peak time (ms)','phase mean dire',autoCorr.idxC2,[titleX ' meth2']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDire2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.minPhaseArr(idxTag),...
        'peak time (ms)','min phase theta hist',autoCorr.idxC2,[titleX ' meth2']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMinPhaseArr2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.maxPhaseArr(idxTag),...
        'peak time (ms)','max phase theta hist',autoCorr.idxC2,[titleX ' meth2']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMaxPhaseArr2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    isHighAmpT = autoCorrTag.isSpikeHighAmp == 1 & idxTag;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        autoCorrTag.peakTime(isHighAmpT),autoCorrTag.relDepthNeuHDef(isHighAmpT),...
        'peak time (ms)','depth',autoCorr.idxC2(isHighAmp),[titleX ' meth2']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepth2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.relDepthNeuHDef(idxTag),...
        'peak time (ms)','depth',autoCorr.idxC2,[titleX ' meth2']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepthAllInt2' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    %% klustering method 3
    plotCompC(autoCorr.refract,autoCorr.burstInd,...
        autoCorrTag.refract(idxTag),autoCorrTag.burstInd(idxTag),...
        'refractory (ms)','burst index',autoCorr.idxC3,[titleX ' meth3']);  
    fileName1 = [pathAnal 'Interneuron_RefrVsBurst3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.peakTo40ms,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.peakTo40ms(idxTag),...
        'peak time (ms)','peak to 40-50 ms',autoCorr.idxC3,[titleX ' meth3']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPeakTo40ms3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.phaseMeanDire,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.phaseMeanDire(idxTag),...
        'peak time (ms)','phase mean dire',autoCorr.idxC3,[titleX ' meth3']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDire3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.minPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.minPhaseArr(idxTag),...
        'peak time (ms)','min phase theta hist',autoCorr.idxC3,[titleX ' meth3']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMinPhaseArr3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.maxPhaseArr,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.maxPhaseArr(idxTag),...
        'peak time (ms)','max phase theta hist',autoCorr.idxC3,[titleX ' meth3']);
    fileName1 = [pathAnal 'Interneuron_PeakTVsMaxPhaseArr3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    isHighAmp = autoCorr.isSpikeHighAmp == 1;
    isHighAmpT = autoCorrTag.isSpikeHighAmp == 1 & idxTag;
    plotCompC(autoCorr.peakTime(isHighAmp),autoCorr.relDepthNeuHDef(isHighAmp),...
        autoCorrTag.peakTime(isHighAmpT),autoCorrTag.relDepthNeuHDef(isHighAmpT),...
        'peak time (ms)','depth',autoCorr.idxC3(isHighAmp),[titleX ' meth3']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepth3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompC(autoCorr.peakTime,autoCorr.relDepthNeuHDef,...
        autoCorrTag.peakTime(idxTag),autoCorrTag.relDepthNeuHDef(idxTag),...
        'peak time (ms)','depth',autoCorr.idxC3,[titleX ' meth3']); 
    fileName1 = [pathAnal 'Interneuron_PeakTVsDepthAllInt3' Tagtype];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
end