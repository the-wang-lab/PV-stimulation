function PyrExplainedVarAllRecShortInterval(taskSel)
%% calculate how much the variance of firing rate for each pyramidal neuron can be 
%% explained by the firing rate from [-1.5 1.5] sec or [-1 1] sec around the run onset  
%% accumulate over all the recordings

    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
    pathAnal1 = 'Z:\Yingxue\Draft\PV\PyrVarExplained\';
    if(exist([pathAnal1 'varPyrAllRecShortInterval.mat']))
        load([pathAnal1 'varPyrAllRecShortInterval.mat']);
    end
    
    if(exist([pathAnal1 'varPyrAllRecCueRewShortInterval.mat']))
        load([pathAnal1 'varPyrAllRecCueRewShortInterval.mat']);
    end
    
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeak\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakALPL\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakAL\'];
    end
    
    if(exist([pathAnal 'initPeakPyrIntAllRec.mat']))
        load([pathAnal 'initPeakPyrIntAllRec.mat']);
    end
    
    if(exist([pathAnal 'expVarPyrAllRec.mat']))
        load([pathAnal 'expVarPyrAllRec.mat']);
    end
        
    if(exist('ExpVarAllPyr') == 0)
        %% run onset
        ExpVarAllPyr = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrNoCue,varPyrAL,varPyrPL);
        
        psig = 0.01;
        psig1 = 0.05;
        
        PyrRiseExpVar.rsquared0p5 = ExpVarAllPyr.rsquared0p5(PyrRise.idxRise);
        PyrRiseExpVar.pFstat0p5 = ExpVarAllPyr.pFstat0p5(PyrRise.idxRise);
        PyrRiseExpVar.rsquared0p3 = ExpVarAllPyr.rsquared0p3(PyrRise.idxRise);
        PyrRiseExpVar.pFstat0p3 = ExpVarAllPyr.pFstat0p3(PyrRise.idxRise);
        
        PyrRiseExpVar.pFstat0p5PercSig0p01 = sum(PyrRiseExpVar.pFstat0p5 < psig)/length(PyrRiseExpVar.pFstat0p5);
        PyrRiseExpVar.pFstat0p5PercSig0p05 = sum(PyrRiseExpVar.pFstat0p5 < psig1)/length(PyrRiseExpVar.pFstat0p5);
        PyrRiseExpVar.meanRsquared0p5 = mean(PyrRiseExpVar.rsquared0p5);
        PyrRiseExpVar.pFstat0p3PercSig0p01 = sum(PyrRiseExpVar.pFstat0p3 < psig)/length(PyrRiseExpVar.pFstat0p3);
        PyrRiseExpVar.pFstat0p3PercSig0p05 = sum(PyrRiseExpVar.pFstat0p3 < psig1)/length(PyrRiseExpVar.pFstat0p3);
        PyrRiseExpVar.meanRsquared0p3 = mean(PyrRiseExpVar.rsquared0p3);
               
        PyrDownExpVar.rsquared0p5 = ExpVarAllPyr.rsquared0p5(PyrDown.idxDown);
        PyrDownExpVar.pFstat0p5 = ExpVarAllPyr.pFstat0p5(PyrDown.idxDown);
        PyrDownExpVar.rsquared0p3 = ExpVarAllPyr.rsquared0p3(PyrDown.idxDown);
        PyrDownExpVar.pFstat0p3 = ExpVarAllPyr.pFstat0p3(PyrDown.idxDown);
        
        PyrDownExpVar.pFstat0p5PercSig0p01 = sum(PyrDownExpVar.pFstat0p5 < psig)/length(PyrDownExpVar.pFstat0p5);
        PyrDownExpVar.pFstat0p5PercSig0p05 = sum(PyrDownExpVar.pFstat0p5 < psig1)/length(PyrDownExpVar.pFstat0p5);
        PyrDownExpVar.meanRsquared0p5 = mean(PyrDownExpVar.rsquared0p5);
        PyrDownExpVar.pFstat0p3PercSig0p01 = sum(PyrDownExpVar.pFstat0p3 < psig)/length(PyrDownExpVar.pFstat0p3);
        PyrDownExpVar.pFstat0p3PercSig0p05 = sum(PyrDownExpVar.pFstat0p3 < psig1)/length(PyrDownExpVar.pFstat0p3);
        PyrDownExpVar.meanRsquared0p3 = mean(PyrDownExpVar.rsquared0p3);
        
        PyrOtherExpVar.rsquared0p5 = ExpVarAllPyr.rsquared0p5(PyrOther.idxOther);
        PyrOtherExpVar.pFstat0p5 = ExpVarAllPyr.pFstat0p5(PyrOther.idxOther);
        PyrOtherExpVar.rsquared0p3 = ExpVarAllPyr.rsquared0p3(PyrOther.idxOther);
        PyrOtherExpVar.pFstat0p3 = ExpVarAllPyr.pFstat0p3(PyrOther.idxOther);
        
        PyrOtherExpVar.pFstat0p5PercSig0p01 = sum(PyrOtherExpVar.pFstat0p5 < psig)/length(PyrOtherExpVar.pFstat0p5);
        PyrOtherExpVar.pFstat0p5PercSig0p05 = sum(PyrOtherExpVar.pFstat0p5 < psig1)/length(PyrOtherExpVar.pFstat0p5);
        PyrOtherExpVar.meanRsquared0p5 = mean(PyrOtherExpVar.rsquared0p5);
        PyrOtherExpVar.pFstat0p3PercSig0p01 = sum(PyrOtherExpVar.pFstat0p3 < psig)/length(PyrOtherExpVar.pFstat0p3);
        PyrOtherExpVar.pFstat0p3PercSig0p05 = sum(PyrOtherExpVar.pFstat0p3 < psig1)/length(PyrOtherExpVar.pFstat0p3);
        PyrOtherExpVar.meanRsquared0p3 = mean(PyrOtherExpVar.rsquared0p3);
        
        %% cue
        ExpVarAllPyrCue = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrCueNoCue1,varPyrCueAL1,varPyrCuePL1);
        
        PyrRiseExpVarCue.rsquared0p5 = ExpVarAllPyrCue.rsquared0p5(PyrRise.idxRise);
        PyrRiseExpVarCue.pFstat0p5 = ExpVarAllPyrCue.pFstat0p5(PyrRise.idxRise);
        PyrRiseExpVarCue.rsquared0p3 = ExpVarAllPyrCue.rsquared0p3(PyrRise.idxRise);
        PyrRiseExpVarCue.pFstat0p3 = ExpVarAllPyrCue.pFstat0p3(PyrRise.idxRise);
        
        PyrRiseExpVarCue.pFstat0p5PercSig0p01 = sum(PyrRiseExpVarCue.pFstat0p5 < psig)/length(PyrRiseExpVarCue.pFstat0p5);
        PyrRiseExpVarCue.pFstat0p5PercSig0p05 = sum(PyrRiseExpVarCue.pFstat0p5 < psig1)/length(PyrRiseExpVarCue.pFstat0p5);
        PyrRiseExpVarCue.meanRsquared0p5 = mean(PyrRiseExpVarCue.rsquared0p5);
        PyrRiseExpVarCue.pFstat0p3PercSig0p01 = sum(PyrRiseExpVarCue.pFstat0p3 < psig)/length(PyrRiseExpVarCue.pFstat0p3);
        PyrRiseExpVarCue.pFstat0p3PercSig0p05 = sum(PyrRiseExpVarCue.pFstat0p3 < psig1)/length(PyrRiseExpVarCue.pFstat0p3);
        PyrRiseExpVarCue.meanRsquared0p3 = mean(PyrRiseExpVarCue.rsquared0p3);
               
        PyrDownExpVarCue.rsquared0p5 = ExpVarAllPyrCue.rsquared0p5(PyrDown.idxDown);
        PyrDownExpVarCue.pFstat0p5 = ExpVarAllPyrCue.pFstat0p5(PyrDown.idxDown);
        PyrDownExpVarCue.rsquared0p3 = ExpVarAllPyrCue.rsquared0p3(PyrDown.idxDown);
        PyrDownExpVarCue.pFstat0p3 = ExpVarAllPyrCue.pFstat0p3(PyrDown.idxDown);
        
        PyrDownExpVarCue.pFstat0p5PercSig0p01 = sum(PyrDownExpVarCue.pFstat0p5 < psig)/length(PyrDownExpVarCue.pFstat0p5);
        PyrDownExpVarCue.pFstat0p5PercSig0p05 = sum(PyrDownExpVarCue.pFstat0p5 < psig1)/length(PyrDownExpVarCue.pFstat0p5);
        PyrDownExpVarCue.meanRsquared0p5 = mean(PyrDownExpVarCue.rsquared0p5);
        PyrDownExpVarCue.pFstat0p3PercSig0p01 = sum(PyrDownExpVarCue.pFstat0p3 < psig)/length(PyrDownExpVarCue.pFstat0p3);
        PyrDownExpVarCue.pFstat0p3PercSig0p05 = sum(PyrDownExpVarCue.pFstat0p3 < psig1)/length(PyrDownExpVarCue.pFstat0p3);
        PyrDownExpVarCue.meanRsquared0p3 = mean(PyrDownExpVarCue.rsquared0p3);
        
        PyrOtherExpVarCue.rsquared0p5 = ExpVarAllPyrCue.rsquared0p5(PyrOther.idxOther);
        PyrOtherExpVarCue.pFstat0p5 = ExpVarAllPyrCue.pFstat0p5(PyrOther.idxOther);
        PyrOtherExpVarCue.rsquared0p3 = ExpVarAllPyrCue.rsquared0p3(PyrOther.idxOther);
        PyrOtherExpVarCue.pFstat0p3 = ExpVarAllPyrCue.pFstat0p3(PyrOther.idxOther);
        
        PyrOtherExpVarCue.pFstat0p5PercSig0p01 = sum(PyrOtherExpVarCue.pFstat0p5 < psig)/length(PyrOtherExpVarCue.pFstat0p5);
        PyrOtherExpVarCue.pFstat0p5PercSig0p05 = sum(PyrOtherExpVarCue.pFstat0p5 < psig1)/length(PyrOtherExpVarCue.pFstat0p5);
        PyrOtherExpVarCue.meanRsquared0p5 = mean(PyrOtherExpVarCue.rsquared0p5);
        PyrOtherExpVarCue.pFstat0p3PercSig0p01 = sum(PyrOtherExpVarCue.pFstat0p3 < psig)/length(PyrOtherExpVarCue.pFstat0p3);
        PyrOtherExpVarCue.pFstat0p3PercSig0p05 = sum(PyrOtherExpVarCue.pFstat0p3 < psig1)/length(PyrOtherExpVarCue.pFstat0p3);
        PyrOtherExpVarCue.meanRsquared0p3 = mean(PyrOtherExpVarCue.rsquared0p3);
        
        %% reward
        ExpVarAllPyrRew = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrRewNoCue1,varPyrRewAL1,varPyrRewPL1);
        
        PyrRiseExpVarRew.rsquared0p5 = ExpVarAllPyrRew.rsquared0p5(PyrRise.idxRise);
        PyrRiseExpVarRew.pFstat0p5 = ExpVarAllPyrRew.pFstat0p5(PyrRise.idxRise);
        PyrRiseExpVarRew.rsquared0p3 = ExpVarAllPyrRew.rsquared0p3(PyrRise.idxRise);
        PyrRiseExpVarRew.pFstat0p3 = ExpVarAllPyrRew.pFstat0p3(PyrRise.idxRise);
        
        PyrRiseExpVarRew.pFstat0p5PercSig0p01 = sum(PyrRiseExpVarRew.pFstat0p5 < psig)/length(PyrRiseExpVarRew.pFstat0p5);
        PyrRiseExpVarRew.pFstat0p5PercSig0p05 = sum(PyrRiseExpVarRew.pFstat0p5 < psig1)/length(PyrRiseExpVarRew.pFstat0p5);
        PyrRiseExpVarRew.meanRsquared0p5 = mean(PyrRiseExpVarRew.rsquared0p5);
        PyrRiseExpVarRew.pFstat0p3PercSig0p01 = sum(PyrRiseExpVarRew.pFstat0p3 < psig)/length(PyrRiseExpVarRew.pFstat0p3);
        PyrRiseExpVarRew.pFstat0p3PercSig0p05 = sum(PyrRiseExpVarRew.pFstat0p3 < psig1)/length(PyrRiseExpVarRew.pFstat0p3);
        PyrRiseExpVarRew.meanRsquared0p3 = mean(PyrRiseExpVarRew.rsquared0p3);
               
        PyrDownExpVarRew.rsquared0p5 = ExpVarAllPyrRew.rsquared0p5(PyrDown.idxDown);
        PyrDownExpVarRew.pFstat0p5 = ExpVarAllPyrRew.pFstat0p5(PyrDown.idxDown);
        PyrDownExpVarRew.rsquared0p3 = ExpVarAllPyrRew.rsquared0p3(PyrDown.idxDown);
        PyrDownExpVarRew.pFstat0p3 = ExpVarAllPyrRew.pFstat0p3(PyrDown.idxDown);
        
        PyrDownExpVarRew.pFstat0p5PercSig0p01 = sum(PyrDownExpVarRew.pFstat0p5 < psig)/length(PyrDownExpVarRew.pFstat0p5);
        PyrDownExpVarRew.pFstat0p5PercSig0p05 = sum(PyrDownExpVarRew.pFstat0p5 < psig1)/length(PyrDownExpVarRew.pFstat0p5);
        PyrDownExpVarRew.meanRsquared0p5 = mean(PyrDownExpVarRew.rsquared0p5);
        PyrDownExpVarRew.pFstat0p3PercSig0p01 = sum(PyrDownExpVarRew.pFstat0p3 < psig)/length(PyrDownExpVarRew.pFstat0p3);
        PyrDownExpVarRew.pFstat0p3PercSig0p05 = sum(PyrDownExpVarRew.pFstat0p3 < psig1)/length(PyrDownExpVarRew.pFstat0p3);
        PyrDownExpVarRew.meanRsquared0p3 = mean(PyrDownExpVarRew.rsquared0p3);
        
        PyrOtherExpVarRew.rsquared0p5 = ExpVarAllPyrRew.rsquared0p5(PyrOther.idxOther);
        PyrOtherExpVarRew.pFstat0p5 = ExpVarAllPyrRew.pFstat0p5(PyrOther.idxOther);
        PyrOtherExpVarRew.rsquared0p3 = ExpVarAllPyrRew.rsquared0p3(PyrOther.idxOther);
        PyrOtherExpVarRew.pFstat0p3 = ExpVarAllPyrRew.pFstat0p3(PyrOther.idxOther);
        
        PyrOtherExpVarRew.pFstat0p5PercSig0p01 = sum(PyrOtherExpVarRew.pFstat0p5 < psig)/length(PyrOtherExpVarRew.pFstat0p5);
        PyrOtherExpVarRew.pFstat0p5PercSig0p05 = sum(PyrOtherExpVarRew.pFstat0p5 < psig1)/length(PyrOtherExpVarRew.pFstat0p5);
        PyrOtherExpVarRew.meanRsquared0p5 = mean(PyrOtherExpVarRew.rsquared0p5);
        PyrOtherExpVarRew.pFstat0p3PercSig0p01 = sum(PyrOtherExpVarRew.pFstat0p3 < psig)/length(PyrOtherExpVarRew.pFstat0p3);
        PyrOtherExpVarRew.pFstat0p3PercSig0p05 = sum(PyrOtherExpVarRew.pFstat0p3 < psig1)/length(PyrOtherExpVarRew.pFstat0p3);
        PyrOtherExpVarRew.meanRsquared0p3 = mean(PyrOtherExpVarRew.rsquared0p3);
    end
    
    save([pathAnal1 'expVarPyrAllRecShortInterval.mat'],'ExpVarAllPyr','PyrRiseExpVar','PyrDownExpVar','PyrOtherExpVar',...
        'ExpVarAllPyrCue','PyrRiseExpVarCue','PyrDownExpVarCue','PyrOtherExpVarCue',...
        'ExpVarAllPyrRew','PyrRiseExpVarRew','PyrDownExpVarRew','PyrOtherExpVarRew');
    
