function fieldStimEffectPVAct(location)
%% PV activation midcue recordings
% location == 1, mid cue
% location == 2, run onset

    RecordingList;
    
    pathAnal0 = 'Z:\Yingxue\Draft\PV\PVActivationField\';
    if(location == 1)
        numRec = [66:72 82:89];
        str = 'MidCue';
    elseif(location == 2)
        numRec = [11:16 35:39 51:53];
        str = 'RunOnset'; 
    end
    
    fieldPerRec = struct(...
        'indRec',zeros(1,length(numRec)),...
        'noStim',zeros(1,length(numRec)),...
        'stim',zeros(1,length(numRec)),...
        'stimCtrl',zeros(1,length(numRec)));
    
    PVStimField = struct(...
        'indRec',[],...
        'indNeuron',[],...
        'FW',[],...
        'indStart',[],...
        'indPeak',[],...
        'peakFR',[],...
        'meanCorrNZ',[],...
        'spatialInfo',[]);
    
    PVFieldNoStim = PVStimField;
    PVFieldStim = PVStimField;
    PVFieldStimCtrl = PVStimField;
    
    PVStimCom = struct(...
        'indRec',[],...
        ...
        'indNeuron',[],...
        'FW1',[],...
        'indStart1',[],...
        'indPeak1',[],...
        'peakFR1',[],...
        'spatialInfo1',[],...
        'meanCorrNZ1',[],...
        ...
        'FW2',[],...
        'indStart2',[],...
        'indPeak2',[],...
        'peakFR2',[],...
        'spatialInfo2',[],...
        'meanCorrNZ2',[],...
        ...
        'ratioCommon1',[],...
        'ratioCommon2',[]);
    
    PVNoStim_Stim_Com = PVStimCom;
    PVNoStim_StimCtrl_Com = PVStimCom;
    
    PVStimOnly = struct(...
        'indRec',[],...
        ...
        'indNeuron',[],...
        'FW',[],...
        'indStart',[],...
        'indPeak',[],...
        'peakFR',[],...
        'spatialInfo',[],...
        'meanCorrNZ',[],...
        ...
        'ratioOnly1',[],...
        'ratioOnly2',[]);
        
    PVNoStim_Stim_NoStimOnly = PVStimOnly;
    PVNoStim_StimCtrl_NoStimOnly = PVStimOnly;
    PVNoStim_Stim_StimOnly = PVStimOnly;
    PVNoStim_StimCtrl_StimCtrlOnly = PVStimOnly;
    
    noRec = 0;   
    for i = numRec
        noRec = noRec + 1;
        disp(listRecordingsActiveLickPath(i,:))
        cd(listRecordingsActiveLickPath(i,:));
        
        fileNamePeakFR = [listRecordingsActiveLickFileName(i,:)...
            '_PeakFRAligned_msess' num2str(mazeSessionActiveLick(i)) ...
            '_Run1.mat'];
        load(fileNamePeakFR,'pulseMeth');
        if(location == 1)
            indStimSess = find(pulseMeth == 3);
        elseif(location == 2)
            indStimSess = find(pulseMeth == 2);
        end
        
        % fields from no stim trials
        fileNameFieldNoStim = [listRecordingsActiveLickFileName(i,:)...
            '_FieldSpCorrAlignedCtrl_Run' ...
            num2str(mazeSessionActiveLick(i)) '_Run1.mat'];
        load(fileNameFieldNoStim,'fieldSpCorrSessNonStim');
        PVFieldNoStim = fieldInfoCollection(PVFieldNoStim,...
            fieldSpCorrSessNonStim,i);
        
        % fields from stim and stim ctrl trials 
        fileNameFieldStim = [listRecordingsActiveLickFileName(i,:) ...
            '_FieldSpCorrAlignedStim_Run' ...
            num2str(mazeSessionActiveLick(i)) '_Run1.mat'];
        load(fileNameFieldStim,'fieldSpCorrSessStim','fieldSpCorrSessStimCtrl');

        PVFieldStim = fieldInfoCollection(PVFieldStim,...
            fieldSpCorrSessStim{indStimSess},i);
        PVFieldStimCtrl = fieldInfoCollection(PVFieldStimCtrl,...
            fieldSpCorrSessStimCtrl{indStimSess},i);
        
        % number of fields per condition 
        fieldPerRec.indRec(noRec) = i;
        if(~isempty(fieldSpCorrSessNonStim))
            fieldPerRec.noStim(noRec) = length(fieldSpCorrSessNonStim.indNeuron);
        end
        if(~isempty(fieldSpCorrSessStim))
            fieldPerRec.stim(noRec) = length(fieldSpCorrSessStim{indStimSess}.indNeuron);
        end
        if(~isempty(fieldSpCorrSessStimCtrl))
            fieldPerRec.stimCtrl(noRec) = length(fieldSpCorrSessStimCtrl{indStimSess}.indNeuron);
        end
        
        % common fields
        PVNoStim_Stim_Com = fieldComnon(PVNoStim_Stim_Com,...
            fieldSpCorrSessNonStim,fieldSpCorrSessStim{indStimSess},i);
        PVNoStim_StimCtrl_Com = fieldComnon(PVNoStim_StimCtrl_Com,...
            fieldSpCorrSessNonStim,fieldSpCorrSessStimCtrl{indStimSess},i);
        
        % fields unique to no stim trials
        PVNoStim_Stim_NoStimOnly = fieldOnly(PVNoStim_Stim_NoStimOnly,...
            fieldSpCorrSessNonStim,fieldSpCorrSessStim{indStimSess},i);
        PVNoStim_StimCtrl_NoStimOnly = fieldOnly(PVNoStim_StimCtrl_NoStimOnly,...
            fieldSpCorrSessNonStim,fieldSpCorrSessStimCtrl{indStimSess},i);
        
        % fields unique to stim trials
        PVNoStim_Stim_StimOnly = fieldOnly(PVNoStim_Stim_StimOnly,...
            fieldSpCorrSessStim{indStimSess},fieldSpCorrSessNonStim,i);
        
        % fields unique to stim ctrl trials
        PVNoStim_StimCtrl_StimCtrlOnly = fieldOnly(PVNoStim_StimCtrl_StimCtrlOnly,...
            fieldSpCorrSessStimCtrl{indStimSess},fieldSpCorrSessNonStim,i);
    end
    
    save([pathAnal0 'PVActivation' str 'Field.mat'],...
        'PVFieldNoStim','PVFieldStim','PVFieldStimCtrl','fieldPerRec',...
        'PVNoStim_Stim_Com','PVNoStim_StimCtrl_Com',...
        'PVNoStim_Stim_NoStimOnly','PVNoStim_StimCtrl_NoStimOnly',...
        'PVNoStim_Stim_StimOnly','PVNoStim_StimCtrl_StimCtrlOnly');
