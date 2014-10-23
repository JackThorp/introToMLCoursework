function [ decision_tree ] = getDecisionTree(emotion_number)
% Returns a decision tree for the given emotion number.
%   The function generates the binary target for the emotion from the
%   clean data set and then calls the decisionTreeLearning function to
%   generate the decision tree.

% load('/homes/jt1712/3rdYEar/ML/forstudents/cleandata_students.mat')

% decision_tree = decisionTreeLearning(examples, attributes, binary_targets); 
    newy = [1;2;3;4;5;6;1]
    decision_tree = get_bin_tars(newy,1)

end

function bin_tars = get_bin_tars(y, emotion)
   
    bin_tars = zeros([length(y) 1])
% iterrate through the array
    for i = 1:length(y)
        if y(i)==emotion
            bin_tars(i)=1;
        end
    end
end