function PyrIntInitPeakPVStimCtrlNormPerRec(methodKMean)
% compare Pyramidal neurons and PV interneurons on their initial peak
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalPVStimALCtrl\'];
    pathAnal1 = ['Z:\Yingxue\Draft\PV\PyramidalPVStimALCtrl\PerRecNorm\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalPVStimALCtrl\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat']))
        load([pathAnal 'initPeakPyrAllRecStimCtrlTr.mat']);
    end
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimCtrlTr.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimCtrlTr.mat']);
    end
    
    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl;
    
    PyrStim.avgFRProfile = avgFRProfile;
    PyrStim.avgFRProfileStim = avgFRProfileStim;
    PyrStim.avgFRProfileStimCtrl = avgFRProfileStimCtrl;
    PyrStim.avgFRProfileNorm = zeros(size(avgFRProfile,1),size(avgFRProfile,2));
    for i = 1:size(avgFRProfile,1)
        if(max(avgFRProfile(i,:)) ~= 0)
            PyrStim.avgFRProfileNorm(i,:) = avgFRProfile(i,:)/max(avgFRProfile(i,:));
        end
    end
    PyrStim.avgFRProfileNormStim = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfileStim(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStim(i,:) = avgFRProfileStim(i,:)/max(avgFRProfileStim(i,:));
        end
    end
    PyrStim.avgFRProfileNormStimRStimCtrl = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfileStim(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStimRStimCtrl(i,:) = avgFRProfileStim(i,:)/max(avgFRProfileStimCtrl(i,:));
        end
    end
    PyrStim.avgFRProfileNormStimCtrl = zeros(size(avgFRProfileStimCtrl,1),size(avgFRProfileStimCtrl,2));
    for i = 1:size(avgFRProfileStimCtrl,1)
        if(max(avgFRProfileStimCtrl(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStimCtrl(i,:) = avgFRProfileStimCtrl(i,:)/max(avgFRProfileStimCtrl(i,:));
        end
    end
        
    for cond = 1:length(PyrStim1.FRProfile1)
        recList = unique(PyrStim1.FRProfile1{cond}.indRecPyrRise);
        for j = 1:length(recList)
            %% all the cells for each recording and each stim condition
            % for each recording and each stim condition, finding the FR profile for each pyramidal rise neuron
            indRecList = PyrStim1.FRProfile1{cond}.indRecPyrRise == recList(j);
            FRProfile = PyrStim.avgFRProfileNorm(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            FRProfileStim = PyrStim.avgFRProfileNormStim(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            FRProfileStimRStimCtrl = PyrStim.avgFRProfileNormStimRStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            FRProfileStimCtrl = PyrStim.avgFRProfileNormStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            
            % compare good non stim trials with stim trials, pyr rise
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfile,FRProfileStim,...
                ['FRPyrRiseNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimRStimCtrl,FRProfileStim,...
                ['FRPyrRiseNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrRiseStimCtrlVsStimRStimCtrl_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimCtrl,FRProfileStim,...
                ['FRPyrRiseNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrRiseStimCtrlVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
            % for each recording and each stim condition, finding the FR profile for each pyramidal down neuron
            indRecList = PyrStim1.FRProfile1{cond}.indRecPyrDown == recList(j);
            FRProfile = PyrStim.avgFRProfileNorm(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            FRProfileStim = PyrStim.avgFRProfileNormStim(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            FRProfileStimRStimCtrl = PyrStim.avgFRProfileNormStimRStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            FRProfileStimCtrl = PyrStim.avgFRProfileNormStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            
            % compare good non stim trials with stim trials, pyr rise
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfile,FRProfileStim,...
                ['FRPyrDownNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimRStimCtrl,FRProfileStim,...
                ['FRPyrDownNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrDownStimCtrlVsStimRStimCtrl_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimCtrl,FRProfileStim,...
                ['FRPyrDownNm Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrDownStimCtrlVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
            %% all the cells with fields for each recording and each stim condition
            % for each recording and each stim condition, finding the FR profile for each pyramidal rise neuron
            indRecList = PyrStim1.FRProfile1{cond}.indRecPyrRise == recList(j) &...
                    PyrRise.isNeuWithFieldAligned{cond}.isFieldComb == 1;
            FRProfile = PyrStim.avgFRProfileNorm(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            FRProfileStim = PyrStim.avgFRProfileNormStim(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            FRProfileStimCtrl = PyrStim.avgFRProfileNormStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise(indRecList),:);
            
            % compare good non stim trials with stim trials, pyr rise
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfile,FRProfileStim,...
                ['FRPyrRiseNmFC Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrRiseFieldCombNoStimGoodVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimCtrl,FRProfileStim,...
                ['FRPyrRiseNmFC Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrRiseFieldCombStimCtrlVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
            % for each recording and each stim condition, finding the FR profile for each pyramidal down neuron
            indRecList = PyrStim1.FRProfile1{cond}.indRecPyrDown == recList(j) &...
                    PyrDown.isNeuWithFieldAligned{cond}.isFieldComb == 1;
            FRProfile = PyrStim.avgFRProfileNorm(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            FRProfileStim = PyrStim.avgFRProfileNormStim(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            FRProfileStimCtrl = PyrStim.avgFRProfileNormStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown(indRecList),:);
            
            % compare good non stim trials with stim trials, pyr rise
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfile,FRProfileStim,...
                ['FRPyrDownNmFC Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrDownFieldCombNoStimGoodVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
            plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                FRProfileStimCtrl,FRProfileStim,...
                ['FRPyrDownNmFC Rec' num2str(recList(j)) 'N' num2str(sum(indRecList))],...
                ['Pyr_FRProfileNormPyrDownFieldCombStimCtrlVsStim_Cond' num2str(cond) '_Rec' num2str(recList(j))],...
                pathAnal1,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
        end
        
        pause;
        close all;
    end
end







