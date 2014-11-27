function [ new_case ] = makeCase( x2, y , out)
% makeCase initialises a new case variable and adds x2 ( the AU vector) to
% it along with setting other default values


% * * * IMPLEMENTATION DETAILS * * * 
% Every case should have a vector of AU values, a
% solution (the emotion of the example) and perhaps more things. For
% instance, typicallity. Instead of adding multiple cases into our CBR system
% that have the same AU vector we increase the typicallity of the existing
% one - a measure of how common it is. 
% We might need to think about more features a case could have to make our system more effective.

% ? Problem description, which depicts the state of the world when the case occurred;
% ? Problem solution which states the derived solution to that problem; and/or
% ? Outcome, which describes the state of the world after the case occurred.
   
    new_case.des = x2;
    new_case.sol = y;
    new_case.out = out;
    return
end

