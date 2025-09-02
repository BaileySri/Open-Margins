function [res] = ErrorTerms(n, mode)
    syms res e [1 n];
    syms w;
    
    for i = 1:n
        outersum = sym(0);
        for j = 1:i-1
            innersum = sym(0);
            for k = 1:j
                innersum = innersum + ( (-1)^(j+k) * w^(k) * nchoosek(j-1, k-1) );
            end
            if mode == 2
                % Mode switch to calculate variance instead of error terms
                outersum = outersum + (e(i-j) * innersum^2);
            else
                outersum = outersum + ( (-1)^(j) * e(i-j) * innersum );
            end
            
        end
        res(i) = e(i)+outersum;
    end
end

%% Saved for later
%syms e [1 17];
%syms w;
%exps = ErrorTerms(10, 2);
%for i = 1:10
%subs(exps(i), [e w], [ones(1, 10) 1])
%end