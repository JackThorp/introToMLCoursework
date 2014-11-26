function [ indexes ] = get_indexes( caselist )
% index is a cell array AUs that characterize the interpretation category
% it is  (i.e., derive it from cases by excluding each AU combination 
% whose component AUs are also cases in their own right).

indexes = {};

% find the one that only equal to 1
% add the au to index and remove it from the caselist
i = 1
while( i<= numel(caselist))
    case_i = caselist(i);
    if(numel(case_i.des)==1)
        indexes{numel(indexes)+1} = case_i.des;
        caselist(i) = [];
        i = i - 1; %decrease the pointer
    end
    i = i + 1;
end
    
% remove the cases that contain au that is already in the indexes 
% from caselist
for j = 1:numel(indexes)
    index_j = cell2mat(indexes(j));
    l = 1;
    while(l <= numel(caselist))
        case_l = caselist(l);
        if(any(case_l.des == index_j))
            caselist(l)=[]; %decrease the pointer
            l = l -1;
        end
        l=l+1;
    end    
end

% add the rest of the au combination from the caselist
for k= 1:numel(caselist)
    case_k = caselist(k);
    indexes{numel(indexes)+1} = case_k.des;
end

return;
end

