path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');

%max_pathway_gene_numΪɸѡ��G0����ֵ��pathway�ĳ������ֵ��
%TΪɸѡ��G0_NolessThan_T����ֵ��ÿ��pathway������mgi_id�ཻ��pathway����С���ȣ�
max_pathway_gene_num=2000;
T=3;

build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');

%�������K
K=225;

%V1Ϊlevel4 g-p����
%V2Ϊlevel5 g-p����
V = gp_network;
[m,~] = size(V);
[coeff,score] = pca(V);

t_circle = 10;

I_score = zeros(t_circle,1);
for t = 1:t_circle
[Idx,~] = kmeans(score,K,'emptyaction','singleton');
G_predict = zeros(m,K);
  for i = 1:m
     G_predict(i,Idx(i))=1;
  end
  [ RD(t),F(t),Precision(t),Recall(t),jaccard(t) ] = rand_index( G_predict,G0_NoLessThan_T,1);
  
  for j = 1:K
    a = find(G_predict(:,j)==1);
    pathway_gene_mgi_id((1:length(a)),j) = mgi_id(a)';
  end
  rat(t)=ratio(pathway_gene_mgi_id);
end



