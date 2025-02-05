function plotSequenceDistOverTrials(path, fileName, onlyRun, mazeSess, intervalT, spaceBin, neuSel, trSel)
% plot the sequence from one recording, align the sequence to different
% behavioral features

    fullPath = [path fileName '_behPar_msess' num2str(mazeSess) '.mat']; 
    if(exist(fullPath) == 0)
        disp('The _behPar file does not exist');
        return;
    end
    load(fullPath);
    
    indBadBeh = behPar.indTrBadBeh;
    
    goodTrials = find(indBadBeh == 0);
    badTrials = find(indBadBeh == 1);
    disp(['Number of good trials = ' num2str(length(goodTrials))]);
    
    fileNameCorr = [fileName '_meanSpikesCorrTAligned_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '_intT' ...
            num2str(intervalT) '.mat'];
    fullPath = [path fileNameCorr];
    if(exist(fullPath) == 0)
        disp('The _meanSpikesCorrTAligned_Run file does not exist');
        return;
    end    
    load(fullPath,'meanCorrTRun');
    
    indRecName = strfind(fileName, '_');
    fileNameBehElec = [fileName(1:indRecName) 'BehavElectrDataLFP.mat'];
            
    fullPath = [path fileNameBehElec];
    if(exist(fullPath) == 0)
        disp('The recording BehElectDataLFP file does not exist.');
        disp(fullPath)
        return;
    end
    load(fullPath,'Laps');
    indTrRun = find(Laps.mazeSess == mazeSess);
    
    fileNameCorr = [fileName '_alignRun_msess' num2str(mazeSess) '.mat'];
    fullPath = [path fileNameCorr];
    if(exist(fullPath) == 0)
        disp('The _alignRun_msess file does not exist');
        return;
    end    
    load(fullPath,'trialsRun');
    
    GlobalConst;
    if(neuSel == 1)
        thrCorrT = 0.2;
        indSelCorrT = selPyrNeurons(path,fileName,onlyRun,minFR);
        indSelCorrT = meanCorrTRun.meanGood > thrCorrT & indSelCorrT;
        neuronNo = find(indSelCorrT == 1);
        filenameEnd = '_CorrT';
    elseif(neuSel == 2)
        neuronNo = [2 6 8 18 25 30 40 41 47 51 55 57 67 68 69 71 72 73 77 78 84];
        filenameEnd = '_Sel';
    else
        fileNameFW = [fileName '_FieldSpCorrAligned_Run' num2str(mazeSess) ...
                            '_Run' num2str(onlyRun) '.mat'];
        fullPath = [path fileNameFW];
        if(exist(fullPath) == 0)
            disp('The _FieldSpCorrAligned_Run file does not exist');
            return;
        end
        load(fullPath,'fieldSpCorrSessNonStimGood');
        neuronNo = fieldSpCorrSessNonStimGood.indNeuron;
        filenameEnd = '_Field';
    end
    
    fullPath = [path fileName '.mat'];
    if(exist(fullPath) == 0)
        disp('The recording file does not exist');
        return;
    end
    load(fullPath,'trials');
    
    fullPath = [path fileName '_convSpikesDist' num2str(spaceBin) ...
                    'mm_Run' num2str(onlyRun) '.mat'];
    if(exist(fullPath) == 0)
        disp('The _convSpikesDist file does not exist');
        return;
    end
    load(fullPath,'filteredSpikeArrayNormT','paramC');
    GlobalConst;
    
    avgFilteredSpikeArrayRunGood...
                = avgFilteredSpikeArray(filteredSpikeArrayNormT,goodTrials,neuronNo);
    
    if(sum(diff(goodTrials(trSel)) > 1))
        disp(['trial no.' num2str(goodTrials(trSel))]);
        return;
    end
    if(onlyRun == 1)
        minSpeed = minSpeed;
    else
        minSpeed = 0;
    end
    [spikeArrayMMRunGood,spikeArrayTRunGood,totT,totD,totTArr,totDArr,totTRunOnArr]...
                = spikeArrayOverTrials(trials,indTrRun(goodTrials(trSel)),neuronNo,sampleFq,minSpeed,trialsRun.startLfpInd(goodTrials(trSel)));
            
    indPeak = zeros(1,length(neuronNo));
    for i = 1:length(neuronNo)
        [~,indPeakTmp] = max(avgFilteredSpikeArrayRunGood(i,:));
        indPeak(i) = indPeakTmp(1);
    end
    [~,indNeuronOrder] = sort(indPeak);
    spikeArrayMMRunGood = spikeArrayMMRunGood(indNeuronOrder);
    spikeArrayTRunGood = spikeArrayTRunGood(indNeuronOrder);
           
    plotSequenceDist1(spikeArrayMMRunGood,'Dist (cm)','Neuron No.','',totD,totDArr);
    indstr = strfind(fileName,'_');
    fileName1 = [fileName(1:indstr(1)-1) '-SeqDist-GoodTr' num2str(goodTrials(trSel(1))) ...
        '-' num2str(goodTrials(trSel(end))) filenameEnd];
    savefig([path fileName1 '.fig'])
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    plotSequenceDist1(spikeArrayTRunGood,'Time (s)','Neuron No.','',totT,totTArr);
    for i=1:length(totTRunOnArr)
        h = plot([totTRunOnArr(i) totTRunOnArr(i)],[0 length(spikeArrayTRunGood)+1],'m-')
        set(h,'LineWidth',2);
    end
    indstr = strfind(fileName,'_');
    fileName1 = [fileName(1:indstr(1)-1) '-SeqTime-GoodTr' num2str(goodTrials(trSel(1))) ...
        '-' num2str(goodTrials(trSel(end))) filenameEnd];
    savefig([path fileName1 '.fig'])
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    [spikeArrayMMRunGood,spikeArrayTRunGood,totT,totD,totTArr,totDArr,totTRunOnArr]...
                = spikeArrayOverTrials(trials,indTrRun(goodTrials(trSel)),neuronNo,sampleFq,0,trialsRun.startLfpInd(goodTrials(trSel)));
    spikeArrayMMRunGood = spikeArrayMMRunGood(indNeuronOrder);
    spikeArrayTRunGood = spikeArrayTRunGood(indNeuronOrder);
            
    plotSequenceDist1(spikeArrayMMRunGood,'Dist (cm)','Neuron No.','',totD,totDArr);
    indstr = strfind(fileName,'_');
    fileName1 = [fileName(1:indstr(1)-1) '-SeqDist-GoodTr' num2str(goodTrials(trSel(1))) ...
        '-' num2str(goodTrials(trSel(end))) filenameEnd '-Run0'];
    savefig([path fileName1 '.fig'])
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    plotSequenceDist1(spikeArrayTRunGood,'Time (s)','Neuron No.','',totT,totTArr);
    for i=1:length(totTRunOnArr)
        h = plot([totTRunOnArr(i) totTRunOnArr(i)],[0 length(spikeArrayTRunGood)+1],'m-')
        set(h,'LineWidth',2);
    end
    indstr = strfind(fileName,'_');
    fileName1 = [fileName(1:indstr(1)-1) '-SeqTime-GoodTr' num2str(goodTrials(trSel(1))) ...
        '-' num2str(goodTrials(trSel(end))) filenameEnd '-Run0'];
    savefig([path fileName1 '.fig'])
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
end

