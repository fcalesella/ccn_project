function[pats] = pts_mask(ids, ref)
% Create a mask indicing the subjects that will be selected

nsubj = length(ids);
pats = zeros(nsubj, 1);

for i = 1:nsubj
    
    if ismember(ids(i), ref) == 1
        pats(i) = 1;
    end
end

pats = logical(pats);

end