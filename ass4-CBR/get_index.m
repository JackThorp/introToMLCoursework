function [ index ] = get_index( caselist )
% index is a cell array AUs that characterize the interpretation category
% it is  (i.e., derive it from cases by excluding each AU combination 
% whose component AUs are also cases in their own right).

index = [];

% find the one that only equal to 1
% add the au to index and remove it from the caselist
i = 1;
while( i<= length(caselist))
    case_i = caselist{i};
    if(length(case_i.des)==1)
        if(isempty(index))
            index = case_i.des;
        else    
            index = union(index, case_i.des);
        end
        caselist(i) = [];
        i = i - 1; %decrease the pointer
    end
    i = i + 1;
end
    
% remove the cases that contain au that is already in the index 
% from caselist
for j = 1:numel(index)
    index_j = index(j);
    l = 1;
    while(l <= numel(caselist))
        case_l = caselist{l};
        if(any(case_l.des == index_j))
            caselist(l)=[]; %decrease the pointer
            l = l -1;
        end
        l=l+1;
    end    
end

% add the rest of the au combination from the caselist
for k= 1:numel(caselist)
    case_k = caselist{k};
    if(isempty(index))
        index = case_k.des;
    else    
        index = union(index, case_k.des);
    end
end

return;
end

