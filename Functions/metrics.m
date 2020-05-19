function[metric] = metrics(y, yhat, type, coefs)
% Compute either the R squared or the BIC.
% y is a vector containing the true values.
% yhat is a vector containing the predicted values.
% type is string: rsq for R squared and bic for BIC.
% if type = bic, coefs must be defined as the regression coefficient
% vector.

sse = sum((yhat - y).^2);
if strcmp(type, 'rsq')
    sst = sum((y - mean(y)).^2);
    metric = 1 - sse / sst;
else
    ns = length(y);
    nzc = sum(coefs ~= 0);
    metric = ns + ns * log(2*pi) + ns * log(sse/ns) + log(ns) * nzc;
end