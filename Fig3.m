sigma = 1;
dx = 0.001;
x = dx:dx:100;
dt = 0.001;
t = dt:dt:10;

pd1 = pdf("chi2", x, 1);
a = sigma/2;
pd2 = pdf("ncx2", x, 1, (a)^2);
for i = 1:size(t,2)
    FPR(i) = AreaAbove(pd1, t(i), dx);
    TPR0_5(i) = AreaAbove(pd2, t(i), dx);
    if (FPR(i) == 0) && (TPR0_5(i) == 0)
        break
    end
end

a = sigma;
pd2 = pdf("ncx2", x, 1, (a)^2);
for i = 1:size(t,2)
    TPR1(i) = AreaAbove(pd2, t(i), dx);
    if TPR1(i) == 0
        break
    end
end

a = 3*sigma;
pd2 = pdf("ncx2", x, 1, (a)^2);
for i = 1:size(t,2)
    TPR3(i) = AreaAbove(pd2, t(i), dx);
    if TPR3(i) == 0
        break
    end
end

a = 6*sigma;
pd2 = pdf("ncx2", x, 1, (a)^2);
for i = 1:size(t,2)
    TPR6(i) = AreaAbove(pd2, t(i), dx);
    if TPR6(i) == 0
        break
    end
end

MyPlot({FPR;FPR;FPR;FPR}, {TPR0_5;TPR1;TPR3;TPR6})
leg = legend("a=\sigma_{e}/2","a=\sigma_{e}","a=3\sigma_{e}","a=6\sigma_{e}");
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("False Positive Rate");
ylabel("True Positive Rate")
title("")

export_fig("ROC", "-pdf", "-png", "-transparent")