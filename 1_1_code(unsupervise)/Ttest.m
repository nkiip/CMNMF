
pvalue = zeros(8,8);
for i =1:8
    for j=i+1:8
        [~,p] = ttest2(X(i,:),X(j,:));
        pvalue(i,j) = p;
    end
end
