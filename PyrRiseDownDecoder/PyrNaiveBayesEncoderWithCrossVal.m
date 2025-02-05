function PyrNaiveBayesEncoderWithCrossVal()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;

    for upDown = 1
        
        NaiveBayesClassifierGpuWithCrossVal(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossVal(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end
    
    for upDown = 2
        
        NaiveBayesClassifierGpuWithCrossVal(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpuWithCrossVal(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end
    

    

    