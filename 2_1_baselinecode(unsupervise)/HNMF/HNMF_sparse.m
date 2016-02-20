function [W,H,tempV,rmse,isCoverage] = HNMF_sparse(Max_iter,V1,V2,W,H1,H2,M,lamta1,lamta2)
%V1是父亲层，V2是儿子层，相当于论文分别对应论文中的j属于B和j属于A
%可以理解为当j属于B时，Qp(j)=0;则可以将迭代合并到一起进行。
%注意：最终的tempV，即R^应该是W*tempH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入： V1：level5_g_p_network 对应论文中R的父层关联
%      V2:level6_g_p_network   对应论文中R的子层关联
%       M：父子之间的映射关系
%       W:对应论文中的P（user）
%       H1和H2分别对应论文的父层和子层item
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V =[V1 V2];
H = [H1 H2];

[~,n]=size(H1);

parentH1 = zeros(size(H1));

rmse = zeros(1,Max_iter);
isCoverage = false;
for t = 1:Max_iter
    
    %计算A和B的parent，其中B的parent为0，A的parent为H1*M
    parentH2 = H(:,1:n)*M;
    tempH = H+[parentH1 parentH2];
    
    %构建了新的H之后就可以进行传统的非负矩阵分解
    W = W.* ((V*tempH')./(W*tempH*tempH' + lamta1*W+eps));
    H = H.* ((W'*V)./(W'*W*H+lamta2*H+eps));
    
    %更新完成后，计算第5层的RH
    tempV = W*H(:,1:n);
    
    %计算根方均误差
    rmse(t) = RMSE(V1,tempV);
    
      if(t>10 && rmse(t-10)<=rmse(t))
        disp(['not coverage!']);
        isCoverage = false;
        return;
    end
    
    if(isnan(rmse(t)))
        disp(['not coverage!']);
        isCoverage = false;
        return;
    end
    
     disp(['iter' num2str(t) 'complete!' 'rmse:'  num2str(rmse(t))]);
end
%最终研究第5层的情况
isCoverage = true;
end
