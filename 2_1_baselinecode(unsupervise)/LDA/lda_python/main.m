path(path,'../../../0_1_usefuldata');
%max_pathway_gene_num为筛选出G0的阈值（pathway的长度最大值）
%T为筛选出G0_NolessThan_T的阈值（每个pathway基因与mgi_id相交后pathway的最小长度）
max_pathway_gene_num=2000;
T=3;

build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');
load('gt_network.mat');

% %G0为gene_mgi_id与pathway的对应关系
% A=mmu_pathway_mgi_id;
% [x,~]=size(A);
% 
% G0=zeros(length(mgi_id),x);
% 
% for i=1:x
%     [~,~,ib] = intersect(A(i,:),mgi_id);
%     G0(ib,i) = 1;
% end     

% jaccards=zeros(a*b*c*d,t_circle);
% nonEmptyClusterNum = zeros(a*b*c*d,t_circle);

% %pathway_gene_mgi_id为预测出的gene与pathway关系
% RD = zeros(a*b*c*d,t_circle);
% F = zeros(a*b*c*d,t_circle);
% Z_filter = cell(a*b*c*d,t_circle);
% pathway_gene_mgi_id = cell(a*b*c*d,t_circle);
% Precision=zeros(a*b*c*d,t_circle);
% Recall=zeros(a*b*c*d,t_circle);
% jaccard=zeros(a*b*c*d,t_circle);

alpha_ratio = 1;
%T为zscore阈值
T=3;
Z_filter = cell(10);
pathway_gene_mgi_id = cell(10);

% for t = 1:10
% a=['gt_network' num2str(t)];
% b=load('gt_network_real.mat',a);
% c=struct2cell(b);
% [Z_filter{t},pathway_gene_mgi_id{t}]= predicted_pathway(c{1},T,mgi_id);
% [RD(t),F(t),Precision(t),Recall(t),jaccard(t)]=rand_index(Z_filter{t},G0_NoLessThan_T,alpha_ratio);
% end

% for t = 1:10
% a=['gt_network' num2str(t)];
% b=load('gt_network_100.mat',a);
% c=struct2cell(b);
% [Z_filter{t},pathway_gene_mgi_id{t}]= predicted_pathway(c{1},T,mgi_id);
% [RD(t),F(t),Precision(t),Recall(t),jaccard(t)]=rand_index(Z_filter{t},G0_NoLessThan_T,alpha_ratio);
% end

for t = 1:1
[Z_filter{t},pathway_gene_mgi_id{t}]= predicted_pathway(gt_network,T,mgi_id);
[RD(t),F(t),Precision(t),Recall(t),jaccard(t)]=rand_index(Z_filter{t},G0_NoLessThan_T,alpha_ratio);
rat(t) = ratio(pathway_gene_mgi_id{1,1});
end




