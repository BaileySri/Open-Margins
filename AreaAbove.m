function [ret] = AreaAbove(x, dist, threshold)
    % TPR Calculate area above threshold for dist when using threshold
    startIdx = find(x >= threshold, 1, 'first');
    if isempty(startIdx) || startIdx >= numel(x)
        % There is no area above the threshold
        ret = 0;
    else
         ret = trapz(x(startIdx:end), dist(startIdx:end));
    end
end
