function PyrNaiveBayesEncoderWithCrossValPyrAllSTD0p2Stim()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;
    
    for upDown = 4
        
        NaiveBayesClassifierGpuWithCrossValRiseDownAllSTD0p2Stim(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
               
        close all;
    end

    

    