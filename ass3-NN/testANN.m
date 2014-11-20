function [predictions] = testANN(net, x2)
	Y = num2cell(sim(net, x2),1);
	predictions = cellfun(@NNout2labels, Y);
end

