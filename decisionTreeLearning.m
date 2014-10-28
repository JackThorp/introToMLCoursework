function [ decision_tree ] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.

    if(allBinaryTargetsAreSame(binary_targets) || isempty(attributes))
        % return leaf node with this value
        decision_tree.kids = [];
        decision_tree.op = [];
        decision_tree.class = mode(binary_targets);
        return
    end 

    % find the best_attribute then remove it from list
    best_attribute = chooseBestDecisionAttribute(examples, attributes, binary_targets)
    
    % initialize tree
    decision_tree.op = best_attribute;
    decision_tree.kids = cell(2,1);
    
    attributes = attributes(attributes~=best_attribute);
    
    for possible_value = 0:1
        % get elements of examples with best_attribute == possible_value and the corresponding binary_targets
        [reduced_examples, reduced_binary_targets] = getExamplesWithAttributeOfValue(examples, binary_targets, best_attribute, possible_value);

        if (isempty(reduced_examples))
            subtree.class = mode(binary_targets);
            subtree.op = [];
            subtree.kids = [];
        else 
            % recursively find subtree
            subtree = decisionTreeLearning(reduced_examples, attributes, reduced_binary_targets);
        end
        
        % set subtree
        % need the (+1) because cell arrays are 1-indexed
        decision_tree.kids{possible_value + 1} = subtree;
    end
    
end


function [ reduced_examples, reduced_binary_targets ] = getExamplesWithAttributeOfValue(examples, binary_targets, attribute, value)
    % Pre-allocate arrays
    reduced_examples = zeros(length(examples(:,1)), length(examples(1,:)));
    reduced_binary_targets = zeros(1, length(binary_targets));
    
    next_index = 1;
    for i = 1:length(examples(:,1))
        % Get next example, e.g. row from examples with a value for each
        % attribute
        example = examples(i,:);
        % Get the value of desired attribute
        value_actual = example(attribute);
        
        if (value_actual == value)
            % Add this example to the vector of reduced examples
            reduced_examples(next_index,:) = example;
            reduced_binary_targets(next_index) = binary_targets(i); 
            next_index = next_index + 1;
        end    
    end   
    
    % Crop array to delete space that wasn't used
    while (length(reduced_binary_targets) >= next_index)
        reduced_examples(next_index,:) = [];
        reduced_binary_targets(next_index) = [];
    end
end


function [ best_attribute ] = chooseBestDecisionAttribute(examples, attributes, bin_targs)
    % Returns the attribute from 'attributes' which splits the examples
    % resulting in the greatest information gain.
    
    % map gain accross attributes and pick max.
    gains = arrayfun(@(a) gain(examples, a, bin_targs), attributes);
    [~, best_attribute_index] = max(gains);
    best_attribute = attributes(best_attribute_index);
    
end

function [ gain ] = gain(examples, attribute, bin_targs)
    % generally attribute could take more than 2 values ...
    attr_values = 2;
   
    % divide the examples up into splits depending on value for attribute
    splits = cell(attr_values, 1);
    for i=1:length(examples(:,1))
        val = examples(i, attribute); 
        splits{val+1} = [splits{val+1};bin_targs(i)]; % +1 for zero indexing...
    end
   
    gain = entropy(bin_targs);
    gain = gain - remainder(examples, splits);
end


function [ remainder_entropy ] = remainder(examples, splits)
    remainder_entropy = sum(cellfun(@(c) (length(c)/length(examples))*entropy(c), splits));
end

function [ entropy ] = entropy(bin_targs)
    % Returns the entropy of set by inspecting binary_targets.
    pos = sum(bin_targs == 1) / length(bin_targs);
    neg = sum(bin_targs == 0) / length(bin_targs);
    
    if (pos==0 || neg==0)
        entropy=0;
        return
    end
    
    entropy = sum(arrayfun(@(p) -p*log2(p), [pos neg]));
end

function [ allAreSame ] = allBinaryTargetsAreSame(binary_targets)
    allAreSame = all(binary_targets == binary_targets(1));
end