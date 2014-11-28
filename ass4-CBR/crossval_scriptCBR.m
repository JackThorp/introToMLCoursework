% script to perform 10 fold cross validation and compute the results

data = load('forstudents/cleandata_students.mat');

fold = 10;
matrices = cell(1,fold);

for i = 1:fold

    [ training, validation ] = crossValidationSplit(fold, data, i);
    cbr = CBRinit(training.x, training.y);
    predictions = testCBR( cbr, validation.x );
    
    % Get confusion matrix from predictions and actual validation target
    % emotions.
    [C,order] = confusionmat(validation.y, predictions);
    
    %store the matrix
    matrices{i} = C;
    
    fprintf('confusion matrix %d is:\n',i);
    disp(C);   
end


% combine the matrices by averaging them
c_matrix = sum(reshape(cell2mat(matrices), [ size(matrices{1}), length(matrices) ]), ndims(matrices{1})+1) ;

fprintf('The combined matrix is:\n');
disp(c_matrix);

measures = struct('class', {1,2,3,4,5,6});

% measures for each class
for class=1:6
    recall = measure_recall(c_matrix, class);
    measures.class(i).recall = recall;
    
    precision = measure_precision( c_matrix, class);
    measures.class(i).precision = precision;
    
    F1 = 2 *( (precision*recall)/(precision+recall) );
    measures.class(i).f1 = F1;
end

cr = measure_cr(c_matrix);
measures.cr = cr;
