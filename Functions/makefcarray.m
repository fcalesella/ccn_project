function[ar] = makefcarray(fc, field)
% Transform the functional connectivity structure array in a 3D array.
% Each subject is a row, which contains the 2D fucntional connectivity array.

nsubj = size(fc, 2);

for i = 1:nsubj
     
    try
        ar(i,:,:) = fc(i).(field);
    catch
        ar(i,:,:) = NaN;
    end
end

end