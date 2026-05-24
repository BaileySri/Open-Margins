dx = 0.001;
x = dx:dx:100;
sigma = 1;
weight = 0.5;
variance = sigma^2;
attack = 1;
window = [2, 5, 10];

%%% N=2
% N-1 samples
pd1 = pdf("gamma", x, window(1)-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack/sigma)^2);

%%%%%%%%%%%%%%%%%%%
% This introduces some rounding error but speeds up the process
originalsize = [1 length(pd1); 1 length(pd2)];
newidx = originalsize;
%
pd1 = round(pd1, 5);
pd1 = pd1(find(pd1, 1, 'first'):end);
newidx(1, 1) = originalsize(1, 2) - length(pd1) + 1;
pd1 = pd1(1:find(pd1, 1, 'last'));
newidx(1, 2) = newidx(1, 1) + length(pd1);
%
pd2 = round(pd2, 5);
pd2 = pd2(find(pd2, 1, 'first'):end);
newidx(2, 1) = originalsize(2, 2) - length(pd2) + 1;
pd2 = pd2(1:find(pd2, 1, 'last'));
newidx(2, 2) = newidx(2, 1) + length(pd2);
%%%%%%%%%%%%%%%%%%%%

convPDF = conv(pd1, pd2);
pd1 = convPDF/trapz(dx, convPDF);
%%% The indexes on convx will need to be changed after removing
%%% rounding
convx1 = x(newidx(1, 1)) + x(newidx(2, 1)): ...
        dx: ...
        x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

%Normalize
res1 = pd1/trapz(dx, pd1);

%%% N=5
% N-1 samples
pd1 = pdf("gamma", x, window(2)-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack/sigma)^2);

%%%%%%%%%%%%%%%%%%%
% This introduces some rounding error but speeds up the process
originalsize = [1 length(pd1); 1 length(pd2)];
newidx = originalsize;
%
pd1 = round(pd1, 5);
pd1 = pd1(find(pd1, 1, 'first'):end);
newidx(1, 1) = originalsize(1, 2) - length(pd1) + 1;
pd1 = pd1(1:find(pd1, 1, 'last'));
newidx(1, 2) = newidx(1, 1) + length(pd1);
%
pd2 = round(pd2, 5);
pd2 = pd2(find(pd2, 1, 'first'):end);
newidx(2, 1) = originalsize(2, 2) - length(pd2) + 1;
pd2 = pd2(1:find(pd2, 1, 'last'));
newidx(2, 2) = newidx(2, 1) + length(pd2);
%%%%%%%%%%%%%%%%%%%%

convPDF = conv(pd1, pd2);
pd1 = convPDF/trapz(dx, convPDF);
%%% The indexes on convx will need to be changed after removing
%%% rounding
convx2 = x(newidx(1, 1)) + x(newidx(2, 1)): ...
        dx: ...
        x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

%Normalize
res2 = pd1/trapz(dx, pd1);

%%% N=10
% N-1 samples
pd1 = pdf("gamma", x, window(3)-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack/sigma)^2);

%%%%%%%%%%%%%%%%%%%
% This introduces some rounding error but speeds up the process
originalsize = [1 length(pd1); 1 length(pd2)];
newidx = originalsize;
%
pd1 = round(pd1, 5);
pd1 = pd1(find(pd1, 1, 'first'):end);
newidx(1, 1) = originalsize(1, 2) - length(pd1) + 1;
pd1 = pd1(1:find(pd1, 1, 'last'));
newidx(1, 2) = newidx(1, 1) + length(pd1);
%
pd2 = round(pd2, 5);
pd2 = pd2(find(pd2, 1, 'first'):end);
newidx(2, 1) = originalsize(2, 2) - length(pd2) + 1;
pd2 = pd2(1:find(pd2, 1, 'last'));
newidx(2, 2) = newidx(2, 1) + length(pd2);
%%%%%%%%%%%%%%%%%%%%

convPDF = conv(pd1, pd2);
pd1 = convPDF/trapz(dx, convPDF);
%%% The indexes on convx will need to be changed after removing
%%% rounding
convx3 = x(newidx(1, 1)) + x(newidx(2, 1)): ...
        dx: ...
        x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

%Normalize
res3 = pd1/trapz(dx, pd1);

MyPlot({convx1; convx2; convx3}, {res1; res2; res3})
xlim([0, 40]);
leg = legend("N=" + window);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Innovation");
ylabel("Probability")
title("")

export_fig("TPR Window Changes1", "-pdf", "-png", "-transparent")