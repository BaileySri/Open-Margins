prevalences = [0.05, 0.01, 0.001];
sigma = 1;
dx = 0.001;
x = dx:dx:10;
dt = 0.001;
t = dt:dt:20;

pd1 = pdf("chi2", x, 1);
a = sigma;
pd2 = pdf("ncx2", x, 1, (a)^2);
for i = 1:size(t,2)
    FPR(i) = AreaAbove(pd1, t(i), dx);
    TPR(i) = AreaAbove(pd2, t(i), dx);
    if (FPR(i) == 0) && (TPR(i) == 0)
        break
    end
end

Precisions = zeros(size(prevalences, 2), size(TPR, 2));

for i = 1:size(prevalences, 2)
    Precisions(i, :) = (TPR.*prevalences(i))./((TPR.*prevalences(i))+(FPR.*(1-prevalences(i))));
end

plotY = mat2cell(Precisions, ones(1, size(Precisions, 1)), size(Precisions, 2));
[plotX{1:size(prevalences, 2)}] = deal(FPR);

MyPlot(transpose(plotX), plotY);
ylim([0, 0.4]);
leg = legend("\pi="+prevalences);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Recall");
ylabel("Precision")
title("")

export_fig("PC", "-pdf", "-png", "-transparent")