%因为第5层是父层，hnmf的效果应该是和NMF是一样的。
path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');

MaxIter=30;
K=225;

max_pathway_gene_num=2000;
T=3;

build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');

V1 = g_p_network4;
V2 = g_p_network5;

[m,n1]=size(V1);
[~,n2]=size(V2);

alphas=[0];
gamas=[0];
%lamtas1=[0.01,0.1,1,10,20];
%lamtas2=[0.01,0.1,1,10,20];
lamtas1=[1];
lamtas2=[1];

for lamta1=lamtas1
    for lamta2=lamtas2
        t=1;
        num=0;
        while 1
            num=num+1;
            W= rand(m,K);
            H1 = rand(K,n1);
            H2 = rand(K,n2);
            
            
            [W_out,H_out,V_out,rmse,isCoverage] = HNMF_sparse(MaxIter,V1,V2,W,H1,H2,M,lamta1,lamta2);
            directory='../../result_2015_229/HMF';
                          if(~exist(directory,'dir'))
                              mkdir(directory);
                          end
            if(isCoverage)
                fn = ['../../result_2015_229/HMF/HNMF_result_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2)  '_t&' num2str(t)  '.mat'];
                disp([datestr(now) ':  '  fn ]);
                save(fn,'W_out','H_out','rmse');
            end
            t=t+1;
            if(t>=11 || num>50)
                break;
            end
        end
    end
end

load('mgi_id');
t_circle = 10;
a = length(alphas);
b = length(gamas);
c=length(lamtas1);
d = length(lamtas2);
jaccards=zeros(c*d,10);
RD = zeros(a*b*c*d,t_circle);
F = zeros(a*b*c*d,t_circle);
Z_filter = cell(a*b*c*d,t_circle);
pathway_gene_mgi_id = cell(a*b*c*d,t_circle);
Precision=zeros(a*b*c*d,t_circle);
Recall=zeros(a*b*c*d,t_circle);
jaccard=zeros(a*b*c*d,t_circle);
alpha_ratio=1;
T=3;
for j=1:c
    lamta1=lamtas1(j);
    for k=1:d
        lamta2=lamtas2(k);
        for t=1:10
            fn = ['../../result_2015_229/HMF/HNMF_result_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2)  '_t&' num2str(t)  '.mat'];
            if(~exist(fn,'file'))
                continue;
            end
            load(fn);
            location=(1-1)*b*c*d+(1-1)*c*d+(j-1)*d+k;
            [Z_filter{location,t},pathway_gene_mgi_id{location,t}]= predicted_pathway(W_out,T,mgi_id);
            [RD(location,t),F(location,t),Precision(location,t),Recall(location,t),jaccard(location,t)]=rand_index(Z_filter{location,t},G0_NoLessThan_T,alpha_ratio);
            I1(location,t) = I1_score(W_out);
        end
    end
end

