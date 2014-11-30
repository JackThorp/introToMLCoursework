function ts = t_test_script(clean_or_noisy)
if(strcmp(clean_or_noisy, 'clean'))
    tree_data = load('../ass2-decision_trees/classerrors_clean.mat');
    ann_data = load('../ass3-NN/annerrors_clean.mat');
    %cbr_data = load('classerrors_clean.mat');
    disp('validating clean data');
elseif(strcmp(clean_or_noisy, 'noisy'))
    tree_data = load('../ass2-decision_trees/classerrors_noisy.mat');
    ann_data = load('../ass3-NN/annerrors_noisy.mat');
    %cbr_data = load('classerrors_noisy.mat');
    disp('validating noisy data');
else
    disp('Please input ''clean'' or ''noisy''');
end

ts = cell(3, 6);
sig = 0.05;

for e = 1:6
    tree_sample = tree_data.ans(:, e);
    ann_sample = ann_data.ans(:, e);
    cbr_sample = cbr_data(:, e);
    [h, p] = ttest(tree_sample, ann_sample, 'Alpha', sig/3);
    ts{1, e} = [h, p];
    [h, p] = ttest(tree_sample, cbr_sample, 'Alpha', sig/3);
    ts{2, e} = [h, p];
    [h, p] = ttest(ann_sample, cbr_sample, 'Alpha', sig/3);
    ts{3, e} = [h, p];
end

end