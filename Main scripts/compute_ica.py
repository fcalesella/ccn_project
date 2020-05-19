# -*- coding: utf-8 -*-
"""
Created on Tue Nov 19 14:34:58 2019

@author: fede_

Perform Independent Component Analysis (ICA) on "vecotrized_data" and save a 
set of features for each selected number of components (ncomp)
"""

import scipy.io as sio
import numpy as np
from sklearn.decomposition import FastICA

mat = sio.loadmat('vectorized_data.mat')
inp = mat['vec_fc']
components = np.arange(10, 100, 5)

ica = {}
mix = {}
mse = np.zeros(components.shape[0])
se = np.zeros(components.shape[0])
for i, comp in enumerate(components):
    transformer = FastICA(n_components=comp, max_iter = 1000, random_state = 1234)
    name = 'n{}'.format(comp)
    sica = transformer.fit_transform(inp)
    ica[name] = sica
    reco = transformer.inverse_transform(sica)
    rer = np.mean((reco - inp)**2, 1)
    mse[i] = np.mean(rer)
    se[i] = np.std(rer, ddof=1) / np.sqrt(len(rer))
    mix[name] = transformer.mixing_
    
sio.savemat('ica_output.mat', {'feats': ica,
                                 'reco_error': mse,
                                 'reco_se': se,
                                 'ncomp': components,
                                 'weights': mix})
