sigma = 1;

% Bulk parameters
param = "attack";
weight = 0.67;
variance = sigma^2;
attack = 0:0.01:1.2;
window = 20;
attackWindow = -1; % Assume attack is over whole window

res = BulkParamEvaluator(param, weight, variance, attack, window, attackWindow);

MyPlot({attack}, {res});
leg = legend("");
theme(gcf, "light")
set(leg, 'visible', 'off');
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Attack-noise ratio");
ylabel("True Positive Rate")
title("")

export_fig("TPR Attack Changes2", "-pdf", "-png", "-transparent")