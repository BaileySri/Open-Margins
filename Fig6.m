dx = 0.001;
x = dx:dx:300;
sigma = 1;
weight = 0.5;
variance = sigma^2;
attack = [0.5, 1, 3, 6, 10];
window = 17;

%%% a=0.5
% N-1 samples
pd1 = pdf("gamma", x, window-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack(1)/sigma)^2);

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

%% a=1
% N-1 samples
pd1 = pdf("gamma", x, window-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack(2)/sigma)^2);

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

%% a=3
% N-1 samples
pd1 = pdf("gamma", x, window-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack(3)/sigma)^2);

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

%% a=6
% N-1 samples
pd1 = pdf("gamma", x, window-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack(4)/sigma)^2);

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
convx4 = x(newidx(1, 1)) + x(newidx(2, 1)): ...
        dx: ...
        x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

%Normalize
res4 = pd1/trapz(dx, pd1);

%% a=10
% N-1 samples
pd1 = pdf("gamma", x, window-1, 2*(sigma^2));
% 1 attack sample, freedom = 1, noncentrality = (attack/sigma)^2
pd2 = pdf("ncx2", x, 1, (attack(5)/sigma)^2);

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
convx5 = x(newidx(1, 1)) + x(newidx(2, 1)): ...
        dx: ...
        x(newidx(1, 2)) + x(newidx(2,2)) - 2*dx;

%Normalize
res5 = pd1/trapz(dx, pd1);

%% Plot
MyPlot({convx1;convx2;convx3;convx4;convx5}, {res1;res2;res3;res4;res5})
xlim([0, 200]);
leg = legend("a=" + attack);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Innovation");
ylabel("Probability")
title("")

export_fig("TPR Attack Changes1", "-pdf", "-png", "-transparent")