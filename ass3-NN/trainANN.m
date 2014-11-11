
data = load('/homes/jt1712/3rdYear/ML/introToMLCoursework/forstudents/cleandata_students.mat');

% prepare data (format by transposing) for neural network functions

[trainval, test] = crossValidationSplit(10, data, 1);
[x2, y2] = ANNdata(trainval.x, trainval.y);

% Create blank feedforward network
net = feedforwardnet(10, 'traingd');
net = init(net);
net = configure(net, x2, y2); %sets up network and initialises weights. Also configure is done automatically by train function.


% configure and run training algorithm.
% Stop criteria for training includes end of epochs, max_fail, min_grad,
% time (timeout) or goal (minimum performance value).
% net.trainParam.min_grad
net.trainParam.epochs = 300000;
net.trainParam.lr = 0.01;
net.trainParam.max_fail = 6;
net.divideFcn = 'divideind';
net.divideParam.valInd = 1:100;
net.divideParam.trainInd = 101:900;
%net.trainParam.showWindow = 0;

% tr is the training record. 
[net, tr] = train(net, x2, y2);
tr.best_vperf
tr.best_epoch
tr.stop


% To retrain a network  net = train(net, x2, y2); maybe
% create a new type of feedforward net. 

%Y = sim(net, y2);
%plot(x2,y2,x2,Y, 'r.');

%plotperf(tr) - plot performance using training records.