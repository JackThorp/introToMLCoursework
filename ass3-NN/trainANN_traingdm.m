data = load('forstudents/cleandata_students.mat');


layer_configs = [[10 30];[15 35];[20 25];[25 35];[40 35]];

table = cell(length(layer_configs)*2*2+1,7);

table{1,1} = 'layers';
table{1,2} = 'LR';
table{1,3} = 'mc';
table{1,4} = 'fail';
table{1,5} = 'Performance';
table{1,6} = 'CR';

split = 10;
trainFcn.name = 'traingdm';

max_fail = 6;
epochs = 5000;

[trainval, test] = crossValidationSplit(10, data, split);
[train,val]  = crossValidationSplit(9, trainval, 1);
[valx2, valy2] = ANNdata(val.x, val.y);

row = 2;
for lr = 0.01:0.01:0.02
	for mc = 0.09:0.005:0.095
	    for j = 1:length(layer_configs)
		layers = layer_configs(j,:);
		display(mc)
		display(lr)
		display(layers)

		trainFcn.mc =  mc;
		trainFcn.lr = lr;
		[net1, tr1] = train_ann(trainval,layers,trainFcn, max_fail, epochs);

		Y = num2cell(sim(net1, valx2),1);
		predictions = cellfun(@NNout2labels, Y);
		[C,order] = confusionmat(val.y, predictions);

		cr = measure_cr(C);


		table{row, 1} = layers;
		table{row, 2} = lr;
		table{row, 3} = mc;
		table{row, 4} = tr1.stop;
		table{row, 5} = tr1.best_vperf;
		table{row, 6} = cr;
		row = row + 1;
	    end
	end
end

