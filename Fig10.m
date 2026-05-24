dx = 0.001;
x = dx:dx:300;
sigma = 1;
weight =[0, 0.33, 0.67, 1];
variance = sigma^2;
attack = 0;
window = 17;

for i = 1:size(weight, 2)
    [resX{i}, resDist{i}] = HeuristicGraphs(variance, weight(i), attack, window, -1);
end

%% Plot
MyPlot(transpose(resX), transpose(resDist));
xlim([0, 60]);
ylim([0 0.08]);
leg = legend("w=" + weight);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Innovation");
ylabel("Probability")
title("")

export_fig("No Attack Weight Changes", "-pdf", "-png", "-transparent")