function PyrModAllRec(onlyRun,taskSel,methodKMean)
% e.g. PyrModAllRec(1,1,2)

    if(nargin == 1)
        methodKMean = 2; % which kmean method is used
    end
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\Pyramidal\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    % accumulate data from different recording types based on taskSel
    mod = PyrModAllRecByType(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyrNoCue,modPyrAL,modPyrPL,autoCorrPyrAll,taskSel,methodKMean);
    
    save([pathAnal 'autoCorrPyrAllRecMod_km' num2str(methodKMean)  '.mat'],'mod');
%     
%     figure
%     for i = 1:max(idxC)
%         indCurC = idxC == i;
%         h = plot(phaseMeanDire(indCurC),phaseDiff(indCurC),'o');
%         set(gca,'XLim',[0 2*pi],'YLim',[0 300])
%         pause;
%     end

    % for each cluster, compare neurons in the recordings with fields vs.
    % recordings without field
    modPyrStatsField = modPyrStatsFieldPerC(mod);
    
    % compare neurons between the two clusters
    modPyrStatsC = modPyrStatsClass(mod);
    
    % for each cluster, compare neurons with fields and without field
    modPyrStatsFNeuVsNoFNeu = modPyrStatsFieldNeu(mod);
    
    modPyrStatsField.diffFreqNoField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 0);
    modPyrStatsField.diffFreqField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 1);
    modPyrStatsField.pRSDiffFreq = ranksum(modPyrStatsField.diffFreqNoField,modPyrStatsField.diffFreqField);
    modPyrStatsField.meanDiffFreq = [mean(modPyrStatsField.diffFreqNoField),mean(modPyrStatsField.diffFreqField)];    
    modPyrStatsField.semDiffFreq = [std(modPyrStatsField.diffFreqNoField)/sqrt(sum(mod.isNeuWithField == 0)),...
        std(modPyrStatsField.diffFreqField)/sqrt(sum(mod.isNeuWithField))];    
    
    if(taskSel == 1)
        save([pathAnal 'autoCorrPyrAllRec_km' num2str(methodKMean)  '.mat'],'modPyrStatsField','modPyrStatsC',...
            'modPyrStatsFNeuVsNoFNeu'); 
    elseif(taskSel == 2)
        save([pathAnal 'autoCorrPyrALPLRec_km' num2str(methodKMean) '.mat'],'modPyrStatsField','modPyrStatsC',...
            'modPyrStatsFNeuVsNoFNeu'); 
    else
        save([pathAnal 'autoCorrPyrALRec_km' num2str(methodKMean) '.mat'],'modPyrStatsField','modPyrStatsC',...
            'modPyrStatsFNeuVsNoFNeu'); 
    end
    close all;
    
    %% difference between cell oscillation frequency and LFP frequency    
    %% field before alignment
    diffFreqNoField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 0);
    diffFreqField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 1);
    pRSDiffFreq = ranksum(diffFreqNoField,diffFreqField);
    plotBarOnly([mean(diffFreqNoField),mean(diffFreqField)],...
        [std(diffFreqNoField)/sqrt(sum(mod.isNeuWithField == 0)),...
        std(diffFreqField)/sqrt(sum(mod.isNeuWithField))],...
        '','Neuron mod. freq. - LFP freq.', ['p=' num2str(pRSDiffFreq)],pathAnal,'ModFreqMinorsLFPFreqField')
        
    %% theta phase mean direction vs.burst mean direction 
    plotBurstVsTheta(mod.burstMeanDire,mod.phaseMeanDire,mod.fractBurst,pathAnal);
       
    %% plot polar plot of theta phase direction for the whole population
    plotPolarPlot(mod.phaseMeanDire,[],...
        'Mean theta phase direction',...
        'Pyr_ThetaMeanAllPolar',pathAnal,[]);
    
    plotPolarPlot(mod.burstMeanDire(mod.fractBurst > 0),[],...
        'Burst phase',...
        'Pyr_BurstMeanDireAllPolar',pathAnal,[]);
    
    plotPolarPlot(mod.nonBurstMeanDire,[],...
        'Non-burst phase',...
        'Pyr_NonBurstMeanDireAllPolar',pathAnal,[]);
    
    plotPolarPlot(mod.burstMeanDireStart(mod.fractBurst > 0),[],...
        'Burst start phase direction',...
        'Pyr_BurstMeanDireStartAllPolar',pathAnal,[]);
    
    
    %% C1 and C2 contain what percentage of neurons with field, to be changed based on the clustering result
    if(methodKMean == 2)
        clu1 = 2; % deep
        clu2 = 1; % superficial
    elseif(methodKMean == 3)
        clu1 = 1; % deep
        clu2 = 2; % superficial
    end
    if(clu1 == 1)
        colorArr = [...
        163/255 207/255 98/255;...
        234/255 131/255 114/255];
    else
        colorArr = [...
        234/255 131/255 114/255;...
        163/255 207/255 98/255];
    end
        
    numNeuField = sum(mod.isNeuWithField);
    percFieldNeuC1 = sum(modPyrStatsFNeuVsNoFNeu.indCurCField{clu1})/numNeuField;
    percFieldNeuC2 = sum(modPyrStatsFNeuVsNoFNeu.indCurCField{clu2})/numNeuField;
    plotStackedBar(percFieldNeuC1,percFieldNeuC2,'Perc. neurons with field',...
        'Pyr_PercNeuWithFieldC1C2',pathAnal);
    
    %% compare two pyramidal clusters
    colorSel = 0;
    plotCompPyrClusters(pathAnal, mod, modPyrStatsC, colorSel, clu1, clu2, 0);
    
    pause;
    close all;
    
    %% compare field neurons vs. no field neuron in cluster 1
    colorSel = 1;   
    plotCompPyrClu1FieldNoField(pathAnal, mod, modPyrStatsFNeuVsNoFNeu, colorSel, clu1);
    
    %% compare field neurons vs. no field neurons in cluster 2
    colorSel = 2;   
    plotCompPyrClu2FieldNoField(pathAnal, mod, modPyrStatsFNeuVsNoFNeu, colorSel, clu2);
    
    %% plot clusters with fields
    indCurCField1 = mod.nNeuWithField > 1 & mod.isNeuWithField == 1;
    indCurCNoField1 = mod.nNeuWithField <= 1 & mod.isNeuWithField == 1;
    indField = mod.nNeuWithField > 1;

    indCurCField2 = mod.isNeuWithField == 1;
    burstDiffDouble = [mod.burstThetaDiff/pi*180, mod.burstThetaDiff/pi*180];
    thetaDouble = [mod.phaseMeanDire/pi*180, mod.phaseMeanDire/pi*180+360];
    plotClustersFieldsPhaseLabelF(pathAnal,burstDiffDouble,thetaDouble,...
        [mod.idxC mod.idxC],[],[],...
        [],[],1:2*length(indCurCField2),...
        'Burst mean phase-Mean theta phase','Mean theta phase','All tasks',...
        'Pyr_BurstThetaDiffVsThetaMeanAll',colorArr);
    set(gca,'Xlim',[-180 180],'XTick',[-180 0 180],'YLim',[0 720],'YTick',[0 360 720])
    plot([0 0],[0 720],'k-');
    fileName1 = [pathAnal 'Pyr_BurstThetaDiffVsThetaMeanAll'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    burstDiffDoubleField = [mod.burstThetaDiff(indCurCField2)/pi*180,...
        mod.burstThetaDiff(indCurCField2)/pi*180];
    thetaDoubleField = [mod.phaseMeanDire(indCurCField2)/pi*180,...
        mod.phaseMeanDire(indCurCField2)/pi*180+360];
    plotClustersFieldsPhaseLabelF(pathAnal,burstDiffDouble,thetaDouble,...
        [mod.idxC mod.idxC],burstDiffDoubleField,thetaDoubleField,...
        [],[],1:2*length(indCurCField2),...
        'Burst mean phase-Mean theta phase','Mean theta phase','All tasks',...
        'Pyr_BurstThetaDiffVsThetaMeanAll',colorArr);
    set(gca,'Xlim',[-180 180],'XTick',[-180 0 180],'YLim',[0 720],'YTick',[0 360 720])
    plot([0 0],[0 720],'k-');
    fileName1 = [pathAnal 'Pyr_BurstThetaDiffVsThetaMeanAllWithField'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotClustersFieldsPhaseLabelF(pathAnal,mod.phaseMeanDire/pi*180,mod.thetaModFreq3,...
        mod.idxC,mod.phaseMeanDire(indCurCField2)/pi*180,mod.thetaModFreq3(indCurCField2),...
        [],[],1:length(indCurCField2),...
        'Mean theta phase','Theta modulation freq. (Hz)','All tasks label Fields',...
        'Pyr_ThetaMeanVsModFreqAllVsField',colorArr);

    %% compare neurons in the recordings with fields vs. in the recordings with no field in cluster 1
    colorSel = 1;   
    plotCompPyrClu1RecFieldNoField(pathAnal, mod, modPyrStatsField, colorSel, clu1);
    
    
    %% compare neurons in the recordings with fields vs. in the recordings with no field in cluster 2
    colorSel = 2;  
    plotCompPyrClu2RecFieldNoField(pathAnal, mod, modPyrStatsField, colorSel, clu2);
    
    %%
    plotClustersFields(pathAnal,mod.thetaModHist,mod.phaseMeanDire,...
        mod.idxC,mod.nNeuWithField > 1,...
        'Theta modulation (hist)','Theta phase mean direction','All tasks',...
        'Pyr_ThetaModHistVsThetaMean',colorArr);
    
    pause;
    close all;
end









