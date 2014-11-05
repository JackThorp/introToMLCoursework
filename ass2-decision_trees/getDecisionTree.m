function [ decision_tree ] = getDecisionTree(emotion, data)
% Returns a decision tree for the given emotion number.
%   The function generates the binary target for the emotion from the
%   clean data set and then calls the decisionTreeLearning function to
%   generate the decision tree.

    binary_targets = data.y;
    for i=1:length(binary_targets),
        binary_targets(i) = (binary_targets(i) == emotion);
    end
    attributes = (1:length(data.x(1,:)));
    decision_tree = decisionTreeLearning(data.x, attributes, binary_targets); 
end
