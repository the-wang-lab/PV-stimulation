function ProcessAllRecBehMusc()
% process all the recordings
    RecordingListNT;
        
%     accumulateRecDataMusc();
%     accumRecDataRunStatMusc();
    accumRecDataCueStatMusc();
   
    plotAccumulateRecDataMusc();
    plotAccumulateRecDataCueMusc();
end

