function [predictions] = testANN(net, x2)
    x = transpose(x2);
	Y = num2cell(sim(net, x),1);
	predictions = cellfun(@NNout2labels, Y);
    predictions = transpose(predictions);
end

