function PyrIntInitPeak_LongShortTr(taskSel,speedMode)
% compare PyrRise and PyrDown neurons with different trial length
% speedMode = 0, matching mean speed
% speedMode = 1, matching the speed between 1 to 2 sec
% speedMode = 2, matching the speed between -1 to 0 sec. It turns out that
% most of the long trials has a short stop time before run

    if(taskSel == 1) % including all the neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeak\';
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\'];s
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakALPL\';
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakALPL\2\'];
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAL\';
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalInitPeakAL\2\'];
    end
    
    GlobalConstFq;
    minNumTr = 15; % minimum number of trials of a recording to be considered
    
    if(exist([pathAnal 'initPeakPyrIntAllRec.mat']))
        load([pathAnal 'initPeakPyrIntAllRec.mat'],'InitAll','PyrRise','PyrDown','PyrOther');
    end
    
    load([pathAnal0 'initPeakPyrAllRec_LongShortTr.mat'],'modPyr2NoCue','modPyr2AL','modPyr2PL');

    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    InitAll1 = PyrIntInitPeakByType(taskSel,modPyr2NoCue,modPyr2AL,modPyr2PL);
    if(length(InitAll.task) ~= length(InitAll1.task))
        disp('InitAll and InitAll1 contain different number of neurons. quit.');
        return;
    end
    
    PyrRise1.idxRise = PyrRise.idxRise;
    PyrRise1.task = PyrRise.task;
    PyrRise1.indRec = PyrRise.indRec;
    PyrRise1.indNeu = PyrRise.indNeu;
    PyrRise1.avgFRProfileShort = InitAll1.avgFRProfileShort(PyrRise1.idxRise,:);
    PyrRise1.avgFRProfileLong = InitAll1.avgFRProfileLong(PyrRise1.idxRise,:);
    
    PyrDown1.idxDown = PyrDown.idxDown;
    PyrDown1.task = PyrDown.task;
    PyrDown1.indRec = PyrDown.indRec;
    PyrDown1.indNeu = PyrDown.indNeu;
    PyrDown1.avgFRProfileShort = InitAll1.avgFRProfileShort(PyrDown1.idxDown,:);
    PyrDown1.avgFRProfileLong = InitAll1.avgFRProfileLong(PyrDown1.idxDown,:);
    
    PyrOther1.idxOther = PyrOther.idxOther;
    PyrOther1.task = PyrOther.task;
    PyrOther1.indRec = PyrOther.indRec;
    PyrOther1.indNeu = PyrOther.indNeu;
    PyrOther1.avgFRProfileShort = InitAll1.avgFRProfileShort(PyrOther1.idxOther,:);
    PyrOther1.avgFRProfileLong = InitAll1.avgFRProfileLong(PyrOther1.idxOther,:);
    
    %% only include the recording if both short and long trials have enough
    %% number of trials
    PyrRise1.avgFRProfileShort1 = [];
    PyrRise1.avgFRProfileLong1 = [];
    PyrRise1.avgFRProfileShortToRew1 = [];
    PyrRise1.avgFRProfileLongToRew1 = [];
    PyrRise1.task1 = [];
    PyrRise1.indRec1 = [];
    PyrRise1.rewardDistShort1 = [];
    PyrRise1.rewardDistLong1 = [];
    PyrRise1.rewardIndShort1 = [];
    PyrRise1.rewardIndLong1 = [];
    PyrRise1.pRSSpeed1 = [];
    PyrRise1.pRSSpeed1to2s = [];
    PyrRise1.speedShortTr1 = [];
    PyrRise1.speedLongTr1 = [];
    PyrRise1.speedShortTrToRew1 = [];
    PyrRise1.speedLongTrToRew1 = [];
    
    PyrDown1.avgFRProfileShort1 = [];
    PyrDown1.avgFRProfileLong1 = [];
    PyrDown1.avgFRProfileShortToRew1 = [];
    PyrDown1.avgFRProfileLongToRew1 = [];
    PyrDown1.task1 = [];
    PyrDown1.indRec1 = [];
    
    PyrOther1.avgFRProfileShort1 = [];
    PyrOther1.avgFRProfileLong1 = [];
    PyrOther1.task1 = [];
    PyrOther1.indRec1 = [];
    
    if(taskSel == 1)
        [PyrRise1,PyrDown1,PyrOther1] = goodSessionLongShortTr(pathAnal,modPyr2NoCue,PyrRise1,PyrDown1,PyrOther1,minNumTr,1,sampleFq,speedMode);
    end
    
    if(taskSel == 2)
        [PyrRise1,PyrDown1,PyrOther1] = goodSessionLongShortTr(pathAnal,modPyr2PL,PyrRise1,PyrDown1,PyrOther1,minNumTr,3,sampleFq,speedMode);
    end
    
    [PyrRise1,PyrDown1,PyrOther1] = goodSessionLongShortTr(pathAnal,modPyr2AL,PyrRise1,PyrDown1,PyrOther1,minNumTr,2,sampleFq,speedMode);
    
    % calculate for each session speed of long and short trials
    PyrRise1.speedShort1 = PyrRise1.rewardDistShort1./(PyrRise1.rewardIndShort1/sampleFq);
    PyrRise1.speedLong1 = PyrRise1.rewardDistLong1./(PyrRise1.rewardIndLong1/sampleFq);
    
    % speed statistics
    PyrRise1.pRSSpeedLS = ranksum(PyrRise1.speedShort1,PyrRise1.speedLong1);
    
    indTmp = modPyr2AL.timeStepRun >=-1 & modPyr2AL.timeStepRun <= 4 ;
    avgFRProfileShortNormRise1 = normProfile(PyrRise1.avgFRProfileShort1,indTmp);
    avgFRProfileLongNormRise1 = normProfile(PyrRise1.avgFRProfileLong1,indTmp);  
    avgFRProfileShortNormRiseToRew1 = normProfile(PyrRise1.avgFRProfileShortToRew1,indTmp);
    avgFRProfileLongNormRiseToRew1 = normProfile(PyrRise1.avgFRProfileLongToRew1,indTmp);  
    
    avgFRProfileShortNormDown1 = normProfile(PyrDown1.avgFRProfileShort1,indTmp);
    avgFRProfileLongNormDown1 = normProfile(PyrDown1.avgFRProfileLong1,indTmp);    
    avgFRProfileShortNormDownToRew1 = normProfile(PyrDown1.avgFRProfileShortToRew1,indTmp);
    avgFRProfileLongNormDownToRew1 = normProfile(PyrDown1.avgFRProfileLongToRew1,indTmp);  
    
    avgFRProfileShortNormOther1 = normProfile(PyrOther1.avgFRProfileShort1,indTmp);
    avgFRProfileLongNormOther1 = normProfile(PyrOther1.avgFRProfileLong1,indTmp);    
    
    save([pathAnal 'initPeakPyrIntAllRec_LongShortTr_SpeedMode' num2str(speedMode) '.mat'],'InitAll1','PyrRise1','PyrDown1','PyrOther1');
    
    plotPyrNeuStimUpDownAlone_LongShortTr(pathAnal, FRProfileMean, modPyr2AL.timeStepRun, ...
        avgFRProfileShortNormRise1, avgFRProfileLongNormRise1,...
        PyrRise1.avgFRProfileShort1,PyrRise1.avgFRProfileLong1,'PyrRise');
    plotPyrNeuStimUpDownAlone_LongShortTr(pathAnal, FRProfileMean, modPyr2AL.timeStepRun, ...
        avgFRProfileShortNormDown1, avgFRProfileLongNormDown1,...
        PyrDown1.avgFRProfileShort1,PyrDown1.avgFRProfileLong1,'PyrDown');
    
    plotPyrNeuStimUpDownAlone_LongShortTr(pathAnal, FRProfileMean, modPyr2AL.timeStepRun, ...
        avgFRProfileShortNormRiseToRew1, avgFRProfileLongNormRiseToRew1,...
        PyrRise1.avgFRProfileShortToRew1,PyrRise1.avgFRProfileLongToRew1,'PyrRiseToRew');
    plotPyrNeuStimUpDownAlone_LongShortTr(pathAnal, FRProfileMean, modPyr2AL.timeStepRun, ...
        avgFRProfileShortNormDownToRew1, avgFRProfileLongNormDownToRew1,...
        PyrDown1.avgFRProfileShortToRew1,PyrDown1.avgFRProfileLongToRew1,'PyrDownToRew');
    
    plotPyrNeuStimUpDownAlone_LongShortTr(pathAnal, FRProfileMean, modPyr2AL.timeStepRun, ...
        avgFRProfileShortNormOther1, avgFRProfileLongNormOther1,...
        PyrOther1.avgFRProfileShort1,PyrOther1.avgFRProfileLong1,'PyrOther');
    
    plotAvgFRProfileCmp(modPyr2AL.timeStepSpeed,...
            PyrRise1.speedShortTr1/10,...
            PyrRise1.speedLongTr1/10,...
            ['Speed Long/Short (cm/s)'],...
            ['SpeedLongShort'],...
            pathAnal0,[0 60],'Time (s)');
        
    plotAvgFRProfileCmp(modPyr2AL.timeStepSpeed,...
            PyrRise1.speedShortTrToRew1/10,...
            PyrRise1.speedLongTrToRew1/10,...
            ['Speed Long/Short (cm/s)'],...
            ['SpeedLongShortToRew'],...
            pathAnal0,[0 60],'Time (s)');
    
