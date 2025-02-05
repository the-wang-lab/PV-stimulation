function plotBurstVsTheta(burstMeanDire,phaseMeanDire,fractBurst,pathAnal)

    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    x = burstMeanDire(fractBurst > 0) - phaseMeanDire(fractBurst > 0);
    x(x < -pi) = x(x < -pi) + 2*pi;
    x(x > pi) = x(x > pi) - 2*pi;
    X = [x' phaseMeanDire(fractBurst > 0)'];
    N = hist3(X,'CdataMode','auto','Ctrs',{-1.2*pi:pi/18:1.2*pi 0:pi/36:2*pi});
    imagesc((-1.2*pi:pi/36:1.2*pi)/pi*180,(0:pi/36:2*pi)/pi*180,N');
    hold on;
    h = plot([0 0],[0 2*180],'r-');
    set(gca,'XLim',[-180 180]);
    xlabel('Burst mean phase - theta mean phase');
    ylabel('Theta mean phase');
    fileName1 = [pathAnal 'Pyr-Burst-ThetaMeanPhaseVsThetaPhase'];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
        
end