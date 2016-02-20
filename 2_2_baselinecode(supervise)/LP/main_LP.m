path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');
load('gp_network.mat');
%load('similarity.mat');

%max_pathway_gene_numΪɸѡ��G0����ֵ��pathway�ĳ������ֵ��
%TΪɸѡ��G0_NolessThan_T����ֵ��ÿ��pathway������mgi_id�ཻ��pathway����С���ȣ�
max_pathway_gene_num=200;
T=2;
iter = 100;
build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');

gene_dis = squareform(pdist(gp_network,'euclidean'));
simi = exp(-gene_dis);

 %t_circleΪ��ʼ������
 %roc_n_setΪ����rocʱ�Ĵ���ֵn
 roc_n_set = [10,30,50,100,150,230];
 %roc_geneΪ��Ž����������ÿһ��Ԫ�ش���ȥ����i������ѵ�����auc���ֵ
 %roc_gene=zeros(length(roc_n_set),length(SelectedGene));
 roc_gene=zeros(length(SelectedGene),length(roc_n_set));
 roc=zeros(length(roc_n_set));
 %ÿһ��roc_n_set��Ӧһ��roc cell��ÿ��cellΪһ�����󣬴洢��ͬ�����£���ͬ��ʼ�����aucֵ
 for t=1:length(roc_n_set)                
      for i=1:length(SelectedGene)
            %targetΪ��Ҫȥ���Ļ�������Ӧ��mgi_idλ��
            target=find(mgi_id==SelectedGene(i));     
            [W_out,rmse,f_u] = lpa(simi,G0_NoLessThan_T,target,iter);
            ranked_pathways_for_specific_gene=rankgene(W_out,G0_NoLessThan_T,target);
            roc_gene(i,t)=ROC(ranked_pathways_for_specific_gene,roc_n_set(t));  
      end
       roc(t)=mean(roc_gene(:,t));  
 end
