function[back] = fc_back(vec)
% Restore the original functional connectivity matrix, from the vetoriezed 
% data. 


[nsubj, nfeat] = size(vec);
% solve the second order equation to get the the original FC matrix
% dimensions (x^2 - x - (52326 * 2) = 0).
syms x;
x = vpasolve(x^2 - x - (nfeat * 2) == 0, x);
mdim = double(x(2));
back = NaN(nsubj, mdim, mdim);

for i = 1:nsubj
    
    start = 1;
    point_end = 0;
    for c = 1:mdim
        
        dim_seg = mdim - c;
        point_end = point_end + dim_seg;
        back(i, c, (c + 1):end) = vec(i, start:point_end);
        back(i, (c + 1):end, c) = vec(i, start:point_end);
        start = start + dim_seg;
    end
end

end