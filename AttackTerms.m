function [res] = AttackTerms(n)
    syms w a;
    
    for i = 1:n
        innersum = sym(0);
        for j = 1:i
            innersum = innersum + (-1)^(i+j) * nchoosek(i, j-1) * (w)^(i-j);
        end
        res = a*innersum;
    end
end