end

%% collect field information
function field = fieldInfoCollection(field,fieldSpCorr,recNo)
    if(~isempty(fieldSpCorr))
        field.indRec = [field.indRec ...
            recNo*ones(1,length(fieldSpCorr.indNeuron))];
        field.indNeuron = [field.indNeuron fieldSpCorr.indNeuron];
        field.FW = [field.FW fieldSpCorr.FW];
        field.indStart = [field.indStart fieldSpCorr.indStartField];
        field.indPeak = [field.indPeak fieldSpCorr.indPeakField];
        field.peakFR = [field.peakFR fieldSpCorr.peakInstFiringRate];
        field.meanCorrNZ = [field.meanCorrNZ fieldSpCorr.meanCorrNZ];
        field.spatialInfo = [field.spatialInfo fieldSpCorr.spatialInfo];
    end
end

%% find common fields
function fieldCmp = fieldComnon(fieldCmp,field1,field2,recNo)
    if(~isempty(field1) && ~isempty(field2))
        [common,ind1,ind2] = intersect(field1.indNeuron,field2.indNeuron);
        if(~isempty(common))
            fieldCmp.indRec = [fieldCmp.indRec recNo*ones(1,length(common))];

            fieldCmp.indNeuron = [fieldCmp.indNeuron common];
            fieldCmp.FW1 = [fieldCmp.FW1 field1.FW(ind1)];
            fieldCmp.indStart1 = [fieldCmp.indStart1 field1.indStartField(ind1)];
            fieldCmp.indPeak1 = [fieldCmp.indPeak1 field1.indPeakField(ind1)];
            fieldCmp.peakFR1 = [fieldCmp.peakFR1 field1.peakInstFiringRate(ind1)];
            fieldCmp.spatialInfo1 = [fieldCmp.spatialInfo1 field1.spatialInfo(ind1)];
            fieldCmp.meanCorrNZ1 = [fieldCmp.meanCorrNZ1 field1.meanCorrNZ(ind1)];

            fieldCmp.FW2 = [fieldCmp.FW2 field2.FW(ind2)];
            fieldCmp.indStart2 = [fieldCmp.indStart2 field2.indStartField(ind2)];
            fieldCmp.indPeak2 = [fieldCmp.indPeak2 field2.indPeakField(ind2)];
            fieldCmp.peakFR2 = [fieldCmp.peakFR2 field2.peakInstFiringRate(ind2)];
            fieldCmp.spatialInfo2 = [fieldCmp.spatialInfo2 field2.spatialInfo(ind2)];
            fieldCmp.meanCorrNZ2 = [fieldCmp.meanCorrNZ2 field2.meanCorrNZ(ind2)];

            fieldCmp.ratioCommon1 = [fieldCmp.ratioCommon1 ...
                length(common)/length(field1.indNeuron)*ones(1,length(common))];
            fieldCmp.ratioCommon2 = [fieldCmp.ratioCommon2 ...
                length(common)/length(field2.indNeuron)*ones(1,length(common))];
        end
    end
