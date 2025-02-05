function PyrNaiveBayesEncoderWithCrossValSTD0p2()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;

    for upDown = 1
        
        NaiveBayesClassifierGpuWithCrossValSTD0p2(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossValSTD0p2(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end
    
    for upDown = 2
        
        NaiveBayesClassifierGpuWithCrossValSTD0p2(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossValSTD0p2(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end
    

    

    