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

% look throught the indexes and decide which cluster
% 1. Create the following empty lists: clusters, cases-list, best-cases, and 
% solutions. Go to 2. 

% 2. Match the AUs of AUs-list with the AUs of index vectors of the 
% emotion chunks constituting the case base. Each time a match is 
% established, exclude the matching AUs from AUs-list, add label of the 
% chunk in question to clusters, add all cases of that chunk to cases-list. If 
% AU-list is empty, go to 3. 

% 3. Re-establish AUs-list. Examine the cases of cases-list. If the current 
% case is composed of AUs that belong to AUs-list, add it to best-cases. 

% Go to 4. 
% use the K-nearest neighbour algorithm with the best-cases to find the
% solution


end

