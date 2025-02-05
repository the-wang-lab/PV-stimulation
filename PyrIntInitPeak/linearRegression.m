function [lm, slopePValue, slope, intercept] = linearRegression(input, output)
    
    % Perform linear regression
    lm = fitlm(input,output);

    % Extract parameters
    slopePValue = lm.Coefficients.pValue(2); % the p-value for the slope (test if the slope is significantly different from 0)
    slope = lm.Coefficients.Estimate(2); % the estimated slope
    intercept = lm.Coefficients.Estimate(1); % the estimated intercept
end
