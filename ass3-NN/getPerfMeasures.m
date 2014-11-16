function [ f1, rc, pc ] = getPerfMeasures(c_matrix, num_classes)
    
    f1 = cell(num_classes,1);
    rc = cell(num_classes,1);
    pc = cell(num_classes,1);
    
    for class = 1:num_classes
        [f1c, rcc, pcc] = measure_F1(c_matrix, class); 
        f1{class} = f1c;
        rc{class} = rcc;
        pc{class} = pcc;
 
    end
end

