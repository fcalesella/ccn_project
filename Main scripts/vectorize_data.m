load FCMatrixImage_132subj.mat;
load finalsubs.mat;

% tranforming the structure array with the FC matrices in a 3D array
fc = makefcarray(img, 'img');
% vectorizing functional connctivity matrices
vec_fc = vec(fc);

% extracting the 131 patients IDs
pt_id = fcs({img.name});
% indexing only the good patients
gp_mask = pts_mask(pt_id, pats);
% take the 100 good patients
vec_fc = vec_fc(gp_mask, :);
% setting NaN to 0 (damaged parcels)
vec_fc(isnan(vec_fc)) = 0;

save('vectorized_data.mat', 'vec_fc');