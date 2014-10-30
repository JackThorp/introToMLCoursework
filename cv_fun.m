function  yfit  = cv_fun( XTRAIN,YTRAIN,XTEST,YTEST )
% predfun is a function handle called with the training subset of X, 
% the training subset of y, and the test subset of X as follows:
% 
% yfit = predfun(XTRAIN,ytrain,XTEST)
% Each time it is called, predfun should use XTRAIN and ytrain to 
% fit a regression model and then return fitted values in a column vector yfit. 
% Each row of yfit contains the predicted values for the corresponding row of XTEST. 
% crossval computes the squared errors between yfit and the corresponding response test set, 
% and returns the overall mean across all test sets.
    %trees
    decision_trees= cell(1,6);
    
    for emotion = 1:6 
        decision_trees{emotion} = getDecisionTree(emotion,XTRAIN, YTRAIN);
    end
    
    predictions = testTrees(decision_trees, XTEST);

end

