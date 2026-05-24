dx = 0.001;
x = dx:dx:300;
sigma = 1;
weight = 0;
variance = sigma^2;
attack = 0;
window = [1, 5, 17, 20];

for i = 1:size(window, 2)
    [resX{i}, resDist{i}] = HeuristicGraphs(variance, weight, attack, window(i), -1);
end

%% Plot
MyPlot(transpose(resX), transpose(resDist));
xlim([0, 40]);
ylim([0 0.2]);
leg = legend("N=" + window);
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Innovation");
ylabel("Probability")
title("")

export_fig("No Attack Window Changes", "-pdf", "-png", "-transparent")