
data = load('/forstudents/cleandata_students.mat');

l = 1;
m = 4;
n = 4;

num_of_results = l*m*n ;
table = cell(num_of_results+1,14);

    %npick = [0,2,3,4,5,6,7,8,9,10];
    
    table{1,1} = 'fold';
    table{1,2} = 'layers';
    table{1,3} = 'LR';
    table{1,4} = 'LR_inc';
    table{1,5} = 'LR_dec';
    table{1,6} = 'max_fail';
    table{1,7} = 'epochs' ;
    table{1,8} = 'fail';
    table{1,9} = 'Performance';
    table{1,10} = 'CR';
    table{1,11} = 'F1 rates';
    table{1,12} = 'Recall rates';
    table{1,13} = 'Precision rates';
    table{1,14} = 'TR';
    
max_fail = 6;
epochs = 3000;

for fold = 5:6

    split = fold;
    trainFcn.name = 'traingda';

    [trainval, test] = crossValidationSplit(10, data, split);
    [train,val]  = crossValidationSplit(9, trainval, 1);
    [valx2, valy2] = ANNdata(val.x, val.y);

    layer_map = [15,20,25,30,35,40,[23,15],[23,20],[23,35],[27,15],[27,20],[27,35],[32,15],[32,20],[32,25]];
    %layer_map1 = [23,27,32]; % remove 23 for later
    %layer_map2 = [15,20,35];
    lr_map = [0.05,0.01,0.015,0.02]; %array to store learning rate
    lr_inc_map = [1.05, 1.1, 1.15];
    lr_dec_map = [0.5, 0.7, 0.9];

    row = 1; % init row number


    for l_i = 1:15
     for lr_i = 1:4
         for lr_inc_i = 1:3
            for lr_dec_i = 1:3

                trainFcn.lr = lr_map(lr_i);
                trainFcn.lr_inc = lr_inc_map(lr_inc_i);
                trainFcn.lr_dec = lr_dec_map(lr_dec_i);

                layers = layer_map(l_i);

                [net1, tr1] = train_ann(trainval,layers, trainFcn, max_fail, epochs);

                Y = num2cell(sim(net1, valx2),1);
                predictions = cellfun(@NNout2labels, Y);
                [C,order] = confusionmat(val.y, predictions);

                cr = measure_cr(C);
                [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));

    %             row = (k-1)*(m+n) + (i-1)*n + j + 1;
                row = row+1;

                table{row, 1} = fold;
                table{row, 2} = layers;
                table{row, 3} = net1.trainParam.lr;
                table{row, 4} = net1.trainParam.lr_inc;
                table{row, 5} = net1.trainParam.lr_dec;
                table{row, 6} =  max_fail;
                table{row, 7} = epochs ;
                table{row, 8} = tr1.stop;
                table{row, 9} = tr1.best_vperf;
                table{row,10} = cr;
                table{row,11} = f1s;
                table{row,12} = rcs;
                table{row,13} = pcs;
                table{row,14} = tr1;

                %layer1(row-1,1) = layers(1);
                %layer2(row-1,1) = layers(2);
                %crs(row-1,1) = cr;
            end
         end
     end
    end

end

% add centre 
%centre = 23;
%trainFcn.lr = 0.01;

 %           layers = [centre,centre];
  %          [net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);
            
   %         Y = num2cell(sim(net1, valx2),1);
    %        predictions = cellfun(@NNout2labels, Y);
     %       [C,order] = confusionmat(val.y, predictions);
            
      %      cr = measure_cr(C);
       %     [f1s, rcs, pcs]  = getPerfMeasures(C, length(order));
            
%       %      row = (k-1)*(m+n) + (i-1)*n + j + 1;
         %   row = row+1;

          %  table{row, 1} = layers;
          %  table{row, 2} = net1.trainParam.lr;
%             table{row, 3} = lr_inc;
%             table{row, 4} = lr_dec;
          %  table{row, 5} =  max_fail;
          %  table{row, 6} = epochs ;
          %  table{row, 7} = tr1.stop;
          %  table{row, 8} = tr1.best_vperf;
          %  table{row,9} = cr;
          %  table{row,10} = f1s;
          %  table{row,11} = rcs;
          %  table{row,12} = pcs;
          %  table{row,13} = tr1;
            
          %  layer1(row-1,1) = layers(1);
          %  layer2(row-1,1) = layers(2);
          %  crs(row-1,1) = cr;

save('traingda_table56.mat', 'table');

% fit response surface
%sf = fit([layer1, layer2],crs,'poly23');
%xlabel('time (sec)')
%ylabel('output')
%plot(sf,[layer1,layer2],crs);
