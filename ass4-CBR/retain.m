function [ cbr ] = retain( cbr, solved_case )
% Indexes the solved_case into the cbr system. 
       
    sol = solved_case.sol;
    cluster = cbr.clusters(sol);
    found = 0;
    for i = 1:numel(cluster.cases)
        case_i = cluster.cases{i};
        if(isequal(case_i.des, solved_case.des))
          cbr.clusters(sol).cases{i}.typ = case_i.typ+1;
          found = 1;
          break;
        end
    end
    
    if (found == 0)
        solved_case.out = 1;
        cbr.clusters(sol).cases{end+1} = solved_case;
    end
    
    if(~indexed(cbr.clusters(sol).index, solved_case.des)) 
        cbr.clusters(sol).index{end+1} = solved_case.des;
    end
     
    return; %return the cbr system given
end

