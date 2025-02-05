function plotStat(dataX,dataY,meanArr,semArr,...
                rankXY,xlab,ylab,ti,filename,path)    
    if(length(dataX) == length(dataY))
        dataArr = [dataX' dataY'];
    else
        dataArr = [];
    end
    barPlotWithStat(1:2,meanArr,semArr,dataArr,xlab,ylab,ti,rankXY,[],[]);       
    print('-painters', '-dpdf', [path filename], '-r600')
    savefig([path filename '.fig']);
end