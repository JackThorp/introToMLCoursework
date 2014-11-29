function errors = crossval_ANNscript(clean_or_noisy, trainFcn, layers)
% takes a string 'clean' or dirty'
% perform the validation process and print everything

if(strcmp(clean_or_noisy, 'clean'))
    data = load('forstudents/cleandata_students.mat');
    disp('validating clean data');
elseif(strcmp(clean_or_noisy, 'noisy'))
    data = load('forstudents/noisydata_students.mat');
    disp('validating noisy data');
else
    disp('Please input ''clean'' or ''noisy''');
end

fold = 10;
matrices = cell(1,fold);
max_fail = 6;
epochs = 30000;

for i = 1:fold

    [ training, test ] = crossValidationSplit(fold, data, i);
     
    net1 = train_ann(training,layers,trainFcn, max_fail, epochs);
    
    [testx, testy] = ANNdata(test.x, test.y);
    Y = num2cell(sim(net1, testx),1);
    predictions = cellfun(@NNout2labels, Y);
    C = confusionmat(test.y, predictions);
    
    %store the matrix
    matrices{i} = C;
    
    fprintf('confusion matrix %d is:\n',i);
    disp(C);
end

% get errors (F1)
errors = zeros(fold, 6);
for i = 1:fold
    for j = 1:6
        r = measure_recall(matrices{i}, j);
        p = measure_precision(matrices{i}, j);
        errors(i, j) = 1 - (2 * ((p * r) / (p + r)));
    end
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



