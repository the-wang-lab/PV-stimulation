function PyrExplainedVarAllRecSig(taskSel,pshuffle)
%% calculate how much the variance of firing rate for each pyramidal neuron can be 
%% explained by the firing rate from [-1.5 1.5] sec or [-1 1] sec around the run onset  
%% accumulate over all the recordings

    pathAnal0 = 'Z:\Yingxue\Draft\PV\Pyramidal\';
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
    pathAnal1 = 'Z:\Yingxue\Draft\PV\PyrVarExplained\';
    if(exist([pathAnal1 'varPyrAllRec.mat']))
        load([pathAnal1 'varPyrAllRec.mat']);
    end
    
    if(taskSel == 1) % including all the neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSig\' num2str(pshuffle) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigALPL\' num2str(pshuffle) '\'];
    else
        pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalIntInitPeakSigAL\' num2str(pshuffle) '\'];
    end
    
    if(exist([pathAnal 'initPeakPyrIntAllRecSig.mat']))
        load([pathAnal 'initPeakPyrIntAllRecSig.mat']);
    end
    
    if(exist([pathAnal 'expVarPyrAllRecSig.mat']))
        load([pathAnal 'expVarPyrAllRecSig.mat']);
    end
    
    if(exist('ExpVarAllPyr') == 0)
        %% run onset
        ExpVarAllPyr = PyrIntInitPeakByTypeSig(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrNoCue,varPyrAL,varPyrPL);
        
        psig = 0.01;
        psig1 = 0.05;
        PyrRiseExpVar.rsquared = ExpVarAllPyr.rsquared(PyrRise.idxRise);
        PyrRiseExpVar.pFstat = ExpVarAllPyr.pFstat(PyrRise.idxRise);
        PyrRiseExpVar.rsquaredN1to1 = ExpVarAllPyr.rsquaredN1to1(PyrRise.idxRise);
        PyrRiseExpVar.pFstatN1to1 = ExpVarAllPyr.pFstatN1to1(PyrRise.idxRise);
        
        PyrRiseExpVar.pFstatPercSig0p01 = sum(PyrRiseExpVar.pFstat < psig)/length(PyrRiseExpVar.pFstat);
        PyrRiseExpVar.pFstatPercSig0p05 = sum(PyrRiseExpVar.pFstat < psig1)/length(PyrRiseExpVar.pFstat);
        PyrRiseExpVar.meanRsquared = mean(PyrRiseExpVar.rsquared);
        PyrRiseExpVar.pFstatN1to1PercSig0p01 = sum(PyrRiseExpVar.pFstatN1to1 < psig)/length(PyrRiseExpVar.pFstatN1to1);
        PyrRiseExpVar.pFstatN1to1PercSig0p05 = sum(PyrRiseExpVar.pFstatN1to1 < psig1)/length(PyrRiseExpVar.pFstatN1to1);
        PyrRiseExpVar.meanRsquaredN1to1 = mean(PyrRiseExpVar.rsquaredN1to1);
               
        PyrDownExpVar.rsquared = ExpVarAllPyr.rsquared(PyrDown.idxDown);
        PyrDownExpVar.pFstat = ExpVarAllPyr.pFstat(PyrDown.idxDown);
        PyrDownExpVar.rsquaredN1to1 = ExpVarAllPyr.rsquaredN1to1(PyrDown.idxDown);
        PyrDownExpVar.pFstatN1to1 = ExpVarAllPyr.pFstatN1to1(PyrDown.idxDown);
        
        PyrDownExpVar.pFstatPercSig0p01 = sum(PyrDownExpVar.pFstat < psig)/length(PyrDownExpVar.pFstat);
        PyrDownExpVar.pFstatPercSig0p05 = sum(PyrDownExpVar.pFstat < psig1)/length(PyrDownExpVar.pFstat);
        PyrDownExpVar.meanRsquared = mean(PyrDownExpVar.rsquared);
        PyrDownExpVar.pFstatN1to1PercSig0p01 = sum(PyrDownExpVar.pFstatN1to1 < psig)/length(PyrDownExpVar.pFstatN1to1);
        PyrDownExpVar.pFstatN1to1PercSig0p05 = sum(PyrDownExpVar.pFstatN1to1 < psig1)/length(PyrDownExpVar.pFstatN1to1);
        PyrDownExpVar.meanRsquaredN1to1 = mean(PyrDownExpVar.rsquaredN1to1);
        
        PyrOtherExpVar.rsquared = ExpVarAllPyr.rsquared(PyrOther.idxOther);
        PyrOtherExpVar.pFstat = ExpVarAllPyr.pFstat(PyrOther.idxOther);
        PyrOtherExpVar.rsquaredN1to1 = ExpVarAllPyr.rsquaredN1to1(PyrOther.idxOther);
        PyrOtherExpVar.pFstatN1to1 = ExpVarAllPyr.pFstatN1to1(PyrOther.idxOther);
        
        PyrOtherExpVar.pFstatPercSig0p01 = sum(PyrOtherExpVar.pFstat < psig)/length(PyrOtherExpVar.pFstat);
        PyrOtherExpVar.pFstatPercSig0p05 = sum(PyrOtherExpVar.pFstat < psig1)/length(PyrOtherExpVar.pFstat);
        PyrOtherExpVar.meanRsquared = mean(PyrOtherExpVar.rsquared);
        PyrOtherExpVar.pFstatN1to1PercSig0p01 = sum(PyrOtherExpVar.pFstatN1to1 < psig)/length(PyrOtherExpVar.pFstatN1to1);
        PyrOtherExpVar.pFstatN1to1PercSig0p05 = sum(PyrOtherExpVar.pFstatN1to1 < psig1)/length(PyrOtherExpVar.pFstatN1to1);
        PyrOtherExpVar.meanRsquaredN1to1 = mean(PyrOtherExpVar.rsquaredN1to1);
        
        %% cue
        ExpVarAllPyrCue = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrCueNoCue1,varPyrCueAL,varPyrCuePL);
        
        PyrRiseExpVarCue.rsquared = ExpVarAllPyrCue.rsquared(PyrRise.idxRise);
        PyrRiseExpVarCue.pFstat = ExpVarAllPyrCue.pFstat(PyrRise.idxRise);
        PyrRiseExpVarCue.rsquaredN1to1 = ExpVarAllPyrCue.rsquaredN1to1(PyrRise.idxRise);
        PyrRiseExpVarCue.pFstatN1to1 = ExpVarAllPyrCue.pFstatN1to1(PyrRise.idxRise);
        
        PyrRiseExpVarCue.pFstatPercSig0p01 = sum(PyrRiseExpVarCue.pFstat < psig)/length(PyrRiseExpVarCue.pFstat);
        PyrRiseExpVarCue.pFstatPercSig0p05 = sum(PyrRiseExpVarCue.pFstat < psig1)/length(PyrRiseExpVarCue.pFstat);
        PyrRiseExpVarCue.meanRsquared = mean(PyrRiseExpVarCue.rsquared);
        PyrRiseExpVarCue.pFstatN1to1PercSig0p01 = sum(PyrRiseExpVarCue.pFstatN1to1 < psig)/length(PyrRiseExpVarCue.pFstatN1to1);
        PyrRiseExpVarCue.pFstatN1to1PercSig0p05 = sum(PyrRiseExpVarCue.pFstatN1to1 < psig1)/length(PyrRiseExpVarCue.pFstatN1to1);
        PyrRiseExpVarCue.meanRsquaredN1to1 = mean(PyrRiseExpVarCue.rsquaredN1to1);
               
        PyrDownExpVarCue.rsquared = ExpVarAllPyrCue.rsquared(PyrDown.idxDown);
        PyrDownExpVarCue.pFstat = ExpVarAllPyrCue.pFstat(PyrDown.idxDown);
        PyrDownExpVarCue.rsquaredN1to1 = ExpVarAllPyrCue.rsquaredN1to1(PyrDown.idxDown);
        PyrDownExpVarCue.pFstatN1to1 = ExpVarAllPyrCue.pFstatN1to1(PyrDown.idxDown);
        
        PyrDownExpVarCue.pFstatPercSig0p01 = sum(PyrDownExpVarCue.pFstat < psig)/length(PyrDownExpVarCue.pFstat);
        PyrDownExpVarCue.pFstatPercSig0p05 = sum(PyrDownExpVarCue.pFstat < psig1)/length(PyrDownExpVarCue.pFstat);
        PyrDownExpVarCue.meanRsquared = mean(PyrDownExpVarCue.rsquared);
        PyrDownExpVarCue.pFstatN1to1PercSig0p01 = sum(PyrDownExpVarCue.pFstatN1to1 < psig)/length(PyrDownExpVarCue.pFstatN1to1);
        PyrDownExpVarCue.pFstatN1to1PercSig0p05 = sum(PyrDownExpVarCue.pFstatN1to1 < psig1)/length(PyrDownExpVarCue.pFstatN1to1);
        PyrDownExpVarCue.meanRsquaredN1to1 = mean(PyrDownExpVarCue.rsquaredN1to1);
        
        PyrOtherExpVarCue.rsquared = ExpVarAllPyrCue.rsquared(PyrOther.idxOther);
        PyrOtherExpVarCue.pFstat = ExpVarAllPyrCue.pFstat(PyrOther.idxOther);
        PyrOtherExpVarCue.rsquaredN1to1 = ExpVarAllPyrCue.rsquaredN1to1(PyrOther.idxOther);
        PyrOtherExpVarCue.pFstatN1to1 = ExpVarAllPyrCue.pFstatN1to1(PyrOther.idxOther);
        
        PyrOtherExpVarCue.pFstatPercSig0p01 = sum(PyrOtherExpVarCue.pFstat < psig)/length(PyrOtherExpVarCue.pFstat);
        PyrOtherExpVarCue.pFstatPercSig0p05 = sum(PyrOtherExpVarCue.pFstat < psig1)/length(PyrOtherExpVarCue.pFstat);
        PyrOtherExpVarCue.meanRsquared = mean(PyrOtherExpVarCue.rsquared);
        PyrOtherExpVarCue.pFstatN1to1PercSig0p01 = sum(PyrOtherExpVarCue.pFstatN1to1 < psig)/length(PyrOtherExpVarCue.pFstatN1to1);
        PyrOtherExpVarCue.pFstatN1to1PercSig0p05 = sum(PyrOtherExpVarCue.pFstatN1to1 < psig1)/length(PyrOtherExpVarCue.pFstatN1to1);
        PyrOtherExpVarCue.meanRsquaredN1to1 = mean(PyrOtherExpVarCue.rsquaredN1to1);
        
        %% reward
        ExpVarAllPyrRew = PyrIntInitPeakByType(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                    varPyrRewNoCue1,varPyrRewAL,varPyrRewPL);
        
        PyrRiseExpVarRew.rsquared = ExpVarAllPyrRew.rsquared(PyrRise.idxRise);
        PyrRiseExpVarRew.pFstat = ExpVarAllPyrRew.pFstat(PyrRise.idxRise);
        PyrRiseExpVarRew.rsquaredN1to1 = ExpVarAllPyrRew.rsquaredN1to1(PyrRise.idxRise);
        PyrRiseExpVarRew.pFstatN1to1 = ExpVarAllPyrRew.pFstatN1to1(PyrRise.idxRise);
        
        PyrRiseExpVarRew.pFstatPercSig0p01 = sum(PyrRiseExpVarRew.pFstat < psig)/length(PyrRiseExpVarRew.pFstat);
        PyrRiseExpVarRew.pFstatPercSig0p05 = sum(PyrRiseExpVarRew.pFstat < psig1)/length(PyrRiseExpVarRew.pFstat);
        PyrRiseExpVarRew.meanRsquared = mean(PyrRiseExpVarRew.rsquared);
        PyrRiseExpVarRew.pFstatN1to1PercSig0p01 = sum(PyrRiseExpVarRew.pFstatN1to1 < psig)/length(PyrRiseExpVarRew.pFstatN1to1);
        PyrRiseExpVarRew.pFstatN1to1PercSig0p05 = sum(PyrRiseExpVarRew.pFstatN1to1 < psig1)/length(PyrRiseExpVarRew.pFstatN1to1);
        PyrRiseExpVarRew.meanRsquaredN1to1 = mean(PyrRiseExpVarRew.rsquaredN1to1);
               
        PyrDownExpVarRew.rsquared = ExpVarAllPyrRew.rsquared(PyrDown.idxDown);
        PyrDownExpVarRew.pFstat = ExpVarAllPyrRew.pFstat(PyrDown.idxDown);
        PyrDownExpVarRew.rsquaredN1to1 = ExpVarAllPyrRew.rsquaredN1to1(PyrDown.idxDown);
        PyrDownExpVarRew.pFstatN1to1 = ExpVarAllPyrRew.pFstatN1to1(PyrDown.idxDown);
        
        PyrDownExpVarRew.pFstatPercSig0p01 = sum(PyrDownExpVarRew.pFstat < psig)/length(PyrDownExpVarRew.pFstat);
        PyrDownExpVarRew.pFstatPercSig0p05 = sum(PyrDownExpVarRew.pFstat < psig1)/length(PyrDownExpVarRew.pFstat);
        PyrDownExpVarRew.meanRsquared = mean(PyrDownExpVarRew.rsquared);
        PyrDownExpVarRew.pFstatN1to1PercSig0p01 = sum(PyrDownExpVarRew.pFstatN1to1 < psig)/length(PyrDownExpVarRew.pFstatN1to1);
        PyrDownExpVarRew.pFstatN1to1PercSig0p05 = sum(PyrDownExpVarRew.pFstatN1to1 < psig1)/length(PyrDownExpVarRew.pFstatN1to1);
        PyrDownExpVarRew.meanRsquaredN1to1 = mean(PyrDownExpVarRew.rsquaredN1to1);
        
        PyrOtherExpVarRew.rsquared = ExpVarAllPyrRew.rsquared(PyrOther.idxOther);
        PyrOtherExpVarRew.pFstat = ExpVarAllPyrRew.pFstat(PyrOther.idxOther);
        PyrOtherExpVarRew.rsquaredN1to1 = ExpVarAllPyrRew.rsquaredN1to1(PyrOther.idxOther);
        PyrOtherExpVarRew.pFstatN1to1 = ExpVarAllPyrRew.pFstatN1to1(PyrOther.idxOther);
        
        PyrOtherExpVarRew.pFstatPercSig0p01 = sum(PyrOtherExpVarRew.pFstat < psig)/length(PyrOtherExpVarRew.pFstat);
        PyrOtherExpVarRew.pFstatPercSig0p05 = sum(PyrOtherExpVarRew.pFstat < psig1)/length(PyrOtherExpVarRew.pFstat);
        PyrOtherExpVarRew.meanRsquared = mean(PyrOtherExpVarRew.rsquared);
        PyrOtherExpVarRew.pFstatN1to1PercSig0p01 = sum(PyrOtherExpVarRew.pFstatN1to1 < psig)/length(PyrOtherExpVarRew.pFstatN1to1);
        PyrOtherExpVarRew.pFstatN1to1PercSig0p05 = sum(PyrOtherExpVarRew.pFstatN1to1 < psig1)/length(PyrOtherExpVarRew.pFstatN1to1);
        PyrOtherExpVarRew.meanRsquaredN1to1 = mean(PyrOtherExpVarRew.rsquaredN1to1);
    end
    
    save([pathAnal1 'expVarPyrAllRecSig' num2str(pshuffle) '.mat'],'ExpVarAllPyr','PyrRiseExpVar','PyrDownExpVar','PyrOtherExpVar',...
        'ExpVarAllPyrCue','PyrRiseExpVarCue','PyrDownExpVarCue','PyrOtherExpVarCue',...
        'ExpVarAllPyrRew','PyrRiseExpVarRew','PyrDownExpVarRew','PyrOtherExpVarRew');
    
