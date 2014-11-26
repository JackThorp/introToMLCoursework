function [ score ] = similarity_jaccard( case1, case2 )

% Similarity Measure for Crisp Sets
% Jaccard coefficient
% |X ∩ Y |/ |X|+|Y|-|X ∩ Y|

    a = case1.des;  
    b = case2.des;
    
    % Jaccard coefficient, it is a normalized coefficient
    inter_count = numel(intersect(a,b));
    score = (inter_count)/(numel(a)+numel(b)-inter_count);
    return;

end

