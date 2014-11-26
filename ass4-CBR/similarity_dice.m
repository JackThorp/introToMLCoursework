function [ score ] = similarity_dice( case1, case2 )

% Similarity Measure for Crisp Sets
% Dice coefficient
% (2| X  ∩  Y |)/(| X | + | Y |)

    a = case1.des;  
    b = case2.des;
    
    % Dice coefficient, it is a normalized coefficient
    score = 2*(numel(intersect(a,b)))/(numel(a)+numel(b));
    return;

end

