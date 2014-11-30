% script to perform 10 fold cross validation and compute the results

tic;
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

measures = struct('class', {emolab2str(1),emolab2str(2),emolab2str(3),...
    emolab2str(4),emolab2str(5),emolab2str(6)});

% measures for each class
for class=1:6
    recall = measure_recall(c_matrix, class);
    measures(class).recall = recall;
    
    precision = measure_precision( c_matrix, class);
    measures(class).precision = precision;
    
    F1 = 2 *( (precision*recall)/(precision+recall) );
    measures(class).f1 = F1;
end

cr = measure_cr(c_matrix);
measures(1).cr = cr;
time_spent = toc;
