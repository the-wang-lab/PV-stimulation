function plotSequenceRunOnTNonStimStim(path, fileName, onlyRun, mazeSess, intervalT,neuSel)
% plot the sequence from one recording, align the sequence to different
% behavioral features
% e.g.: plotSequenceRunOnTNonStimStim('./','A107-20230731-01_DataStructure_mazeSection1_TrialType1',1,1,10,3)

    fullPath = [path fileName '_behPar_msess' num2str(mazeSess) '.mat']; 
    if(exist(fullPath) == 0)
        disp('The _behPar file does not exist');
        return;
    end
    load(fullPath);
    
    fullPath = [path fileName '_PeakFRAligned_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '.mat']; 
    if(exist(fullPath) == 0)
        disp('The _PeakFRAligned file does not exist');
        return;
    end
    load(fullPath,'trialNoNonStimGood','trialNoStim','trialNoStimCtrl','pulseMeth');
    
    fullPath = [path fileName '_FRAlignedRun_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '.mat']; 
    if(exist(fullPath) == 0)
        disp('The _PeakFRAligned file does not exist');
        return;
    end
    load(fullPath);
    
    indBadBeh = behPar.indTrBadBeh;
    for i = 1:length(trialNoStim)
        stimGoodTrials{i} = intersect(find(indBadBeh == 0),trialNoStim{i});
        stimCtrlGoodTrials{i} = intersect(find(indBadBeh == 0),trialNoStimCtrl{i});
        
        stimInterval = diff(trialNoStim{i});
        interval2 = sum(stimInterval == 2);
        interval3 = sum(stimInterval == 3);
        if(pulseMeth(i) == 4)
            if(interval2>interval3)
                trialNoStimCtrlTmp = trialNoStim{i}-1;
            else
                trialNoStimCtrlTmp = trialNoStim{i}-2;
            end
        else
            trialNoStimCtrlTmp = trialNoStim{i}-1;
        end
        trialNoStimCtrl2ndGood{i} = intersect(trialNoStimCtrlTmp,find(indBadBeh == 0));
    end
    
    fileNameCorr = [fileName '_meanSpikesCorrTAligned_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '_intT' ...
            num2str(intervalT) '.mat'];
    fullPath = [path fileNameCorr];
    if(exist(fullPath) == 0)
        disp('The _meanSpikesCorrTAligned_Run file does not exist');
        return;
    end    
    load(fullPath,'meanCorrTRun');
    
    GlobalConst;
    if(neuSel == 1)
        thrCorrT = 0.25;
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
    
    fullPath = [path fileName '_convSpikesAligned_msess' num2str(mazeSess) ...
        '_Run' num2str(onlyRun) '.mat'];
    if(exist(fullPath) == 0)
        disp('The _convSpikesAligned_Run file does not exist');
        return;
    end
    load(fullPath,'filteredSpikeArrayRun','filteredSpikeArrayRew','filteredSpikeArrayCue',...
            'timeStep');
    timeStep1 = timeStep;
    GlobalConst;
    
    mFRGood = mFRStructNonStimGood.mFR(neuronNo);
        
    avgFilteredSpikeArrayRunGood...
                = avgFilteredSpikeArray(filteredSpikeArrayRun,trialNoNonStimGood,neuronNo);
    avgFilteredSpikeArrayRewGood...
                = avgFilteredSpikeArray(filteredSpikeArrayRew,trialNoNonStimGood,neuronNo);
    avgFilteredSpikeArrayCueGood...
                = avgFilteredSpikeArray(filteredSpikeArrayCue,trialNoNonStimGood,neuronNo);
    
    for i = 1:length(trialNoStim)
        [~,~,indLap] = intersect(stimGoodTrials{i},mFRStructStim{i}.indLapList);
        mFRStimGood = mean(mFRStructStim{i}.mFRArr(neuronNo,indLap),2);
        [~,~,indLap] = intersect(stimCtrlGoodTrials{i},mFRStructStimCtrl{i}.indLapList);
        mFRStimCtrlGood = mean(mFRStructStimCtrl{i}.mFRArr(neuronNo,indLap),2);
        [~,~,indLap] = intersect(trialNoStimCtrl2ndGood{i},mFRStructStimCtrl{i}.indLapList);
        mFRStimCtrl2ndGood = mean(mFRStructStimCtrl{i}.mFRArr(neuronNo,indLap),2);
        
        avgFilteredSpikeArrayRunStim{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRun,stimGoodTrials{i},neuronNo);
        avgFilteredSpikeArrayRewStim{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRew,stimGoodTrials{i},neuronNo);
        avgFilteredSpikeArrayCueStim{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayCue,stimGoodTrials{i},neuronNo);
       
        avgFilteredSpikeArrayRunStimCtrl{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRun,stimCtrlGoodTrials{i},neuronNo);
        avgFilteredSpikeArrayRewStimCtrl{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRew,stimCtrlGoodTrials{i},neuronNo);
        avgFilteredSpikeArrayCueStimCtrl{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayCue,stimCtrlGoodTrials{i},neuronNo);
                
        avgFilteredSpikeArrayRunStimCtrl2nd{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRun,trialNoStimCtrl2ndGood{i},neuronNo);
        avgFilteredSpikeArrayRewStimCtrl2nd{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayRew,trialNoStimCtrl2ndGood{i},neuronNo);
        avgFilteredSpikeArrayCueStimCtrl2nd{i}...
                    = avgFilteredSpikeArray(filteredSpikeArrayCue,trialNoStimCtrl2ndGood{i},neuronNo);      
    end
            
    indPeak = zeros(1,length(neuronNo));
    for i = 1:length(neuronNo)
        [~,indPeakTmp] = max(avgFilteredSpikeArrayRunGood(i,:));
        indPeak(i) = indPeakTmp(1);
    end
    [~,indNeuronOrder] = sort(indPeak);
    avgFilteredSpikeArrayRunGood = avgFilteredSpikeArrayRunGood(indNeuronOrder,:);
    avgFilteredSpikeArrayRewGood = avgFilteredSpikeArrayRewGood(indNeuronOrder,:);
    avgFilteredSpikeArrayCueGood = avgFilteredSpikeArrayCueGood(indNeuronOrder,:);
    
    for i = 1:length(trialNoStim)
        avgFilteredSpikeArrayRunStim{i} = avgFilteredSpikeArrayRunStim{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayRewStim{i} = avgFilteredSpikeArrayRewStim{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayCueStim{i} = avgFilteredSpikeArrayCueStim{i}(indNeuronOrder,:);
        
        avgFilteredSpikeArrayRunStimCtrl{i} = avgFilteredSpikeArrayRunStimCtrl{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayRewStimCtrl{i} = avgFilteredSpikeArrayRewStimCtrl{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayCueStimCtrl{i} = avgFilteredSpikeArrayCueStimCtrl{i}(indNeuronOrder,:);
        
        avgFilteredSpikeArrayRunStimCtrl2nd{i} = avgFilteredSpikeArrayRunStimCtrl2nd{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayRewStimCtrl2nd{i} = avgFilteredSpikeArrayRewStimCtrl2nd{i}(indNeuronOrder,:);
        avgFilteredSpikeArrayCueStimCtrl2nd{i} = avgFilteredSpikeArrayCueStimCtrl2nd{i}(indNeuronOrder,:);
    end
            
    plotSequenceRunOnT_aligned(avgFilteredSpikeArrayRunGood,...
        avgFilteredSpikeArrayRewGood,avgFilteredSpikeArrayCueGood,...
        timeStep1/sampleFq,'Time (s)','Neuron No.','Firing rate good trials');
    indstr = strfind(fileName,'_');
    fileName1 = [fileName(1:indstr(1)-1) '-Seq-GoodTr' filenameEnd];
    savefig([fileName1 '.fig'])
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    if(~isempty(avgFilteredSpikeArrayRunStim))
        for i = 1:length(trialNoStim) 
            plotSequenceRunOnT_aligned(avgFilteredSpikeArrayRunStim{i},...
                avgFilteredSpikeArrayRewStim{i},avgFilteredSpikeArrayCueStim{i},...
                timeStep1/sampleFq,'Time (s)','Neuron No.',['Firing rate stim trials ' num2str(i)]);
            indstr = strfind(fileName,'_');
            fileName1 = [fileName(1:indstr(1)-1) '-Seq-StimTr' filenameEnd 'StimP' num2str(pulseMeth(i))];
            savefig([fileName1 '.fig'])
            print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
            
            plotSequenceRunOnT_aligned(avgFilteredSpikeArrayRunStimCtrl{i},...
                avgFilteredSpikeArrayRewStimCtrl{i},avgFilteredSpikeArrayCueStimCtrl{i},...
                timeStep1/sampleFq,'Time (s)','Neuron No.',['Firing rate stim ctrl trials P' num2str(pulseMeth(i))]);
            indstr = strfind(fileName,'_');
            fileName1 = [fileName(1:indstr(1)-1) '-Seq-StimTr' filenameEnd 'StimCtrlP' num2str(pulseMeth(i))];
            savefig([fileName1 '.fig'])
            print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
            
            plotSequenceRunOnT_aligned(avgFilteredSpikeArrayRunStimCtrl2nd{i},...
                avgFilteredSpikeArrayRewStimCtrl2nd{i},avgFilteredSpikeArrayCueStimCtrl2nd{i},...
                timeStep1/sampleFq,'Time (s)','Neuron No.',['Firing rate 2nd stim ctrl trials P' num2str(pulseMeth(i))]);
            indstr = strfind(fileName,'_');
            fileName1 = [fileName(1:indstr(1)-1) '-Seq-StimTr' filenameEnd 'StimCtrl2ndP' num2str(pulseMeth(i))];
            savefig([fileName1 '.fig'])
            print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
        end
    end
end

function [avgFilteredSpikeArr]...
                = avgFilteredSpikeArray(filteredSpikeArr,indTr,neuronNo)
    lenTr = size(filteredSpikeArr{1},2);
    nTrials = length(indTr);
    nNeurons = length(neuronNo);
    avgFilteredSpikeArr = zeros(nNeurons,lenTr);
    for i = 1:nNeurons
        avgFilteredSpikeTmp = zeros(1,lenTr);
        for j = 1:nTrials
            avgFilteredSpikeTmp = avgFilteredSpikeTmp + filteredSpikeArr{neuronNo(i)}(indTr(j),:);
        end
        avgFilteredSpikeArr(i,:) = avgFilteredSpikeTmp/nTrials/max(avgFilteredSpikeTmp);
    end      
end

function plotSequenceRunOnT_aligned(arr1,arr2,arr3,timeStep,xl,yl,title)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 600   280],'Name',title)
    nNeurons = size(arr1,1);
    subplot(1,3,1)
    imagesc(timeStep,1:nNeurons,arr1);
    colormap jet
    set(gca,'XLim',[0 5])
    xlabel(xl);
    ylabel(yl);
    
    subplot(1,3,2)
    imagesc(timeStep,1:nNeurons,arr2);
    colormap jet
    set(gca,'XLim',[0 5])
    xlabel(xl);
    
    subplot(1,3,3)
    imagesc(timeStep,1:nNeurons,arr3);
    colormap jet
    set(gca,'XLim',[0 5])
    xlabel(xl);
end