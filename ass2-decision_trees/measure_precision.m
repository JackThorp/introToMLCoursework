function precision = measure_precision( c_matrix, class )
%Function to take a 6x6 confusion matrix 
% and produce precision of the specific class (1-6)
%  precision = TP / (TP + FP)

% tp is the cell predicted $class and actual $class  
tp = c_matrix(class, class);

labels = 1:6 ;

% fp is the sum of the cells predicted $class, actual $not_class
% tp + fp is the sum of the cells predicted $class
tp_plus_fp = sum ( arrayfun(@(x) c_matrix(x, class), labels) ) ;

precision = tp / tp_plus_fp ;

end