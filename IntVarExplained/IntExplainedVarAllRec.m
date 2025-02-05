function IntExplainedVarAllRec(taskSel)
%% calculate how much the variance of firing rate for each pyramidal neuron can be 
%% explained by the firing rate from [-1.5 1.5] sec or [-1 1] sec around the run onset  
%% accumulate over all the recordings

    
    pathAnalInt0 = 'Z:\Yingxue\Draft\PV\Interneuron\';
    if(exist([pathAnalInt0 'initPeakIntAllRec.mat']))
        load([pathAnalInt0 'initPeakIntAllRec.mat']);
    end
    
    pathAnal1 = 'Z:\Yingxue\Draft\PV\IntVarExplained\';
    if(exist([pathAnal1 'varIntAllRec.mat']))
        load([pathAnal1 'varIntAllRec.mat']);
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
    
    if(exist([pathAnal 'expVarIntAllRec.mat']))
        load([pathAnal 'expVarIntAllRec.mat']);
    end
    
    
    if(exist('ExpVarAllPyr') == 0)
        ExpVarAllInt = PyrIntInitPeakByType(taskSel,modInt1NoCue,modInt1AL,modInt1PL,...
                                    varIntNoCue,varIntAL,varIntPL);
        
        psig = 0.01;
        psig1 = 0.05;
        for i = 1:length(IntRise.idxRise)
            IntRiseExpVar.rsquared{i} = ExpVarAllInt.rsquared(IntRise.idxRise{i});
            IntRiseExpVar.pFstat{i} = ExpVarAllInt.pFstat(IntRise.idxRise{i});
            IntRiseExpVar.rsquaredN1to1{i} = ExpVarAllInt.rsquaredN1to1(IntRise.idxRise{i});
            IntRiseExpVar.pFstatN1to1{i} = ExpVarAllInt.pFstatN1to1(IntRise.idxRise{i});

            IntRiseExpVar.pFstatPercSig0p01{i} = sum(IntRiseExpVar.pFstat{i} < psig)/length(IntRiseExpVar.pFstat{i});
            IntRiseExpVar.pFstatPercSig0p05{i} = sum(IntRiseExpVar.pFstat{i} < psig1)/length(IntRiseExpVar.pFstat{i});
            IntRiseExpVar.meanRsquared{i} = mean(IntRiseExpVar.rsquared{i});
            IntRiseExpVar.pFstatN1to1PercSig0p01{i} = sum(IntRiseExpVar.pFstatN1to1{i} < psig)/length(IntRiseExpVar.pFstatN1to1{i});
            IntRiseExpVar.pFstatN1to1PercSig0p05{i} = sum(IntRiseExpVar.pFstatN1to1{i} < psig1)/length(IntRiseExpVar.pFstatN1to1{i});
            IntRiseExpVar.meanRsquaredN1to1{i} = mean(IntRiseExpVar.rsquaredN1to1{i});

            IntDownExpVar.rsquared{i} = ExpVarAllInt.rsquared(IntDown.idxDown{i});
            IntDownExpVar.pFstat{i} = ExpVarAllInt.pFstat(IntDown.idxDown{i});
            IntDownExpVar.rsquaredN1to1{i} = ExpVarAllInt.rsquaredN1to1(IntDown.idxDown{i});
            IntDownExpVar.pFstatN1to1{i} = ExpVarAllInt.pFstatN1to1(IntDown.idxDown{i});

            IntDownExpVar.pFstatPercSig0p01{i} = sum(IntDownExpVar.pFstat{i} < psig)/length(IntDownExpVar.pFstat{i});
            IntDownExpVar.pFstatPercSig0p05{i} = sum(IntDownExpVar.pFstat{i} < psig1)/length(IntDownExpVar.pFstat{i});
            IntDownExpVar.meanRsquared{i} = mean(IntDownExpVar.rsquared{i});
            IntDownExpVar.pFstatN1to1PercSig0p01{i} = sum(IntDownExpVar.pFstatN1to1{i} < psig)/length(IntDownExpVar.pFstatN1to1{i});
            IntDownExpVar.pFstatN1to1PercSig0p05{i} = sum(IntDownExpVar.pFstatN1to1{i} < psig1)/length(IntDownExpVar.pFstatN1to1{i});
            IntDownExpVar.meanRsquaredN1to1{i} = mean(IntDownExpVar.rsquaredN1to1{i});
        end
        
    end
    
    save([pathAnal1 'expVarIntAllRec.mat'],'ExpVarAllInt','IntRiseExpVar','IntDownExpVar');
    
