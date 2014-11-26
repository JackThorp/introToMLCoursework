function [ score ] = similarity_euclidean( case1, case2 )
% SIM( X , Y )= 1/DIST( X , Y )
% we are using the euclidean distance 
% √sum((xi-yi)^2)
    
    a = case1.des;  
    b = case2.des;
    
    % sim base on euclidean distance, we
    score = 1 - sqrt(numel(setdiff(union(a,b),intersect(a,b))));
    return;
end

