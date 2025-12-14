function [ret] = TPR(dist, threshold, dx)
    % TPR Calculate TPR for dist when using threshold
    ret = trapz(dx, dist(ceil(threshold/dx):end));
end