end

function ExpVarAllInt = PyrIntInitPeakByType(taskSel,modInt1NoCue,modInt1AL,modInt1PL,...
                                varIntNoCue,varIntAL,varIntPL)
    if(taskSel == 1)
        if(sum(modInt1NoCue.indNeuGood-varIntNoCue.indNeu) == 0 && ...
                sum(modInt1AL.indNeuGood-varIntAL.indNeu) == 0 && ...
                sum(modInt1PL.indNeuGood-varIntPL.indNeu) == 0)
            ExpVarAllInt.task = [modInt1NoCue.taskGood modInt1AL.taskGood modInt1PL.taskGood];
            ExpVarAllInt.indRec = [modInt1NoCue.indRecGood modInt1AL.indRecGood modInt1PL.indRecGood];
            ExpVarAllInt.indNeu = [modInt1NoCue.indNeuGood modInt1AL.indNeuGood modInt1PL.indNeuGood];
            ExpVarAllInt.rsquared = [varIntNoCue.rsquared varIntAL.rsquared ...
                varIntPL.rsquared]; 
            ExpVarAllInt.pFstat = [varIntNoCue.pFstat varIntAL.pFstat ...
                varIntPL.pFstat]; 
            ExpVarAllInt.rsquaredN1to1 = [varIntNoCue.rsquaredN1to1 varIntAL.rsquaredN1to1 ...
                varIntPL.rsquaredN1to1]; 
            ExpVarAllInt.pFstatN1to1 = [varIntNoCue.pFstatN1to1 varIntAL.pFstatN1to1 ...
                varIntPL.pFstatN1to1]; 
        else
            disp('modInt1 and varInt do not have equal number of neurons');
        end
    elseif(taskSel == 2)
        if(sum(modInt1AL.indNeuGood-varIntAL.indNeu) == 0 && ...
                sum(modInt1PL.indNeuGood-varIntPL.indNeu) == 0)
            ExpVarAllInt.task = [modInt1AL.taskGood modInt1PL.taskGood];
            ExpVarAllInt.indRec = [modInt1AL.indRecGood modInt1PL.indRecGood];
            ExpVarAllInt.indNeu = [modInt1AL.indNeuGood modInt1PL.indNeuGood];
            ExpVarAllInt.rsquared = [varIntAL.rsquared varIntPL.rsquared]; 
            ExpVarAllInt.pFstat = [varIntAL.pFstat varIntPL.pFstat]; 
            ExpVarAllInt.rsquaredN1to1 = [varIntAL.rsquaredN1to1 varIntPL.rsquaredN1to1]; 
            ExpVarAllInt.pFstatN1to1 = [varIntAL.pFstatN1to1 varIntPL.pFstatN1to1]; 
        else
            disp('modInt1 and varInt do not have equal number of neurons');
        end            
    elseif(taskSel == 3)
        if(sum(modInt1AL.indNeuGood-varIntAL.indNeu) == 0)
            ExpVarAllInt.task = modInt1AL.taskGood;
            ExpVarAllInt.indRec = modInt1AL.indRecGood;
            ExpVarAllInt.indNeu = modInt1AL.indNeuGood;
            ExpVarAllInt.rsquared = varIntAL.rsquared; 
            ExpVarAllInt.pFstat = varIntAL.pFstat; 
            ExpVarAllInt.rsquaredN1to1 = varIntAL.rsquaredN1to1; 
            ExpVarAllInt.pFstatN1to1 = varIntAL.pFstatN1to1; 
        else
            disp('modInt1 and varInt do not have equal number of neurons');
        end
    end
end