function cr = measure_cr_class(cm, class)
TP = cm(class, class);
false_class = cm;
false_class(class, :) = [];
false_class(:, class) = [];
TN = sum(false_class(:));
cr = (TP + TN) / sum(cm(:));
end