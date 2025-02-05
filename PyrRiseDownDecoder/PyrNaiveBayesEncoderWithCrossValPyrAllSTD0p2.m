function PyrNaiveBayesEncoderWithCrossValPyrAllSTD0p2()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;
    
    for upDown = 4
        
        NaiveBayesClassifierGpuWithCrossValRiseDownAllSTD0p2(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossValRiseDownAllSTD0p2(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end

    

    