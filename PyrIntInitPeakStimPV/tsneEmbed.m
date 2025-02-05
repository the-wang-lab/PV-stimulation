function tsneEmbed(avgFRProfileNorm,idx,idx1,path,filename)    
    [coeff,score,latent,tsquared,explained,mu] = pca(avgFRProfileNorm');
    explainedV = cumsum(explained);
    numPCA = find(explainedV >= 90,1,'first'); 
    Y = tsne(avgFRProfileNorm,'NumPCAComponents',numPCA,'Distance','correlation');
    
    xl = zeros(1,size(avgFRProfileNorm,1));
    xl(1:idx) = 1;
    xl(idx+1:idx1-1) = 2;
    xl(idx1:end) = 3;
    
    h = figure;
    set(h,'OuterPosition',[500 500 280 280]);
    gscatter(Y(:,1),Y(:,2),xl);
    set(gca,'fontSize',12)
    xlabel('Y1')
    ylabel('Y2')
    saveas(gcf,[path filename '_90PercVar.fig']);
    print('-painters', '-dpdf', [path filename '_90PercVarCorr'], '-r600');
    
    q = size(avgFRProfileNorm,2)/size(avgFRProfileNorm,1);
    lambda_max = ((1+sqrt(1/q))^2);
    Y = tsne(avgFRProfileNorm,'NumPCAComponents',ceil(lambda_max),'Distance','correlation');
    
    h = figure;
    set(h,'OuterPosition',[500 500 280 280]);
    gscatter(Y(:,1),Y(:,2),xl);
    set(gca,'fontSize',12)
    xlabel('Y1')
    ylabel('Y2')
    saveas(gcf,[path filename '_MPDist.fig']);
    print('-painters', '-dpdf', [path filename '_MPDistCorr'], '-r600');
    
end