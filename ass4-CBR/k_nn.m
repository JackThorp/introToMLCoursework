function [ bestlist ] = k_nn( k, caselist, newcase, simfunc)
% given a list of case,
% find the k nearest cases with the simfunc given
% find the most frequent solution from the k nearest 
% simfunc can be 'cosine','dice','euclidean','jaccard'

% check if caselist smaller than k, if smaller, return caselist
if(k > numel(caselist))
    bestlist = caselist;
    return;
end

% compute the similarity
simmap = zeros(1,numel(caselist));
for i = 1:numel(caselist)
    case_i = caselist(i);
    switch simfunc
        case 'cosine'
            simmap(i)= similarity_cosine(case_i, newcase);       
        case 'dice'
            simmap(i)= similarity_dice(case_i, newcase);  
        case 'euclidean'
            simmap(i)= similarity_euclidean(case_i, newcase);  
        case 'jaccard'
            simmap(i)= similarity_jaccard(case_i, newcase);  
        otherwise
            warning('Unexpected simfunc.simfunc can be "cosine","dice","euclidean","jaccard".');
            return;
    end
end

% choose the k best case from caselist base on simmap and put in best list

for j = 1:k
    [val, ind] = max(simmap);
    bestlist(j)= caselist(ind);
    %remove this elem from both simmap and caselist    
    simmap(ind) = [];
    caselist(ind) = [];
end

return;
end

