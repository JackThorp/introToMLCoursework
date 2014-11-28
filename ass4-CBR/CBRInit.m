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
    CB = struct('label', {'anger', 'disgust', 'fear', 'happiness', 'sadness', 'suprise'});  
%     g_index = zeros(1,45);
    
    for i=1:length(CB)
        CB(i).cases = {};
%         CB(i).index = zeros(1,45);
    end
    
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
        CB(y_u).cases{end+1} = makeCase(x2,y_u,out_u);
        
%         % Increase index count and global count for each AU in example
%         for j=1:length(x2)
%            CB(y(i)).index(x2(j)) = CB(y(i)).index(x2(j))  + 1;
%            g_index(x2(j)) = g_index(x2(j)) + 1;
%         end
    end
   
    % update index
    for j = 1:6
        CB(j).index = get_index(CB(j).cases);
    end
    
    CBS.clusters = CB;
%     CBS.g_index = g_index;
end

