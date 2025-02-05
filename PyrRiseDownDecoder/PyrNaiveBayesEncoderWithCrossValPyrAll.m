function PyrNaiveBayesEncoderWithCrossValPyrAll()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;
    
    for upDown = 4
        
        NaiveBayesClassifierGpuWithCrossValRiseDownAll(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossValRiseDownAll(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end

    

    