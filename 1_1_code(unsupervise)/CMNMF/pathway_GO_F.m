%simi = G0_NoLessThan_T*G0_NoLessThan_T';
%simi(simi>0) = 1;

max_pathway_gene_num=200;
T=2;
build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('similarity_simple.mat');
load('mgi_id.mat');
simi = simi+simi'-2*eye(size(simi,1),size(simi,1));
G0_NoLessThan_T = G0_NoLessThan_T(:,SelectedPathway_G0_NoLessThan_T_norm(1:5));
[m,n] = size(G0_NoLessThan_T);
for i = 1:m
    G0_NoLessThan_T(i,:)=G0_NoLessThan_T(i,:)*i;
end
Pathway_gene_row=G0_NoLessThan_T(:)';
Pathway_gene_row((Pathway_gene_row)==0)=[];
K=length(Pathway_gene_row);
Pathway_GO = zeros(K,K);
for i=1:K
    for j=1:K
        Pathway_GO(i,j) = simi(Pathway_gene_row(i),Pathway_gene_row(j)); 
    end
end

% imagesc(Pathway_GO);
% colormap(gray);
a= mat2gray(1-(Pathway_GO));
imshow(a);