function [avgFilteredSpikeArr]...
                = avgFilteredSpikeArray(filteredSpikeArr,indTr,neuronNo)
    lenTr = size(filteredSpikeArr{2},2);
    nTrials = length(indTr);
    nNeurons = length(neuronNo);
    avgFilteredSpikeArr = zeros(nNeurons,lenTr);
    for i = 1:nNeurons
        avgFilteredSpikeTmp = zeros(1,lenTr);
        for j = 1:nTrials
            if(isempty(filteredSpikeArr{indTr(j)}))
                continue;
            end
            avgFilteredSpikeTmp = avgFilteredSpikeTmp + filteredSpikeArr{indTr(j)}(neuronNo(i),:);
        end
        avgFilteredSpikeArr(i,:) = avgFilteredSpikeTmp/nTrials/max(avgFilteredSpikeTmp);
    end      
end

function [spikeArrMM,spikeArrT,totT,totD,totTArr,totDArr,totTRunOnArr]...
                = spikeArrayOverTrials(trials,indTr,neuronNo,sampleFq,minSpeed,runStartLfp) 
    nTrials = length(indTr);
    nNeurons = length(neuronNo);
    spikeArrMM = cell(1,nNeurons);
    spikeArrT = cell(1,nNeurons);
    totTArr = zeros(1,length(indTr));
    totDArr = zeros(1,length(indTr));
    totTRunOnArr = zeros(1,length(indTr));
    totT = 0;
    totD = 0;
    for i = 1:nNeurons
        for j = 1:nTrials
            idx = trials{indTr(j)}.spikesSpeed{neuronNo(i)} > minSpeed;
            if(j == 1)
                spikeArrMM{i} = trials{indTr(j)}.spikesMM{neuronNo(i)}(idx)'/10;
                spikeArrT{i} = trials{indTr(j)}.spikes{neuronNo(i)}(idx)'/sampleFq;
                totT = trials{indTr(j)}.Nsamples/sampleFq;
                totD = trials{indTr(j)}.xMM(end)/10;
            else
                spikeArrMM{i} = [spikeArrMM{i} trials{indTr(j)}.spikesMM{neuronNo(i)}(idx)'/10+totD];
                spikeArrT{i} = [spikeArrT{i} trials{indTr(j)}.spikes{neuronNo(i)}(idx)'/sampleFq+totT];
                totT = totT + trials{indTr(j)}.Nsamples/sampleFq;
                totD = totD + trials{indTr(j)}.xMM(end)/10;
            end
            totTArr(j) = totT;
            totDArr(j) = totD;
            totTRunOnArr(j) = (runStartLfp(j)-trials{indTr(1)}.lfpIndStart)/sampleFq;
        end
    end      
end

function plotSequenceDist1(arr1,xl,yl,title,xL,xLArr)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 600 280],'Name',title)
    nNeurons = length(arr1);
    hold on;
    for i = 1:nNeurons
        plot(arr1{i},i*ones(1,length(arr1{i})),'k.',...
                 'MarkerSize',5);  
    end
    for i=1:length(xLArr)-1
        h = plot([xLArr(i) xLArr(i)],[0 nNeurons+1],'r-')
        set(h,'LineWidth',2);
    end
    set(gca,'XLim',[0 xL],'YLim',[0 nNeurons+1])
    xlabel(xl);
    ylabel(yl);
   
end
