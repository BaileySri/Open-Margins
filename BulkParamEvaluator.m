function [res] = BulkParamEvaluator(param, weight, variance, attack, window)
%BULKPARAMEVALUATOR Calculate TPR points as a parameter changes
%   Calculates TPR as a specific parameter is changed. Others are constant
    %Constant
    dx = 0.001;
    fpr = 0.01;
    %
    if strcmp(param, "weight")
        if ~isequal(size(variance), size(attack), size(window))
            error("Other parameters must be constants.")
        end
        iterations = max(size(weight));
        res = zeros(iterations, 1);
        for idx = 1:iterations
            %Calculate threshold needed
            [xben, disben] = HeuristicGraphs(variance, weight(idx), 0, window);
            t = ThresholdFinder(xben, disben, fpr, dx);
            %Calculate TPR corresponding to attack value at t threshold
            [~, dis] = HeuristicGraphs(variance, weight(idx), attack, window);
            res(idx) = TPR(dis, t, dx);
            disp(idx + "/" + iterations)
        end
    elseif strcmp(param, "variance")
        if ~isequal(size(weight), size(attack), size(window))
            error("Other parameters must be constants")
        end
        iterations = max(size(variance));
        res = zeros(iterations, 1);
        for idx = 1:iterations
            %Calculate threshold needed
            [xben, disben] = HeuristicGraphs(variance(idx), weight, 0, window);
            t = ThresholdFinder(xben, disben, fpr, dx);
            %Calculate TPR corresponding to attack value at t threshold
            [~, dis] = HeuristicGraphs(variance(idx), weight, attack, window);
            res(idx) = TPR(dis, t, dx);
            disp(idx + "/" + iterations)
        end
    elseif strcmp(param, "attack")
        if ~isequal(size(weight), size(variance), size(window))
            error("Other parameters must be constants")
        end
        iterations = max(size(attack));
        res = zeros(iterations, 1);
        %Calculate threshold needed for
        [xben, disben] = HeuristicGraphs(variance, weight, 0, window);
        t = ThresholdFinder(xben, disben, fpr, dx);
        for idx = 1:iterations
            %Calculate TPR corresponding to attack value at t threshold
            [~, dis] = HeuristicGraphs(variance, weight, attack(idx), window);
            res(idx) = TPR(dis, t, dx);
            disp(idx + "/" + iterations)
        end
    elseif strcmp(param, "window")
        if ~isequal(size(weight), size(attack), size(variance))
            error("Other parameters must be constants")
        end
        iterations = max(size(window));
        res = zeros(iterations, 1);
        for idx = 1:iterations
            %Calculate threshold needed
            [xben, disben] = HeuristicGraphs(variance, weight, 0, window(idx));
            t = ThresholdFinder(xben, disben, fpr, dx);
            %Calculate TPR corresponding to attack value at t threshold
            [~, dis] = HeuristicGraphs(variance, weight, attack, window(idx));
            res(idx) = TPR(dis, t, dx);
            disp(idx + "/" + iterations)
        end
    else
        error("No valid parameter selected.")
    end
end

