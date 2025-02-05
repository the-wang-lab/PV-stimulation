function plotClusterTagged(pathAnal,autoCorrIntAll,autoCorrIntTag,cluPV,cluSST)

%     plotCompCNoTagC5(autoCorrIntAll.peakTime,autoCorrIntAll.phaseMeanDire/pi*180,...
%         'peak time (ms)','phase mean dire',autoCorrIntAll.idxC1,'All Interneurons',[],[]);
%     fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDireC5NoTag'];
%     saveas(gcf,fileName1);
%     print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCNoTagC5(autoCorrIntAll.peakTime,autoCorrIntAll.phaseMeanDire/pi*180,...
        'peak time (ms)','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[]);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDireNoTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
       
    idxTagPV = autoCorrIntTag.cellType == 1;
    plotCompCTagC5(autoCorrIntAll.peakTime,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.peakTime(idxTagPV),autoCorrIntTag.phaseMeanDire(idxTagPV)/pi*180,...
        'peak time (ms)','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluPV);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDirePVTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
    idxTagSST = autoCorrIntTag.cellType == 2;
    plotCompCTagC5(autoCorrIntAll.peakTime,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.peakTime(idxTagSST),autoCorrIntTag.phaseMeanDire(idxTagSST)/pi*180,...
        'peak time (ms)','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluSST);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDireSSTTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    cluSST1 = cluSST(1);
    idxTagSST1 = autoCorrIntTag.cellType == 2 & autoCorrIntTag.idxC2 == cluSST1;
    plotCompCTagC5(autoCorrIntAll.peakTime(autoCorrIntAll.idxC2 == cluSST1),...
        autoCorrIntAll.phaseMeanDire(autoCorrIntAll.idxC2 == cluSST1)/pi*180,...
        autoCorrIntTag.peakTime(idxTagSST1),autoCorrIntTag.phaseMeanDire(idxTagSST1)/pi*180,...
        'peak time (ms)','phase mean dire',autoCorrIntAll.idxC2(autoCorrIntAll.idxC2 == cluSST1),...
        'SST O_LM neurons',[],[0 360],cluSST1);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDireSSTTagClu' num2str(cluSST1)];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    cluPV1 = cluPV(1);
    idxTagPV1 = autoCorrIntTag.cellType == 1 & autoCorrIntTag.idxC2 == cluPV1;
    plotCompCTagC5(autoCorrIntAll.peakTime(autoCorrIntAll.idxC2 == cluPV1),...
        autoCorrIntAll.phaseMeanDire(autoCorrIntAll.idxC2 == cluPV1)/pi*180,...
        autoCorrIntTag.peakTime(idxTagPV1),autoCorrIntTag.phaseMeanDire(idxTagPV1)/pi*180,...
        'peak time (ms)','phase mean dire',autoCorrIntAll.idxC2(autoCorrIntAll.idxC2 == cluPV1),...
        'PV basket neurons',[],[0 360],cluPV1);
    fileName1 = [pathAnal 'Interneuron_PeakTVsPhaseMeanDirePVTagClu' num2str(cluPV1)];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCNoTagC5(autoCorrIntAll.burstInd,autoCorrIntAll.phaseMeanDire/pi*180,...
        'burst index','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[]);
    fileName1 = [pathAnal 'Interneuron_BurstIndVsPhaseMeanDireC5NoTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCTagC5(autoCorrIntAll.burstInd,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.burstInd(idxTagPV),autoCorrIntTag.phaseMeanDire(idxTagPV)/pi*180,...
        'burst index','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluPV);
    fileName1 = [pathAnal 'Interneuron_burstIndVsPhaseMeanDireC5PVTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCTagC5(autoCorrIntAll.burstInd,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.burstInd(idxTagSST),autoCorrIntTag.phaseMeanDire(idxTagSST)/pi*180,...
        'burst index','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluSST);
    fileName1 = [pathAnal 'Interneuron_burstIndVsPhaseMeanDireC5SSTTag'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCTagC5BG(autoCorrIntAll.burstInd,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.burstInd(idxTagPV),autoCorrIntTag.phaseMeanDire(idxTagPV)/pi*180,...
        'burst index','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluPV1);
    fileName1 = [pathAnal 'Interneuron_burstIndVsPhaseMeanDirePVTagBGC' num2str(cluPV1)];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotCompCTagC5BG(autoCorrIntAll.burstInd,autoCorrIntAll.phaseMeanDire/pi*180,...
        autoCorrIntTag.burstInd(idxTagSST),autoCorrIntTag.phaseMeanDire(idxTagSST)/pi*180,...
        'burst index','phase mean dire',autoCorrIntAll.idxC2,'All Interneurons',[],[],cluSST(1));
    fileName1 = [pathAnal 'Interneuron_burstIndVsPhaseMeanDireSSTTagBGC' num2str(cluSST1)];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')