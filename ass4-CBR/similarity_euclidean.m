function [ score ] = similarity_euclidean( case1, case2 )
% similarity calculates how similar two cases are. This funciton is used
% in the process of finding the most similar existing case in our CBR system
% so that we may classify a new case.


% * * * IMPLEMENTATION DETAILS * * * 
% One similarity function is to calculate the euclidean distance between
% the two vectors in each case. Don't know if we should do that here though
% . Thinking that a good distance is if number appears in both vectors then
% distance in then distance in that dimension is 0. If only in one then 
% distance is 1. Add all distance's up and take square root? What does
% everyone else think?

%  IMPORTANT
%  Students are advised to consult the papers uploaded on the Machine
%  Learning Website. You should implement at least 3 different similarity
%  measures. 
    
    a = case1.des;  
    b = case2.des;
    
    % euclidean distance
    score = sqrt(numel(setdiff(union(a,b),intersect(a,b))));
    return;
end

