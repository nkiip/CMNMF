clc;model.doc_topic_
clear all;
load('g_p_netwrok_2015_3_4&5.mat');
inter_id = intersect(first_level_id', second_level_id');
second_level_id_copy = second_level_id;
for i =1:length(inter_id)
   second_level_id(second_level_id_copy == inter_id(i)) = [];
    g_p_network5(:,second_level_id_copy == inter_id(i)) = [];
end
gp_network = [g_p_network4, g_p_network5];
mpo_id = [first_level_id', second_level_id'];
save('gp_network.mat', 'gp_network');
save('mpo_id.mat', 'mpo_id');