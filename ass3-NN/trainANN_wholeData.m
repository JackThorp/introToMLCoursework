data = load('forstudents/cleandata_students.mat');

trainFcn.name = 'traingd';
trainFcn.lr = 0.008;
best_layer_conf = [25 25];

epochs = 30000;
max_fail = 6;


net = train_ann(data,best_layer_conf,trainFcn, max_fail, epochs);

[training, validation] = crossValidationSplit(10, data, 1);

[valx, valy] = ANNdata(validation.x, validation.y);
Y = num2cell(sim(net, valx),1);
predictions = cellfun(@NNout2labels, Y);
conf_mat = confusionmat(validation.y, predictions);


cr = measure_cr(conf_mat)