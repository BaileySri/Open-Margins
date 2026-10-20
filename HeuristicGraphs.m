
function [retX, retDist] = HeuristicGraphs(variance, weight, attack, window, attackWindow)
    % When attackWindow is -1, the entire window is influenced by attack
    % This is the normal behavior and assumption made in the paper Sec 4.3
    if isequal(attackWindow, -1)
        attackWindow = window;
    end

    %--- Setup ---% 
    % Noise coefficient matrix V
    % V is lower triangular with 1s on the diagonal.
    % The entries below the diagonal are:
    %   V[n,j] = -w * sum(V[i,j], i = j...n-1),  for j < n
    %
    % r[1] = V[1,1] * e[1]
    % r[2] = V[2,1] * e[1] + V[2,2] * e[2]
    %  ...
    % r[n] = V[n,1] * e[1] + V[n,2] * e[2] + ... + V[n,n] * e[n] 
    %
    % Attack coefficient vector s:
    % s(1) = 1
    % s(2) = 2 - w * s(1) 
    % ...
    % s(n) = n - w * [s(1) + ... + s(n-1)]
    %
    % These coefficients can be confirmed with the
    % existing Expression(n) and AttackTerms(n) helpers

    % This sets up the matrix V and vector s
    V = zeros(window, window);
    s = zeros(window, 1);
    V(1,1) = 1;
    s(1) = 1;
    for n = 2:window
        % Accumulate the column sum of prior rows
        % acc(j) is the sum of V(i,j) over i = j...n-1
        acc = zeros(1, n-1);
        for i = 1:n-1
            acc(1:i) = acc(1:i) + V(i, 1:i);
        end
        V(n, 1:n-1) = -weight * acc;
        V(n, n) = 1;

        if n <= attackWindow
            s(n) = n - weight * sum(s(1:n-1));
        else
            % Catch the case where step n is not attacked
            s(n) = -weight * sum(s(1:n-1));
        end
    end

    %--- Eigendecomposition ---%
    % mean residual vector
    mu = attack * s;
    % covariance matrix of residuals
    C  = variance * (V * V');

    % C*Q = Q*D
    % Q is a matrix with columns corresponding to right eigenvectors
    % D is a diagonal matrix of eigenvalues
    [Q, D] = eig(C);
    % This converts D to just a vector of the eigenvalues
    D = diag(D);
    % Mean in eigenvector basis
    Qmu = Q' * mu;

    % Resolution
    dx = 0.01;
    % Cutoff probability
    tailTol = 1e-10;

    % First lambda to start
    lambda1 = Qmu(1)^2 / D(1);
    % Calculating per distribution bins to speed up convolution
    componentMax = D(1) * ncx2inv(1 - tailTol/(2*window), 1, lambda1);
    componentMax = ceil(componentMax/dx) * dx;
    edges = 0:dx:componentMax;

    if isequal(lambda1, 0)
        %Use gamma equivalent when lambda == 0
        term1 = diff(gamcdf(edges, 1/2, 2*D(1)));
        upperTail = gammainc(componentMax/(2*D(1)), 1/2, "upper");
    else
        %Otherwise use scaled noncentral chi-square
        term1 = diff(ncx2cdf(edges/D(1), 1, lambda1));
        upperTail = ncx2cdf(componentMax/D(1), 1, lambda1, "upper");
    end

    % Guarding against losing mass because of max value on axis
    if upperTail > (tailTol/window)
        error("Mass cutoff by max. Raise max value.")
    end

    term1x = edges(1:end-1) + dx/2;

    % Trim leading/trailing zeros
    idx1 = find(term1);
    term1 = term1(idx1(1):idx1(end));
    term1x = term1x(idx1(1):idx1(end));
    convx = term1x;

    % Everything gets stored back in term1, so it just gets reused from
    % here forward
    for i = 2:window
        % noncentrality
        lambda = Qmu(i)^2 / D(i);
        % Calculating per distribution bins to speed up convolution
        componentMax = D(i) * ncx2inv(1 - tailTol/(2*window), 1, lambda);
        componentMax = ceil(componentMax/dx) * dx;
        edges = 0:dx:componentMax;
        if isequal(lambda, 0)
            %Use gamma equivalent when lambda == 0
            term2 = diff(gamcdf(edges, 1/2, 2*D(i)));
            upperTail = gammainc(componentMax/(2*D(i)), 1/2, "upper");
        else
            %Otherwise use scaled noncentral chi-square
            term2 = diff(ncx2cdf(edges/D(i), 1, lambda));
            upperTail = ncx2cdf(componentMax/D(i), 1, lambda, "upper");
        end

        % Guarding against losing mass because of max value on axis
        if upperTail > (tailTol/window)
            error("Mass cutoff by max. Raise max value.")
        end

        term2x = edges(1:end-1) + dx/2;

        % Trim leading/trailing zeros
        idx1 = find(term1);
        term1 = term1(idx1(1):idx1(end));
        term1x = term1x(idx1(1):idx1(end));
        idx2 = find(term2);
        term2 = term2(idx2(1):idx2(end));
        term2x = term2x(idx2(1):idx2(end));

        % Convolve bin probabilities, Switched to FFT for speed
        convLength = numel(term1) + numel(term2) - 1;
        fftLength = 2^nextpow2(convLength);
        convMass = ifft(fft(term1, fftLength) .* fft(term2, fftLength));
        term1 = max(real(convMass(1:convLength)), 0);
        convx = term1x(1) + term2x(1): ...
                dx: ...
                term1x(1) + term2x(1) + (numel(term1)-1)*dx;
        term1x = convx;
    end

    % Normalize and convert to PDF
    term1 = term1 / sum(term1) / dx;
    retX = convx;
    retDist = term1;
end