end

function ExpVarAllPyr = PyrIntInitPeakByTypeSig(taskSel,modPyr1NoCue,modPyr1AL,modPyr1PL,...
                                varPyrNoCue,varPyrAL,varPyrPL)
    if(taskSel == 1)
        if(sum(modPyr1NoCue.indNeuGood-varPyrNoCue.indNeu) == 0 && ...
                sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0 && ...
                sum(modPyr1PL.indNeuGood-varPyrPL.indNeu) == 0)
            ExpVarAllPyr.task = [modPyr1NoCue.taskGood modPyr1AL.taskGood modPyr1PL.taskGood];
            ExpVarAllPyr.indRec = [modPyr1NoCue.indRecGood modPyr1AL.indRecGood modPyr1PL.indRecGood];
            ExpVarAllPyr.indNeu = [modPyr1NoCue.indNeuGood modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
            ExpVarAllPyr.rsquared = [varPyrNoCue.rsquared varPyrAL.rsquared ...
                varPyrPL.rsquared]; 
            ExpVarAllPyr.pFstat = [varPyrNoCue.pFstat varPyrAL.pFstat ...
                varPyrPL.pFstat]; 
            ExpVarAllPyr.rsquaredN1to1 = [varPyrNoCue.rsquaredN1to1 varPyrAL.rsquaredN1to1 ...
                varPyrPL.rsquaredN1to1]; 
            ExpVarAllPyr.pFstatN1to1 = [varPyrNoCue.pFstatN1to1 varPyrAL.pFstatN1to1 ...
                varPyrPL.pFstatN1to1]; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end
    elseif(taskSel == 2)
        if(sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0 && ...
                sum(modPyr1PL.indNeuGood-varPyrPL.indNeu) == 0)
            ExpVarAllPyr.task = [modPyr1AL.taskGood modPyr1PL.taskGood];
            ExpVarAllPyr.indRec = [modPyr1AL.indRecGood modPyr1PL.indRecGood];
            ExpVarAllPyr.indNeu = [modPyr1AL.indNeuGood modPyr1PL.indNeuGood];
            ExpVarAllPyr.rsquared = [varPyrAL.rsquared varPyrPL.rsquared]; 
            ExpVarAllPyr.pFstat = [varPyrAL.pFstat varPyrPL.pFstat]; 
            ExpVarAllPyr.rsquaredN1to1 = [varPyrAL.rsquaredN1to1 varPyrPL.rsquaredN1to1]; 
            ExpVarAllPyr.pFstatN1to1 = [varPyrAL.pFstatN1to1 varPyrPL.pFstatN1to1]; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end            
    elseif(taskSel == 3)
        if(sum(modPyr1AL.indNeuGood-varPyrAL.indNeu) == 0)
            ExpVarAllPyr.task = modPyr1AL.taskGood;
            ExpVarAllPyr.indRec = modPyr1AL.indRecGood;
            ExpVarAllPyr.indNeu = modPyr1AL.indNeuGood;
            ExpVarAllPyr.rsquared = varPyrAL.rsquared; 
            ExpVarAllPyr.pFstat = varPyrAL.pFstat; 
            ExpVarAllPyr.rsquaredN1to1 = varPyrAL.rsquaredN1to1; 
            ExpVarAllPyr.pFstatN1to1 = varPyrAL.pFstatN1to1; 
        else
            disp('modPyr1 and varPyr do not have equal number of neurons');
        end
    end
end