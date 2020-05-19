% plot predictions
predp = figure();
predp(1) = scatter(y, yhat, 'filled');
predp(2) = lsline;
predp(2).Color = 'k';
legend(predp(2), 'Least-squares fit', 'Location', 'southeast');
title(upper(method));
ylim([-4 2])
xlabel('True value')
ylabel('Prediction')
saveas(gcf, 'predictions.jpg'); 

% plot back-projected coefficients
bw_vec = weights * coefs';
bw_mat = fc_back(bw_vec');
bpjw = figure();
plot_feat(bw_mat, [], 1, 'off');
saveas(bpjw, 'back_coefficients.jpg');

% plot the 9 features with the highest associated coefficents
[sorted, sorter] = sort(abs(coefs), 'descend');
n = 1:9;
ind = sorter(n);
back = fc_back(weights');
sort_feat = figure(); 
plot_feat(back, coefs, ind, 'off');
saveas(sort_feat, 'sorted_features.jpg');