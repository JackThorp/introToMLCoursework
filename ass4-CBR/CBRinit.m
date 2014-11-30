function [ CBS ] = CBRinit(x, y)
% Takes matrix of AU vectors, x, and vector of target values, y, and
% returns a new case based reasoning system.

% * * IMPLEMENTATION NOTES * *
% This function will have to transform x each row of x into a vector
% formatted like [a,b,c,d,...] where a,b etc are the indices of AU's that
% are on (value 1).
% This function will have to create a new case for each row by calling the
% function makeCase(x2) which initialeses a new case using the new vector 
% format of a row (see makeCase for more info). The target emotion of the
% example, found in y, should be added to the returned case.

    % Create a struct array for CBR clusters
    CBS = struct();  
%     g_index = zeros(1,45);
    

    CBS.cases = {};

    % group the elements in x and y together and add count
    attached = [x,y];
    [u, ~, ic]=unique(attached, 'rows');
    counted = [u histc(ic, 1:length(u))];
    
    % Loop through examples and initialise clusters.
    for i=1:length(counted)
        
        x_u = counted(i, 1:45);
        y_u = counted(i, 46);
        out_u = counted(i, 47);
        % Reformat example into new AU vector format
        x2 = find(x_u);
        
        % Add example to cases of appropriate cluster
        CBS.cases{end+1} = makeCase(x2,y_u,out_u);
        
    end
end

