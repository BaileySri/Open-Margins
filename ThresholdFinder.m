function [ret] = ThresholdFinder(x, dist, fpr)
    % Calculate tail areas in one pass using the trapezoidal rule
    x = x(:);
    dist = dist(:);
    intervalArea = diff(x) .* (dist(1:end-1) + dist(2:end)) / 2;
    tailArea = [flipud(cumsum(flipud(intervalArea))); 0];

    % Find the x values around fpr
    idx = find(tailArea >= fpr, 1, "last");
    if isempty(idx) || idx == numel(x)
        error("No threshold found, manually inspect arguments.")
    end

    % Estimate threshold
    fraction = (tailArea(idx) - fpr) / ...
        (tailArea(idx) - tailArea(idx + 1));
    ret = x(idx) + fraction * (x(idx + 1) - x(idx));
end