% Perform Principal Component Analysis (PCA) on "vecotrized_data" and save 
% a set of features for each selected number of components (ncomp)

load('vectorized_data.mat');
ncomp = 10:5:95;

n_pca = length(ncomp);
reco_error = zeros(n_pca, 1);
reco_se = zeros(n_pca, 1);
feats = cell(1, n_pca);
weights = cell(1, n_pca);
[coeff, score, ~, ~, ~, mu] = pca(vec_fc);

for i = 1:n_pca
    
    comp_sel = score(:, 1:ncomp(i));
    coeff_sel = coeff(:, 1:ncomp(i));
    feats{i} = comp_sel;
    weights{i} = coeff_sel;
    reco = comp_sel * coeff_sel' + repmat(mu, size(vec_fc, 1), 1);
    rer = mean((reco - vec_fc).^2, 2);
    reco_error(i) = mean(rer);
    reco_se(i) = std(rer) / sqrt(length(rer));
end

save('pca_output.mat', 'feats',...
    'reco_error',...
    'reco_se',...
    'ncomp',...
    'weights');