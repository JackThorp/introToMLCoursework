function [ confusion_matrix ] = confusionMatrix(actual, predictions)
    % Takes an array of actual values and an array of predicted.
    % actual and predicted should be the same length.
    % Returns a confusion matrix.
    m = zeros(6);
    for i=1:length(actual),
        a = actual(i);
        p = predictions(i);
        m(a, p) = m(a, p) + 1;
    end
    confusion_matrix = m;
end
