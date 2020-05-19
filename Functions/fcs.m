function[number] = fcs(names)

nsubj = length(names);
number = zeros(nsubj, 1);

for i = 1:nsubj
    
    number(i) = str2double(names{i}(end-2:end));
end

end