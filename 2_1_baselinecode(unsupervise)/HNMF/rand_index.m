function [ RD,F,Precision,Recall,jaccard ] = rand_index( G,pathway_gene,a)
NoIntersectGene = find(sum(pathway_gene,2)==0);
G(NoIntersectGene,:)=0;

g_g_predict = G*G';
g_g_pathway = pathway_gene*pathway_gene';
g_g_predict(g_g_predict>0) = 1;
g_g_pathway(g_g_pathway>0) = 1;
g_g_predict=g_g_predict-diag(diag(g_g_predict));
g_g_pathway=g_g_pathway-diag(diag(g_g_pathway));



TP = nnz(g_g_predict+g_g_pathway==2);
TN = nnz(g_g_predict+g_g_pathway==0);
FP = nnz(g_g_predict-g_g_pathway==1);
FN = nnz(g_g_predict-g_g_pathway==-1);

RD = (TP+TN)/(TP+TN+FP+FN);

Precision = TP/(TP+FP);

Recall = TP/(TP+FN);

F=(a^2+1)*Recall*Precision/(a^2*(Recall+Precision));

jaccard = TP/nnz(g_g_predict+g_g_pathway);

end

