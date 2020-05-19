function[data] = vec(fc)
% Vectorize the functional connectivity matrix. Only one half is kept.

dim_vec = ((size(fc, 2)^2) - size(fc, 2)) / 2;
nsubj = size(fc, 1);
data = zeros(nsubj, dim_vec);

for i = 1:nsubj
    
    vec = [];
    for row = 1:(size(fc, 2) - 1)
        
        line = fc(i, row, (row + 1):size(fc, 3));
        sl = squeeze(line);
        vec = [vec, sl'];
    end
        
    data(i,:) = vec;
end
end