% Perform Non-Negative Matrix Factorization (PCA) on "vecotrized_data" and 
% save a set of features for each selected number of components (ncomp)

load('vectorized_data.mat');
ncomp = 10:5:95;

n = length(ncomp);
reco_error = zeros(n, 1);
reco_se = zeros(n, 1);
feats = cell(1, n);
weights = cell(1, n);
opt = statset('UseParallel', true);

for i = 1:n
    
    [feats{i}, weights{i}] = nnmf(vec_fc, ncomp(i), 'alg', 'mult', 'options', opt, 'replicates', 100);
    reco = feats{i} * weights{i};
    rer = mean((reco - vec_fc).^2, 2);
    reco_error(i) = mean(rer);
    reco_se(i) = std(rer) / sqrt(length(rer));
    
end

save('nnmf_output.mat', 'feats',...
    'reco_error',...
    'reco_se',...
    'ncomp',...
    'weights');