function[coefs, mse, choice, yhat] = loo(x, y, alpha, lambda)
% Perform Leave-one-out (LOO) cross validation (CV). This is the outer 
% function for parameter tuning, calling the opt_comp function for the 
% optimization of the number of features (see line 11: opt_lambda). 
% x is a cell array containing the feature sets.
% y is a vector containing the targets.
% alpha and lambda are the regularization type and strength passed to
% opt_alpha and opt_lambda

npca = length(x);
nsubj = size(y, 1);
nalpha = length(alpha);
nlam = length(lambda);
mse = zeros(nlam, nalpha, npca);
yhat = zeros(nlam, nalpha, npca, nsubj);
coefs = cell(1, npca);
waitb = parfor_wait(nsubj, 'Waitbar', true);

parfor i = 1:nsubj

    trainc = ones(nsubj, 1, 'logical');
    trainc(i) = 0;
    testc = ~trainc;
    
    [xtrain, xtest] = train_ind(x, trainc, testc);
    
    yset = y;
    ytrain = yset(trainc, :);
    ytest = yset(testc, :);
    
    [coefs_temp, mse_temp, yhat(:, :, :, i)] = opt_comp(xtrain, ytrain, xtest, ytest, alpha, lambda);
    coefs = sum_cell(coefs, coefs_temp);
    mse = mse + mse_temp;
    
    waitb.Send;
  
end

mse = mse ./ nsubj;
[min_mse, loc] = min(mse(:));
[l, a, p] = ind2sub(size(mse), loc);
if size(l, 1) == 1 && size(a, 1) == 1 && size(p, 1) 
    bl = lambda(l);
    ba = alpha(a);
    bp = size(x{p}, 2);
    choice = [bl, ba, bp, min_mse];
    coefs = cell2mat(coefs(:, p));
    coefs = coefs(:, l, a)';
    coefs = coefs ./ nsubj;
    yhat = squeeze(yhat(l, a, p, :));
else
    num_comp = size(coefs, 1);
    dummy_lam = l(1, :);
    dummy_alpha = a(1, :);
    dummy_comp = p(1, :);
    bl = lambda(dummy_lam);
    ba = alpha(dummy_alpha);
    bp = size(x{dummy_comp}, 2);
    choice = [bl, ba, bp, min_mse, num_comp];
    coefs = cell2mat(coefs(:, dummy_comp));
    coefs = coefs(:, l, a)';
    coefs = coefs ./ nsubj;
    yhat = squeeze(yhat(l, a, p, :));
    fprintf(['Warning: multiple minima have been detected for ', ...
            '%i selected components\n'], num_comp)
end

waitb.Destroy

end