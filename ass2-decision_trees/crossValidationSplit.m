function [ training, validation ] = crossValidationSplit(folds, data, split)
    % Folds - the total number of folds in which data will be divided
    % Split - specifies which of these folds will be returned as validation data
    
    assert(split <= folds, 'The split number must be smaller than the total number of folds'); 
    
    % Get information about the input
    data_size = length(data.x(:,1));
    fold_size = fix(data_size / folds);
    number_of_attributes = length(data.x(1,:));
    
    split_end = split * fold_size;
    split_start = split_end - fold_size + 1;
       
    remainder = mod(data_size, folds);
    
    
    
    % Validation data
    validation = [];
    validation.x = zeros(fold_size+remainder, number_of_attributes);
    validation.y = zeros(fold_size+remainder, 1);
    validation.x(1:end, 1:end) = data.x(split_start:split_end+remainder, 1:end);
    validation.y(1:end) = data.y(split_start:split_end+remainder);
    
    % Training data
    training = [];
    training.x = zeros(data_size - fold_size - remainder, number_of_attributes);
    training.x(1:split_start-1, 1:end) = data.x(1:split_start-1, 1:end);
    training.x(split_start:end, 1:end) = data.x(split_end+remainder+1:end, 1:end);
    
    training.y = zeros(data_size - fold_size - remainder, 1);
    training.y(1:split_start-1) = data.y(1:split_start-1);
    training.y(split_start:end) = data.y(split_end+remainder+1:end);
    
end
