function [ decision_tree ] = getDecisionTree(emotion)
% Returns a decision tree for the given emotion number.
%   The function generates the binary target for the emotion from the
%   clean data set and then calls the decisionTreeLearning function to
%   generate the decision tree.
    load('forstudents/cleandata_students.mat');
    binary_targets = y;
    for i=1:length(binary_targets),
        binary_targets(i) = (binary_targets(i) == emotion);
    end
    attributes = (1:length(x(1,:)));
    decision_tree = decisionTreeLearning(x, attributes, binary_targets); 
end
