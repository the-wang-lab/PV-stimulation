
% ----------------------------------------------------------------------- %
% Function plot_areaerrorbar plots the mean and standard deviation of a   %
% set of data filling the space between the positive and negative mean    %
% error using a semi-transparent background, completely customizable.     %
%                                                                         %
%   Input parameters:                                                     %
%       - data:     Data matrix, with rows corresponding to observations  %
%                   and columns to samples.                               %
%       - options:  (Optional) Struct that contains the customized params.%
%           * options.handle:       Figure handle to plot the result.     %
%           * options.color_area:   RGB color of the filled area.         %
%           * options.color_line:   RGB color of the mean line.           %
%           * options.alpha:        Alpha value for transparency.         %
%           * options.line_width:   Mean line width.                      %
%           * options.x_axis:       X time vector.                        %
%           * options.error:        Type of error to plot (+/-).          %
%                   if 'std',       one standard deviation;               %
%                   if 'sem',       standard error mean;                  %
%                   if 'var',       one variance;                         %
%                   if 'c95',       95% confidence interval.              %
% ----------------------------------------------------------------------- %
%   Example of use:                                                       %
%       data = repmat(sin(1:0.01:2*pi),100,1);                            %
%       data = data + randn(size(data));                                  %
%       plot_areaerrorbar(data);                                          %
% ----------------------------------------------------------------------- %
%   Author:  Victor Martinez-Cagigal                                      %
%   Date:    30/04/2018                                                   %
%   E-mail:  vicmarcag (at) gmail (dot) com                               %
% ----------------------------------------------------------------------- %
function plot_areaerrorbarXYZ1(data_meanX, data_meanY, data_meanZ, data_stdX, data_stdY, data_stdZ, options)
    options.handle     = figure;
    set(options.handle,'OuterPosition',...
        [500 500 350 350])
    % Default options
    if(nargin<4)
        options.color_areaX = [128 193 219]./255;    % Blue theme
        options.color_lineX = [ 52 148 186]./255;
        options.color_areaY = [243 169 114]./255;    % Orange theme
        options.color_lineY = [236 112  22]./255;
        options.color_areaZ = [192 221 173]./255;    % Green theme
        options.color_lineZ = [112 173  71]./255;
        options.alpha      = 0.5;
        options.line_width = 2;
        options.error      = 'sem';
    end
    if(isfield(options,'x_axisX')==0)
        options.x_axisX = 1:size(dataX,2); 
        options.x_axisY = 1:size(dataY,2);
        options.x_axisZ = 1:size(dataZ,2);
    else
        options.x_axisX = options.x_axisX(:);
        options.x_axisY = options.x_axisY(:);
        options.x_axisZ = options.x_axisZ(:);
    end
        
    % Type of error plot
    errorX = data_stdX;
    errorY = data_stdY;
    errorZ = data_stdZ;
    
    % Plotting the result
%     figure(options.handle);
    x_vectorX = [options.x_axisX', fliplr(options.x_axisX')];
    patch = fill(x_vectorX, [data_meanX+errorX,fliplr(data_meanX-errorX)], options.color_areaX);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', options.alpha);
    hold on;
    plot(options.x_axisX, data_meanX, 'color', options.color_lineX, ...
        'LineWidth', options.line_width);
    
    x_vectorY = [options.x_axisY', fliplr(options.x_axisY')];
    patch = fill(x_vectorY, [data_meanY+errorY,fliplr(data_meanY-errorY)], options.color_areaY);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', options.alpha);
    plot(options.x_axisY, data_meanY, 'color', options.color_lineY, ...
        'LineWidth', options.line_width);
    
    x_vectorZ = [options.x_axisZ', fliplr(options.x_axisZ')];
    patch = fill(x_vectorZ, [data_meanZ+errorZ,fliplr(data_meanZ-errorZ)], options.color_areaZ);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', options.alpha);
    plot(options.x_axisZ, data_meanZ, 'color', options.color_lineZ, ...
        'LineWidth', options.line_width);
        
end