function[]= bulid_G0(max_pathway_gene_num,T)
load('mmu_pathway_mgi_id_true.mat');
load('mgi_id.mat');
load('selected_pathway.mat');
B=mmu_pathway_mgi_id_true;
A=B;
%GeneNum为每组pathway下基因数
GeneNum=sum(A>0,2);
%A为基因个数10-90的pathway
%max_pathway_gene_num = 200;
C=1:280;

A = B((GeneNum<max_pathway_gene_num),:);
filtered_C1 = C(:,(GeneNum<max_pathway_gene_num));

% mmu_pathway_id(GeneNum>=max_pathway_gene_num);
% mmu_pathway_id(selected_pathway,:);
[x,~]=size(A);

G0=zeros(length(mgi_id),x);
for i=1:x
    [~,~,ib] = intersect(A(i,:),mgi_id);
    G0(ib,i) = 1;
end       
save('G0_data.mat','G0');


%删除基因数小于T的pathway
%T=5;

filtered_C2 = filtered_C1(:,sum(G0,1)>=T);
G0(:,sum(G0,1)<T) = [];


G0_NoLessThan_T = G0;
save('G0_data.mat','G0_NoLessThan_T','-append');

[SelectedPathway,~,SelectedPathway_G0_NoLessThan_T_norm]=intersect(selected_pathway,filtered_C2);


%ratio = 0.8;
% G0_NoLessThan_T_ratio = zeros(m,n);

% for i=1:n   
%     index = find(G0_NoLessThan_T(:,i)==1);
%     index_randperm=index(randperm(length(index)));
%     index_ratio=index_randperm(1:(floor(ratio*length(index))));
%     G0_NoLessThan_T_ratio(index_ratio,i)=1;    
% end
% 

 G0_NoLessThan_T_norm = G0_NoLessThan_T;
 [~,n]=size(G0_NoLessThan_T_norm);
 for i=1:n
     G0_NoLessThan_T_norm(:,i)= G0_NoLessThan_T(:,i)/sum(G0_NoLessThan_T(:,i));
 end
 save('G0_data.mat','G0_NoLessThan_T_norm','-append');

G=B(SelectedPathway,:);

SelectedGene=unique(G);
SelectedGene=intersect(SelectedGene,mgi_id);
GeneTimes = sum(G0_NoLessThan_T,2);
Selected_mgi_id = mgi_id(GeneTimes~=0);
SelectedGene = intersect(SelectedGene,Selected_mgi_id);
% %%%%记得注释去掉
% SelectedGene_randperm=SelectedGene(randperm(length(SelectedGene)));
% SelectedGene=SelectedGene_randperm(1:randpick_gene_num,:);
% %%%%
save('G0_data.mat','SelectedPathway_G0_NoLessThan_T_norm','-append');
save('G0_data.mat','SelectedGene','-append');


end





