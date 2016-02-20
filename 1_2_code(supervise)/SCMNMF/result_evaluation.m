function [ average_auc_in_different_para_combs,Auc_N_ParaCombs,MeanAuc_N_ParaCombs] = result_evaluation( alphas,beta,gamas,lamtas1,lamtas2,auc_n_set,auc_topN_for_paras_selection,min_gene_num_in_a_pathway,max_pathway_gene_num,t_circle,GeneNumStart,GeneNumEnd,common_filedir)
%EVALUATION Summary of this function goes here
%   Detailed explanation goes here
load('G0_data.mat');
load('mgi_id');
 a = length(alphas);
 b = length(gamas);
 c = length(lamtas1);
 d = length(lamtas2);
 
 %Th 预测时，取前Th个pathway为正例
 %Th=25;
 %roc_n_set为计算roc时的传参值n
 %auc_n_set = [10,20,30,100];
 Auc_N_ParaCombs = cell(length(auc_n_set),a*b*c*d); 
 MeanAuc_N_ParaCombs = zeros(length(auc_n_set),a*b*c*d); 
 %roc_gene为存放结果的向量，每一个元素代表去掉第i个基因训练后的auc结果值
 %roc_gene=zeros(length(roc_n_set),length(SelectedGene));
 auc_Gene_T_circle=zeros(length(SelectedGene),t_circle);
 %每一个roc_n_set对应一个roc cell，每个cell为一个矩阵，存储不同参数下，不同初始结果的auc值
%  alpha=alphas(1);
%  gama=gamas(1);

 for n = 1:length(auc_n_set)
 for al=1:a
     alpha1=alphas(al);
     for ga=1:b
         gama1=gamas(ga); 
        for j=1:c
            lamta1=lamtas1(j);
            for k=1:d
                lamta2=lamtas2(k);
                for t=1:t_circle                  
                    for i=GeneNumStart:GeneNumEnd                           
                            fn = [common_filedir 'SCMNMF_simple_alpha' num2str(alpha1) '_beta&' num2str(beta) '_gama&' num2str(gama1) '_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2) '_t' num2str(t) '_i' num2str(i) '.mat'];
                            if(~exist(fn,'file'))
                                continue;
                            end
                             load(fn);
                             %location 为每一组参数结果存放的位置
                             location=(al-1)*b*c*d + (ga-1)*c*d + (j-1)*d + k;

                             %target为需要去掉的基因所对应的mgi_id位置
                             target=find(mgi_id==SelectedGene(i));

                             ranked_pathways_for_specific_gene=rankgene(W_out,G0_NoLessThan_T,target);

                             auc_Gene_T_circle(i,t)=ROC(ranked_pathways_for_specific_gene,auc_n_set(n));                        
                            Auc_N_ParaCombs{n,location} = auc_Gene_T_circle;
                    end                     
                end
                MeanAuc_N_ParaCombs(n,location)=sum(sum(Auc_N_ParaCombs{n,location})); 
                disp(fn);
            end
        end
    end
 end
 end
average_auc_in_different_para_combs =mean(MeanAuc_N_ParaCombs(1:auc_topN_for_paras_selection,:));

end

