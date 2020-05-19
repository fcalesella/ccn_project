function[coefs, mse, yhat] = opt_comp(xtrain, ytrain, xtest, ytest, alpha, lambda)
% Perform the tuning of the number of features parameter for the lasso 
% function (see line 11: opt_lambda).
% This function is called by the loo function for number of components
% tuning in a cross-validation setting.

npca = length(xtrain);
nlam = length(lambda);
nalpha = length(alpha);
coefs = cell(1, npca);
mse = zeros(nlam, nalpha, npca);
yhat = zeros(nlam, nalpha, npca);

parfor i = 1:npca
    
    [coefs{i}, mse(:, :, i), yhat(:, :, i)] = opt_alpha(xtrain{i}, ytrain, xtest{i}, ytest, alpha, lambda);
    
end

end