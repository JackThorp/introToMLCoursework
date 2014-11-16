trainFcn.name = 'traingda';
trainFcn.lr = 0.015;
trainFcn.lr_inc = 1.05;
trainFcn.lr_dec = 0.5;
best_layer_conf = [20];

crossval_ANNscript('clean', trainFcn, best_layer_conf);