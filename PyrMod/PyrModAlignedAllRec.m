function PyrModAlignedAllRec(onlyRun,taskSel,methodKMean)

    if(nargin == 1)
        methodKMean = 2;
    end
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal1 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAligned\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAlignedALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalAlignedAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    load([pathAnal1 'autoCorrPyrAllRec.mat']);
    GlobalConstFq;
    
    if(taskSel == 1 && exist('modAlignedPyrNoCue') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modAlignedPyrNoCue = accumPyrNeuronsAligned(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,sampleFq);

        disp('Active licking')
        modAlignedPyrAL = accumPyrNeuronsAligned(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,sampleFq);

        disp('Passive licking')
        modAlignedPyrPL = accumPyrNeuronsAligned(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,sampleFq);
    
        save([pathAnal1 'autoCorrPyrAllRec.mat'],'modAlignedPyrNoCue','modAlignedPyrAL','modAlignedPyrPL','-append'); 
    end
    
    % accumulate data from different recording types based on taskSel
    mod = PyrModAlignedAllRecByType(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modAlignedPyrNoCue,modAlignedPyrAL,modAlignedPyrPL,autoCorrPyrAll,taskSel,methodKMean);
            
    % for each cluster, compare neurons in the recordings with fields vs.
    % recordings without field
    modAlignedPyrStatsField = modPyrStatsFieldPerC(mod);
    
    % compare neurons between the two clusters
    modAlignedPyrStatsC = modPyrStatsClass(mod);
    
    % for each cluster, compare neurons with fields and without field
    modAlignedPyrStatsFNeuVsNoFNeu = modPyrStatsFieldNeu(mod);
    
    save([pathAnal 'autoCorrPyrAllRec_km' num2str(methodKMean) '.mat'],...
        'modAlignedPyrStatsField','modAlignedPyrStatsFNeuVsNoFNeu','modAlignedPyrStatsC'); 
    
    close all;
    
    %% difference between cell oscillation frequency and LFP frequency
    
    %% field after alignment
    diffFreqNoField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 0);
    diffFreqField = mod.diffNeuronLFPFreq(mod.isNeuWithField == 1);
    pRSDiffFreq = ranksum(diffFreqNoField,diffFreqField);
    plotBarOnly([mean(diffFreqNoField),mean(diffFreqField)],...
        [std(diffFreqNoField)/sqrt(sum(mod.isNeuWithField == 0)),...
        std(diffFreqField)/sqrt(sum(mod.isNeuWithField))],...
        '','Neuron mod. freq. - LFP freq.', ['p=' num2str(pRSDiffFreq)],pathAnal,'ModFreqMinorsLFPFreqField')
    
    %% theta phase mean direction vs. 
    % diff between burst mean direction and theta mean direction
    plotBurstVsTheta(mod.burstMeanDire,mod.phaseMeanDire,mod.fractBurst,pathAnal);
   
    %% to be changed depending on the clustering result
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
    %%
    
    numNeuField = sum(mod.isNeuWithField);
    percFieldNeuC1 = sum(modAlignedPyrStatsFNeuVsNoFNeu.indCurCField{clu1})/numNeuField;
    percFieldNeuC2 = sum(modAlignedPyrStatsFNeuVsNoFNeu.indCurCField{clu2})/numNeuField;
    plotStackedBar(percFieldNeuC1,percFieldNeuC2,'Perc. neurons with field',...
        'Pyr_PercNeuWithFieldC1C2',pathAnal);
    
    %% compare two clusters
    colorSel = 0;
    plotCompPyrClusters(pathAnal, mod, modAlignedPyrStatsC, colorSel, clu1, clu2, 1);
        
    %% compare field vs. no field cluster 1 (deep cells)
    colorSel = 1;   
    plotCompPyrClu1FieldNoField(pathAnal, mod, modAlignedPyrStatsFNeuVsNoFNeu, colorSel, clu1);
        
    %% compare field vs. no field cluster 2
    colorSel = 2;   
    plotCompPyrClu2FieldNoField(pathAnal, mod, modAlignedPyrStatsFNeuVsNoFNeu, colorSel, clu2);
    
    pause;
    close all;
    
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
    %% be careful, there might be limited amount of data in no field recordings after aligning to run
    colorSel = 1;   
    plotCompPyrClu1RecFieldNoField(pathAnal, mod, modAlignedPyrStatsField, colorSel, clu1);
        
    %% compare neurons in the recordings with fields vs. in the recordings with no field in cluster 2
    %% be careful, there might be limited amount of data in no field recordings after aligning to run
    colorSel = 2;  
    plotCompPyrClu2RecFieldNoField(pathAnal, mod, modAlignedPyrStatsField, colorSel, clu2);
    
    %%
    plotClustersFields(pathAnal,mod.thetaModHist,mod.phaseMeanDire,...
        mod.idxC,mod.nNeuWithField > 1,...
        'Theta modulation (hist)','Theta phase mean direction','All tasks',...
        'Pyr_ThetaModHistVsThetaMean',colorArr);
    
    pause;
    close all;
end










