function plot_weights(weights, name, color)
% Make stem plot of the regression coefficients. Specify the name of the
% model and an associated color

zw = weights == 0;
nw = 1:1:length(weights);

h = stem(nw(~zw), weights(~zw), 'filled', 'Color', color);
hold on
if ~isempty(nw(zw))
    h(2) = stem(nw(zw), weights(zw), 'p', 'k', 'MarkerSize', 7, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');
end
hold off
title(name)
xlabel('Features')
ylabel('Weights')
ylim([-0.5, 0.5])
try
    nz = sum(zw);
    leg = sprintf('Zero-coefficients (n = %d)', nz);
    legend(h(2), leg);
catch
end

end