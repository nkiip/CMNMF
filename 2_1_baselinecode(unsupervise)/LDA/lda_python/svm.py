#work for svm
import numpy as np
import scipy.io as sio

g_path_data = sio.loadmat('D:\Git\workspace\lab_2015_03_23\4_1_code - 副本\svm\G0_data.mat')
g_mpo_data = sio.loadmat('D:\Git\workspace\lab_2015_03_23\4_1_code - 副本\svm\gp_network.mat')
g_path_matrix = g_path_data['G0_NoLessThan_T_norm']
g_mpo_matrix = g_mpo_data['gp_network']
