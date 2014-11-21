function [ closest_case ] = retrieve( cbr, new_case )
% retrieve uses the cbr and the similarity function to extract the nearest
% matching case. Uses . . . retrieval function. 

% * * * IMPLEMENTATION DETAILS * * *
% I think in the description of this method in manual they assume we are 
% implementing 1-NN in which case we use similarity function to return the
% nearest neighbour. If we use K-NN then this funciton find the K most 
% similar cases and either return the set or a calculated target emotion,
% this is not clear at the moment. Methods for getting target value from K 
% nearest neighbours include taking modal value or weighting contributions
% from neighbours based on inverse of their similarity (see book for more
% on this).
% (Hint: Think what will happen if there are two more best matches with 
% different labels).


end

