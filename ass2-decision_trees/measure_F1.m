function [F1, recall, precision] = measure_F1(  c_matrix, class )
%Function to take a 6x6 confusion matrix 
% and produce F1-measures 
% F1 = 2 ( (precision*recall)/(precision+recall) )

precision = measure_precision(c_matrix, class);
recall = measure_recall(c_matrix, class);
F1 = 2 *( (precision*recall)/(precision+recall) );

end

