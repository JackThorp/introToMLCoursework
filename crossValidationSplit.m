function [ training, validation ] = crossValidationSplit(folds, data, split)
    % Folds - the total number of folds in which data will be divided
    % Split - specifies which of these folds will be returned as validation data
    
    assert(split <= folds, 'The split number must be smaller than the total number of folds'); 
    
    % Get information about the input
    data_size = length(data(:,1));
    fold_size = data_size / folds;
    number_of_attributes = length(data(1,:));
    
    split_end = split * fold_size;
    split_start = split_end - fold_size + 1;
       
    % Validation data
    validation = zeros(fold_size, number_of_attributes);
    validation(1:end, 1:end) = data(split_start:split_end, 1:end);
     
    % Training data
    training = zeros(data_size - fold_size, number_of_attributes);
    training(1:split_start-1, 1:end) = data(1:split_start-1, 1:end);
    training(split_start:end, 1:end) = data(split_end+1:end, 1:end);
    
end
