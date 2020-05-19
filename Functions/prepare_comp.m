function[xs] = prepare_comp(comp, mask)
% Prepare each set of features for regression. The subjects without a
% target are discarded and the remaining subjects are standardized.
% comp is a cell array containing the feature sets.
% mask is a logical vector inidicing which subjects have the target

ncomp = length(comp);
xs = cell(1, ncomp);

for i = 1:ncomp
    
    x = comp{i};
    x = x(mask, :);
    x = (x - mean2(x)) / std2(x);
    xs{i} = x; 
end