function [ score ] = similarity_cosine( case1, case2 )

% Similarity Measure for Crisp Sets
% Cosine coefficient
% |X ∩ Y |/ √(X)*√(Y)

    a = case1.des;  
    b = case2.des;
    
    % Cosine coefficient, it is a normalized coefficient
    score = (numel(intersect(a,b)))/(sqrt(a)*sqrt(b));
    return;

end

