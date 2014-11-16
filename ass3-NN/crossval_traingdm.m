
trainFcn.name = 'traingdm';
trainFcn.lr = 0.02;
trainFcn.mc = 0.095;
best_layer_conf = [25,35];

crossval_ANNscript('clean', trainFcn, best_layer_conf);