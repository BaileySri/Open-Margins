windows = [1, 5, 17, 20];
variance = 1;
dx = 0.001;
x = dx:dx:300;

dist1 = pdf("chi2", x, windows(1));
dist2 = pdf("chi2", x, windows(2));
dist3 = pdf("chi2", x, windows(3));
dist4 = pdf("chi2", x, windows(4));

fig = MyPlot({x;x;x;x},{dist1; dist2; dist3; dist4});
ylim([0, 0.2]);
xlim([0 40]);
leg = legend("N=" + windows);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Test Metric");
ylabel("Probability")
title("")

export_fig("FPR Window", "-pdf", "-png", "-transparent")