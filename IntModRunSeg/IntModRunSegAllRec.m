function IntModRunSegAllRec(onlyRun,taskSel,methodKMean)

    methodTheta = 1;
    minFRInt = 2;
    
    RecordingList;
    pathAnal0 = 'Z:\Yingxue\DataAnalysisRaphi\interneuron\'; 
    load([pathAnal0 'autoCorrIntAllRec.mat']);
    
    if(taskSel == 1) % including all the neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\IntModRunSeg\';
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = 'Z:\Yingxue\Draft\PV\IntModRunSegALPL\';
    else
        pathAnal = 'Z:\Yingxue\Draft\PV\IntModRunSegAL\';
    end
    if(exist([pathAnal0 'modRunSegIntAllRec.mat']))
        load([pathAnal0 'modRunSegIntAllRec.mat']);
    end
    
    if(taskSel == 1)
        %% interneurons in no cue passive task
        disp('No cue')
        modSegIntNoCue = accumIntNeurons4(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFRInt,1,onlyRun);

        disp('Active licking')
        modSegIntAL = accumIntNeurons4(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFRInt,2,onlyRun);

        disp('Passive licking')
        modSegIntPL = accumIntNeurons4(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFRInt,3,onlyRun);

        save([pathAnal0 'modRunSegIntAllRec.mat'],'modSegIntNoCue','modSegIntAL','modSegIntPL'); 
    end
    
    mod = IntModRunSegAllRecByType(autoCorrIntNoCue,autoCorrIntAL,autoCorrIntPL,...
        modIntNoCue,modIntAL,modIntPL,modSegIntNoCue,modSegIntAL,modSegIntPL,taskSel,methodKMean);
    
    % for each cluster, compare neurons in the recordings with fields vs.
    % recordings without field
    modSegIntStatsField = modIntStatsSegmentFieldPerC(mod);
    
    % compare neurons between the two clusters
    modSegIntStatsSeg = modIntStatsSegments(mod);
    
    save([pathAnal 'modRunSegIntAllRecSel.mat'],'mod','modSegIntStatsField','modSegIntStatsSeg'); 
        
    %% compare two clusters
    colorSel = 1;
    cluster = 3;
    idxC = mod.idxC;
    indCurCField = idxC == cluster & mod.nNeuWithField >= 2;
    indCurCNoField = idxC == cluster & mod.nNeuWithField < 1;
    plotModRunSeg(mod,modSegIntStatsField,modSegIntStatsSeg,colorSel,...
        cluster,indCurCField,indCurCNoField,pathAnal);
    
    %% 
    colorSel = 6;
    cluster = 5;
    indCurCField = idxC == cluster & mod.nNeuWithField >= 2;
    indCurCNoField = idxC == cluster & mod.nNeuWithField < 1;
    plotModRunSeg(mod,modSegIntStatsField,modSegIntStatsSeg,colorSel,...
        cluster,indCurCField,indCurCNoField,pathAnal);
    
    %% 
    colorSel = 0;
    cluster = 2;
    indCurCField = idxC == cluster & mod.nNeuWithField >= 2;
    indCurCNoField = idxC == cluster & mod.nNeuWithField < 1;
    plotModRunSeg(mod,modSegIntStatsField,modSegIntStatsSeg,colorSel,...
        cluster,indCurCField,indCurCNoField,pathAnal);
end

function plotClusters(x,y,idx,xl,yl,ti)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])

    % only for plotting two clusters with fields
    colorArr = [...
                234 131 114;...
                163 207 98]/255;
            
%     colorArr = [0.5 0.5 0.9;...
%         0.9 0.5 0.5;...
%         0.3 0.3 0.7;...
%         0.7 0.3 0.3;...
%         0.5 0.9 0.5;...
%         0.2 0.5 0.8;...
%         0.2 0.8 0.5;...
%         0.8 0.5 0.2;...
%         0.3 0.7 0.3];
    hold on;
    for i = 1:max(idx)
        indTmp = idx == i;
        h = plot(x(indTmp),y(indTmp),'.');
        set(h,'MarkerSize',8,'Color',colorArr(mod(i,2)+1,:));
    end
%     h = plot(xt,yt,'k+');
%     set(h,'MarkerSize',7);
    maxX = max(x);
    maxY = max(y);
    minX = min(x);
    minY = min(y);
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    title(ti);
end


function plotClustersFieldsPhase(pathAnal,x,y,idx,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
    plot([0 2*pi],[0 2*pi],'k-')
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    if(sum(~indField) > 0)
        plotClusters(x(~indField),y(~indField),...
            idx(~indField),xl,yl,[ti ' - no field']);
        plot([0 2*pi],[0 2*pi],'k-')

        fileName1 = [pathAnal fileN 'NoField'];
        saveas(gcf,fileName1);
        print('-painters', '-dpdf', fileName1, '-r600')
    end
end

function plotClustersFieldsPhaseLabelF(pathAnal,x,y,idx,xfF,yfF,xfNoF,yfNoF,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
%     plot([0 2*pi],[0 2*pi],'k-')
    h = plot(xfF,yfF,'k+');
    set(h,'MarkerSize',9);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    if(sum(~indField) > 0)
        plotClusters(x(~indField),y(~indField),...
            idx(~indField),xl,yl,[ti ' - no field']);
    %     plot([0 2*pi],[0 2*pi],'k-')
        h = plot(xfNoF,yfNoF,'k+');
        set(h,'MarkerSize',9);

        fileName1 = [pathAnal fileN 'NoField'];
        saveas(gcf,fileName1);
        print('-painters', '-dpdf', fileName1, '-r600')
    end
end

function plotClustersFields(pathAnal,x,y,idx,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotClusters(x(~indField),y(~indField),...
        idx(~indField),xl,yl,[ti ' - no field']);
        
    fileName1 = [pathAnal fileN 'NoField'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end

function plotClustersFieldsLabelF(pathAnal,x,y,idx,xfF,yfF,xfNoF,yfNoF,indField,xl,yl,ti,fileN)
    plotClusters(x(indField),y(indField),...
        idx(indField),xl,yl,[ti ' - field']);
    h = plot(xfF,yfF,'k+');
    set(h,'MarkerSize',9);
    
    fileName1 = [pathAnal fileN 'Field'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    
    plotClusters(x(~indField),y(~indField),...
        idx(~indField),xl,yl,[ti ' - no field']);
    h = plot(xfNoF,yfNoF,'k+');
    set(h,'MarkerSize',9);
    
    fileName1 = [pathAnal fileN 'NoField'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end
