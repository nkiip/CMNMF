path(path,'../../0_1_usefuldata');
max_pathway_gene_num=200;
min_gene_num_in_a_pathway=2;
%MaxIterΪ��������
%U=Inner_MaxIterΪ�ڲ���������

%build_G0(max_pathway_gene_num,min_gene_num_in_a_pathway);
load('G0_data.mat');

SelectedGeneNum = length(SelectedGene);
GeneNumStart = 1;
GeneNumEnd = 145;

MaxIter=30;
Inner_MaxIter=1;
%t_circleΪ��ʼ������
t_circle=5;
%alphas,beta,gamas,lamtas1,lamtas2Ϊ����
alphas=[0.01];
gamas=[0.1];
beta=1;
%beta=1-alphas-gamas;
lamtas1=[1];
lamtas2=[1];
% average_auc_in_different_para_combs = ['average_auc_in_different_para_combs_group_' num2str(GroupNum)'];
% Auc_N_ParaCombs = ['Auc_N_ParaCombs_group_' num2str(GroupNum)'];
% MeanAuc_N_ParaCombs = ['MeanAuc_N_ParaCombs_group_' num2str(GroupNum)'];
auc_n_set = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230];
auc_topN_for_paras_selection = 3;
common_filedir =  '../../5_9_result_2015/SCMNMF/SCMNMF_LF/';
run_experiment(alphas,beta,gamas,lamtas1,lamtas2,MaxIter,Inner_MaxIter,t_circle,max_pathway_gene_num,min_gene_num_in_a_pathway,GeneNumStart,GeneNumEnd,common_filedir);
[average_auc_in_different_para_combs,Auc_N_ParaCombs,MeanAuc_N_ParaCombs] = result_evaluation( alphas,beta,gamas,lamtas1,lamtas2,auc_n_set,auc_topN_for_paras_selection,min_gene_num_in_a_pathway, max_pathway_gene_num,t_circle,GeneNumStart,GeneNumEnd,common_filedir);

datetime=fix(clock);
      s='';
      for i=1:6
      s=[s num2str(datetime(i))];
      end
      fn2=[common_filedir 'AUC_LF_group_' all '.mat'];
      save(fn2,'average_auc_in_different_para_combs','Auc_N_ParaCombs','MeanAuc_N_ParaCombs');





