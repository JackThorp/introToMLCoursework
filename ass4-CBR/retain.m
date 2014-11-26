function [ output_args ] = retain( cbr, solved_cases )
% Indexes the solved_case into the cbr system. 

% * * * IMPLEMENTATION * * * 
% (Hint: Think what will happen if you try to add a case to the CBR system 
% that is already known to the system.) Updating typicallity? 

% 1. If the set of AUs a1 + ... + aN for which a novel interpretation 
% label “x” has been introduced (this can be only a part of the original 
% input expression) matches exactly a specific case stored in the case 
% base, the old case is removed and the case base is reconstructed to 
% reflect these changes. Go to 2. Otherwise, go to 2 as well. 

% 2. Match label “x” with label of each interpretation category chunk 
% constituting the dynamic memory. If chunk “x” already exists, go to 3. 
% Otherwise, generate a new chunk “x” using the following vectors: 
% label[“x”], cases[(a1 + ... + aN, 1)], and index[(a1 + ... + aN)]. 
% Terminate the execution of this procedure. 

% 3. Reconstruct the dynamic memory of experiences by adding the 
% new case a1 + ... + aN to chunk “x”. Add (a1 + ... + aN, 1) to cases. 
% Redefine index vector to contain only the AUs and AU combinations 
% that characterize the interpretation category “x” (i.e., derive it from 
% cases by excluding each AU combination whose component AUs are 
% also cases in their own right).



end

