function[tr, tr_not] = train_ind(x, index, not)

npca = length(x);
tr = cell(1, npca);
tr_not = cell(1, npca);


for i = 1:npca
    tr{i} = x{i}(index, :);
    tr_not{i} = x{i}(not, :);
end

end