end

%% find fields only show up in one condition
function fieldOnly = fieldOnly(fieldOnly,field1,field2,recNo)
    if(~isempty(field1))
        if(~isempty(field2))
            [only,ind1] = setdiff(field1.indNeuron,field2.indNeuron);
        else
            only = field1.indNeuron;
            ind1 = 1:length(field1.indNeuron);
        end
        if(~isempty(only))
            fieldOnly.indRec = [fieldOnly.indRec recNo*ones(1,length(only))];
            
            fieldOnly.indNeuron = [fieldOnly.indNeuron only];
            fieldOnly.FW = [fieldOnly.FW field1.FW(ind1)];
            fieldOnly.indStart = [fieldOnly.indStart field1.indStartField(ind1)];
            fieldOnly.indPeak = [fieldOnly.indPeak field1.indPeakField(ind1)];
            fieldOnly.peakFR = [fieldOnly.peakFR field1.peakInstFiringRate(ind1)];
            fieldOnly.spatialInfo = [fieldOnly.spatialInfo field1.spatialInfo(ind1)];
            fieldOnly.meanCorrNZ = [fieldOnly.meanCorrNZ field1.meanCorrNZ(ind1)];

            fieldOnly.ratioOnly1 = [fieldOnly.ratioOnly1 ...
                length(only)/length(field1.indNeuron)*ones(1,length(only))];
            if(~isempty(field2) && ~isempty(field2.indNeuron))
                fieldOnly.ratioOnly2 = [fieldOnly.ratioOnly2 ...
                length(only)/length(field2.indNeuron)*ones(1,length(only))];
            else
                fieldOnly.ratioOnly2 = [fieldOnly.ratioOnly2 ...
                    -1*ones(1,length(only))];
            end
        end
    end
end