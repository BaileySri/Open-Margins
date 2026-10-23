sigma = 1;

% Bulk parameters
param = "window";
weight = 0.5;
variance = sigma^2;
attack = 0.7*sigma;
window = 1:1:20;
attackWindow = ones(1, size(window, 2))*-1; % Assume attack is over whole window

res = BulkParamEvaluator(param, weight, variance, attack, window, attackWindow);

MyPlot({window}, {res});
ylim([0 1])
xlim([1 20])
leg = legend("");
set(leg, 'visible', 'off');
theme(gcf, "light")
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Window size");
ylabel("True Positive Rate")
title("")

export_fig("TPR Window Changes2", "-pdf", "-png", "-transparent")