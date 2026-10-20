sigma = 1;

% Bulk parameters
param = "weight";
weight = 0:0.02:1;
variance = sigma^2;
attack = 0.8;
window = 20;
attackWindow = -1; % Assume attack is over whole window

res = BulkParamEvaluator(param, weight, variance, attack, window, attackWindow);

MyPlot({weight}, {res});
ylim([0 1])
leg = legend("");
theme(gcf, "light")
set(leg, 'visible', 'off');
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Weight");
ylabel("True Positive Rate")
title("")

export_fig("TPR Weight Changes", "-pdf", "-png", "-transparent")