end

function InitAll = PyrIntInitPeakByType(taskSel,modPyr2NoCue,modPyr2AL,modPyr2PL)

    if(taskSel == 1)   
        InitAll.task = [modPyr2NoCue.task modPyr2AL.task modPyr2PL.task];
        InitAll.indRec = [modPyr2NoCue.indRec modPyr2AL.indRec modPyr2PL.indRec];
        InitAll.indNeu = [modPyr2NoCue.indNeu modPyr2AL.indNeu modPyr2PL.indNeu];
        InitAll.avgFRProfileShort = [modPyr2NoCue.avgFRProfileShort; modPyr2AL.avgFRProfileShort; modPyr2PL.avgFRProfileShort];
        InitAll.avgFRProfileLong = [modPyr2NoCue.avgFRProfileBad; modPyr2AL.avgFRProfileBad; modPyr2PL.avgFRProfileBad];
    elseif(taskSel == 2)
        InitAll.task = [modPyr2AL.task modPyr2PL.task];
        InitAll.indRec = [modPyr2AL.indRec modPyr2PL.indRec];
        InitAll.indNeu = [modPyr2AL.indNeu modPyr2PL.indNeu];
        InitAll.avgFRProfileShort = [modPyr2AL.avgFRProfileShort; modPyr2PL.avgFRProfileShort];
        InitAll.avgFRProfileLong = [modPyr2AL.avgFRProfileLong; modPyr2PL.avgFRProfileLong];
    elseif(taskSel == 3)
        InitAll.task = modPyr2AL.task;
        InitAll.indRec = modPyr2AL.indRec;
        InitAll.indNeu = modPyr2AL.indNeu;
        InitAll.avgFRProfileShort = modPyr2AL.avgFRProfileShort;
        InitAll.avgFRProfileLong = modPyr2AL.avgFRProfileLong;
    end
