#work for lda in gp_network
import scipy.io as sio
import numpy as np
import lda
gp_network = sio.loadmat('gp_network.mat')
model = lda.LDA(n_topics = 20, n_iter = 500, random_state = 1)
model.fit(gp_network)
sio.savemat('gt_network.mat', model.doc_topic_)
sio.savemat('tp_network.mat', model.topic_word_)
