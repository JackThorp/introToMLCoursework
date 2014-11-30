% script to perform 10 fold cross validation and compute the results
function errors = crossval_scriptCBR(clean_or_noisy)

tic;
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

% get errors (F1)
errors = zeros(fold, 6);
for i = 1:fold
    for j = 1:6
        errors(i, j) = 1 - measure_cr_class(matrices{i}, j);
    end
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

end
