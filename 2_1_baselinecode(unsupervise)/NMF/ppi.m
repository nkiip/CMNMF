function[selected_gene,selected_ppi]=ppi(pathway_genes)
load('ppi_network_4588.mat');
[C,~,ib]=intersect(pathway_genes,entrez_id);
selected = sum(ppi_network(ib,:));
SelectGene = union(find(selected~=0),ib);
selected_gene = entrez_id(SelectGene);
selected_ppi = ppi_network(SelectGene,SelectGene);
end


