function [corrCoef, pVal] = calCorrCoeff(input, output)
    
    % Calculate correlation coefficient using corrcoef
    [R, P] = corrcoef(input, output);

    % Extract the correlation coefficient and p-value
    corrCoef = R(1,2);
    pVal = P(1,2);
end
