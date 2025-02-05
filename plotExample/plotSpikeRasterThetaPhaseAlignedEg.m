function plotSpikeRasterThetaPhaseAlignedEg(path, fileName, onlyRun, mazeSess, trialNo, neuronNo)
% plot spikes rasters across run segments
% E.G.: plotSpikeRasterThetaPhaseEg('./','A007-20190116-01_DataStructure_mazeSection1_TrialType1',1,[1:49],36)

    if(nargin == 3)
        trialNo = [];
        neuronNo = [];
    elseif(nargin == 4)
        neuronNo = [];
    end

    %%%%%%%%% load recording file
    fullPath = [path fileName '_alignedSpikesPerNPerT_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '.mat'];  
    if(exist(fullPath) == 0)
        disp('The _alignedSpikesPerNPerT_msess file does not exist');
        return;
    end
    load(fullPath,'trialsRunSpikes');
    
    fullPath = [path fileName '.mat']; 
    if(exist(fullPath) == 0)
        disp('The recording file does not exist');
        return;
    end
    load(fullPath,'cluList');
    if(isempty(neuronNo))
        neuronNo = 1:length(cluList.all);
    end
    if(isempty(trialNo))
        trialNo = 1:length(trialsRun);
    end
    
    GlobalConst;
    
    trialLen = 4; %sec

    for i = neuronNo
        disp(['Neuron ' num2str(i)]);
        [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = 'Spikes vs Time';
%             figTitle = 'Spikes vs Dist';
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 280 280],'Name',figTitle)
        
        hold on;
        thetaPhase = [];
        time = [];
        for j = 1:length(trialNo)   
            indTr = trialNo(j);
            thetaPhase = [thetaPhase; trialsRunSpikes.thPhaseInterpSpike{i,indTr}];
            time = [time; trialsRunSpikes.Time{i,indTr}/sampleFq];                 
        end
        [thetaDistDouble,thetaSpikesDouble] = ...
            getMultiCycles(time,thetaPhase,2);
        plot(thetaDistDouble,thetaSpikesDouble,'k.',...
                 'MarkerSize',3);
             
        set(gca, 'XLim', [0 trialLen],'YLim', [0 720],'YTick', [0 360 720]);
        ylabel('Theta phase (deg.)');
        xlabel('Time (s)');
        figTitle = ['Neu ' num2str(i) '(' num2str(cluList.shank(i))...
                    ' ' num2str(cluList.localClu(i)) ')'];
        title(figTitle);
        
        ind = strfind(fileName,'_');
        fileName1 = ['Z:\Yingxue\DataAnalysisRaphi\' ...
            fileName(1:ind(1)) 'Neu' num2str(i) '_SpikeRasterThetaAligned'];
        saveas(gcf,fileName1);
        print('-painters', '-dpdf', fileName1, '-r600')
    end