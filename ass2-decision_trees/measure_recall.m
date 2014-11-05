function recall = measure_recall( c_matrix, class )
%Function to take a 6x6 confusion matrix 
% and produce recall of the specific class (1-6)
%  recall = TP / (TP + FN)

% tp is the cell predicted $class and actual $class  
tp = c_matrix(class, class);

labels = 1:6 ;
% not_class = labels(labels~=class);

% fn is the sum of cells predicted $not_class, actual $class   
% fn = sum ( arrayfun(@(x) c_matrix(class, x), not_class) ) ;

tp_plus_fn = sum ( arrayfun(@(x) c_matrix(class, x), labels) ) ;

recall = tp / tp_plus_fn ;

end

