% Example described in Section 4.3.3
attack  = 2; % Position accuracy
weight  = 0.5;
window  = 5;
noise   = 0.1*attack:0.01*attack:1.5;   % 0.1a to roughly where TPR=0
                                        % TPR goes to 0 by 0.75a, this saves
                                        % time by stopping at 1.5

res = BulkParamEvaluator("variance", weight, noise.^2, attack, window, -1);

MyPlot({noise}, {res});
ylim([0 1]);
xlim([0.2 1.5]);
leg = legend("");
set(leg, 'visible', 'off');
ax = gca;
ax.FontSize = 12;
ax.FontWeight = "bold";
xlabel("std dev (m)");
ylabel("True Positive Rate")
title("")

export_fig("Example Section 4.3.3", "-pdf", "-png", "-transparent")