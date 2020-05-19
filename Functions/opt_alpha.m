function[coefs, mse, yhat] = opt_alpha(xtrain, ytrain, xtest, ytest, alpha, lambda)
% Perform the tuning of the alpha parameter for the lasso function 
% (see line 11: opt_lambda).
% This function is called by opt_comp in the cross validation setting. 

nalpha = length(alpha);
nlam = length(lambda);
coefs = zeros(size(xtrain,2), nlam, nalpha);
yhat = zeros(nlam, nalpha);
mse = zeros(nlam, nalpha);

parfor i = 1:nalpha
    
    [coefs(:, :, i), mse(:, i), yhat(:, i)] = opt_lambda(xtrain, ytrain, xtest, ytest, alpha(i), lambda);
    
end

end