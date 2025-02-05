function plotCCG(path, FileNameBase, neuNo1, neuNo2)
% plot CCG between a pair of neurons
% e.g.: plotCCG('Z:\Raphael_tests\mice_expdata\ANM016\A016-20190603\A016-20190603-01\','A016-20190603-01',49,49)

    fprintf(...
        'Load Spike from %s file.\n', ...
        [path FileNameBase '_BehavElectrDataLFP_CCG.mat']);
    load([path FileNameBase '_BehavElectrDataLFP_CCG.mat'],'ccgVal','ccgT');
    
    for i = neuNo1
        for j = neuNo2
            [figNew,pos] = CreateFig();
            set(0,'Units','pixels') 
            set(figure(figNew),'OuterPosition',...
                [500 500 280 280])
            
            h = bar(ccgT,ccgVal(:,i,j));
            set(h,'FaceColor',[0 0 0],'EdgeColor',[0 0 0])
            set(gca,'XLim',[-50 50])
            xlabel('Time (s)')
            ylabel('Count')
            
            print ('-painters', '-dpdf', ['spikeCCG_' FileNameBase '_Neu' num2str(i) '_' num2str(j) ], '-r600')
        end
    end    
end

