
load('/homes/jt1712/3rdYear/ML/introToMLCoursework/forstudents/cleandata_students.mat')

% prepare data (format by transposing) for neural network functions.
[x2, y2] = ANNdata(x,y);

% Create blank feedforward network
net = feedforwardnet(5, 'traingd');
net = configure(net, x2, y2); %sets up network and initialises weights. Also configure is done automatically by train function.


% configure and run training algorithm.
% Stop criteria for training includes end of epochs, max_fail, min_grad,
% time (timeout) or goal (minimum performance value).
% net.trainParam.epochs   - sets number of epochs default = ...?
% net.trainParam.lr       - sets learning rate, defualt value is 0.01
% net.trainParam.max_fail - sets the number of validation checks allowed
%                           before failure. Default is 6. i.e after 6 
%                           increments of error function training stops. 
% net.trainParam.min_grad - min gradient value that training will stop at,
%                           default = 1e-5.

% tr is the training record. 
[net, tr] = train(net, x2, y2);

%Y = sim(net, y2);
%plot(x2,y2,x2,Y, 'r.');

%plotperf(tr) - plot performance using training records.