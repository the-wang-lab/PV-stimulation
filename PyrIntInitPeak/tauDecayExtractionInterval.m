function [tauPyr,fitcurve,gof] = tauDecayExtractionInterval(timeStepRun,avgFRProfile,endloc,locPeak,ampPeak,display)
%% extract the decay time constant of firng rate profiles
% timeStepRun:  time steps
% avgFRProfile: average firing rate profile over time, each row represent
% one neuron (NxM, N: number of neurons, M: the length of time step run)
% locPeak: peak firing rate location (size = N)
% ampPeak: peak amplitude of firing rate profile (size = N) 

    tauPyr = zeros(1,size(avgFRProfile,1));
    fitcurve = cell(1,size(avgFRProfile,1));
    gof = cell(1,size(avgFRProfile,1));

    for i = 1:size(avgFRProfile,1)
        % Curve fitting using function a*exp(b*x)
        fo = fitoptions('Method', 'NonlinearLeastSquares', ...
                        'Lower', [-Inf, -Inf], ... % Lower bounds for [a, b]
                        'Upper', [ampPeak(i)*2, -0.06], ... % Lower bounds for [a, b]
                        'StartPoint',[ampPeak(i) -1]); % Start points for [a, b]
        fitType1 = fittype('a*exp(b*x)', 'options', fo);
        
        % to exclude one neuron with no firing between startloc and locPeak
        if(length(locPeak(i):endloc)<2)
            fitcurve{i} = [];
            tauPyr(i) = nan;
            continue;
        end
        
        [fitted_curve, gof_curve] = fit(timeStepRun(locPeak(i):endloc)'-timeStepRun(locPeak(i)), ...
            avgFRProfile(i,locPeak(i):endloc)', fitType1); 
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
            plot(timeStepRun(locPeak(i):endloc)-timeStepRun(locPeak(i)),...
                avgFRProfile(i,locPeak(i):endloc));
            hold on
            fitCurve = a*exp(b*(timeStepRun(locPeak(i):endloc)-timeStepRun(locPeak(i))));
            plot(timeStepRun(locPeak(i):endloc)-timeStepRun(locPeak(i)),fitCurve);
            hold off
            title(['tau = ' num2str(-1/b)])
            pause;
        end
    end
end