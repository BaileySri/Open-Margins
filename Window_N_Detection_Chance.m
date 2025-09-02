% Resolution
dx = 0.001;
max = 3500;
x = dx:dx:max;

% Parameters
N = 10;
w = 0.5;
sigma_e = 1;
t = 29.6; % 0.001 FPR
k = 4;
attacks = 0:0.01*sigma_e:10*sigma_e;

detection_rate = zeros(1, length(attacks));
parfor i = 1:length(attacks)
    a = attacks(i);

    % k=1
    %term1 = pdf("chi2", x, N);
    %term2 = pdf("ncx2", x, 1, (a^2)/(sigma_e^2));
    
    % Immediate Adoption
    %term1 = pdf("gamma", x, (N-k)/2, 2*(sigma_e^2));
    %term2 = pdf("ncx2", x, k, k*(a^2)/(sigma_e^2));

    % Reject Attack
    %term1 = pdf("gamma", x, (N-k)/2, 2*(sigma_e^2));
    %term2 = pdf("ncx2", x, k, ((a^2)/(sigma_e^2)) * (k*(k+1)*(2*k+1)/6));

    % Weighed Attack
    term1 = pdf("gamma", x, 6/2, 2*(sigma_e^2));
    term2 = pdf("ncx2", x, 4, ((a^2)/(sigma_e^2)) * ...
        w^6-4*w^5+11*w^4-24*w^3+36*w^2-40*w+30);
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
    convPDF = convPDF/trapz(dx, convPDF);
    %%% The indexes on convx will need to be changed after removing
    %%% rounding
    convx = x(newidx(1, 1)) + x(newidx(2, 1)): ...
            dx: ...
            x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

    detection_rate(i) = trapz(dx, convPDF(convx > t));
end

%%-- Chaff code I used to calculate FPR curve
% pd_fpr = pdf("gamma", x, N, 2*(sigma_e^2));
% FPR = zeros(1, length(t));
% dt = 0.001;
% t = dt:dt:50;
% parfor i = 1:length(t)
%     FPR(i) = trapz(dx, pd_fpr(x > t(i)));
% end