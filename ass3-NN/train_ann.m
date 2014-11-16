function [net1, tr1] = train_ann( trainval,layers,trainFcn,max_fail, epochs)
    % prepare data (format by transposing) for neural network functions
    
    [x2, y2] = ANNdata(trainval.x, trainval.y);

    % Create blank feedforward network
    net = feedforwardnet(layers);
    net.trainFcn = trainFcn.name; %sets the network trainFcn property.
    
    if strcmp(trainFcn.name, 'traingda')
        net.trainParam.lr_inc = trainFcn.lr_inc;
        net.trainParam.lr_dec = trainFcn.lr_dec;
    
    elseif strcmp(trainFcn.name, 'traingdm')
        net.trainParam.mc = trainFcn.mc;

    elseif strcmp(trainFcn.name, 'trainrp')
        net.trainParam.delta0 = trainFcn.delta0;
        net.trainParam.deltamax = trainFcn.deltamax;
        net.trainParam.delt_dec = trainFcn.delt_dec;
        net.trainParam.delt_inc = trainFcn.delt_inc;
        
    elseif strcmp(trainFcn.name, 'traingd')
        
    else
        error('Invalid training function name passed to train_ann');  
    end
        
    net.trainParam.lr = trainFcn.lr;
    net.trainParam.epochs = epochs;
    net.trainParam.max_fail = max_fail;
    net.divideFcn = 'divideind';
    net.divideParam.valInd = 1:100;
    net.divideParam.trainInd = 101:900;
    
     net.trainParam.showWindow = 0;

    
    % tr is the training record. pick the best perf
    pick_best =  cell(1,3);
    perfs = zeros(1,3);
    for j = 1:3
%         net = init(net);
%         net = configure(net, x2, y2); 
        [net,tr] = train(net, x2, y2);
        pick_best{j}.net = net;
        pick_best{j}.tr = tr;
        perfs(1,j) = pick_best{j}.tr.best_vperf;
    end    
    [M, I] = min(perfs); 
    tr1 = pick_best{I}.tr;
    net1 = pick_best{I}.net;

end

