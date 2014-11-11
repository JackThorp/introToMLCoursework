function tr1 = train_ann( data,split,layers,trainFcn,lr,lr_inc, lr_dec, max_fail, epochs)
    % prepare data (format by transposing) for neural network functions

    [trainval, test] = crossValidationSplit(10, data, split);
    [x2, y2] = ANNdata(trainval.x, trainval.y);

    % Create blank feedforward network
    net = feedforwardnet(layers);
%     net = configure(net, x2, y2); 
    %sets up network and initialises weights. Also configure is done automatically by train function.


    net.trainFcn = trainFcn; %sets the network trainFcn property.

    % configure and run training algorithm.
    % Stop criteria for training includes end of epochs, max_fail, min_grad,
    % time (timeout) or goal (minimum performance value).
    % net.trainParam.min_grad
    net.trainParam.epochs = epochs;
    net.trainParam.lr = lr;
    net.trainParam.lr_inc = lr_inc;
    net.trainParam.lr_dec = lr_dec;
    net.trainParam.max_fail = max_fail;
    net.divideFcn = 'divideind';
    net.divideParam.valInd = 1:100;
    net.divideParam.trainInd = 101:900;

    % tr is the training record. pick the best perf
    pick_best =  cell(1,3);
    perfs = zeros(1,3);
    for j = 1:3
%         net = init(net);
%         net = configure(net, x2, y2); 
        [net,tr] = train(net, x2, y2);
        pick_best{j} = tr;
        perfs(1,j) = pick_best{j}.best_vperf;
    end    
    [M, I] = min(perfs); 
    tr1 = pick_best{I};

end