end

function ExpVarAllPyr = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                varPyrNoCue,varPyrAL,varPyrPL)
    if(taskSel == 1)
        if(sum(modPyr1NoCue.indNeuGood-varPyrNoCue.indNeu) == 0 && ...
                sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0 && ...
                sum(modPyr1PL.indNeuGood-varPyrPL.indNeu) == 0)
            ExpVarAllPyr.task = [modPyr1NoCue.taskGood modPyr1AL.taskGood modPyr1PL.taskGood];
            ExpVarAllPyr.indRec = [modPyr1NoCue.indRecGood modPyr1AL.indRecGood modPyr1PL.indRecGood];
            ExpVarAllPyr.indNeu = [modPyr1NoCue.indNeuGood modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
            ExpVarAllPyr.rsquared0p5 = [varPyrNoCue.rsquared0p5 varPyrAL.rsquared0p5 ...
                varPyrPL.rsquared0p5]; 
            ExpVarAllPyr.pFstat0p5 = [varPyrNoCue.pFstat0p5 varPyrAL.pFstat0p5 ...
                varPyrPL.pFstat0p5]; 
            ExpVarAllPyr.rsquared0p3 = [varPyrNoCue.rsquared0p3 varPyrAL.rsquared0p3 ...
                varPyrPL.rsquared0p3]; 
            ExpVarAllPyr.pFstat0p3 = [varPyrNoCue.pFstat0p3 varPyrAL.pFstat0p3 ...
                varPyrPL.pFstat0p3]; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end
    elseif(taskSel == 2)
        if(sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0 && ...
                sum(modPyr1PL.indNeuGood-varPyrPL.indNeu) == 0)
            ExpVarAllPyr.task = [modPyr1AL.taskGood modPyr1PL.taskGood];
            ExpVarAllPyr.indRec = [modPyr1AL.indRecGood modPyr1PL.indRecGood];
            ExpVarAllPyr.indNeu = [modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
            ExpVarAllPyr.rsquared0p5 = [varPyrAL.rsquared0p5 varPyrPL.rsquared0p5]; 
            ExpVarAllPyr.pFstat0p5 = [varPyrAL.pFstat0p5 varPyrPL.pFstat0p5]; 
            ExpVarAllPyr.rsquared0p3 = [varPyrAL.rsquared0p3 varPyrPL.rsquared0p3]; 
            ExpVarAllPyr.pFstat0p3 = [varPyrAL.pFstat0p3 varPyrPL.pFstat0p3]; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end            
    elseif(taskSel == 3)
        if(sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0)
            ExpVarAllPyr.task = modPyr1AL.taskGood;
            ExpVarAllPyr.indRec = modPyr1AL.indRecGood;
            ExpVarAllPyr.indNeu = modPyr1AL.indNeuGood;
            ExpVarAllPyr.rsquared0p5 = varPyrAL.rsquared0p5; 
            ExpVarAllPyr.pFstat0p5 = varPyrAL.pFstat0p5; 
            ExpVarAllPyr.rsquared0p3 = varPyrAL.rsquared0p3; 
            ExpVarAllPyr.pFstat0p3 = varPyrAL.pFstat0p3; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end
    end
end