function plotThetaModStimStats(pathAnal0,thetaModStat,xlabels,fnstr)

    colorSel = 0;
    for i = 1:length(thetaModStat)
        
        %% theta modulation related parameters
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanThetaFreqHMean,...
            thetaModStat{i}.semThetaFreqHMean,...
            ['Mean theta freq. cond ' num2str(i)],...
            '', thetaModStat{i}.pRSThetaFreqHMean,...
            ['MeanThetaFreqHGoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[0 8]);
        
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanThetaMod,...
            thetaModStat{i}.semThetaMod,...
            ['Mean theta mod. cond ' num2str(i)],...
            '', thetaModStat{i}.pRSThetaMod,...
            ['MeanThetaModGoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[0 0.6]);
        
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanThetaModInd,...
            thetaModStat{i}.semThetaModInd,...
            ['Mean theta mod. ind. cond ' num2str(i)],...
            '', thetaModStat{i}.pRSThetaModInd,...
            ['MeanThetaModIndGoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[0 0.6]);
        
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanThetaModInd3,...
            thetaModStat{i}.semThetaModInd3,...
            ['Mean theta mod. ind3 cond ' num2str(i)],...
            '', thetaModStat{i}.pRSThetaModInd3,...
            ['MeanThetaModInd3GoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[0 0.6]); 
        
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanThetaAsym3,...
            thetaModStat{i}.semThetaAsym3,...
            ['Mean theta asym. cond ' num2str(i)],...
            '', thetaModStat{i}.pRSThetaAsym3,...
            ['MeanThetaAsym3GoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[0 0.6]); 
        
        barPlotWithStat4(1:2,...
            thetaModStat{i}.meanDiffThetaFreq,...
            thetaModStat{i}.semDiffThetaFreq,...
            ['Diff theta freq. cond ' num2str(i)],...
            '', thetaModStat{i}.pRSDiffThetaFreq,...
            ['MeanDiffThetaFreqGoodNoStimVsStim' fnstr '_cond' num2str(i)],...
            pathAnal0,colorSel,xlabels,[-0.3 0.8]); 
    end