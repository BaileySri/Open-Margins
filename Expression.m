function [exp] = Expression(n)
    syms m u r e [1 n];
    syms y0 w a;

    u(1) = y0;

    for i = 1:n
        m(i) = y0 + e(i) + i*a;
    end

    r(1) = m(1) - u(1);

    for i = 2:n
        u(i) = u(i - 1) + w*r(i-1);
        r(i) = m(i) - u(i);
    end
    
    exp = collect(expand(r(end)), [e a]);
end

% Maybe use this for automated subsitution
% norm(x, mu, sigma) = (1/sqrt(2*pi*sigma^2))*exp(-(x-mu)^2/(2*sigma^2));