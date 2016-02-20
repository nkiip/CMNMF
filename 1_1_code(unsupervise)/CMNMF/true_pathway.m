A = importdata('pathway3.xlsx');

[m,n]=size(A);
for i=1:m
    for j=1:n
        if(isnan(A(i,j))==1)
            A(i,j)=0;
        end
    end
end

mmu_pathway_mgi_id_true = A;
save('mmu_pathway_mgi_id_true.mat','mmu_pathway_mgi_id_true');
