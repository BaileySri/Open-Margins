sigma = 1;

% Bulk parameters
param = "attack";
weight = 0.5;
variance = sigma^2;
attack = 0:0.1:6;
window = 17;
attackWindow = -1; % Assume attack is over whole window

res = BulkParamEvaluator(param, weight, variance, attack, window, attackWindow);

MyPlot({attack}, {res});
leg = legend("");
set(leg, 'visible', 'off');
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("Attack-noise ratio");
ylabel("True Positive Rate")
title("")

export_fig("TPR Attack Changes2", "-pdf", "-png", "-transparent")