function[coefs, mse, yhat] = opt_lambda(xtrain, ytrain, xtest, ytest, alpha, lambda)
% Perform lambda optimization on the lasso function.

nlam = length(lambda);
coefs = zeros(size(xtrain,2), nlam);
yhat = zeros(nlam, 1);
mse = zeros(nlam, 1);

parfor i = 1:nlam
    
    b = lasso(xtrain, ytrain, 'Lambda', lambda(i), 'Alpha', alpha, 'Standardize', false);
    
    coefs(:, i) = b;
    yhat(i) = xtest * b;
    mse(i) = ((ytest - yhat(i)).^2) / size(ytest, 1);
end

end