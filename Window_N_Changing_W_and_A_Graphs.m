% Resolution
dx = 0.001;
max = 300;
x = dx:dx:max;

% Parameters
window = [2 5 10];
sigma_e = 1;
attack = [0.5 1 3 6 10];

% equation: chi2_{N-1}^{2}\sigma_{e}^{2} + \\
%           ncx_{1}^{2}( a^{2} / \sigma_{e}^{2} )



f = figure;
hold on;
legend();
xlabel("Residual", 'fontweight', 'bold', 'fontsize', 14);
ylabel("Probability", 'fontweight', 'bold', 'fontsize', 14);
set(get(gca, 'XAxis'), 'FontWeight', 'bold', 'fontsize', 14);
set(get(gca, 'YAxis'), 'FontWeight', 'bold', 'fontsize', 14);

% w = 10;
% title(['Residual distribution as attack changes ' ...
%        '(\sigma_{e}=' num2str(sigma_e) ', w=' num2str(w) ')'], ...
%         'fontweight', 'bold', 'fontsize', 14);
% for i = 1:length(attack)
%     term1 = pdf("chi2", x, w - 1);
%     term2 = pdf("ncx2", x, 1, (attack(i)^2)/(sigma_e^2));
%     convPDF = conv(term1, term2);
%     convPDF = convPDF/trapz(dx, convPDF);
%     convx = dx+dx:dx:max+max;
%     plot(convx, convPDF, "LineWidth", 3, "DisplayName", ['a = ' num2str(attack(i))]);
% end

a = 3;
title(['Residual distribution as window changes ' ...
       '(\sigma_{e}=' num2str(sigma_e) ', a=' num2str(a) ')'], ...
        'fontweight', 'bold', 'fontsize', 14);
for i = 1:length(window)
    term1 = pdf("chi2", x, window(i) - 1);
    term2 = pdf("ncx2", x, 1, (a^2)/(sigma_e^2));
    convPDF = conv(term1, term2);
    convPDF = convPDF/trapz(dx, convPDF);
    convx = dx+dx:dx:max+max;
    plot(convx, convPDF, "LineWidth", 3, "DisplayName", ['w = ' num2str(window(i))]);
end