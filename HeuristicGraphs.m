
function [retX, retDist] = HeuristicGraphs(variance, weight, attack, window, attackWindow)
    % No attacker present, this is a benign analysis so
    % window==attackWindow
    if isequal(attackWindow, -1)
        attackWindow = window;
    end

    %Mean and Variance for the ith distribution, i = 1...k
    means = zeros(attackWindow, 1);
    variances = zeros(attackWindow, 1);

    %Mean is dependent only on attack and weight term
    for i = 1:attackWindow
        innersum = 0;
        for j = 1:i
            innersum = innersum + (-1)^(i+j)*nchoosek(i, j-1)*weight^(i-j);
        end
        means(i) = attack*innersum;
    end

    %Variance is dependent on error and weight term
    for i = 1:attackWindow
        outersum = 0;
        for j = 1:i-1
            innersum = 0;
            for x = 1:j
                innersum = innersum + (-1)^(j+x)*weight^(x)*nchoosek(j-1, x-1);
            end
            % This part doesn't look the same as the summation form in the
            % paper but that's because the random variables, e[n], have
            % additive variance. I just dropped the alternating -1 and
            % squared the coefficient on the variance, i.e., innersum.
            outersum = outersum + variance*(innersum)^2;
        end
        variances(i) = variance + outersum;
    end

    % We essentially have a generalized chi-square. The heuristic approach
    % I am taking here is to assemble each distribution then just convolve
    % them all into the desired distribution.
   
    % Resolution
    dx = 0.001;
    max = 3500;
    x = dx:dx:max;
    
    %If mean is 0, ncx2 fails
    if isequal(means(1), 0)
        % Scaled Chi-square, alpha=1/2 and theta=2*stddev
        % alpha=1/2 because each term has 1 degree of freedom
        term1 = pdf("gamma", x, 1/2, 2*variance);
    else
        %Non-zero mean, non-central chi square
        term1 = pdf("ncx2", x, 1, means(1)/variances(1));
    end

    % Everything gets stored back in term1, so it just gets reused from
    % here forward
    convx = x;
    for i = 2:attackWindow
        % Weighed Attack
        if isequal(means(i), 0)
            term2 = pdf("gamma", x, 1/2, 2*variances(i));
        else
            term2 = pdf("ncx2", x, 1, means(1)/variances(i));
        end
        %%%%%%%%%%%%%%%%%%%
        % This introduces some rounding error but speeds up the process
        originalsize = [1 length(term1); 1 length(term2)];
        newidx = originalsize;
        %
        term1 = round(term1, 5);
        term1 = term1(find(term1, 1, 'first'):end);
        newidx(1, 1) = originalsize(1, 2) - length(term1) + 1;
        term1 = term1(1:find(term1, 1, 'last'));
        newidx(1, 2) = newidx(1, 1) + length(term1);
        %
        term2 = round(term2, 5);
        term2 = term2(find(term2, 1, 'first'):end);
        newidx(2, 1) = originalsize(2, 2) - length(term2) + 1;
        term2 = term2(1:find(term2, 1, 'last'));
        newidx(2, 2) = newidx(2, 1) + length(term2);
        %%%%%%%%%%%%%%%%%%%%
        
        convPDF = conv(term1, term2);
        term1 = convPDF/trapz(dx, convPDF);
        %%% The indexes on convx will need to be changed after removing
        %%% rounding
        convx = x(newidx(1, 1)) + x(newidx(2, 1)): ...
                dx: ...
                x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;
    end

    % Convolution of benign terms if there are any
    if ~isequal(attackWindow, window)
        Nminusk = window - attackWindow;

        % Benign term
        term2 = pdf("chi2", x, Nminusk);

        %%%%%%%%%%%%%%%%%%%
        % This introduces some rounding error but speeds up the process
        % For final results remove this rounding step
        originalsize = [1 length(term1); 1 length(term2)];
        newidx = originalsize;
        %
        term1 = round(term1, 5);
        term1 = term1(find(term1, 1, 'first'):end);
        newidx(1, 1) = originalsize(1, 2) - length(term1) + 1;
        term1 = term1(1:find(term1, 1, 'last'));
        newidx(1, 2) = newidx(1, 1) + length(term1);
        %
        term2 = round(term2, 5);
        term2 = term2(find(term2, 1, 'first'):end);
        newidx(2, 1) = originalsize(2, 2) - length(term2) + 1;
        term2 = term2(1:find(term2, 1, 'last'));
        newidx(2, 2) = newidx(2, 1) + length(term2);
        %%%%%%%%%%%%%%%%%%%%
        
        convPDF = conv(term1, term2);
        term1 = convPDF/trapz(dx, convPDF);
        %%% The indexes on convx will need to be changed after removing
        %%% rounding
        convx = x(newidx(1, 1)) + x(newidx(2, 1)): ...
                dx: ...
                x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;
    end
   
    %Normalize before returning
    term1 = term1/trapz(dx, term1);
    retX = convx;
    retDist = term1;
end