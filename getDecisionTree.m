function [ decision_tree ] = getDecisionTree(emotion)
% Returns a decision tree for the given emotion number.
%   The function generates the binary target for the emotion from the
%   clean data set and then calls the decisionTreeLearning function to
%   generate the decision tree.
    
    load('forstudents/cleandata_students.mat');
    binary_targets = get_bin_tars(y, emotion);
    decision_tree = decisionTreeLearning(x, attributes, binary_targets); 
    
end

function bin_tars = get_bin_tars(y, emotion)
% creates the binary targets vector for the given emotion number from the 
% classifications given in y.

    bin_tars = zeros([length(y) 1])
    for i = 1:length(y)
        if y(i)==emotion
            bin_tars(i)=1;
        end
    end
end