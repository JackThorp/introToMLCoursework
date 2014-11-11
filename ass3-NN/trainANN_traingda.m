
data = load('/forstudents/cleandata_students.mat');

m = 3;
n = 3;

table = cell(m*n+1,9);

npick = [0,2,3,4,5,6,7,8,9,10];

table{1,1} = 'layers';
table{1,2} = 'LR';
table{1,3} = 'LR_inc';
table{1,4} = 'LR_dec';
table{1,5} = 'max_fail';
table{1,6} = 'epochs' ;

table{1,7} = 'fail';
table{1,8} = 'Performance';
table{1,9} = 'TR';

for i = 1:m
    for j = 1:n
        split = 1;
        layers = [i,j];
        trainFcn = 'traingda';
        lr = 0.01;
        lr_inc = 1.05;
        lr_dec = 0.7;
        max_fail =6;
        epochs = 1000;
        
        tr1 = train_ann( data,split,layers,trainFcn,lr,lr_inc, lr_dec, max_fail, epochs);
        
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
    end
end



