function [ output_args ] = retain( CBS, solved_case )
% Indexes the solved_case into the cbr system. 
       
    sol = solved_case.sol;
    cluster = CBS.clusters(sol);
    found = 0;
    for i = 1:numel(cluster.cases)
        case_i = cluster.cases{i};
        if(isequal(case_i.des, solved_case.des))
          CBS.clusters(sol).cases{i}.out = case_i.out+1;
          found = 1;
          break;
        end
    end
    
    if (found == 0)
        solved_case.out = 1;
        CBS.clusters(sol).cases{end+1} = solved_case;
    end
    
    % Update global and cluster index.
    for j=1:length(solved_case.des)
        AU = solved_case.des(j);
        CBS.g_index(AU) = CBS.index(AU) + 1;
        CBS.clusters(sol).index(AU) = CBS.clusters(sol).index(AU) + 1;
    end
    
end

