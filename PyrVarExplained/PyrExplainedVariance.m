function PyrExplainedVariance()
%% calculate how much the variance of firing rate for each pyramidal neuron can be 
%% explained by the firing rate from [-1.5 1.5] sec or [-1 1] sec around the run onset  

    RecordingListPyrInt;
    pathAnal0 = 'Z:\Yingxue\Draft\PV\PyrVarExplained\';
    
    if(~exist(pathAnal0))
        mkdir(pathAnal0);
    end
    
    pathAnalPeak0 = 'Z:\Yingxue\Draft\PV\PyramidalInitPeak\2\';
    if(exist([pathAnalPeak0 'initPeakPyrAllRec_km2.mat']))
        load([pathAnalPeak0 'initPeakPyrAllRec_km2.mat'],'FRProfileMean');
    end
        
    GlobalConstFq;
    
    if(exist('varPyrNoCue') == 0)
        disp('No cue - variance explained')
        varPyrNoCue = ...
            varPyrCal(listRecordingsNoCuePath,...
                listRecordingsNoCueFileName,mazeSessionNoCue,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                1,minFR,maxFR);
        
        fullpath = [pathAnal0 'varPyrAllRec.mat'];
        save(fullpath, 'varPyrNoCue','-v7.3');
        
        disp('Active licking - variance explained')
        varPyrAL = ...
            varPyrCal(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                2,minFR,maxFR);
        
        save(fullpath, 'varPyrAL','-append');
        
        disp('Passive licking - variance explained')
        varPyrPL = ...
            varPyrCal(listRecordingsPassiveLickPath,...
                listRecordingsPassiveLickFileName,mazeSessionPassiveLick,...
                FRProfileMean.indFR0to1,FRProfileMean.indFRBefRun,...
                3,minFR,maxFR);
        
        save(fullpath, 'varPyrPL','-append');
    end
end
   
function varPyr = varPyrCal(paths,filenames,mazeSess,indAft,indBef,...
    task,minFR,maxFR)

    varPyr.task = [];
    varPyr.indRec = [];
    varPyr.indNeu = []; 
    varPyr.perTr = [];
    varPyr.perTrRunOnset  = [];
    varPyr.md1 = [];
    varPyr.rsquared = [];
    varPyr.pFstat = [];
    varPyr.perTrRunOnsetN1to1  = [];
    varPyr.mdN1to1 = [];
    varPyr.rsquaredN1to1 = [];
    varPyr.pFstatN1to1 = [];
    
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
        load(fullPath,'filteredSpikeArrayRunOnSet','timeStepRun');
        
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
        load(fullPath,'trialNoNonStimGood');
        
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
                
        indNeu = find(mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1);
        
        if(length(trialNoNonStimGood) >= paramF.minNumTr)
            % median trial length
            medTrLen = prctile(behPar.numSamplesRun,75)/1250;
            indTime = find(timeStepRun/1250 >= medTrLen,1);
            if(isempty(indTime))
                indTime = length(timeStepRun);
            end
            
            indTimeRunOnset = timeStepRun/1250 >= -1 & timeStepRun/1250 <= 1; % indices between -1 to 1 sec around run onset
            
            perTr = cell(1,length(indNeu));
            perTrRunOnset = cell(1,length(indNeu));
            md1 = cell(1,length(indNeu));
            rsquared1 = zeros(1,length(indNeu));
            pFstat1 = zeros(1,length(indNeu));
            
            perTrRunOnsetN1to1 = cell(1,length(indNeu));
            md2 = cell(1,length(indNeu));
            rsquared2 = zeros(1,length(indNeu));
            pFstat2 = zeros(1,length(indNeu));
            
            parfor n = 1:length(indNeu)
                perTr{n} = var(filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood,1:indTime)');
                perTrRunOnset{n} = var(filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood,indBef(1):indAft(end))'); % between -1.5 to 1.5 sec around run onset
                perTrRunOnsetN1to1{n} = var(filteredSpikeArrayRunOnSet{indNeu(n)}(trialNoNonStimGood,indTimeRunOnset)');
                
                md1{n} = fitlm(perTrRunOnset{n},perTr{n},'RobustOpts','on');   
                md2{n} = fitlm(perTrRunOnsetN1to1{n},perTr{n},'RobustOpts','on'); 
                
                rsquared1(n) = md1{n}.Rsquared.Adjusted;
                pFstatTmp = anova(md1{n},'summary');
                pFstat1(n) = pFstatTmp.pValue(2);
                
                rsquared2(n) = md2{n}.Rsquared.Adjusted;
                pFstatTmp = anova(md2{n},'summary');
                pFstat2(n) = pFstatTmp.pValue(2);
            end
            
            varPyr.task = [varPyr.task task*ones(1,length(indNeu))];
            varPyr.indRec = [varPyr.indRec i*ones(1,length(indNeu))];
            varPyr.indNeu = [varPyr.indNeu indNeu]; 
            
            varPyr.perTr = [varPyr.perTr perTr];
            varPyr.perTrRunOnset  = [varPyr.perTrRunOnset perTrRunOnset];
            varPyr.md1 = [varPyr.md1 md1];
            varPyr.rsquared = [varPyr.rsquared rsquared1];
            varPyr.pFstat = [varPyr.pFstat pFstat1];
            
            varPyr.perTrRunOnsetN1to1  = [varPyr.perTrRunOnsetN1to1 perTrRunOnsetN1to1];
            varPyr.mdN1to1 = [varPyr.mdN1to1 md2];
            varPyr.rsquaredN1to1 = [varPyr.rsquaredN1to1 rsquared2];
            varPyr.pFstatN1to1 = [varPyr.pFstatN1to1 pFstat2];
            
        else
            disp(['Recording ' filenames(i,:) ' has ' num2str(length(trialNoNonStimGood)) ' good trials']);
        end
    end
end