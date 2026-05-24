function [ret] = AreaAbove(dist, threshold, dx)
    % TPR Calculate area above threshold for dist when using threshold
    startIdx = ceil(threshold/dx);
    if startIdx >= size(dist, 2)
        % There is no area above the threshold
        ret = 0;
    else
        ret = trapz(dx, dist(startIdx:end));
    end
end

