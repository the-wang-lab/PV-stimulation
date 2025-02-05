function InterneuronInitPeakAllRecSig()
    
    RecordingListPyrIntSST;
    pathAnal0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
   
    GlobalConstFq;
    
    if(exist([pathAnal0 'initPeakPyrAllRecSig.mat']))
        load([pathAnal0 'initPeakPyrAllRecSig.mat']);
    end
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
    
    if(exist('modInt1SigNoCue') == 0)
        disp('No cue - peak firing rate')
        modInt1SigNoCue = intInitSig(listRecordingsNoCuePath,...
                listRecordingsNoCueFileName,mazeSessionNoCue,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                1,minFRInt,p,numShuffle);
            
        disp('Active licking - peak firing rate')
        modInt1SigAL = intInitSig(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                2,minFRInt,p,numShuffle);

        disp('Passive licking - peak firing rate')
        modInt1SigPL = intInitSig(listRecordingsPassiveLickPath,...
                listRecordingsPassiveLickFileName,mazeSessionPassiveLick,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                3,minFRInt,p,numShuffle);

        fullpath = [pathAnal0 'initPeakIntAllRecSig.mat'];
        save([pathAnal0 'initPeakIntAllRecSig.mat'],'modInt1SigNoCue','modInt1SigAL','modInt1SigPL');
    end    
end


function modInt1Sig = ...
    intInitSig(paths,filenames,mazeSess,indAft,indBef,...
    task,minFRInt,p,numShuffle)
   
    modInt1Sig.task = [];
    modInt1Sig.indRec = [];
    modInt1Sig.indNeu = []; 
    modInt1Sig.isPeakNeuArrAll = [];
    modInt1Sig.ratioAftBefShufArrAll = [];
    
    numRec = size(paths,1);
    for i = 1:numRec
        disp(['rec' num2str(i)])
        fileNamePeakFR = [filenames(i,:) '_PeakFR_msess' num2str(mazeSess(i)) ...
                        '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath,'file') == 0)
            disp(['The firing profile file does not exist. Try to run the',...
                        ' "ConvSpikeTrain_AlignedRunOnset" function first.']);
            return;
        end
        load(fullPath);
        
        fullPathFR = [filenames(i,:) '_FR_Run1.mat'];
        fullPath = [paths(i,:) fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(mFRStructSess) > 1)
            mFR = mFRStructSess{mazeSess(i)};
        else
            mFR = mFRStruct;
        end
        
        fullPath = [paths(i,:) filenames(i,:) '_behPar_msess' num2str(mazeSess(i)) '.mat']; 
        if(exist(fullPath) == 0)
            disp('The _behPar file does not exist');
            return;
        end
        load(fullPath);

        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i))...
            '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'trialNoNonStimGood','trialNoNonStimBad');
        
        fileNameInfo = [filenames(i,:) '_Info.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr'); 
        
        fileNameFW = [filenames(i,:) '_FieldSpCorrAligned_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'paramF'); 
                
        indNeu = find(autoCorr.isInterneuron == 1 & mFR.mFR > minFRInt);
        
        if(length(trialNoNonStimGood) >= paramF.minNumTr)
        
            % median trial length
            medTrLen = prctile(behPar.numSamplesRun,75)/1250;
            indTime = find(timeStepRun/1250 >= medTrLen,1);
            if(isempty(indTime))
                indTime = length(timeStepRun);
            end

            isPeakNeuArr = zeros(length(indNeu),length(p));
            ratioAftBefShufArr = zeros(numShuffle,length(indNeu));

            % detect neurons with peaks based on all the trials in the session
            for n = 1:length(indNeu)
%                 disp(['Neuron ' num2str(n)])
                [isPeakNeuArr(n,:),ratioAftBefShufArr(:,n)] = neuPeakDetection(...
                    filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood,1:indTime),...
                    indAft,indBef,p,numShuffle);
            end

            modInt1Sig.task = [modInt1Sig.task task*ones(1,length(indNeu))];
            modInt1Sig.indRec = [modInt1Sig.indRec i*ones(1,length(indNeu))];
            modInt1Sig.indNeu = [modInt1Sig.indNeu indNeu]; 
            modInt1Sig.isPeakNeuArrAll = [modInt1Sig.isPeakNeuArrAll; isPeakNeuArr];
            modInt1Sig.ratioAftBefShufArrAll = [modInt1Sig.ratioAftBefShufArrAll ratioAftBefShufArr];
        else
            disp(['Recording ' filenames(i,:) ' has ' num2str(length(trialNoNonStimGood)) ' good trials']);
        end
    end
    
end
