function cr = measure_cr( c_matrix )
% Function to take a 6x6 confusion matrix 
% and produce classification rate of (do not need to specify class)
 % CR = (TP + TN) / (TP + TN + FP + FN)
%     = sum_of_correctly_classified / sum_of_all

 labels = 1:6 ;
 sum_of_correctly_classified = sum( arrayfun(@(x) c_matrix(x,x), labels) );
 
 sum_of_all =  sum (c_matrix(:)) ;
 
 cr = sum_of_correctly_classified / sum_of_all ;
end

