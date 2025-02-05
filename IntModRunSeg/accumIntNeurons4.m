function modInt = accumIntNeurons1(paths,filenames,mazeSess,minFRInt,task,onlyRun)

    %% Ints in no cue passive task
    numRec = size(paths,1);
    modInt = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              ...  
                              'minPhaseFilBefRun',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFilBefRun',[],... % the phase which fires the largest number of spikes 
                              'thetaModHistBefRun',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDireBefRun',[],... % the mean phase direction
                              'phaseMeanResultantLenBefRun',[],... % the mean resultant length of the mean phase direction
                              ...
                              'minPhaseFilH0to1',[],... % the phase which fires the least number of spikes (hilbert)
                              'maxPhaseFilH0to1',[],... % the phase which fires the largest number of spikes (hilbert)
                              'thetaModHistH0to1',[],... % theta modulation calculated based on theta phase histogram (hilbert)
                              'phaseMeanDireH0to1',[],... % the mean phase direction (hilbert)
                              'phaseMeanResultantLenH0to1',[],... % the mean resultant length of the mean phase direction (hilbert)
                              ...
                              'minPhaseFil0to1',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFil0to1',[],... % the phase which fires the largest number of spikes 
                              'thetaModHist0to1',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDire0to1',[],... % the mean phase direction
                              'phaseMeanResultantLen0to1',[],... % the mean resultant length of the mean phase direction
                              ...
                              'minPhaseFilH3to5',[],... % the phase which fires the least number of spikes (hilbert)
                              'maxPhaseFilH3to5',[],... % the phase which fires the largest number of spikes (hilbert)
                              'thetaModHistH3to5',[],... % theta modulation calculated based on theta phase histogram (hilbert)
                              'phaseMeanDireH3to5',[],... % the mean phase direction (hilbert)
                              'phaseMeanResultantLenH3to5',[],... % the mean resultant length of the mean phase direction (hilbert)
                              ...
                              'minPhaseFil3to5',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFil3to5',[],... % the phase which fires the largest number of spikes 
                              'thetaModHist3to5',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDire3to5',[],... % the mean phase direction
                              'phaseMeanResultantLen3to5',[],... % the mean resultant length of the mean phase direction
                              ...
                              'minPhaseFilH3to4',[],... % the phase which fires the least number of spikes (hilbert)
                              'maxPhaseFilH3to4',[],... % the phase which fires the largest number of spikes (hilbert)
                              'thetaModHistH3to4',[],... % theta modulation calculated based on theta phase histogram (hilbert)
                              'phaseMeanDireH3to4',[],... % the mean phase direction (hilbert)
                              'phaseMeanResultantLenH3to4',[],... % the mean resultant length of the mean phase direction (hilbert)
                              ...
                              'minPhaseFil3to4',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFil3to4',[],... % the phase which fires the largest number of spikes 
                              'thetaModHist3to4',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDire3to4',[],... % the mean phase direction
                              'phaseMeanResultantLen3to4',[]); % the mean resultant length of the mean phase direction
                          
    for i = 1:numRec
        disp(filenames(i,:));
        if(i == 7)
            a = 1;
        end
        
        fullPath = [paths(i,:) filenames(i,:) '.mat'];
        if(exist(fullPath) == 0)
            disp('File does not exist.');
            return;
        end
        load(fullPath,'cluList'); 
        
        fileNameInfo = [filenames(i,:) '_Info.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr'); 
        
        fileNameThetaPhaseSeg = [filenames(i,:) '_ThetaPhaseLAlignedSeg_msess'...
            num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhaseSeg];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseLAlignedSeg file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStimGood0to1','spikeThetaPhaseRunNoStimGood3to5',...
            'spikeThetaPhaseRunNoStimGood3to4');
        spikeThetaPhaseRunNoStimGood0to1L = spikeThetaPhaseRunNoStimGood0to1;
        spikeThetaPhaseRunNoStimGood3to5L = spikeThetaPhaseRunNoStimGood3to5;
        spikeThetaPhaseRunNoStimGood3to4L = spikeThetaPhaseRunNoStimGood3to4;
        
        fileNameThetaPhaseSeg = [filenames(i,:) '_ThetaPhaseHAlignedSeg_msess'...
            num2str(mazeSess(i)) '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhaseSeg];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseHAlignedSeg file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStimGood0to1','spikeThetaPhaseRunNoStimGood3to5',...
            'spikeThetaPhaseRunNoStimGood3to4');
        
        fileNameThetaPhaseSegBefRun = [filenames(i,:) '_ThetaPhaseLSeg_msess' ...
            num2str(mazeSess(i)) '_RunOnset0.mat'];
        fullPath = [paths(i,:) fileNameThetaPhaseSegBefRun];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseLSeg_RunOnset file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseRunNoStimGoodbefRun');
        
        indNeu = cluList.firingRate > minFRInt &...
                    autoCorr.isInterneuron == 1;
        modInt.task = [modInt.task task*ones(1,sum(indNeu))];
        modInt.indRec = [modInt.indRec i*ones(1,sum(indNeu))];
        modInt.indNeu = [modInt.indNeu find(indNeu == 1)]; 
        
        modInt.minPhaseFil0to1 = [modInt.minPhaseFil0to1 spikeThetaPhaseRunNoStimGood0to1L.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFil0to1 = [modInt.maxPhaseFil0to1 spikeThetaPhaseRunNoStimGood0to1L.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDire0to1 = [modInt.phaseMeanDire0to1 spikeThetaPhaseRunNoStimGood0to1L.meanDire(indNeu)];
        modInt.phaseMeanResultantLen0to1 = [modInt.phaseMeanResultantLen0to1 spikeThetaPhaseRunNoStimGood0to1L.meanResultantLen(indNeu)];
        modInt.thetaModHist0to1 = [modInt.thetaModHist0to1 spikeThetaPhaseRunNoStimGood0to1L.thetaMod(indNeu)]; 
        
        modInt.minPhaseFilH0to1 = [modInt.minPhaseFilH0to1 spikeThetaPhaseRunNoStimGood0to1.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFilH0to1 = [modInt.maxPhaseFilH0to1 spikeThetaPhaseRunNoStimGood0to1.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDireH0to1 = [modInt.phaseMeanDireH0to1 spikeThetaPhaseRunNoStimGood0to1.meanDire(indNeu)];
        modInt.phaseMeanResultantLenH0to1 = [modInt.phaseMeanResultantLenH0to1 spikeThetaPhaseRunNoStimGood0to1.meanResultantLen(indNeu)];
        modInt.thetaModHistH0to1 = [modInt.thetaModHistH0to1 spikeThetaPhaseRunNoStimGood0to1.thetaMod(indNeu)]; 
        
        modInt.minPhaseFil3to5 = [modInt.minPhaseFil3to5 spikeThetaPhaseRunNoStimGood3to5L.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFil3to5 = [modInt.maxPhaseFil3to5 spikeThetaPhaseRunNoStimGood3to5L.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDire3to5 = [modInt.phaseMeanDire3to5 spikeThetaPhaseRunNoStimGood3to5L.meanDire(indNeu)];
        modInt.phaseMeanResultantLen3to5 = [modInt.phaseMeanResultantLen3to5 spikeThetaPhaseRunNoStimGood3to5L.meanResultantLen(indNeu)];
        modInt.thetaModHist3to5 = [modInt.thetaModHist3to5 spikeThetaPhaseRunNoStimGood3to5L.thetaMod(indNeu)]; 
        
        modInt.minPhaseFilH3to5 = [modInt.minPhaseFilH3to5 spikeThetaPhaseRunNoStimGood3to5.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFilH3to5 = [modInt.maxPhaseFilH3to5 spikeThetaPhaseRunNoStimGood3to5.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDireH3to5 = [modInt.phaseMeanDireH3to5 spikeThetaPhaseRunNoStimGood3to5.meanDire(indNeu)];
        modInt.phaseMeanResultantLenH3to5 = [modInt.phaseMeanResultantLenH3to5 spikeThetaPhaseRunNoStimGood3to5.meanResultantLen(indNeu)];
        modInt.thetaModHistH3to5 = [modInt.thetaModHistH3to5 spikeThetaPhaseRunNoStimGood3to5.thetaMod(indNeu)]; 
        
        modInt.minPhaseFil3to4 = [modInt.minPhaseFil3to4 spikeThetaPhaseRunNoStimGood3to4L.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFil3to4 = [modInt.maxPhaseFil3to4 spikeThetaPhaseRunNoStimGood3to4L.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDire3to4 = [modInt.phaseMeanDire3to4 spikeThetaPhaseRunNoStimGood3to4L.meanDire(indNeu)];
        modInt.phaseMeanResultantLen3to4 = [modInt.phaseMeanResultantLen3to4 spikeThetaPhaseRunNoStimGood3to4L.meanResultantLen(indNeu)];
        modInt.thetaModHist3to4 = [modInt.thetaModHist3to4 spikeThetaPhaseRunNoStimGood3to4L.thetaMod(indNeu)]; 
        
        modInt.minPhaseFilH3to4 = [modInt.minPhaseFilH3to4 spikeThetaPhaseRunNoStimGood3to4.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFilH3to4 = [modInt.maxPhaseFilH3to4 spikeThetaPhaseRunNoStimGood3to4.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDireH3to4 = [modInt.phaseMeanDireH3to4 spikeThetaPhaseRunNoStimGood3to4.meanDire(indNeu)];
        modInt.phaseMeanResultantLenH3to4 = [modInt.phaseMeanResultantLenH3to4 spikeThetaPhaseRunNoStimGood3to4.meanResultantLen(indNeu)];
        modInt.thetaModHistH3to4 = [modInt.thetaModHistH3to4 spikeThetaPhaseRunNoStimGood3to4.thetaMod(indNeu)]; 
        
        modInt.minPhaseFilBefRun = [modInt.minPhaseFilBefRun spikeThetaPhaseRunNoStimGoodbefRun.minPhaseFilArr(indNeu)];
        modInt.maxPhaseFilBefRun = [modInt.maxPhaseFilBefRun spikeThetaPhaseRunNoStimGoodbefRun.maxPhaseFilArr(indNeu)];
        modInt.phaseMeanDireBefRun = [modInt.phaseMeanDireBefRun spikeThetaPhaseRunNoStimGoodbefRun.meanDire(indNeu)];
        modInt.phaseMeanResultantLenBefRun = [modInt.phaseMeanResultantLenBefRun spikeThetaPhaseRunNoStimGoodbefRun.meanResultantLen(indNeu)];
        modInt.thetaModHistBefRun = [modInt.thetaModHistBefRun spikeThetaPhaseRunNoStimGoodbefRun.thetaMod(indNeu)]; 
    end
    
    indDire = find(modInt.phaseMeanDireBefRun < 0);
    modInt.phaseMeanDireBefRun(indDire) = modInt.phaseMeanDireBefRun(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDire0to1 < 0);
    modInt.phaseMeanDire0to1(indDire) = modInt.phaseMeanDire0to1(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDire3to5 < 0);
    modInt.phaseMeanDire3to5(indDire) = modInt.phaseMeanDire3to5(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDire3to4 < 0);
    modInt.phaseMeanDire3to4(indDire) = modInt.phaseMeanDire3to4(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDireH0to1 < 0);
    modInt.phaseMeanDireH0to1(indDire) = modInt.phaseMeanDireH0to1(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDireH3to5 < 0);
    modInt.phaseMeanDireH3to5(indDire) = modInt.phaseMeanDireH3to5(indDire) + 2*pi;
    
    indDire = find(modInt.phaseMeanDireH3to4 < 0);
    modInt.phaseMeanDireH3to4(indDire) = modInt.phaseMeanDireH3to4(indDire) + 2*pi;
end