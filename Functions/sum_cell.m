function[out] = sum_cell(c1, c2)

n = length(c2);
out = cell(1, n);

for i = 1:n
    if isempty(c1{i})
        out{i} = c2{i};
    else
        out{i} = c1{i} + c2{i};
    end
end