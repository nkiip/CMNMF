path(path,'../../0_1_usefuldata');
load('g_p_netwrok_2015_3_4&5.mat');

%max_pathway_gene_numΪɸѡ��G0����ֵ��pathway�ĳ������ֵ��
%TΪɸѡ��G0_NolessThan_T����ֵ��ÿ��pathway������mgi_id�ཻ��pathway����С���ȣ�
max_pathway_gene_num=2000;
T=0;

build_G0(max_pathway_gene_num,T);
load('G0_data.mat');
load('mgi_id');
%t_circleΪ��ʼ������
t_circle=10;

%V1Ϊlevel4 g-p����
%V2Ϊlevel5 g-p����
V1 = g_p_network4;
V2 = g_p_network5;

[m,n1]=size(V1);
[~,n2]=size(V2);

%����
alphas=[1];
gamas=[0,0.5,1];
%lamtas1 ̫��᲻����
lamtas1=[1];
lamtas2=[1];

a = length(alphas);
b = length(gamas);
c = length(lamtas1);
d = length(lamtas2);

% jaccards=zeros(a*b*c*d,t_circle);
% nonEmptyClusterNum = zeros(a*b*c*d,t_circle);

%pathway_gene_mgi_idΪԤ�����gene��pathway��ϵ
RD = zeros(a*b*c*d,t_circle);
F = zeros(a*b*c*d,t_circle);
Z_filter = cell(a*b*c*d,t_circle);
pathway_gene_mgi_id = cell(a*b*c*d,t_circle);
rat = zeros(a*b*c*d,t_circle);
%TΪzscore��ֵ
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
                fn = ['../../5_6_result_2015/CMNMF/CMNMF_LF/CMNMF_simple_alpha' num2str(alpha1)  '_gama&' num2str(gama1) '_lamta1&' num2str(lamta1)  '_lamta2&' num2str(lamta2) '_t' num2str(t) '.mat'];
                if(~exist(fn,'file'))
                    continue;
                end
                load(fn);
                %locationΪĳ�������Ӧ��λ��
                location=(al-1)*b*c*d+(ga-1)*c*d+(j-1)*d+k;
                [Z_filter{location,t},pathway_gene_mgi_id{location,t}]= predicted_pathway(W_out,T,mgi_id);
                rat(location,t) = ratio(pathway_gene_mgi_id{location,t});
                end
            end
        end
    end
end



