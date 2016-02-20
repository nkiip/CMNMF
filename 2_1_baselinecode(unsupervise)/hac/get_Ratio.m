function [ratio] = get_Ratio(result)
%similarity called simi;
load('similarity.mat');
%mgi_id called mgi_id
load('mgi_id.mat');

%delete zero cols in result;
result = result(:,(sum(result) ~= 0));

[gene_number, path_number] = size(result);
all_gene_number = size(mgi_id, 1);
plus_0 = zeros(all_gene_number, all_gene_number);
path_map = plus_0;
% simi = 1 - simi - eye(all_gene_number);

%compute the inner distance;
for i  = 1:path_number
    for j = 1:gene_number
        if result(j, i) ~= 0
            result(j, i) = max(find(mgi_id == result(j, i)),0);
        end
    end
     temp = result(:,i);
     temp = temp(temp ~=0 );
     n = size(temp,1);
     if n > 1
         for k = 1:n
             path_map(temp(k), temp) = path_map(temp(k), temp) + 1/(n^2 - n);
         end
     end
end
inner_distance = sum(sum(path_map .* simi))/path_number;

 %comput the outter distance;
path_map = plus_0;
for i = 1:path_number
    tmp1 = result(:,i);
    tmp1 = tmp1(tmp1 ~= 0);
     n = size(tmp1, 1);
    for j = i+1:path_number
        tmp2 = result(:, j);
        tmp2 = tmp2(tmp2 ~= 0);
        m = size(tmp2, 1);
        for k = 1:n
            path_map(tmp1(k), tmp2) = path_map(tmp1(k), tmp2) + 1/(n * m);
        end
    end
end
outter_distance = 2 * sum(sum(path_map .*simi))/(path_number^2 - path_number);

 %compute ratio;
 ratio = inner_distance/outter_distance;
 disp('finish one!....................');
 disp(ratio);
end