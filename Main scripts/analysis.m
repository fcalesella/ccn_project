% Main script for the analysis.
% First the needed loadings and parameters should be defined. 

% load files with scores and indices of good patients
load scores_132.mat;
load finalsubs.mat;
% define the variables of intereset (targets) and passing in get_scores
select_scores = {'Language'}; % 'MemoryV', 'AttentionVF', 'MemoryS'
% load the desired features
load('pca_output.mat');
% define the lambda (regularization strength) and alpha (regularization
% type) ranges
lambda = logspace(-5, 5, 100);
alpha = 0.1:0.1:1;
% define the Cross-Validation setup ('loo' for Leave-one-out or 'nloo' for 
% nested Leave-One-Out)
cv_setup = 'loo';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% getting the scores of the target variable
scout = get_scores(scores, select_scores);
% extracting the patient IDs
sc_id = fcs({scores.subjName});
% indexing only the good patients
gs_mask = pts_mask(sc_id, pats);
% taking the good patients
scout = scout(gs_mask, :);
% indexing not-empty scores
sc_mask = ~isnan(scout);

if isstruct(feats)
    feats = struct2cell(feats);
end
% synchronize feature and score selection and standardize
x = prepare_comp(feats, sc_mask);
y = scout(sc_mask, :);
y = (y - mean(y)) / std(y);

clearvars -except x y cv_setup alpha lambda
tic
rng('default')

if strcmp(cv_setup, 'loo')
    [coefs, mse, choice, yhat] = loo(x, y, alpha, lambda);
    rsq = metrics(y, yhat, 'rsq');
    bic = metrics(y, yhat, 'bic', coefs);
else
    [coefs, mse, choice, yhat] = nested_loo(x, y, alpha, lambda);
    rsq = metrics(y, yhat, 'rsq');
end

toc
