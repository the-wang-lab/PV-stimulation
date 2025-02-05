function [model, pValue,binnedMeans,binnedStd,binCenters] = analyzeBinnedCorrelation(x, y, numElemPerBins)
% Analyze the correlation between x and y after binning x into numBins bins.
%
% Parameters:
%   x - vector of x values
%   y - vector of y values (must be the same length as x)
%
% Returns:
%   fitResult - structure containing linear fit coefficients
%   pValue - p-value of the correlation test

    % Ensure x and y are column vectors
    x = x(:);
    y = y(:);
 
    % Total number of elements in x
    lenX = length(x);

    % Calculate the number of bins based on the total length and bin size
    numBins = floor(lenX / numElemPerBins);
    if(numBins < 10)
        numBins = 10;
    end

    % Compute the remainder of neurons that do not fit evenly into bins
    numRemaining = mod(lenX, numElemPerBins);

    % Determine the maximum index for binning based on whether there's a remainder
    if (numRemaining > 0)
        % If there is a remainder, adjust the max index to exclude extra neurons
        maxNum = lenX - numRemaining + 1;
    else
        % If no remainder, consider the full range minus one bin size
        maxNum = lenX - numElemPerBins + 1;
    end

    % Bin x into equal intervals
    edges = linspace(min(x(1:maxNum)), max(x(1:maxNum)), numBins + 1);  % Define bin edges
    binCenters = edges(1:end-1) + diff(edges)/2;   % Compute bin centers
    binnedMeans = zeros(numBins, 1);                % Initialize mean values for y
    binnedStd = zeros(numBins, 1);                  % Initialize standard deviation for y
    binnedCounts = zeros(numBins, 1);               % Initialize counts for each bin

    % Calculate the mean value of y within each bin
    for i = 1:numBins
        binMask = x >= edges(i) & x < edges(i + 1);  % Identify points in the bin
        if any(binMask)
            binnedMeans(i) = mean(y(binMask));       % Compute mean y in the bin
            binnedStd(i) = std(y(binMask));          % Compute standard deviation
            binnedCounts(i) = sum(binMask);          % Count points in the bin
        end
    end

    % Perform linear regression using fitlm
    tbl = table(binCenters(:), binnedMeans(:), 'VariableNames', {'X', 'Y'});
    model = fitlm(tbl, 'Y ~ X');

    % Extract p-value for the slope
    slope = model.Coefficients.Estimate(2);  % Slope of the fit
    intercept = model.Coefficients.Estimate(1);  % Intercept of the fit
    pValue = model.Coefficients.pValue(2);  % p-value for the slope term (X)

    % Display the results
    % Display results
    fprintf('Linear regression results:\n');
    disp(model);
    fprintf('Slope: %.4f\n', slope);
    fprintf('P-value for slope: %.4f\n', pValue);
end