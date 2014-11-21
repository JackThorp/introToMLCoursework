function [ new_case ] = makeCase( x2 )
% makeCase initialises a new case variable and adds x2 ( the AU vector) to
% it along with setting other default values


% * * * IMPLEMENTATION DETAILS * * * 
% a case will be some kind of struct that holds all the information we
% think a case should have. Every case should have a vector of AU values, a
% solution (the emotion of the example) and perhaps more things. For
% instance, typicallity. Instead of adding multiple cases into our CBR system
% that have the same AU vector we increase the typicallity of the existing
% one - a measure of how common it is. We might need to think about more 
% features a case could have to make our system more effective.


end

