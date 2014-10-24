function [decision_tree] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.

decision_tree.name='Ed Plum';

end


function [ M ]  = majorityValue(binary_targets)
% Returns the mode of the binary-targets

M = mode(binary_targets); 

end

function [ tree ] = getTree()
% returns an initialise tree struct where the tree op = attr



function allAreSame = allBinaryTargetsAreSame(binary_targets)
% returns True iff all binary_targets have the same value
% used as part of decisionTreeLearning algorithm
% TODO: Fails when binary_targets is an empty vector, not sure if we 
%       have to handle this case though
    allAreSame = all(binary_targets == binary_targets(1))
end