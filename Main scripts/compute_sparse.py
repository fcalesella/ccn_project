# -*- coding: utf-8 -*-
"""
Created on Mon Dec 16 14:35:33 2019

@author: fede_

Perform Dictionary Learning (DL) on "vecotrized_data" and save a 
set of features for each selected number of components (ncomp)
"""

import scipy.io as sio
import numpy as np
from sklearn.decomposition import DictionaryLearning

mat = sio.loadmat('vectorized_data.mat')
inp = mat['vec_fc']
components = np.arange(10, 100, 5)

dic = {}
weights = {}
mse = np.zeros(components.shape[0])
se = np.zeros(components.shape[0])
for i, comp in enumerate(components):
    dic_learn = DictionaryLearning(comp, random_state = 1234)
    name = 'n{}'.format(comp)
    dic[name] = dic_learn.fit_transform(inp)
    weights[name] = dic_learn.components_
    reco = np.dot(dic[name], weights[name])
    rer = np.mean((reco - inp)**2, 1)
    mse[i] = np.mean(rer)
    se[i] = np.std(rer, ddof=1) / np.sqrt(len(rer))

sio.savemat('sparse_output.mat', {'feats': dic,
                                  'reco_error': mse,
                                  'reco_se': se,
                                  'ncomp': components,
                                  'weights': weights})