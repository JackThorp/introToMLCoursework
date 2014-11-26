function [ solved_case ] = reuse( best_match, new_case )
% Update the solution to the new_case using the best_match,
% our best match is a list of best match cases
% which will be retrive with the knn algorithm

solmap = zeros(1,numel(best_match));
for i = 1:numel(best_match)
    solmap(i) = best_match(i).sol;
end

% get the most common solution
sol = mode(solmap);
new_case.sol = sol;

solved_case = new_case;
return
end

