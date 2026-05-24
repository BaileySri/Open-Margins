sigma = 1;

% Bulk parameters
param = "window";
weight = 0.5;
variance = sigma^2;
attack = 2.1;
window = 1:1:20;
attackWindow = ones(1, size(window, 2))*-1; % Assume attack is over whole window

res = BulkParamEvaluator(param, weight, variance, attack, window, attackWindow);

MyPlot({window}, {res});
ylim([0 1])
leg = legend("");
set(leg, 'visible', 'off');
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Window size");
ylabel("True Positive Rate")
title("")

export_fig("TPR Window Changes2", "-pdf", "-png", "-transparent")