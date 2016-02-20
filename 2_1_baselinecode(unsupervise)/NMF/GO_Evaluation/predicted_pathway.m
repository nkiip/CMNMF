function [Z_filtered,predicted_pathway_mgi_id] = predicted_pathway(W,K,mgi_id)
%计算Z-score
z_threshold =K;
Z=zscore(W');
Z(Z<z_threshold)=0;
Z =Z';

%聚簇
[m,n]=size(Z);
%k(每个基因，每次筛选的个数）
k = zeros(m,1);

%Z_filtered为预测出的gene-pathway关系矩阵，为0,1矩阵
Z_filtered=zeros(m,n);

[order,index]=sort(Z,2,'descend');

    for i=1:m
        %0.9为阈值筛选
        if sum(order(i,:)) ==0
            Z_filtered(i,:) = 0;
        else
            p=0;
            while(p<0.9)
                k(i)=k(i)+1;
                p=sum(order(i,1:k(i)))/sum(order(i,:));

            end
        end

        Z_filtered(i,index(i,1:k(i)))=1;

    end
    
%predicted_pathway_mgi_id每一列为一个pathway,其中包含此pathway中基因的mgi_id
%将Z_filter矩阵转化为predicted_pathway_mgi_id矩阵

max_pathway_gene = max(sum(Z_filtered));
gene_location = zeros(max_pathway_gene,n);
predicted_pathway_mgi_id = zeros(max_pathway_gene,n);
     
   for i = 1:n
         gene_location = find(Z_filtered(:,i)==1);
         gene_mgi_id = mgi_id(gene_location);
         predicted_pathway_mgi_id(1:length(gene_mgi_id),i)=gene_mgi_id;
   end
   
%去除空的pathway       
%predicted_pathway_mgi_id(all(predicted_pathway_mgi_id==0),:)=[]; 
             
% [~,G0_col]=size(G0);
% 
% pathway=zeros(6,n);
% 
% 
% for i=1:n
%     s=zeros(m,G0_col);
%     
%     for j=1:G0_col
%         s(:,j)=Z_filtered(:,i).*G0(:,j);
%     end
%     
%     
%     Intersect_GeneNum=sum(s);
%     
%     pathway_id_many=find(Intersect_GeneNum==max(Intersect_GeneNum));
%     q=sum(G0(:,pathway_id_many));
%     q_min=find(q==min(q));
%  
%     pathway(1,i)=pathway_id_many(q_min(1));
%     pathway(2,i)=Intersect_GeneNum(pathway(1,i));
%     pathway(3,i)=sum(Z_filtered(:,i));
%     pathway(4,i)=sum(s(:,pathway(1,i)))/sum(Z_filtered(:,i));
%     pathway(5,i)=sum(G0(:,pathway(1,i)));
%     pathway(6,i)=sum(s(:,pathway(1,i)))/sum(G0(:,pathway(1,i)));
% end


%      [B,ix]=sort(Z_filtered,1,'descend');
%      Z_filtered(Z_filtered<0.1) = 0;
%      jaccard = 0;
%      nonEmptyClusterNum = 0;
%      for i = 1:n
%         if sum(Z_filtered(:,i)) > 0 
%             nonEmptyClusterNum = nonEmptyClusterNum+1;
%             p = 0;
%             while(p<0.7)
%                 k2(i)=k2(i)+1;
%                 p=sum(B(1:k2(i),i))/sum(B(:,i));
%             end
%                 filteredGene_clusters(1:k2(i),i) = mgi_id(ix(1:k2(i),i));
%                 [~,~,ib]=intersect(filteredGene_clusters(:,i),bg_mgi_id);
%                 subC=C(ib,ib);
%                 jaccard=jaccard+nnz(subC)/(k2(i)^2);
%             
%         end        
%      end
%      jaccard = jaccard/nonEmptyClusterNum;  
     
