function plot_feat(feat, coefs, n, random)
% Plot the features.
% feat represents the features.
% coefs is a vector containing the regression coefficients.
% n is the number of features to be plotted.
% random is a string: 'on' for n random features; otherwise 'off'

nfeat = size(feat, 1);

if random == "off"
    len = length(n);
    if len > 1
        imdim = ceil(sqrt(len));
        ind(:) = n;
        n = len; % n = imdim^2;
    else
        imdim = 1;
        ind(1) = n;
        n = 1;
    end
else
    imdim = floor(sqrt(n));
    n = imdim^2;
    % generate n non-repeating random integers
    ind = randperm(nfeat, n);
    ind = sort(ind);
end

if n == 1
    ylab = 1;
else
    ylab = 0;
end

for i = 1:n
    
    sel = ind(i);
    to_plot = squeeze(feat(sel, :, :));
    ma = max(abs(to_plot(:)));
    
    if isempty(coefs) ~= 1
        ttl = sprintf('Feature %i\n Weight = %.4f', sel, coefs(ind(i)));
    else
        ttl = sprintf('Feature %i', sel);
    end
    subplot(imdim, imdim, i);
    GLvisFC(to_plot, [-ma, ma], ylab);
    title(ttl)
    %{
    pl = subplot(imdim, imdim, n);
    position = get(pl, 'pos');
    position(3) = position(3) + 0.004;
    position(4) = position(4) + 0.004;
    set(pl, 'pos', position);
    GLvisFC(to_plot);
    axis square;
    axis off;
    %}

end