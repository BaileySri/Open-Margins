function [ret] = ThresholdFinder(x, dist, fpr, dx)
    % Roughly approximate a starting point
    startIdx = size(nonzeros(round(dist, 4)), 1);
    % Rounding errors but the computation doesn't take hours anymore
    endIdx = size(nonzeros(round(dist, 6)), 1);
    ret = -1; %We will throw an error if ret is still -1 at end
    for idx = startIdx:-1:1
        percent = trapz(dx, dist(idx:endIdx));
        if percent >= fpr
            ret = x(idx);
            return
        end
    end
    if isequal(ret, -1)
        error("No threshold found, manually inspect arguments.")
    end
end

