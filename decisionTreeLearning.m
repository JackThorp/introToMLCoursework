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
