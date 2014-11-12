data = load('cleandata_students.mat');

nLr = 30;
nInc = 6;
nDec = 4;
nH1 = 5;
nH2 = 5;
n0 = 3;
nMax = 3;

split = 1;
trainFcn.name = 'trainrp';
max_fail = 6;
epochs = 1000;

[trainval, test] = crossValidationSplit(10, data, split);
[train, val] = crossValidationSplit(9, trainval, 1);
[x2, y2] = ANNdata(val.x, val.y);

lr_map = [1:nLr] * 0.01;
inc_map = ([1:nInc] * 0.2) + 0.8;
dec_map = [1:nDec] * 0.2;
H1map = [3, 5, 10, 15, 30];
H2map = [3, 5, 10, 15, 30];
zerMap = ([1:n0] * 0.2) + 0.3;
maxMap = ([1:nMax] * 10) + 30;

tableHeaders = {'Layers', 'LR', 'delt_inc', 'delt_dec', 'delta0', 'deltamax', 'Fail', 'Performance', 'TR', 'CR', 'F1 Rates', 'Recall Rates', 'Precision Rates'};
result = {};

for l = 1:nLr
    for h1 = 1:nH1
        for h2 = 1:nH2
            for inc = 1:nInc
                for dec = 1:nDec
                    for zer = 1:n0
                        for max = 1:nMax
                            
                            trainFcn.lr = lr_map(l);
                            trainFcn.delt_inc = inc_map(inc);
                            trainFcn.delt_dec = dec_map(dec);
                            trainFcn.delta0 = zerMap(zer);
                            trainFcn.deltamax = maxMap(max);
                            layers = [h1, h2];
                            [net1, tr1] = train_ann(trainval, layers, trainFcn, max_fail, epochs);
                            Y = num2cell(sim(net1, x2), 1);
                            predictions = cellfun(@NNout2labels, Y);
                            [C, order] = confusionmat(val.y, predictions);
                            cr = measure_cr(C);
                            [f1s, rcs, pcs] = getPerfMeasures(C, length(order));

                            tr1.best_vperf % Output performance to prove program is doing something...
                            result = [result; {layers, lr_map(l), inc_map(inc), dec_map(dec), zerMap(zer), maxMap(max), tr1.stop, tr1.best_vperf, tr1, cr, f1s, rcs, pcs}];
                        end
                    end
                end
            end
        end
    end
end

resultTable = array2table(result, 'VariableNames', tableHeaders);
save('trainrp_table.mat', 'table');
