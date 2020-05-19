function[coefs, mse, choice, yhat] = nested_loo(x, y, alpha, lambda)
% Perform nested Leave-One-Out (LOO)cross validation(CV). This is the outer
% function for simple LOO CV.

npca = length(x);
nsubj = size(y, 1);
nalpha = length(alpha);
nlam = length(lambda);
mse = zeros(nlam, nalpha, npca);
yhat = zeros(nsubj, 1);
coefs = cell(1, nsubj);
choice = cell(1, nsubj);
waitb = parfor_wait(nsubj, 'Waitbar', true);

parfor i = 1:nsubj
    
    coord = ones(nsubj, 1, 'logical');
    coord(i) = 0;
    trainc = coord;
    testc = ~trainc;
    
    [xtrain, xtest] = train_ind(x, trainc, testc);
    
    yset = y;
    ytrain = yset(trainc, :);
    
    [~, mse_temp, choice{i}, ~] = loo(xtrain, ytrain, alpha, lambda);
    mse = mse + mse_temp;
    
    bl = choice{i}(1);
    ba = choice{i}(2);
    bp = choice{i}(3);
    poscomp = cellfun(@(x) size(x, 2) == bp, xtrain);
    
    b = lasso(xtrain{poscomp}, ytrain, 'Lambda', bl, 'Alpha', ba, 'Standardize', false);
    yhat(i) = xtest{poscomp} * b;
    coefs{i} = b;
    
    waitb.Send;
end

mse = mse ./ nsubj;

waitb.Destroy
end