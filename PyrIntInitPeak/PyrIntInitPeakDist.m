function PyrIntInitPeakDist(taskSel)
% plot heatmap for all pyramidal neurons and sequence over distance
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    pathAnalInt0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    if(exist([pathAnalInt0 'initPeakIntAllRec.mat']))
        load([pathAnalInt0 'initPeakIntAllRec.mat']);
    end
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
       
    if(taskSel == 1) % including all the neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeak\';
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakALPL\';
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAL\';
    end
    if(exist([pathAnal 'initPeakPyrIntAllRec.mat']))
        load([pathAnal 'initPeakPyrIntAllRec.mat']);
    end
    
    InitAllDist = PyrIntInitPeakDistByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    modInt1NoCue,modInt1AL,modInt1PL);
    
    %% pyramidal rise and down ordered based on InitAll
    mean0to1 = mean(InitAll.avgFRProfile(:,FRProfileMean.indFR0to1),2);
    meanBefRun = mean(InitAll.avgFRProfile(:,FRProfileMean.indFRBefRun),2);
    ratio0to1BefRun = mean0to1./meanBefRun;
    [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
      
    %% order pyramidal neurons based on the bef and after firing rate ratio
    plotIndFRProfile(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNorm,indOrd,['Neurons No'],...
            ['Pyr_IndFRProfileNormFRDistFR0to1VsBefRunNeu'],...
            pathAnal,[])
        
    %% bad trial,order pyramidal neurons based on the bef and after firing rate ratio
    plotIndFRProfile(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistBadAllNorm,indOrd,['Neurons No'],...
            ['Pyr_IndFRProfileNormFRDistFR0to1VsBefRunNeuBadAll'],...
            pathAnal,[])
        
    %% average profile good vs bad trials
    plotAvgFRProfileCmp(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDist(PyrRise.idxRise,:),...
            InitAllDist.avgFRProfileDistBad(PyrRise.idxRiseBadBad,:),...
            ['FR PyrRise Good/Bad'],...
            ['Pyr_FRProfilePyrRiseDistGoodBad'],...
            pathAnal,[0 2.6],[{'Good'} {'Bad'}])
        
    plotAvgFRProfileCmp(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDist(PyrRise.idxDown,:),...
            InitAllDist.avgFRProfileDistBad(PyrRise.idxDownBadBad,:),...
            ['FR PyrDown Good/Bad'],...
            ['Pyr_FRProfilePyrDownDistGoodBad'],...
            pathAnal,[0 2.6],[{'Good'} {'Bad'}])
        
        
    %% order pyramidal neurons with field based on the peak firing rate after 0s
    indTmp = modPyr1NoCue.timeStepRun > 0;
    [~,indMax] = max(InitAll.avgFRProfile(InitAll.isNeuWithFieldAligned == 1,indTmp)');
    [~,indOrd] = sort(indMax,'descend');
    plotIndFRProfile(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNorm(InitAll.isNeuWithFieldAligned == 1,:),indOrd,['Neurons No'],...
            ['Pyr_IndFRProfileDistNormFRPeakAftRunNeuField'],...
            pathAnal,[])
            
    indNeuField = find(InitAll.isNeuWithFieldAligned == 1);
    indIndFieldGood = [];
    indFieldBad = [];
    indFieldGood = [];
    for i = 1:length(indNeuField)
        indTmp = find(InitAll.taskBad == InitAll.task(indNeuField(i)) & ...
            InitAll.indRecBad == InitAll.indRec(indNeuField(i)) & ...
            InitAll.indNeuBad == InitAll.indNeu(indNeuField(i)));
        if(~isempty(indTmp))
            indIndFieldGood = [indIndFieldGood; i];
            indFieldBad = [indFieldBad; indTmp];
            indFieldGood = [indFieldGood; indNeuField(i)];
        end
    end
    %% ordered by time peak
    indTmp = modPyr1NoCue.timeStepRun > 0;
    [~,indMax] = max(InitAll.avgFRProfileNorm(indFieldGood,indTmp)');
    [~,indOrd] = sort(indMax,'descend');
    plotIndFRProfileProvOrder(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNormBad(indFieldBad,:),['Neuron No. Bad (good order time)'],...
            ['Pyr_IndFRProfileNormFRDistPeakAftRunNeuFieldBad_GoodOrder'],...
            pathAnal,indOrd);
    plotIndFRProfileProvOrder(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNorm(indFieldGood,:),['Neuron No. (good order time)'],...
            ['Pyr_IndFRProfileNormFRDistPeakAftRunNeuField_BadSelGoodOrder'],...
            pathAnal,indOrd); 
        
    % ordered by distance peak
    indTmp = modPyr1NoCue.timeStepRun > 0;
    [~,indMax] = max(InitAllDist.avgFRProfileDistNorm(indFieldGood,indTmp)');
    [~,indOrd] = sort(indMax,'descend');
    plotIndFRProfileProvOrder(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNormBad(indFieldBad,:),['Neuron No. Bad (good order dist)'],...
            ['Pyr_IndFRProfileNormFRDistPeakAftRunNeuFieldBad_GoodOrderDistPeak'],...
            pathAnal,indOrd);
    plotIndFRProfileProvOrder(modPyr1NoCue.spaceSteps/10,...
            InitAllDist.avgFRProfileDistNorm(indFieldGood,:),['Neuron No. (good order dist)'],...
            ['Pyr_IndFRProfileNormFRDistPeakAftRunNeuField_BadSelGoodOrderDistPeak'],...
            pathAnal,indOrd); 
end


function plotIndFRProfile(timeStepRun,avgFRProfile,indOrd,yl,fileName,pathAnal,ylimit)
    if(isempty(avgFRProfile))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400]);
    numNeurons = size(avgFRProfile,1);
    
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile(indOrd,:));
%     set(h,'LineWidth',0.1)
    set(gca,'XLim',[0 180]);
%     if(~isempty(ylimit))
%         set(gca,'YLim',ylimit);
%     else
%         set(gca,'YLim',[min(avgFRProfile(:)) max(avgFRProfile(:))]);
%     end
    xlabel('Distance (cm)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end

function plotIndFRProfileProvOrder(timeStepRun,avgFRProfile,yl,fileName,pathAnal,indOrd)
    if(isempty(avgFRProfile))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400]);
    numNeurons = size(avgFRProfile,1);
    
    h = imagesc(timeStepRun,1:numNeurons,avgFRProfile(indOrd,:));
%     set(h,'LineWidth',0.1)
    set(gca,'XLim',[0 180]);
%     if(~isempty(ylimit))
%         set(gca,'YLim',ylimit);
%     else
%         set(gca,'YLim',[min(avgFRProfile(:)) max(avgFRProfile(:))]);
%     end
    xlabel('Distance (cm)')
    ylabel(yl)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end

