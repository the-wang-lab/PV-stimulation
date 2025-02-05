function plotSingleTrialPosteriorAL(recNo,upDown)

    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderALPLWithCrossValSTD0p2\'];
    if(upDown == 1) % PyrUp
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRiseAL\'];
        load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
    elseif(upDown == 2) % PyrDown
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrDownAL\'];
        load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
    elseif(upDown == 3) % PyrOther
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrOtherAL\'];
        load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);         
    else % PyrUp and PyrDown
        pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2\PyrRiseDownAL\'];
        load([pathAnal0 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat']);
    end
    
    nBins = length(paramC.timeStep);
    timeBinRatio = paramC.timeBin1/paramC.timeBin;
    nBins1 = nBins/timeBinRatio;
    
    posteriorN2Tmp = naiveBayes.PosteriorN2{recNo};
    posteriorN2Tmp = reshape(posteriorN2Tmp,nBins1,size(naiveBayes.PosteriorN2{recNo},1)/nBins1,nBins1);
    for i = 1:size(posteriorN2Tmp,2)
        plotPosterior(squeeze(posteriorN2Tmp(:,i,:))',naiveBayes.timeTrain{recNo}(1:length(naiveBayesMean.labelN2{recNo})),...
            ['posterior recording ' num2str(recNo) ' Trial ' num2str(i)],...
            ['Posterior' num2str(recNo) 'Trial' num2str(i)], pathAnal);
    end
    