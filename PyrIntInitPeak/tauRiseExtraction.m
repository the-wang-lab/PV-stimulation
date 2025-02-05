function [tauPyr,fitcurve,gof] = tauRiseExtraction(timeStepRun,avgFRProfile,startloc,locPeak,ampPeak,display)
%% extract the rise time constant of firng rate profiles
% timeStepRun:  time steps
% avgFRProfile: average firing rate profile over time, each row represent
% one neuron (NxM, N: number of neurons, M: the length of time step run)
% startloc: the start index where the estimation should start
% locPeak: peak firing rate indices for all the neurons (size = N)
% ampPeak: peak amplitude of firing rate profile for each neuron (size = N) 

    tauPyr = zeros(1,size(avgFRProfile,1));
    fitcurve = cell(1,size(avgFRProfile,1));
    gof = cell(1,size(avgFRProfile,1));

    for i = 1:size(avgFRProfile,1)
        % Curve fitting using function a*exp(b*x)
        fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                        'Lower', [0, -Inf], ... % Lower bounds for [a, b]
                        'Upper', [ampPeak(i)*2, -0.06], ... % Lower bounds for [a, b]
                        'StartPoint',[ampPeak(i) -2]); % Start points for [a, b]
        fitType1 = fittype('a*exp(x*b)', 'options', fo);
        
        % to exclude one neuron with no firing between startloc and locPeak
        if(length(startloc:locPeak(i))<2)
            fitcurve{i} = [];
            tauPyr(i) = nan;
            continue;
        end
        
        [fitted_curve,gof_curve] = fit(timeStepRun(startloc:locPeak(i))'-timeStepRun(startloc), ...
            avgFRProfile(i,locPeak(i):-1:startloc)', fitType1); 
            % the curve is reversed in time, so that we can estimate a
            % decay time constant 
        fitcurve{i} = fitted_curve;
        gof{i} = gof_curve;
        
        % Extract the decay constant
        coeffvals = coeffvalues(fitted_curve);
        a = coeffvals(1);
        b = coeffvals(2);
        tauPyr(i) = -1/b; % For the model a*exp(b*x), decay time constant tau is -1/b
    
        % display figures for testing purposes
        if(display ~= 0)
            figure(1)
            plot(timeStepRun(startloc:locPeak(i))-timeStepRun(startloc),...
                avgFRProfile(i,startloc:locPeak(i)));
            hold on
            fitCurve = a*exp((timeStepRun(locPeak(i):-1:startloc)-timeStepRun(startloc))*b); 
            plot(timeStepRun(startloc:locPeak(i))-timeStepRun(startloc),fitCurve);
            hold off
            title(['tau = ' num2str(tauPyr(i))])
            pause;
        end
    end
end