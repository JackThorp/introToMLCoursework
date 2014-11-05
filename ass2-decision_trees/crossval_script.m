function crossval_script(clean_or_noisy)
% takes a string 'clean' or dirty'
% perform the validation process and print everything

if(strcmp(clean_or_noisy, 'clean'))
    data = load('../forstudents/cleandata_students.mat');
    disp('validating clean data');
elseif(strcmp(clean_or_noisy, 'noisy'))
    data = load('../forstudents/noisydata_students.mat');
    disp('validating noisy data');
else
    disp('Please input ''clean'' or ''noisy''');
end

fold = 10;
matrices = cell(1,fold);

for i = 1:fold
% i=1;

    [ training, validation ] = crossValidationSplit(fold, data, i);
    
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
    
    %store the matrix
    matrices{i} = C;
    
    fprintf('confusion matrix %d is:\n',i);
    disp(C);
end

% combine the matrices by averaging them
c_matrix = mean(reshape(cell2mat(matrices), [ size(matrices{1}), length(matrices) ]), ndims(matrices{1})+1) ;

fprintf('The combined matrix is:\n');
disp(c_matrix);

% measures for each class
for class=1:6
    recall = measure_recall(c_matrix, class);
    fprintf('Recall for class %d is: %d\n ',class, recall);
    
    precision = measure_precision( c_matrix, class);
    fprintf('Precision for class %d is: %d \n ',class, precision);
    
    F1 = 2 *( (precision*recall)/(precision+recall) );
    fprintf('F1 for class %d is: %d\n\n ',class, F1);
end

cr = measure_cr(c_matrix);
fprintf('CR for %s data is: %d\n ',clean_or_noisy, cr);

end



