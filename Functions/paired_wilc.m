function[p, h, z] = paired_wilc(resids_arr)
% Perform paired wilcoxon signed ranking test on the squared residuals of
% each variable (columns). Residuals are squared within the function.

sr = resids_arr .^2;
n = size(sr, 2);
nav = NaN(1, n);
p = diag(nav);
h = diag(nav);
z.zval = diag(nav);
z.signedrank = diag(nav);

for i = 1:n
    
    for c = i:(n-1)
        
        toco = c + 1;
        [p(i, toco), h(i, toco), stat] = signrank(sr(:, i), sr(:, toco));
        z.zval(i, toco) = stat.zval;
        z.signedrank(i, toco) = stat.signedrank;
        p(toco, i) = p(i, toco);
        h(toco, i) = h(i, toco);
        z.zval(toco, i) = z.zval(i, toco);
        z.signedrank(toco, i) = z.signedrank(i, toco);
    end
end
end