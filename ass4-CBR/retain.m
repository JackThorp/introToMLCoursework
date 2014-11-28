function [ cbr ] = retain( cbr, solved_case )
% Indexes the solved_case into the cbr system. 
       
    sol = solved_case.sol;
    cluster = cbr.clusters(sol);
    found = 0;
    for i = 1:numel(cluster.cases)
        case_i = cluster.cases{i};
        if(isequal(case_i.des, solved_case.des))
          cbr.clusters(sol).cases{i}.out = case_i.out+1;
          found = 1;
          break;
        end
    end
    
    if (found == 0)
        solved_case.out = 1;
        cbr.clusters(sol).cases{end+1} = solved_case;
    end
    
    % Update global and cluster index.
%     for j=1:length(solved_case.des)
%         AU = solved_case.des(j);
%         cbr.g_index(AU) = cbr.g_index(AU) + 1;
%         cbr.clusters(sol).index(AU) = cbr.clusters(sol).index(AU) + 1;
%     end
    cbr.clusters(sol).index = union(cbr.clusters(sol).index, solved_case.des);
    
    return; %return the cbr system given
end