end

function [PyrRise1,PyrDown1,PyrOther1] = goodSessionLongShortTr(pathAnal0,modPyr2,PyrRise1,PyrDown1,PyrOther1,minNumTr,task,sampleFq,speedMode)
    indRec = unique(modPyr2.indRec);
    
    profileFq = 1/(modPyr2.timeStepRun(2)-modPyr2.timeStepRun(1));
    fqRatio = sampleFq/profileFq;
    
    speedFq = 1/(modPyr2.timeStepSpeed(2)-modPyr2.timeStepSpeed(1));
    fqRatioS = sampleFq/speedFq;
    
    if(speedMode == 1) % consider both the mean speed and the speed between 1-2 second
        indTime = modPyr2.timeStepSpeed >= 0.5 & modPyr2.timeStepSpeed < 2;
    elseif(speedMode == 2) % consider both the mean speed and the speed between -1to0 second
        indTime = modPyr2.timeStepSpeed >= -1 & modPyr2.timeStepSpeed < 0;
    end
    
    for i = 1:length(indRec)
        if(modPyr2.numShortTr(indRec(i)) >= minNumTr & ...
                modPyr2.numLongTr(indRec(i)) >= minNumTr)
            pRSSpeed1to2s = NaN;
            if(speedMode == 1)
                speedShortTr = mean(modPyr2.speedHistShort{indRec(i)}(:,indTime),2);
                speedLongTr = mean(modPyr2.speedHistLong{indRec(i)}(:,indTime),2);
                pRSSpeed1to2s = ranksum(speedShortTr,speedLongTr);
            elseif(speedMode == 2)
                speedShortTr = mean(modPyr2.speedHistShort{indRec(i)}(:,indTime),2);
                speedLongTr = mean(modPyr2.speedHistLong{indRec(i)}(:,indTime),2);
                pRSSpeedMinus1toos = ranksum(speedShortTr,speedLongTr);
            end
            pRSSpeed = ranksum(modPyr2.rewardDistShort{indRec(i)}./modPyr2.rewardIndShort{indRec(i)},...
                modPyr2.rewardDistLong{indRec(i)}./modPyr2.rewardIndLong{indRec(i)});
            
            pSig = 0;
            if(speedMode == 0)
                if(pRSSpeed > 0.05)
                    pSig = 1;
                end 
            elseif(speedMode == 1)
                if(pRSSpeed > 0.05 & pRSSpeed1to2s > 0.05)
                    pSig = 1;
                end
            else
                if(pRSSpeed > 0.05 & pRSSpeedMinus1toos > 0.05)
                    pSig = 1;
                end
            end
                        
            if(pSig == 1)
                PyrRise1.pRSSpeed1 = [PyrRise1.pRSSpeed1 pRSSpeed];
                PyrRise1.pRSSpeed1to2s = [PyrRise1.pRSSpeed1to2s pRSSpeed1to2s];
                PyrRise1.task1 = [PyrRise1.task1 task];
                PyrRise1.indRec1 = [PyrRise1.indRec1 indRec(i)];
                PyrRise1.rewardDistShort1 = [PyrRise1.rewardDistShort1 mean(modPyr2.rewardDistShort{indRec(i)})];
                PyrRise1.rewardDistLong1 = [PyrRise1.rewardDistLong1 mean(modPyr2.rewardDistLong{indRec(i)})];
                PyrRise1.rewardIndShort1 = [PyrRise1.rewardIndShort1 mean(modPyr2.rewardIndShort{indRec(i)})];
                PyrRise1.rewardIndLong1 = [PyrRise1.rewardIndLong1 mean(modPyr2.rewardIndLong{indRec(i)})];
                PyrRise1.speedShortTr1 = [PyrRise1.speedShortTr1; modPyr2.speedHistShort{indRec(i)}];
                PyrRise1.speedLongTr1 = [PyrRise1.speedLongTr1; modPyr2.speedHistLong{indRec(i)}];
                
                speedTmpShort = modPyr2.speedHistShort{indRec(i)};
                speedTmpShort(:,round(mean(modPyr2.rewardIndShort{indRec(i)})/fqRatioS + 3*speedFq):end) = 0;
                PyrRise1.speedShortTrToRew1 = [PyrRise1.speedShortTrToRew1; speedTmpShort];
                
                speedTmpLong = modPyr2.speedHistLong{indRec(i)};
                speedTmpLong(:,round(mean(modPyr2.rewardIndLong{indRec(i)})/fqRatioS + 3*speedFq):end) = 0;
                PyrRise1.speedLongTrToRew1 = [PyrRise1.speedLongTrToRew1; speedTmpLong];
                
                indRecPR = find(PyrRise1.indRec == indRec(i) & PyrRise1.task == task);
                if(length(indRecPR) > 0)
                                
                    PyrRise1.avgFRProfileShort1 = [PyrRise1.avgFRProfileShort1; ...
                        PyrRise1.avgFRProfileShort(indRecPR,:)];
                    PyrRise1.avgFRProfileLong1 = [PyrRise1.avgFRProfileLong1; ...
                        PyrRise1.avgFRProfileLong(indRecPR,:)];

                    profileTmpShort = PyrRise1.avgFRProfileShort(indRecPR,:);
                    profileTmpShort(:,round(mean(modPyr2.rewardIndShort{indRec(i)})/fqRatio + 3*profileFq):end) = 0;
                    PyrRise1.avgFRProfileShortToRew1 = [PyrRise1.avgFRProfileShortToRew1; ...
                        profileTmpShort];

                    profileTmpLong = PyrRise1.avgFRProfileLong(indRecPR,:);
                    profileTmpLong(:,round(mean(modPyr2.rewardIndLong{indRec(i)})/fqRatio + 3*profileFq):end) = 0;
                    PyrRise1.avgFRProfileLongToRew1 = [PyrRise1.avgFRProfileLongToRew1; ...
                        profileTmpLong];
                    
                  %% average profile 
                    plotAvgFRProfileCmp(modPyr2.timeStepRun,...
                            PyrRise1.avgFRProfileShort(indRecPR,:),...
                            PyrRise1.avgFRProfileLong(indRecPR,:),...
                            ['PyrRise L/S rec' num2str(indRec(i)) ' P' num2str(PyrRise1.pRSSpeed1(end) > 0.05) ' N' num2str(length(indRecPR))],...
                            ['PyrRise_FRProfileLongShort_rec' num2str(indRec(i)) '_task' num2str(task) '_speedP' num2str(PyrRise1.pRSSpeed1(end) > 0.05) '_Neu' num2str(length(indRecPR))],...
                            pathAnal0,[0 3.5],'Time (s)');

                    plotAvgFRProfileCmp(modPyr2.timeStepRun,...
                            profileTmpShort,...
                            profileTmpLong,...
                            ['PyrRiseR L/S rec' num2str(indRec(i)) ' P' num2str(PyrRise1.pRSSpeed1(end) > 0.05) ' N' num2str(length(indRecPR))],...
                            ['PyrRise_FRProfileLongShortToRew_rec' num2str(indRec(i)) '_task' num2str(task) '_speedP' num2str(PyrRise1.pRSSpeed1(end) > 0.05) '_Neu' num2str(length(indRecPR))],...
                            pathAnal0,[0 3.5],'Time (s)');
                end
            else
                disp(['Rec ' num2str(indRec(i)) 'long and short trial speed are different'])
            end
                      
            if(pSig == 1)
                indRecPD = find(PyrDown1.indRec == indRec(i) & PyrDown1.task == task);
                if(length(indRecPD) > 0)
                    PyrDown1.avgFRProfileShort1 = [PyrDown1.avgFRProfileShort1; ...
                        PyrDown1.avgFRProfileShort(indRecPD,:)];
                    PyrDown1.avgFRProfileLong1 = [PyrDown1.avgFRProfileLong1; ...
                        PyrDown1.avgFRProfileLong(indRecPD,:)];

                    profileTmp = PyrDown1.avgFRProfileShort(indRecPD,:);
                    profileTmp(:,round(mean(modPyr2.rewardIndShort{indRec(i)})/fqRatio + 3*profileFq):end) = 0;
                    PyrDown1.avgFRProfileShortToRew1 = [PyrDown1.avgFRProfileShortToRew1; ...
                        profileTmp];

                    profileTmp = PyrDown1.avgFRProfileLong(indRecPD,:);
                    profileTmp(:,round(mean(modPyr2.rewardIndLong{indRec(i)})/fqRatio + 3*profileFq):end) = 0;
                    PyrDown1.avgFRProfileLongToRew1 = [PyrDown1.avgFRProfileLongToRew1; ...
                        profileTmp];
                    
                    PyrDown1.task1 = [PyrDown1.task1 task];
                    PyrDown1.indRec1 = [PyrDown1.indRec1 indRec(i)];
                    
                  %% average profile 
                    plotAvgFRProfileCmp(modPyr2.timeStepRun,...
                            PyrDown1.avgFRProfileShort(indRecPD,:),...
                            PyrDown1.avgFRProfileLong(indRecPD,:),...
                            ['PyrDown_FR L/S rec' num2str(indRec(i)) ' P' num2str(PyrRise1.pRSSpeed1(end) > 0.05) ' N' num2str(length(indRecPR))],...
                            ['PyrDown_FRProfileLongShort_rec' num2str(indRec(i)) '_task' num2str(task) '_speedP' num2str(PyrRise1.pRSSpeed1(end) > 0.05) '_Neu' num2str(length(indRecPR))],...
                            pathAnal0,[0 4.5],'Time (s)');
                end
            end
            
           
            if(pSig == 1)
                indRecPO = find(PyrOther1.indRec == indRec(i) & PyrOther1.task == task);
                if(length(indRecPO) > 0)
                    PyrOther1.avgFRProfileShort1 = [PyrOther1.avgFRProfileShort1; ...
                        PyrOther1.avgFRProfileShort(indRecPO,:)];
                    PyrOther1.avgFRProfileLong1 = [PyrOther1.avgFRProfileLong1; ...
                        PyrOther1.avgFRProfileLong(indRecPO,:)];
                    PyrOther1.task1 = [PyrOther1.task1 task];
                    PyrOther1.indRec1 = [PyrOther1.indRec1 indRec(i)];
                end
            end
        end
    end        
