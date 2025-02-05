function accumulateRecDataMusc()
    
    RecordingListNT;
    
    % muscimol active licking
    disp('muscimol active licking')
    recDataLabel{1} = 'Muscimol active licking';
    [recDataRunPre{1},recDataRunManip{1},recDataRunPost{1}] = ...
                accumRecDataRunMusc(activeLickMuscPath,recSessionsALMusc,...
                                ALMuscSessions,ALMuscMazeSession);
    [recDataCuePre{1},recDataCueManip{1},recDataCuePost{1}] = ...
                accumRecDataCueMusc(activeLickMuscPath,recSessionsALMusc,...
                                ALMuscSessions,ALMuscMazeSession);
        

    fullPath = [folderPath 'allRecData.mat'];
    save(fullPath,'recDataRunPre','recDataRunManip','recDataRunPost',...
        'recDataCuePre','recDataCueManip','recDataCuePost','recDataLabel','-v7.3');
end

