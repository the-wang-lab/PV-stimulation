function PyrNaiveBayesEncoderAllRecWithCrossValSTD0p2Stim(upDown)

    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalDecoderWithCrossValSTD0p2Stim\'];
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1');
    end

    if(upDown == 1) % PyrUp
        pathAnal = [pathAnal 'PyrUpAL\'];
    elseif(upDown == 2) % PyrDown
        pathAnal = [pathAnal 'PyrDownAL\'];
    elseif(upDown == 3) % PyrOther
        pathAnal = [pathAnal 'PyrOtherAL\'];
    else % PyrUp and PyrDown
        pathAnal = [pathAnal 'PyrRiseDownAL\'];
        
    end
    if(exist([pathAnal 'NaiveBayesDecoderPyrAll.mat']))
        load([pathAnal 'NaiveBayesDecoderPyrAll.mat']);
    end
%     if(exist('naiveBayesMeanAll') == 0)
        load([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal.mat'],'recNo','paramC');
%     end
            
    GlobalConstFq;
    
    if(exist('naiveBayesMeanAll') == 0)
    %% accumulate the decoding information from each recording
        naiveBayesMeanAll = accumNaiveBayesEncoderTypes(recNo, pathAnal, paramC.nBins);
         
        save([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanAll');
    end
        
    numCond = length(PyrStim1.FRProfile1);
    for cond = 1:numCond
        naiveBayesMeanStimAll{cond}.actOrInact = PyrStim1.FRProfile1{cond}.actOrInact;
        naiveBayesMeanStimAll{cond}.pulseMethod = PyrStim1.FRProfile1{cond}.pulseMethod;
        naiveBayesMeanStimAll{cond}.stimLoc = PyrStim1.FRProfile1{cond}.stimLoc;
        naiveBayesMeanStimAll{cond}.time = naiveBayesMeanAll.time;
        if(upDown == 1)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrRise);
        elseif(upDown == 2)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrDown);
        elseif(upDown == 3)
            indRec = unique(PyrStim1.FRProfile1{cond}.indRecPyrOther);
        else
            indRec = unique([PyrStim1.FRProfile1{cond}.indRecPyrRise PyrStim1.FRProfile1{cond}.indRecPyrDown]);
        end
        [~,iRecNo] = intersect(naiveBayesMeanAll.recNo,indRec);
        iRecNo = iRecNo(naiveBayesMeanAll.pulseMeth(iRecNo) == naiveBayesMeanStimAll{cond}.pulseMethod);
        naiveBayesMeanStimAll{cond}.recNo = naiveBayesMeanAll.recNo(iRecNo);
        naiveBayesMeanStimAll{cond}.numNeu = naiveBayesMeanAll.numNeu(iRecNo);
        naiveBayesMeanStimAll{cond}.numTr = naiveBayesMeanAll.numTr(iRecNo);
        
        naiveBayesMeanStimAll{cond}.labelN2Mode = naiveBayesMeanAll.labelN2Mode(:,iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2Post = naiveBayesMeanAll.labelN2Post(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2 = naiveBayesMeanAll.PosteriorN2(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.CostN2 = naiveBayesMeanAll.CostN2(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrMean = naiveBayesMeanAll.decodingErrMean(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrMode = naiveBayesMeanAll.decodingErrMode(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrPost = naiveBayesMeanAll.decodingErrPost(:,iRecNo);

        naiveBayesMeanStimAll{cond}.numTrStim = naiveBayesMeanAll.numTrStim(iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2ModeStim = naiveBayesMeanAll.labelN2ModeStim(:,iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2PostStim = naiveBayesMeanAll.labelN2PostStim(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2Stim = naiveBayesMeanAll.PosteriorN2Stim(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrMeanStim = naiveBayesMeanAll.decodingErrMeanStim(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrModeStim = naiveBayesMeanAll.decodingErrModeStim(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrPostStim = naiveBayesMeanAll.decodingErrPostStim(:,iRecNo);

        naiveBayesMeanStimAll{cond}.labelN2MeanShuf = naiveBayesMeanAll.labelN2MeanShuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2ModeShuf = naiveBayesMeanAll.labelN2ModeShuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.labelN2PostShuf = naiveBayesMeanAll.labelN2PostShuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.PosteriorN2Shuf = naiveBayesMeanAll.PosteriorN2Shuf(:,:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrMeanShuf = naiveBayesMeanAll.decodingErrMeanShuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrModeShuf = naiveBayesMeanAll.decodingErrModeShuf(:,iRecNo);
        naiveBayesMeanStimAll{cond}.decodingErrPostShuf = naiveBayesMeanAll.decodingErrPostShuf(:,iRecNo);

        naiveBayesMeanStimMean{cond} = calMeanNaiveBayes(naiveBayesMeanStimAll{cond});            
    end
    save([pathAnal 'NaiveBayesDecoderPyrAll.mat'],'naiveBayesMeanStimAll','naiveBayesMeanStimMean','-append');

    % changed on 1/25/2025, added transpose to PosteriorN2 or
    % PosteriorN2Stim matrix
    for i = 1:size(naiveBayesMeanAll.labelN2Mode,2)
        plotPosterior(naiveBayesMeanAll.PosteriorN2(:,:,i)',naiveBayesMeanAll.time, ...
            ['Mean posterior recording ' num2str(naiveBayesMeanAll.recNo(i)) ' task ' num2str(naiveBayesMeanAll.task(i)) ' Ctrl'],...
            ['MeanPosteriorCtrl' num2str(naiveBayesMeanAll.recNo(i))],pathAnal); 
        
        plotPosterior(naiveBayesMeanAll.PosteriorN2Stim(:,:,i)',naiveBayesMeanAll.time, ...
            ['Mean posterior recording ' num2str(naiveBayesMeanAll.recNo(i)) ' task ' num2str(naiveBayesMeanAll.task(i)) ' Stim'],...
            ['MeanPosteriorStim' num2str(naiveBayesMeanAll.recNo(i))],pathAnal); 
    end
    
    for cond = 1:numCond        
        % posterior prob for ctrl recordings with max-posterior label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2',naiveBayesMeanStimMean{cond}.labelN2Post,...
            naiveBayesMeanAll.time,['Mean posterior ctrl recordings cond ' num2str(cond) ' -postLabel'],...
            ['MeanPosteriorPostLabelCtrl_Cond' num2str(cond)],pathAnal); 
        
        % posterior prob for stim recordings with max-posterior label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2Stim',naiveBayesMeanStimMean{cond}.labelN2PostStim,...
            naiveBayesMeanAll.time,['Mean posterior stim recordings cond ' num2str(cond) ' -postLabel'],...
            ['MeanPosteriorPostLabelStim_Cond' num2str(cond)],pathAnal); 
        
        % posterior prob for ctrl recordings with mean label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2',naiveBayesMeanStimMean{cond}.labelN2Mode,...
            naiveBayesMeanAll.time,['Mean posterior ctrl recordings cond ' num2str(cond) ' -modeLabel'],...
            ['MeanPosteriorModeLabelCtrl_Cond' num2str(cond)],pathAnal); 
        
        % posterior prob for stim recordings with mean label
        plotPosteriorWLabel(naiveBayesMeanStimMean{cond}.PosteriorN2Stim',naiveBayesMeanStimMean{cond}.labelN2ModeStim,...
            naiveBayesMeanAll.time,['Mean posterior stim recordings cond ' num2str(cond) ' -modeLabel'],...
            ['MeanPosteriorModeLabelStim_Cond' num2str(cond)],pathAnal); 

        % comparing decoded max-posterior labels among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.labelN2Post',naiveBayesMeanStimAll{cond}.labelN2PostStim',...
            naiveBayesMeanStimAll{cond}.labelN2PostShuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.pLabelN2PostCtrlStim,naiveBayesMeanStimMean{cond}.pLabelN2PostCtrlShuf,...
            ['PostDecodeTimeDataVsShufStim_Cond' num2str(cond)],pathAnal,[0 5.2],'Decoding time (s)',['Cond' num2str(cond) ' -postLabel']); 
        
        % comparing decoded error based on max-posterior among ctrl, stim and shuffle data, trained
        % using ctrl data
        % comparing decoded error based on max-posterior among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr3(naiveBayesMeanStimMean{cond}.decodingErrPost',naiveBayesMeanStimMean{cond}.decodingErrPostStim',...
            naiveBayesMeanStimMean{cond}.decodingErrPostShuf',naiveBayesMeanStimMean{cond}.decodingErrPostSEM',...
            naiveBayesMeanStimMean{cond}.decodingErrPostStimSEM',naiveBayesMeanStimMean{cond}.decodingErrPostShufSEM',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.decodingErrPrsPostCtrlStim,naiveBayesMeanStimMean{cond}.decodingErrPrsPostCtrlShuf,...
            ['PostDecodeErrDataVsShufStim_Cond' num2str(cond)],pathAnal,[-2.5 2.9],'Decoding error (s)',['Cond' num2str(cond) ' -postLabel']);  
        
        % comparing decoded mean labels among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.labelN2Mode',naiveBayesMeanStimAll{cond}.labelN2ModeStim',...
            naiveBayesMeanStimAll{cond}.labelN2MeanShuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.pLabelN2ModeCtrlStim,naiveBayesMeanStimMean{cond}.pLabelN2ModeCtrlShuf,...
            ['MeanDecodeTimeDataVsShufStim_Cond' num2str(cond)],pathAnal,[0 5.2],'Decoding time (s)',['Cond' num2str(cond) ' -meanLabel']); 
        
        % comparing decoded error based on mean of mode labels among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.decodingErrMode',naiveBayesMeanStimAll{cond}.decodingErrModeStim',...
            naiveBayesMeanStimAll{cond}.decodingErrMeanShuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.decodingErrPrsModeCtrlStim,naiveBayesMeanStimMean{cond}.decodingErrPrsMeanCtrlShuf,...
            ['MeanDecodeErrDataVsShufStim_Cond' num2str(cond)],pathAnal,[-2.5 2.9],'Decoding error (s)',['Cond' num2str(cond) ' -meanLabel']); 
        
        % comparing mean decoded error among ctrl, stim and shuffle data, trained
        % using ctrl data
        plotDecodingErr2(naiveBayesMeanStimAll{cond}.decodingErrMean',naiveBayesMeanStimAll{cond}.decodingErrMeanStim',...
            naiveBayesMeanStimAll{cond}.decodingErrMeanShuf',naiveBayesMeanAll.time,...
            naiveBayesMeanStimMean{cond}.decodingErrPrsMeanCtrlStim,naiveBayesMeanStimMean{cond}.decodingErrPrsMeanCtrlShuf,...
            ['MeanDecodeErrDataVsShufStim_Cond' num2str(cond)],pathAnal,[-2.5 2.9],'Decoding error (s)',['Cond' num2str(cond) ' -meanLabel']); 
    end
        
end

function naiveBayesMeanAll = accumNaiveBayesEncoderTypes(recNo,pathAnal,nBins)
    numRec = length(recNo);
    
    naiveBayesMeanAll = struct( ...
            'recNo',zeros(1,numRec),...
            'task',zeros(1,numRec),... % no cue - 1, AL - 2, PL - 3
            'numNeu',zeros(1,numRec),...
            'numTr',zeros(1,numRec),...
            ...
            'labelN2Mode',zeros(nBins,numRec),...
            'labelN2Post',zeros(nBins,numRec),...
            'PosteriorN2',zeros(nBins,nBins,numRec),...
            'CostN2',zeros(nBins,nBins,numRec),...
            'decodingErrMean',zeros(nBins,numRec),...
            'decodingErrMode',zeros(nBins,numRec),...
            'decodingErrPost',zeros(nBins,numRec),...
            ...
            'numTrStim',zeros(1,numRec),...
            'pulseMeth',zeros(1,numRec),...
            'labelN2ModeStim',zeros(nBins,numRec),...
            'labelN2PostStim',zeros(nBins,numRec),...
            'PosteriorN2Stim',zeros(nBins,nBins,numRec),...
            'decodingErrMeanStim',zeros(nBins,numRec),...
            'decodingErrModeStim',zeros(nBins,numRec),...
            'decodingErrPostStim',zeros(nBins,numRec),...
            ...
            'labelN2MeanShuf',zeros(nBins,numRec),...
            'labelN2ModeShuf',zeros(nBins,numRec),...
            'labelN2PostShuf',zeros(nBins,numRec),...
            'PosteriorN2Shuf',zeros(nBins,nBins,numRec),...
            'decodingErrMeanShuf',zeros(nBins,numRec),...
            'decodingErrModeShuf',zeros(nBins,numRec),...
            'decodingErrPostShuf',zeros(nBins,numRec));

    numRecActual = 1;
    for i = 1:numRec
        if(exist([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal' num2str(recNo(i)) '.mat']))
            load([pathAnal 'NaiveBayesDecoderPyrPerRecWithCrossVal' num2str(recNo(i)) '.mat'],'naiveBayes','naiveBayesMean');
        else
            continue;
        end
        
        if(~isempty(naiveBayesMean.labelN2))
            naiveBayesMeanAll.time = naiveBayes.timeTrain(1:length(naiveBayesMean.labelN2));
        end
    
        for j = 1:length(naiveBayesMean.pulseMeth)
            if(~isempty(naiveBayesMean.labelN2) & sum(isnan(naiveBayesMean.PosteriorN2(:))) == 0 ...
                    & ~isempty(naiveBayesMean.labelN2Stim{j}) ...
                    & sum(isnan(naiveBayesMean.PosteriorN2Stim{j}(:))) == 0)
                naiveBayesMeanAll.recNo(numRecActual) = recNo(i);
                naiveBayesMeanAll.numNeu(numRecActual) = length(naiveBayes.indNeu);
                naiveBayesMeanAll.numTr(numRecActual) = length(naiveBayes.trialNo);
                naiveBayesMeanAll.task(numRecActual) = 2;
                
                naiveBayesMeanAll.labelN2Mode(:,numRecActual) = naiveBayesMean.labelN2;
                naiveBayesMeanAll.labelN2Post(:,numRecActual) = naiveBayesMean.labelN2Post;
                naiveBayesMeanAll.PosteriorN2(:,:,numRecActual) = naiveBayesMean.PosteriorN2;
                naiveBayesMeanAll.CostN2(:,:,numRecActual) = naiveBayesMean.CostN2;
                naiveBayesMeanAll.decodingErrMean(:,numRecActual) = naiveBayesMean.decodingErrMean;
                naiveBayesMeanAll.decodingErrMode(:,numRecActual) = naiveBayesMean.decodingErrMode;
                naiveBayesMeanAll.decodingErrPost(:,numRecActual) = naiveBayesMean.decodingErrPost;
                
                naiveBayesMeanAll.numTrStim(numRecActual) = length(naiveBayes.trialNoStim{j});
                naiveBayesMeanAll.pulseMeth(numRecActual) = naiveBayesMean.pulseMeth(j);
                naiveBayesMeanAll.labelN2ModeStim(:,numRecActual) = naiveBayesMean.labelN2Stim{j};
                naiveBayesMeanAll.labelN2PostStim(:,numRecActual) = naiveBayesMean.labelN2PostStim{j};
                naiveBayesMeanAll.PosteriorN2Stim(:,:,numRecActual) = naiveBayesMean.PosteriorN2Stim{j};
                naiveBayesMeanAll.decodingErrMeanStim(:,numRecActual) = naiveBayesMean.decodingErrMeanStim{j};
                naiveBayesMeanAll.decodingErrModeStim(:,numRecActual) = naiveBayesMean.decodingErrModeStim{j};
                naiveBayesMeanAll.decodingErrPostStim(:,numRecActual) = naiveBayesMean.decodingErrPostStim{j};

                naiveBayesMeanAll.labelN2MeanShuf(:,numRecActual) = naiveBayesMean.labelN2MeanShuf;
                naiveBayesMeanAll.labelN2ModeShuf(:,numRecActual) = naiveBayesMean.labelN2ModeShuf;
                naiveBayesMeanAll.labelN2PostShuf(:,numRecActual) = naiveBayesMean.labelN2PostShuf;
                naiveBayesMeanAll.PosteriorN2Shuf(:,:,numRecActual) = naiveBayesMean.PosteriorN2Shuf;
                naiveBayesMeanAll.decodingErrMeanShuf(:,numRecActual) = naiveBayesMean.decodingErrMeanShuf;
                naiveBayesMeanAll.decodingErrModeShuf(:,numRecActual) = naiveBayesMean.decodingErrModeShuf;
                naiveBayesMeanAll.decodingErrPostShuf(:,numRecActual) = naiveBayesMean.decodingErrPostShuf;
                
                numRecActual = numRecActual+1;
            end
        end
    end

    naiveBayesMeanAll.recNo = naiveBayesMeanAll.recNo(1:numRecActual-1);
    naiveBayesMeanAll.numNeu = naiveBayesMeanAll.numNeu(1:numRecActual-1);
    naiveBayesMeanAll.numTr = naiveBayesMeanAll.numTr(1:numRecActual-1);
    naiveBayesMeanAll.task = naiveBayesMeanAll.task(1:numRecActual-1);
    
    naiveBayesMeanAll.labelN2Mode = naiveBayesMeanAll.labelN2Mode(:,1:numRecActual-1);
    naiveBayesMeanAll.labelN2Post = naiveBayesMeanAll.labelN2Post(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2 = naiveBayesMeanAll.PosteriorN2(:,:,1:numRecActual-1);
    naiveBayesMeanAll.CostN2 = naiveBayesMeanAll.CostN2(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrMean = naiveBayesMeanAll.decodingErrMean(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrMode = naiveBayesMeanAll.decodingErrMode(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrPost = naiveBayesMeanAll.decodingErrPost(:,1:numRecActual-1);

    naiveBayesMeanAll.numTrStim = naiveBayesMeanAll.numTrStim(1:numRecActual-1);
    naiveBayesMeanAll.pulseMeth = naiveBayesMeanAll.pulseMeth(1:numRecActual-1);
    naiveBayesMeanAll.labelN2ModeStim = naiveBayesMeanAll.labelN2ModeStim(:,1:numRecActual-1);
    naiveBayesMeanAll.labelN2PostStim = naiveBayesMeanAll.labelN2PostStim(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2Stim = naiveBayesMeanAll.PosteriorN2Stim(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrMeanStim = naiveBayesMeanAll.decodingErrMeanStim(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrModeStim = naiveBayesMeanAll.decodingErrModeStim(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrPostStim = naiveBayesMeanAll.decodingErrPostStim(:,1:numRecActual-1);

    naiveBayesMeanAll.labelN2MeanShuf = naiveBayesMeanAll.labelN2MeanShuf(:,1:numRecActual-1);
    naiveBayesMeanAll.labelN2ModeShuf = naiveBayesMeanAll.labelN2ModeShuf(:,1:numRecActual-1);
    naiveBayesMeanAll.labelN2PostShuf = naiveBayesMeanAll.labelN2PostShuf(:,1:numRecActual-1);
    naiveBayesMeanAll.PosteriorN2Shuf = naiveBayesMeanAll.PosteriorN2Shuf(:,:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrMeanShuf = naiveBayesMeanAll.decodingErrMeanShuf(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrModeShuf = naiveBayesMeanAll.decodingErrModeShuf(:,1:numRecActual-1);
    naiveBayesMeanAll.decodingErrPostShuf = naiveBayesMeanAll.decodingErrPostShuf(:,1:numRecActual-1);
end

function [naiveBayesMeanAllMean] = calMeanNaiveBayes(naiveBayesMeanAll)
    naiveBayesMeanAllMean.labelN2Mode = mode(naiveBayesMeanAll.labelN2Mode,2);
    naiveBayesMeanAllMean.PosteriorN2 = mean(naiveBayesMeanAll.PosteriorN2,3);
    [~,maxIdxPoster] = max(naiveBayesMeanAllMean.PosteriorN2);
    naiveBayesMeanAllMean.labelN2Post = naiveBayesMeanAll.time(maxIdxPoster);
    naiveBayesMeanAllMean.CostN2 = mean(naiveBayesMeanAll.CostN2,3);
    naiveBayesMeanAllMean.decodingErrMean = mean(naiveBayesMeanAll.decodingErrMean,2);
    naiveBayesMeanAllMean.decodingErrMode = mode(naiveBayesMeanAll.decodingErrMode,2);
    naiveBayesMeanAllMean.decodingErrPost = naiveBayesMeanAllMean.labelN2Post - naiveBayesMeanAll.time;
    naiveBayesMeanAllMean.decodingErrMeanSEM = std(naiveBayesMeanAll.decodingErrMean,0,2)/sqrt(length(naiveBayesMeanAll.recNo)); 
    naiveBayesMeanAllMean.decodingErrModeSEM = std(naiveBayesMeanAll.decodingErrMode,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    naiveBayesMeanAllMean.decodingErrPostSEM = std(naiveBayesMeanAll.decodingErrPost,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    
    naiveBayesMeanAllMean.labelN2ModeStim = mode(naiveBayesMeanAll.labelN2ModeStim,2);
    naiveBayesMeanAllMean.PosteriorN2Stim = mean(naiveBayesMeanAll.PosteriorN2Stim,3);
    [~,maxIdxPoster] = max(naiveBayesMeanAllMean.PosteriorN2Stim);
    naiveBayesMeanAllMean.labelN2PostStim = naiveBayesMeanAll.time(maxIdxPoster);
    naiveBayesMeanAllMean.decodingErrMeanStim = mean(naiveBayesMeanAll.decodingErrMeanStim,2);
    naiveBayesMeanAllMean.decodingErrModeStim = mode(naiveBayesMeanAll.decodingErrModeStim,2);
    naiveBayesMeanAllMean.decodingErrPostStim = naiveBayesMeanAllMean.labelN2PostStim - naiveBayesMeanAll.time;
    naiveBayesMeanAllMean.decodingErrMeanStimSEM = std(naiveBayesMeanAll.decodingErrMeanStim,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    naiveBayesMeanAllMean.decodingErrModeStimSEM = std(naiveBayesMeanAll.decodingErrModeStim,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    naiveBayesMeanAllMean.decodingErrPostStimSEM = std(naiveBayesMeanAll.decodingErrPostStim,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
        
    naiveBayesMeanAllMean.labelN2ModeShuf = mode(naiveBayesMeanAll.labelN2ModeShuf,2);    
    naiveBayesMeanAllMean.PosteriorN2Shuf = mean(naiveBayesMeanAll.PosteriorN2Shuf,3);
    [~,maxIdxPoster] = max(naiveBayesMeanAllMean.PosteriorN2Shuf);
    naiveBayesMeanAllMean.labelN2PostShuf = naiveBayesMeanAll.time(maxIdxPoster);
    naiveBayesMeanAllMean.decodingErrMeanShuf = mean(naiveBayesMeanAll.decodingErrMeanShuf,2);
    naiveBayesMeanAllMean.decodingErrModeShuf = mode(naiveBayesMeanAll.decodingErrModeShuf,2);
    naiveBayesMeanAllMean.decodingErrPostShuf = naiveBayesMeanAllMean.labelN2PostShuf - naiveBayesMeanAll.time;
    naiveBayesMeanAllMean.decodingErrMeanShufSEM = std(naiveBayesMeanAll.decodingErrMeanShuf,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    naiveBayesMeanAllMean.decodingErrModeShufSEM = std(naiveBayesMeanAll.decodingErrModeShuf,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
    naiveBayesMeanAllMean.decodingErrPostShufSEM = std(naiveBayesMeanAll.decodingErrPostShuf,0,2)/sqrt(length(naiveBayesMeanAll.recNo));
        
    for i = 1:length(naiveBayesMeanAllMean.labelN2Mode)
        naiveBayesMeanAllMean.pLabelN2ModeCtrlShuf(i) = ranksum(naiveBayesMeanAll.labelN2Mode(i,:),...
                naiveBayesMeanAll.labelN2ModeShuf(i,:));
        naiveBayesMeanAllMean.pLabelN2PostCtrlShuf(i) = ranksum(naiveBayesMeanAll.labelN2Post(i,:),...
                naiveBayesMeanAll.labelN2PostShuf(i,:));
        
        naiveBayesMeanAllMean.pLabelN2ModeCtrlStim(i) = ranksum(naiveBayesMeanAll.labelN2Mode(i,:),...
                naiveBayesMeanAll.labelN2ModeStim(i,:));
        naiveBayesMeanAllMean.pLabelN2PostCtrlStim(i) = ranksum(naiveBayesMeanAll.labelN2Post(i,:),...
                naiveBayesMeanAll.labelN2PostStim(i,:));
            
        naiveBayesMeanAllMean.decodingErrPrsMeanCtrlShuf(i) = ranksum(naiveBayesMeanAll.decodingErrMean(i,:),...
                naiveBayesMeanAll.decodingErrMeanShuf(i,:));
        naiveBayesMeanAllMean.decodingErrPrsModeCtrlShuf(i) = ranksum(naiveBayesMeanAll.decodingErrMode(i,:),...
                naiveBayesMeanAll.decodingErrModeShuf(i,:));
        naiveBayesMeanAllMean.decodingErrPrsPostCtrlShuf(i) = ranksum(naiveBayesMeanAll.decodingErrPost(i,:),...
                naiveBayesMeanAll.decodingErrPostShuf(i,:));
            
        naiveBayesMeanAllMean.decodingErrPrsMeanCtrlStim(i) = ranksum(naiveBayesMeanAll.decodingErrMean(i,:),...
                naiveBayesMeanAll.decodingErrMeanStim(i,:));
        naiveBayesMeanAllMean.decodingErrPrsModeCtrlStim(i) = ranksum(naiveBayesMeanAll.decodingErrMode(i,:),...
                naiveBayesMeanAll.decodingErrModeStim(i,:));
        naiveBayesMeanAllMean.decodingErrPrsPostCtrlStim(i) = ranksum(naiveBayesMeanAll.decodingErrPost(i,:),...
                naiveBayesMeanAll.decodingErrPostStim(i,:));
    end
end

function plotPosterior(PosteriorP,time,title1,fileName,pathAnal) 
    if(isempty(PosteriorP))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400]);
        
    h = imagesc(time',time',PosteriorP);
    set(gca,'YDir','normal')
    colormap hot
    colorbar
    hold on;
    [~,indMaxPosterior] = max(PosteriorP);
    h = plot(time,time(indMaxPosterior));
    set(h,'LineWidth', 2, 'Color',[1 1 1]);
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end

function plotPosteriorWLabel(PosteriorP,label,time,title1,fileName,pathAnal) 
    if(isempty(PosteriorP))
        return;
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400]);
        
    h = imagesc(time',time',PosteriorP);
    set(gca,'YDir','normal')
    colormap hot
    colorbar
    hold on;
    h = plot(time,label);
    set(h,'LineWidth', 2, 'Color',[1 1 1]);
    xlabel('Real time (s)')
    ylabel('Decoded time (s)')
    title(title1)
    
    fileName1 = [pathAnal fileName];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
    saveas(gcf,[fileName1 '.png'])
end