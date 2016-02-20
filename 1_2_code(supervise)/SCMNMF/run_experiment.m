function []=run_experiment(alphas,beta,gamas,lamtas1,lamtas2,MaxIter,Inner_MaxIter,t_circle,max_pathway_gene_num,min_gene_num_in_a_pathway,GeneNumStart,GeneNumEnd,common_filedir)
%path(path,'../../3_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');
load('G0_data.mat');
load('mgi_id.mat');
%max_pathway_gene_num为筛选出G0的阈值（pathway的长度最大值）
%T为筛选出G0_NolessThan_T的阈值（每个pathway基因与mgi_id相交后pathway的最小长度）
% max_pathway_gene_num=200;
% min_gene_num_in_a_pathway=2;

%MaxIter为迭代次数
%U=Inner_MaxIter为内部迭代次数
% MaxIter=30;
% Inner_MaxIter=2;

[~,K]=size(G0_NoLessThan_T_norm);

%t_circle为初始化次数
% t_circle=5;

%V1为level4 G-P矩阵
%V2为level5 G-P矩阵
V1 = g_p_network4;
V2 = g_p_network5;

W0 = G0_NoLessThan_T_norm;


[m,n1]=size(V1);
[~,n2]=size(V2);

%alphas,beta,gamas,lamtas1,lamtas2为参数
% alphas=[0,1];
% gamas=[0,0.9];
% beta=1;
% %beta=1-alphas-gamas;
% lamtas1=[1];
% lamtas2=[1];

L = cell(length(alphas)*length(gamas),t_circle);

[~,col]=size(G0_NoLessThan_T_norm);

for alpha=alphas
    for gama = gamas
          for lamta1=lamtas1
            for lamta2=lamtas2
                for t=1:t_circle
                    for i=GeneNumStart:GeneNumEnd
                    W= rand(m,K);
                    H1 = rand(K,n1);
                    H2 = rand(K,n2);
                    
                    W0=G0_NoLessThan_T_norm;
                    [~,col]=size(W0);
                   
                    %W0为去掉一个SelectedGene后的的Gene-Pathway矩阵
                    W0(mgi_id==SelectedGene(i),SelectedPathway_G0_NoLessThan_T_norm)=0;                   
                    [L{i,t},W_out,H1_out,H2_out] =  SCMNMF_LF( MaxIter,Inner_MaxIter,V1,V2,W,W0,H1,H2,M,alpha,beta,gama,lamta1,lamta2);
                    directory = common_filedir;
                        if(~exist(directory,'dir'))
                            mkdir(directory);
                        end
                       
                        fn = [common_filedir 'SCMNMF_simple_alpha' num2str(alpha) '_beta&' num2str(beta) '_gama&' num2str(gama) '_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2) '_t' num2str(t) '_i' num2str(i) '.mat'];
                        disp([datestr(now) ':  '  fn ]);
                        save(fn,'L','W_out','H1_out','H2_out');
                    end
                end
            end
        end
    end
end



end