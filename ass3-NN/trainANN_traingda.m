
data = load('/forstudents/cleandata_students.mat');

m = 3;
n = 3;

table = cell(m*n+1,10);

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

split = 1;
trainFcn.name = 'traingda';
lr = 0.01;
lr_inc = 1.05;
lr_dec = 0.7;
max_fail = 6;
epochs = 10000;

[trainval, test] = crossValidationSplit(10, data, split);
[train,val]  = crossValidationSplit(9, trainval, 1);
[valx2, valy2] = ANNdata(val.x, val.y);

%for split = 1:10
for i = 1:m
    for j = 1:n

        trainFcn.lr = lr;
        trainFcn.lr_inc = lr_inc;
        trainFcn.lr_dec = lr_dec;
        layers = [i,j];
        [net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);

        Y = num2cell(sim(net1, valx2),1);
        predictions = cellfun(@NNout2labels, Y);
        [C,order] = confusionmat(val.y, predictions);

        cr = measure_cr(C);
        [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));

        row = (i-1)*n + j + 1;

        table{row, 1} = layers;
        table{row, 2} = lr;
        table{row, 3} = lr_inc;
        table{row, 4} = lr_dec;
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
   

%end


