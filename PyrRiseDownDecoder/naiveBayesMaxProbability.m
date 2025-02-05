function naiveBayesMaxProbability()
    
    for i = 1:6
        naiveBayesMaxProbability1(i);
    end

end


function naiveBayesMaxProbability1(PyrPop)
% calculating the label and decoding error based on max occuring
% frequency

    if(PyrPop == 1) % PyrUpAL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrRiseAL\'];
    elseif(PyrPop == 2) % PyrDownAL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrDownAL\'];
    elseif(PyrPop == 3) % PyrOtherAL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrOtherAL\'];
    elseif(PyrPop == 4) % PyrUpPL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrRisePL\'];
    elseif(PyrPop == 5) % PyrDownPL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrDownPL\'];
    elseif(PyrPop == 6) % PyrOtherPL
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoder\PyrOtherPL\'];
    end


    load([pathAnal 'NaiveBayesDecoderPyrPerRec.mat'],'naiveBayes','paramC');
    nBins = length(paramC.timeStep);
    timeBinRatio = paramC.timeBin1/paramC.timeBin;
    nBins1 = nBins/timeBinRatio;
    for i = 1:length(naiveBayes.task)    
        trialNo = length(naiveBayes.labelN2{i})/nBins1;

        % most likely label
        labelN2Tmp = reshape(naiveBayes.labelN2{i},nBins1,trialNo);
        naiveBayesMaxProb.labelN2{i} = mode(labelN2Tmp,2);

        % most likely decoding error
        decodingErrTmp = reshape(naiveBayes.decodingErr{i},nBins1,trialNo);
        naiveBayesMaxProb.decodingErr{i} = mode(decodingErrTmp,2);

        %% naive bayes classification on shuffled data
        naiveBayesMaxProb.labelN2Shuf{i} = zeros(nBins1,1);
        naiveBayesMaxProb.decodingErrShuf{i} = zeros(nBins1,1);
        for n = 1:paramC.numShuffle
            labelN2Tmp = reshape(naiveBayes.labelN2Shuf{i,n},nBins1,trialNo);
            naiveBayesMaxProb.labelN2Shuf{i} = naiveBayesMaxProb.labelN2Shuf{i} + mode(labelN2Tmp,2);
            decodingErrTmp = reshape(naiveBayes.decodingErrShuf{i,n},nBins1,trialNo);
            naiveBayesMaxProb.decodingErrShuf{i} = naiveBayesMaxProb.decodingErrShuf{i} + mode(decodingErrTmp,2);
        end

        %% calculate mean of classification results for shuffled data
        naiveBayesMaxProb.labelN2Shuf{i} = naiveBayesMaxProb.labelN2Shuf{i}/paramC.numShuffle;
        naiveBayesMaxProb.decodingErrShuf{i} = naiveBayesMaxProb.decodingErrShuf{i}/paramC.numShuffle;
    end

    save([pathAnal 'NaiveBayesDecoderPyrMaxProb.mat'],'naiveBayesMaxProb');
end