end

function avgProfileNorm = normProfile(avgProfile,indTimeStep)
    avgProfileNorm = zeros(size(avgProfile,1),size(avgProfile,2));
    for i = 1:size(avgProfile,1)
        if(max(avgProfile(i,:)) ~= 0)
            rangeFR = max(avgProfile(i,indTimeStep))-min(avgProfile(i,indTimeStep));
            if(rangeFR ~= 0)
                avgProfileNorm(i,:) = (avgProfile(i,:)-min(avgProfile(i,indTimeStep)))...
                    /rangeFR;
            end
        end
    end
end

function plotAvgFRProfileCmp(timeStepRun,avgFRProfilex,avgFRProfiley, yl,fileName,pathAnal,ylimit,labels)
    if(isempty(avgFRProfilex))
        return;
    end
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 280 280])
    options.color_areaX = [27 117 187]./255;    % Blue theme
    options.color_lineX = [ 39 169 225]./255;
    options.color_areaY = [187 189 192]./255;    % Orange theme
    options.color_lineY = [167 169  171]./255;
    options.alpha      = 0.5;
    options.line_width = 0.5;
    options.error      = 'sem';
    options.x_axisX = timeStepRun;
    options.x_axisY = timeStepRun;
    plot_areaerrorbarXY(avgFRProfilex, avgFRProfiley,...
        options);
    hold on;
    minX = min(mean(avgFRProfilex)-std(avgFRProfilex)/sqrt(size(avgFRProfilex,1)));
    minY = min(mean(avgFRProfiley)-std(avgFRProfiley)/sqrt(size(avgFRProfiley,1)));
    maxX = max(mean(avgFRProfilex)+std(avgFRProfilex)/sqrt(size(avgFRProfilex,1)));
    maxY = max(mean(avgFRProfiley)+std(avgFRProfiley)/sqrt(size(avgFRProfiley,1)));
    if(~isempty(ylimit))
        h = plot([0 0],ylimit,'r-');
    else
        h = plot([0 0],[min([minX minY])*0.95 ...
            max([maxX maxY])*1.05],'r-');
    end
    set(h,'LineWidth',1)
    set(gca,'XLim',[-1 6]);
%     set(gca,'XLim',[timeStepRun(1) 7]);
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    else
        set(gca,'YLim',[min([minX minY])*0.95 ...
        max([maxX maxY])*1.05]);
    end
    xlabel('Time (s)')
    ylabel(yl)
    if(~isempty(labels))
        legend(labels)
    end
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end
