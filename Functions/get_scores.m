function[data] = get_scores(scores, names)

nsubj = size(scores, 2);

for i = 1:nsubj
    
    for field = 1:size(names, 2)
        
        try
            data(i, field) = scores(i).(names{field});
        catch
            data(i, field) = NaN;
        end 
    end
end

end