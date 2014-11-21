function [ cbr ] = CBRInit(x, y)
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

end

