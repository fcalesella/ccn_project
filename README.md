# ccn_project
 Feature extraction on functional connectivity in stroke patients
 
 This code was created to extract relevant features from functional connectivity data, in order to predict cognitive impairments in stroke patients. 


Instructions:

1. Use the "vecotize_data" script to vectorize the matrices. The script will save the vectorized data (named "vec_fc") in the current working directory. 

2. Run the compute_* scripts in order to perform dimensionality reduction on "vec_fc", with the desired feature extraction technique. These scripts will save the extracted features (with the associated mapping weights, reconstruction error and standard error) in a file named x_output (where x is the name of the chosen feature extraction techinque).

3. Run the "analysis" script to perform regularized regression on the extracted features in a Leave-One-Out cross-validated setting. For deeper understanding of the alpha and lambda parameters see the MATLAB documentation about the "lasso" function.

4. Generate some figures for model investigation with the "figures" script.

NOTE: in order to run the "loo" and "nested_loo" functions (called by the "analysis script"), a "parfor_wait" class is needed. See: Yun Pu (2020). Waitbar for Parfor (https://www.mathworks.com/matlabcentral/fileexchange/71083-waitbar-for-parfor), MATLAB Central File Exchange. Retrieved May 19, 2020. 
