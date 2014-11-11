function [ table ] = createTable(num_of_results)
%

    table = cell(num_of_results+1,10);

    %npick = [0,2,3,4,5,6,7,8,9,10];

    table{1,1} = 'layers';
    table{1,2} = 'LR';
    table{1,3} = 'LR_inc';
    table{1,4} = 'LR_dec';
    table{1,5} = 'max_fail';
    table{1,6} = 'epochs' ;
    table{1,7} = 'fail';
    table{1,8} = 'Performance';
    table{1,9} = 'TR';
    table{1,10} = 'CR';
    table{1,11} = 'Recall rates';
    table{1,12} = 'Precision rates';
    table{1,13} = 'F1 rates';


end

