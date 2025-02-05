RecordingListFigure1;

onlyRun = 1;
% numRec = size(listRecordingsNoCuePath,1);
% for i = 1:numRec
%     disp(listRecordingsNoCuePath(i,:))
%     cd(listRecordingsNoCuePath(i,:));
%     ProcessingMice_smTrSpeedLick(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1,mazeSessionNoCue(i));
%     ProcessingMice_smTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1);
%     ProcessingMice_smTr_GoodTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1,mazeSessionNoCue(i));
%     FieldWidthLR_GoodTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),20,1,2,0,...
%         onlyRun,mazeSessionNoCue(i));
% %     pause;
%     close all;
%     ProcessingAligned(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1,mazeSessionNoCue(i),1);
%     ProcessingAlignedRun0(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),mazeSessionNoCue(i),1);
%     close all;
% 
%     FieldWidthLRAligned(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1,0,1,mazeSessionNoCue(i));
% end

numRec = size(listRecordingsActiveLickPath,1);
for i = 3:numRec
    disp(listRecordingsActiveLickPath(i,:))
    cd(listRecordingsActiveLickPath(i,:));
    ProcessingMice_smTrSpeedLick(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1,mazeSessionActiveLick(i));
    ProcessingMice_smTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1);
    ProcessingMice_smTr_GoodTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1,mazeSessionActiveLick(i));
    FieldWidthLR_GoodTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),20,1,2,0,...
        onlyRun,mazeSessionActiveLick(i));
%     pause;
    close all;
    ProcessingAligned(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1,mazeSessionActiveLick(i),4);
    ProcessingAlignedRun0(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),mazeSessionActiveLick(i),4);
    close all;
    
    FieldWidthLRAligned(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1,2,1,mazeSessionActiveLick(i)); 
end

% numRec = size(listRecordingsPassiveLickPath,1);
% for i = 1:numRec
%     disp(listRecordingsPassiveLickPath(i,:))
%     cd(listRecordingsPassiveLickPath(i,:)); 
%     ProcessingMice_smTrSpeedLick(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1,mazeSessionPassiveLick(i));
%     ProcessingMice_smTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1);
%     ProcessingMice_smTr_GoodTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1,mazeSessionPassiveLick(i));
%     FieldWidthLR_GoodTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),20,1,2,0,...
%         onlyRun,mazeSessionPassiveLick(i));
% %     pause;
%     close all;
%     ProcessingAligned(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1,mazeSessionPassiveLick(i),3);
%     ProcessingAlignedRun0(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),mazeSessionPassiveLick(i),3);
%     close all;
%     
%     FieldWidthLRAligned(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1,0,1,mazeSessionPassiveLick(i));
% end