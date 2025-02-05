function probDistrActivityCorr(pathAnal,recType,onlyRun)
% plot the distribution of neuronal activity correlation over all the trials
% for each neuron
% default analysis path ['Z:\Raphael_tests\mice_expdata\Analysis\'];
% e.g. probDistrActivityCorr('Z:\Raphael_tests\mice_expdata\Analysis\',1,1)


    RecordingListPyrInt;
    if(recType == 1) 
        recListPath = listRecordingsPassiveLickPath;
        recListFileName = listRecordingsPassiveLickFileName;
        recListSess = mazeSessionPassiveLick;
    elseif(recType == 2)
        recListPath = listRecordingsActiveLickPath;
        recListFileName = listRecordingsActiveLickFileName;
        recListSess = mazeSessionActiveLick;
    elseif(recType == 3)
        % passive no cue
        recListPath = listRecordingsNoCuePath;
        recListFileName = listRecordingsNoCueFileName;
        recListSess = mazeSessionNoCue;
    end
    recListLen = size(recListPath,1);
    
    GlobalConstFq;
    param.minCorr = 0.015;
    param.percActiveTr = 0.4;
    
    for i = 1:recListLen
        fullPath = [recListPath(i,:) recListFileName(i,:) ...
            '_behPar_msess' num2str(recListSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The _behPar file does not exist');
            return;
        end
        load(fullPath);

        %% load activity correlation in distance file
        fullPath = [recListPath(i,:) recListFileName(i,:) ...
            '_spikesCorrDist_Ctrl_Run' num2str(onlyRun) ...
            '_mazeSess' num2str(recListSess(i)) '.mat'];
        if(exist(fullPath,'file') == 2)
            load(fullPath,'spikeCorrDistCtrl','nonZeroCtrl');    
        end

        %% indices of good trials
        indBadTr = behPar.indTrBadBeh;
            % remove the nonstopping criteria 
        indGoodTr = find(indBadTr == 0);
        numGoodTr = length(indGoodTr);
        totNumCorr = (numGoodTr*numGoodTr-numGoodTr)/2;
        recListActivityCorr.indGoodTr = indGoodTr;
        
        %% calculate mean correlation of good trials for each neuron
        neuronNo = size(spikeCorrDistCtrl,2);
        recListActivityCorr.meanNZ{i} = zeros(1,neuronNo);
        recListActivityCorr.mean{i} = zeros(1,neuronNo);
        recListActivityCorr.nNonZeroTr{i} = zeros(1,neuronNo);
        for n = 1:neuronNo            
            corrArr = triu(spikeCorrDistCtrl{n}(indGoodTr,indGoodTr),1);
            corrArr = corrArr(:); 
            recListActivityCorr.mean(n) = sum(corrArr(isnan(corrArr) == 0))/totNumCorr;
            nNonZeroTr = sum(nonZeroCtrl{n} == 1);
            nElemNonZero = (nNonZeroTr*nNonZeroTr-nNonZeroTr)/2;
            recListActivityCorr.meanNZ{i}(n) = sum(corrArr(isnan(corrArr) == 0))/nElemNonZero;
            recListActivityCorr.nNonZeroTr{i}(n) = nNonZeroTr;
        end

        fullPath = [recListPath(i,:) recListFileName(i,:) ...
            '_SpInfo_Ctrl_Run' num2str(onlyRun) '_mazeSess' ...
            num2str(recListSess(i)) '.mat'];
        if(exist(fullPath,'file') == 2)
            load(fullPath,'spatialInfoSessCtrl');     
        end
        spatialInfo = spatialInfoSessCtrl;
                
        meanFR = spatialInfo.meanFR;
        indGoodFR = meanFR > minFR & meanFR < maxFR; %% all the pyramidal neurons
        indGoodNeu = meanFR > minFR & meanFR < maxFR & ...
            activityCorr.meanCorrActiveTrPerNeu >= param.minCorr & ...
            activityCorr.activeTr/length(activityCorr.indLaps) > param.percActiveTr & ...
            numGoodTr >= minNumGoodTr; %% all the pyramidal neurons with enough active trials and good trials
        
        recListActivityCorr.percGoodPyrNeuPerRec(i) = ...
            sum(indGoodNeu)/sum(indGoodFR); % perc. of good pyramidal neurons
        recListActivityCorr.meanCorrNZTrPyrPerRec(i) = ...
            mean(recListActivityCorr.meanNZ{i}(indGoodFR)); 
                % mean correlation of all the pyramidal neurons of one
                % recording (non zero trials)
        recListActivityCorr.stdCorrNZTrPyrPerRec(i) = ...
            std(recListActivityCorr.meanNZ{i}(indGoodFR));
                % std of correlation of all the pyramidal neurons of one
                % recording (non zero trials)
        
        if(sum(indGoodNeu) > 0)
            recListActivityCorr.meanCorrNZTrGoodPyrPerRec(i) = ...
                mean(recListActivityCorr.meanNZ{i}(indGoodNeu));
                % mean correlation of all the good pyramidal neurons of one
                % recording (non zero trials)
            recListActivityCorr.stdCorrNZTrGoodPyrPerRec(i) = ...
                std(recListActivityCorr.meanNZ{i}(indGoodNeu));
                % std of correlation of all the good pyramidal neurons of one recording (non zero trials)
        end
        
        recListActivityCorr.indRec = ...
            [recListActivityCorr.indRec ones(1,sum(indGoodFR))*i];    
                % recording number of each pyramidal cell
        recListActivityCorr.indPyrNeu = ...
            [recListActivityCorr.indPyrNeu find(indGoodFR)];
                % neuron no. of each pyramidal cell
        
        recListActivityCorr.indRecGoodNeu = ...
            [recListActivityCorr.indRecGoodNeu ones(1,sum(indGoodNeu))*i];     
                % recording number of each good pyramidal cell
        recListActivityCorr.indPyrGoodNeu = ...
            [recListActivityCorr.indPyrGoodNeu find(indGoodNeu)];
                % neuron no. of each good pyramidal cell 
        
        recListActivityCorr.meanCorrNZTrPerNeu = ...
            [recListActivityCorr.meanCorrNZTrPerNeu ...
            recListActivityCorr.meanNZ{i}(indGoodFR)];
                % correlation of each pyramidal neurons (non zero trials) 
        recListActivityCorr.meanCorrAllTrPerNeu = ...
            [recListActivityCorr.meanCorrAllTrPerNeu ...
            recListActivityCorr.mean{i}(indGoodFR)];
                % correlation of each pyramidal neurons (all the trials) 
        recListActivityCorr.meanCorrNZTrPerGoodPyr = ...
            [recListActivityCorr.meanCorrNZTrPerGoodPyr ...
            recListActivityCorr.meanNZ{i}(indGoodNeu)];
                % correlation of each good pyramidal neurons (non zero trials) 
        recListActivityCorr.meanCorrAllTrPerGoodPyr = ...
            [recListActivityCorr.meanCorrAllrPerGoodPyr ...
            recListActivityCorr.mean{i}(indGoodNeu)];
                % correlation of each good pyramidal neurons (all the trials) 
        
        recListActivityCorr.meanFRPerNeu = ...
            [recListActivityCorr.meanFRPerNeu ...
            meanFR(indGoodFR)];
            % mean FR for each pyr neuron
        
        recListActivityCorr.spatialInfoPerNeu = ...
            [recListActivityCorr.spatialInfoPerNeu ...
            spatialInfo.spatialInfo(indGoodFR)];
        recListActivityCorr.adaptSpatialInfoPerNeu = ...
            [recListActivityCorr.adaptSpatialInfoPerNeu ...
            spatialInfo.adaptSpatialInfo(indGoodFR)];
        recListActivityCorr.sparsityPerNeu = ...
            [recListActivityCorr.sparsityPerNeu ...
            spatialInfo.sparsity(indGoodFR)];
        recListActivityCorr.SNRPerNeu = ...
            [recListActivityCorr.SNRPerNeu ...
            spatialInfo.SNR(indGoodFR)];
            % spatial information for each pyr neuron
            
        recListActivityCorr.meanFRPerGoodPyr = ...
            [recListActivityCorr.meanFRPerGoodPyr ...
            meanFR(indGoodNeu)];
            % mean FR for each good pyr neuron
        
        recListActivityCorr.spatialInfoPerGoodPyr = ...
            [recListActivityCorr.spatialInfoPerGoodPyr ...
            spatialInfo.spatialInfo(indGoodNeu)];
        recListActivityCorr.adaptSpatialInfoPerGoodPyr = ...
            [recListActivityCorr.adaptSpatialInfoPerGoodPyr ...
            spatialInfo.adaptSpatialInfo(indGoodNeu)];
        recListActivityCorr.sparsityPerGoodPyr = ...
            [recListActivityCorr.sparsityPerGoodPyr ...
            spatialInfo.sparsity(indGoodNeu)];
        recListActivityCorr.SNRPerGoodPyr = ...
            [recListActivityCorr.SNRPerGoodPyr ...
            spatialInfo.SNR(indGoodNeu)];
            % spatial information for each good pyr neuron
        
    end
    
    if(exist(pathAnal,'dir') == 0)
        mkdir(pathAnal);
    end
    fullPath = [pathAnal 'recList' num2str(recType)...
        '_activityCorrNeu_Run' num2str(onlyRun) '.mat'];
    save(fullPath,'recListActivityCorr','param','recListPath','recListFileName');
        
    % activity correlation over dist
    xlabelTmp = 'Corr. neuronal activity over good trials';
    if(recType == 1)
        titleTmp = ['Passive licking (num. neurons ' ...
            num2str(length(recListActivityCorr.indPyrNeu)) ')'];
    elseif(recType == 2)
        titleTmp = ['Active licking (num. neurons ' ...
            num2str(length(recListActivityCorr.indPyrNeu)) ')'];
    elseif(recType == 3)
        titleTmp = ['Passive no cue (num. neurons ' ...
            num2str(length(recListActivityCorr.indPyrNeu)) ')'];
    end
%     plotHist(recListActivityCorr.meanCorrGoodTrPerNeu,-0.025:0.0025:0.35,1,...
%         xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'CorrActivityPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'CorrActivityActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'CorrActivityPassiveNoCue'],'-dpdf','-r600');
%     end
%     
%     % activity correlation over time
%     xlabelTmp = 'CorrT. neuronal activity over good trials';
% 
%     plotHist(recListActivityCorr.meanCorrTGoodTrPerNeu,-0.025:0.0025:0.35,1,...
%         xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'CorrTActivityPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'CorrTActivityActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'CorrTActivityPassiveNoCue'],'-dpdf','-r600');
%     end
%     
%     % activity similarity over time
%     xlabelTmp = 'SimT. neuronal activity over trials';
% 
%     plotHist(recListActivityCorr.meanSimTActiveTrPerNeu,-0.025:0.0025:0.35,1,...
%         xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'SimTActivityPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'SimTActivityActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'SimTActivityPassiveNoCue'],'-dpdf','-r600');
%     end

%     % meanFR
%     xlabelTmp = 'Mean firing rate (Hz)';
% 
%     plotHist(recListActivityCorr.meanFRActiveTrPerNeu,...
%         [param.minFR:0.025:param.maxFR],1,...
%         xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'MeanFRPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'MeanFRActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'MeanFRPassiveNoCue'],'-dpdf','-r600');
%     end
% 
%     % spatial info
%     xlabelTmp = 'Spatial infomation';
%     
%     plotHist(recListActivityCorr.spatialInfoPerNeu,...
%         [min(recListActivityCorr.spatialInfoPerNeu)-0.1:0.025:...
%             max(recListActivityCorr.spatialInfoPerNeu)+0.1],...
%         1,xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'SpatInfoPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'SpatInfoActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'SpatInfoPassiveNoCue'],'-dpdf','-r600');
%     end
%     
%     % adapt spatial info
%     xlabelTmp = 'Adapt spatial infomation';
%     
%     plotHist(recListActivityCorr.adaptSpatialInfoPerNeu,...
%         [min(recListActivityCorr.adaptSpatialInfoPerNeu)-0.1:0.04:...
%             max(recListActivityCorr.adaptSpatialInfoPerNeu)+0.1],...
%         1,xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'AdaptSpatInfoPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'AdaptSpatInfoActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'AdaptSpatInfoPassiveNoCue'],'-dpdf','-r600');
%     end
%     
%     % sparsity
%     xlabelTmp = 'Sparsity';
% 
%     plotHist(recListActivityCorr.sparsityPerNeu,...
%         [min(recListActivityCorr.sparsityPerNeu)-0.1:0.07:...
%             max(recListActivityCorr.sparsityPerNeu)+0.1],...
%         1,xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'SparsityPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'SparsityActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'SparsityPassiveNoCue'],'-dpdf','-r600');
%     end
%     
%     % SNR
%     xlabelTmp = 'SNR';
%     
%     plotHist(recListActivityCorr.SNRPerNeu,...
%         [min(recListActivityCorr.SNRPerNeu)-0.1:0.1:...
%             max(recListActivityCorr.SNRPerNeu)+0.1],...
%         1,xlabelTmp,titleTmp);
%     if(recType == 1)
%         print([pathAnal 'SNRPassive'],'-dpdf','-r600');
%     elseif(recType == 2)
%         print([pathAnal 'SNRActive'],'-dpdf','-r600');
%     elseif(recType == 3)
%         print([pathAnal 'SNRPassiveNoCue'],'-dpdf','-r600');
%     end
    
end

function plotHist(data,centerpoints,ismean,xl,t)
    fig = figure;
    fig.Renderer = 'Painters';
    [counts,centers] = hist(data,centerpoints);
    prob = counts/length(data);
    h = bar(centers,prob,0.9);
    set(h,'EdgeColor',[0.3 0.3 0.3],'FaceColor',[0.5 0.5 0.5]);
    if(ismean == 0)
        meanData = prctile(data,95); 
    else
        meanData = mean(data(~isnan(data))); 
    end
    hold
    h = plot([meanData meanData],[0 max(prob)+0.02],'r:');
    set(h,'LineWidth',1.5);
    set(gca,'FontSize',14,'YLim',[0 max(prob)+0.02]);
    xlabel(xl);
    ylabel('Prob.')
    title(t);
end

