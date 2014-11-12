
data = load('/forstudents/cleandata_students.mat');

l = 1;
m = 4;
n = 4;

num_of_results = l*m*n ;
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
    table{1,9} = 'CR';
    table{1,10} = 'F1 rates';
    table{1,11} = 'Recall rates';
    table{1,12} = 'Precision rates';
    table{1,13} = 'TR';
    
max_fail = 6;
epochs = 30000;

split = 1;
trainFcn.name = 'traingda';

[trainval, test] = crossValidationSplit(10, data, split);
[train,val]  = crossValidationSplit(9, trainval, 1);
[valx2, valy2] = ANNdata(val.x, val.y);

layer_map = [5,14,31,40]; % remove 23 for later
% layer_map = [24,26,27,28,30];
% lr_map = [1:30]*0.01; %array to store learning rate

row = 1; % init row number

% for k = 1:l
     for i = 1:m
        for j = 1:n
            
            trainFcn.lr = 0.01;

            layers = [layer_map(i),layer_map(j)];
            [net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);
            
            Y = num2cell(sim(net1, valx2),1);
            predictions = cellfun(@NNout2labels, Y);
            [C,order] = confusionmat(val.y, predictions);
            
            cr = measure_cr(C);
            [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));
            
%             row = (k-1)*(m+n) + (i-1)*n + j + 1;
            row = row+1;

            table{row, 1} = layers;
            table{row, 2} = net1.trainParam.lr;
%             table{row, 3} = lr_inc;
%             table{row, 4} = lr_dec;
            table{row, 5} =  max_fail;
            table{row, 6} = epochs ;
            table{row, 7} = tr1.stop;
            table{row, 8} = tr1.best_vperf;
            table{row,9} = cr;
            table{row,10} = f1s;
            table{row,11} = rcs;
            table{row,12} = pcs;
            table{row,13} = tr1;
            
            layer1(row-1,1) = layers(1);
            layer2(row-1,1) = layers(2);
            crs(row-1,1) = cr;
        end
     end
% end

% add centre 
centre = 23;
trainFcn.lr = 0.01;

            layers = [centre,centre];
            [net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);
            
            Y = num2cell(sim(net1, valx2),1);
            predictions = cellfun(@NNout2labels, Y);
            [C,order] = confusionmat(val.y, predictions);
            
            cr = measure_cr(C);
            [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));
            
%             row = (k-1)*(m+n) + (i-1)*n + j + 1;
            row = row+1;

            table{row, 1} = layers;
            table{row, 2} = net1.trainParam.lr;
%             table{row, 3} = lr_inc;
%             table{row, 4} = lr_dec;
            table{row, 5} =  max_fail;
            table{row, 6} = epochs ;
            table{row, 7} = tr1.stop;
            table{row, 8} = tr1.best_vperf;
            table{row,9} = cr;
            table{row,10} = f1s;
            table{row,11} = rcs;
            table{row,12} = pcs;
            table{row,13} = tr1;
            
            layer1(row-1,1) = layers(1);
            layer2(row-1,1) = layers(2);
            crs(row-1,1) = cr;

save('traingda_table.mat', 'table');

% fit response surface
sf = fit([layer1, layer2],crs,'poly23');
xlabel('time (sec)')
ylabel('output')
plot(sf,[layer1,layer2],crs);
