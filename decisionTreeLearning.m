function [ decision_tree ] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.
  
    if(allBinaryTargetsAreSame(binary_targets) || isempty(attributes))
        % return leaf node with this value
        decision_tree.class = mode(binary_tagets);
        return
    end 

    % find the best_attribute 
    best_attribute = chooseBestDecisionAttribute(examples, attributes, binary_targets);
    
    % decision tree = new tree with root best_attribute
    decision_tree.op = best_attribute;
    
    % initialize kids to be 2x1 cell array
    decision_tree.kids = cell(2,1);
    
    % TODO introduce a concept of possible attribute values which we can pass around?
    for possible_value = 0:1
        % get elements of examples with best_attribute == possible_value and the corresponding binary_targets
        [reduced_examples, reduced_binary_targets] = getExamplesWithAttributeOfValue(examples, binary_targets, best_attribute, possible_value);
        
        if (isempty(reduced_examples))
            subtree.class = mode(binary_targets);
        else 
            % recursively find subtree
            subtree = decisionTreeLearning(reduced_examples, attributes, reduced_binary_targets);
        end
        
        % set subtree
        % need the (+1) because cell arrays are 1-indexed
        decision_tree.kids{possible_value + 1} = subtree;
    end
    
end


function [ reduced_examples, reduced_binary_targets ] = getExamplesWithAttributeOfValue(examples, binary_targets, attribute, value);
    reduced_examples = [];
    reduced_binary_targets = [];
    
    for i = 1:length(examples)
        % Get next example, e.g. row from examples with a value for each
        % attribute
        example = examples(i,:);
        
        % Get the value of desired attribute
        value_actual = example(attribute);
        
        if (value_actual == value_wanted)
            % Add this example to the vector of reduced examples
            index = length(reduced_examples) + 1;
            % TODO: fix the performance issue by prealocating the array
            reduced_examples(index,:) = example;
            reduced_binary_targets(index,:) = binary_targets(i);
        end    
    end    
end


function [ best_attribute ] = chooseBestDecisionAttribute(examples, attributes, bin_targs)
    % Returns the attribute from 'attributes' which splits the examples
    % resulting in the greatest information gain.
    
    % map gain accross attributes and pick max.
    gains = arrayfun(@(a) gain(examples, a, bin_targs), attributes);
    [~, best_attribute] = max(gains);
    
end

function [ gain ] = gain(examples, attribute, bin_targs)
    % Returns the information gain of an attribute
    
    % generally attribute could take more than 2 values ...
    attr_values = 2;
   
    % divide the examples up into splits depending on value for attribute
    splits = cell(attr_values, 1);
    for i=1:length(examples)
        val = examples(i, attribute); 
        splits{val+1} = [splits{val+1};bin_targs(i)]; % +1 for zero indexing...
    end
   
    gain = entropy(bin_targs);
    gain = gain - sum(arrayfun(@(c) (length(c)/length(examples))*entropy(c), splits));
end

function [ entropy ] = entropy(bin_targs)
    % Returns the entropy of set by inspecting binary_targets.
    pos = sum(bin_targs == 1) / length(bin_targs);
    neg = sum(bin_targs == 0) / length(bin_targs);
    
    entropy = sum(arrayfun(@(p) purity(p), [pos neg]));
    
    function [purity] = purity(v)
        if (v ==0)
            purity = 0;
        else
            purity = -v*log2(v);
        end
    end

end

function [ allAreSame ] = allBinaryTargetsAreSame(binary_targets)
% returns True iff all binary_targets have the same value
% used as part of decisionTreeLearning algorithm
% TODO: Fails when binary_targets is an empty vector, not sure if we 
%       have to handle this case though
    allAreSame = all(binary_targets == binary_targets(1));
end