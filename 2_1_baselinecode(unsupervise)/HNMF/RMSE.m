function [ rmse ] = RMSE(V,V2)
    tempV = V;
    tempV2 = V2;
  
    [row,col]=find(tempV);
    n = length(row);
      
    sse2= sum(sum((tempV(row,col)-tempV2(row,col)).^2));
    mse2 = sse2/n;
    rmse = sqrt(mse2);

end

