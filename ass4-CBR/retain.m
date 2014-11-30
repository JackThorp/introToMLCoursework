function [ cbr ] = retain( cbr, solved_case )
% Indexes the solved_case into the cbr system. 
       
    found = 0;
    for i = 1:numel(cbr.cases)
        case_i = cbr.cases{i};
        if(isequal(case_i.des, solved_case.des))
          cbr.cases{i}.typ = case_i.typ+1;
          found = 1;
          break;
        end
    end
    
    if (found == 0)
        solved_case.typ = 1;
        cbr.cases{end+1} = solved_case;
    end
    
    
    return; %return the cbr system given
end

