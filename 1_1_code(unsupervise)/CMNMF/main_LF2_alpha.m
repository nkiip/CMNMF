path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');

%max_pathway_gene_num为筛选出G0的阈值（pathway的长度最大值）
%T为筛选出G0_NolessThan_T的阈值（每个pathway基因与mgi_id相交后pathway的最小长度）
max_pathway_gene_num=200;
T=2;

build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');
load('gp_network.mat');



%MaxIter为一次NMF迭代，InnerMaxIter为内部迭代
MaxIter=30;
InnerMaxIter=2;

%聚类个数K
K=229;
%t_circle为初始化次数
t_circle=10;

%V1为level4 g-p矩阵
%V2为level5 g-p矩阵
V1 = g_p_network4;
V2 = g_p_network5;


[m,n1]=size(V1);
[~,n2]=size(V2);

%参数
alphas=[0,0.01,0.1,0.5,1,1.5,2,3,5];
gamas=[0,0.01,0.1,0.5,1,1.5];
%lamtas1 太大会不收敛
lamtas1=[1];
lamtas2=[1];

for alpha=alphas
    for gama = gamas
        for lamta1=lamtas1
            for lamta2=lamtas2
                for t=1:t_circle
                    W= rand(m,K);
                    H1 = rand(K,n1);
                    H2 = rand(K,n2);
                    %L为目标函数,W_out,H_out为矩阵分解结果
                    [L,W_out,H1_out,H2_out] =  CMNMF_LF2(MaxIter,InnerMaxIter,V1,V2,W,H1,H2,M,alpha,gama,lamta1,lamta2);
                     
                         directory='../../5_6_result_2015/CMNMF/CMNMF_LF2';
                         if(~exist(directory,'dir'))
                             mkdir(directory);
                         end
                       
                         fn = ['../../5_6_result_2015/CMNMF/CMNMF_LF2/CMNMF_simple_alpha' num2str(alpha)  '_gama&' num2str(gama) '_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2) '_t' num2str(t) '.mat'];
                         disp([datestr(now) ':  '  fn ]);
                         save(fn,'L','W_out','H1_out','H2_out');
                   
                end
            end
        end
    end
end


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

a = length(alphas);
b = length(gamas);
c = length(lamtas1);
d = length(lamtas2);

% jaccards=zeros(a*b*c*d,t_circle);
% nonEmptyClusterNum = zeros(a*b*c*d,t_circle);

%pathway_gene_mgi_id为预测出的gene与pathway关系
RD = zeros(a*b*c*d,t_circle);
F = zeros(a*b*c*d,t_circle);
Z_filter = cell(a*b*c*d,t_circle);
pathway_gene_mgi_id = cell(a*b*c*d,t_circle);
Precision=zeros(a*b*c*d,t_circle);
Recall=zeros(a*b*c*d,t_circle);
jaccard=zeros(a*b*c*d,t_circle);

alpha_ratio = 1;
%T为zscore阈值
T=3;
for al=1:a
    alpha1=alphas(al);
    for ga=1:b
        gama1=gamas(ga); 
        for j=1:c
            lamta1=lamtas1(j);
            for k=1:d
                lamta2=lamtas2(k);
                for t=1:t_circle
                fn = ['../../5_6_result_2015/CMNMF/CMNMF_LF2/CMNMF_simple_alpha' num2str(alpha1)  '_gama&' num2str(gama1) '_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2) '_t' num2str(t) '.mat'];
                if(~exist(fn,'file'))
                    continue;
                end
                load(fn);
                %location为某组参数对应的位置
                location=(al-1)*b*c*d+(ga-1)*c*d+(j-1)*d+k;
                [Z_filter{location,t},pathway_gene_mgi_id{location,t}]= predicted_pathway(W_out,T,mgi_id);
                [RD(location,t),F(location,t),Precision(location,t),Recall(location,t),jaccard(location,t)]=rand_index(Z_filter{location,t},G0_NoLessThan_T,alpha_ratio);
                end
            end
        end
    end
end

%存储结果
datetime=fix(clock);
      s='';
      for i=1:6
      s=[s num2str(datetime(i))];
      end
      fn2=[ '../../5_6_result_2015/CMNMF/CMNMF_LF2/predicted_pathway_LF_' s '.mat'];
      save(fn2,'Z_filter','pathway_gene_mgi_id','RD','F');

