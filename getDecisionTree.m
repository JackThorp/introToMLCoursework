
function [ decision_tree ] = getDecisionTree(emotion_number)
% Returns a decision tree for the given emotion number.
%   The function generates the binary target for the emotion from the
%   clean data set and then calls the decisionTreeLearning function to
%   generate the decision tree.

clean_set = load('forstudents/cleandata_students.mat');

binary_targets = clean_set.y;

for i=1:length(binary_targets),
    binary_targets(i) = (binary_targets(i) == emotion_number);
end

decision_tree = decisionTreeLearning(clean_set.x, [1:size(clean_set.x, 2)], binary_targets);
