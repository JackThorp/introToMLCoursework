
data = load('/forstudents/cleandata_students.mat');

l = 30;
m = 30;
n = 30;

table = createTable(l*m*n);

split = 1;
trainFcn.name = 'traingd';
max_fail = 6;
epochs = 1000;

[trainval, test] = crossValidationSplit(10, data, split);
[train,val]  = crossValidationSplit(9, trainval, 1);
[valx2, valy2] = ANNdata(val.x, val.y);

lr_map = [1:30]*0.01; %array to store learning rate

for k = 1:l
    for i = 1:m
        for j = 1:n
            
            trainFcn.lr = lr_map(k);

            layers = [i,j];
            [net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);
            
            Y = num2cell(sim(net1, valx2),1);
            predictions = cellfun(@NNout2labels, Y);
            [C,order] = confusionmat(val.y, predictions);
            
            cr = measure_cr(C);
            [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));
            
            row = (k-1)*(m+n) + (i-1)*n + j + 1;

            table{row, 1} = layers;
            table{row, 2} = lr_map(k);
%             table{row, 3} = lr_inc;
%             table{row, 4} = lr_dec;
            table{row, 5} =  max_fail;
            table{row, 6} = epochs ;
            table{row, 7} = tr1.stop;
            table{row, 8} = tr1.best_vperf;
            table{row,9} = tr1;
            table{row,10} = cr;
            table{row,11} = f1s;
            table{row,12} = rcs;
            table{row,13} = pcs;
        end
    end
end

save('traingd_table.mat', 'table');
