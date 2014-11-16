
trainFcn.name = 'trainrp';
trainFcn.lr = 0.007;
trainFcn.delta0 = 0.09;
trainFcn.deltamax = 30;
trainFcn.delt_inc = 1.1;
trainFcn.delt_dec = 0.6;

best_layer_conf = [39,25];

crossval_ANNscript('clean', trainFcn, best_layer_conf);
