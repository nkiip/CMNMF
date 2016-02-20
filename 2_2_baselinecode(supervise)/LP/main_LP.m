path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');
load('gp_network.mat');
%load('similarity.mat');

%max_pathway_gene_num为筛选出G0的阈值（pathway的长度最大值）
%T为筛选出G0_NolessThan_T的阈值（每个pathway基因与mgi_id相交后pathway的最小长度）
max_pathway_gene_num=200;
T=2;
iter = 100;
build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');

gene_dis = squareform(pdist(gp_network,'euclidean'));
simi = exp(-gene_dis);

 %t_circle为初始化次数
 %roc_n_set为计算roc时的传参值n
 roc_n_set = [10,30,50,100,150,230];
 %roc_gene为存放结果的向量，每一个元素代表去掉第i个基因训练后的auc结果值
 %roc_gene=zeros(length(roc_n_set),length(SelectedGene));
 roc_gene=zeros(length(SelectedGene),length(roc_n_set));
 roc=zeros(length(roc_n_set));
 %每一个roc_n_set对应一个roc cell，每个cell为一个矩阵，存储不同参数下，不同初始结果的auc值
 for t=1:length(roc_n_set)                
      for i=1:length(SelectedGene)
            %target为需要去掉的基因所对应的mgi_id位置
            target=find(mgi_id==SelectedGene(i));     
            [W_out,rmse,f_u] = lpa(simi,G0_NoLessThan_T,target,iter);
            ranked_pathways_for_specific_gene=rankgene(W_out,G0_NoLessThan_T,target);
            roc_gene(i,t)=ROC(ranked_pathways_for_specific_gene,roc_n_set(t));  
      end
       roc(t)=mean(roc_gene(:,t));  
 end
