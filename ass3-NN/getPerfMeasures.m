function [ f1, rc, pc ] = getPerfMeasures(c_matrix, num_classes)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    
    %f1 = 0;
    %rc = 0;
    %pc = 0;
  
    f1 = cell(num_classes,1);
    rc = cell(num_classes,1);
    pc = cell(num_classes,1);
    
    for class = 1:num_classes
       [f1c, rcc, pcc] = measure_F1(c_matrix, class); 
        f1{class} = f1c;
        rc{class} = rcc;
        pc{class} = pcc;
       % f1c
 
    end
end

