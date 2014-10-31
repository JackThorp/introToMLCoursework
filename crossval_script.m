data = load('forstudents/cleandata_students.mat');

% for i = 1:10
i=1;

    [ training, validation ] = crossValidationSplit(10, data, i);
    
    %trees
    decision_trees= cell(1,6);
    for emotion = 1:6 
        decision_trees{emotion} = getDecisionTree(emotion,training);
%         DrawDecisionTree(decision_trees{emotion},emolab2str(emotion));
    end
    
    % Get predictions of our trees for validation test data.
    predictions = testTrees(decision_trees, validation.x);
    
    % Get confusion matrix from predictions and actual validation target
    % emotions.
    [C,order] = confusionmat(validation.y, predictions);
    
% end