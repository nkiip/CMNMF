function [W,H,tempV,rmse,isCoverage] = HNMF_sparse(Max_iter,V1,V2,W,H1,H2,M,lamta1,lamta2)
%V1�Ǹ��ײ㣬V2�Ƕ��Ӳ㣬�൱�����ķֱ��Ӧ�����е�j����B��j����A
%�������Ϊ��j����Bʱ��Qp(j)=0;����Խ������ϲ���һ����С�
%ע�⣺���յ�tempV����R^Ӧ����W*tempH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���룺 V1��level5_g_p_network ��Ӧ������R�ĸ������
%      V2:level6_g_p_network   ��Ӧ������R���Ӳ����
%       M������֮���ӳ���ϵ
%       W:��Ӧ�����е�P��user��
%       H1��H2�ֱ��Ӧ���ĵĸ�����Ӳ�item
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V =[V1 V2];
H = [H1 H2];

[~,n]=size(H1);

parentH1 = zeros(size(H1));

rmse = zeros(1,Max_iter);
isCoverage = false;
for t = 1:Max_iter
    
    %����A��B��parent������B��parentΪ0��A��parentΪH1*M
    parentH2 = H(:,1:n)*M;
    tempH = H+[parentH1 parentH2];
    
    %�������µ�H֮��Ϳ��Խ��д�ͳ�ķǸ�����ֽ�
    W = W.* ((V*tempH')./(W*tempH*tempH' + lamta1*W+eps));
    H = H.* ((W'*V)./(W'*W*H+lamta2*H+eps));
    
    %������ɺ󣬼����5���RH
    tempV = W*H(:,1:n);
    
    %������������
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
%�����о���5������
isCoverage = true;
end
