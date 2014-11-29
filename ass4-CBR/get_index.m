function [ index ] = get_index( caselist )
% index is a cell array AUs that characterize the interpretation category
% it is  (i.e., derive it from cases by excluding each AU combination
% whose component AUs are also cases in their own right).

    index = {};
    % find the one that only equal to 1
    % add the au to index and remove it from the caselist

    l = 1;
    while( ~isempty(caselist))

        % Add all AU vectors of length l adn remove from caselist
        i = 1;
        while(i <= numel(caselist))
            case_i = caselist{i};
            if(length(case_i.des) == l)
                if(isempty(index))
                    index{1} = case_i.des;
                else
                    index{end+1} = case_i.des;
                end
                caselist(i) = [];
                i=i-1;
            end
            i=i+1;
        end

        % Delete all cases with sub components in index.
        j=1;
        while(j <= numel(caselist))
            case_j = caselist{j};
            if(indexed(index, case_j.des))
                caselist(j) = [];
                j=j-1;
            end
            j=j+1;
        end

        l = l + 1;
    end

    return;
end

