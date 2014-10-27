function [ decision_tree ] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.

    if(allBinaryTargetsAreSame(binary_targets))
        % return leaf node with this value
        % TODO: might want to change this magic 1 for something else
        decision_tree.class = binary_targets(1);
        return
    end 
   
    if(isempty(attributes))
        % return leaf node with value = majorityValue(binary_targets)
        decision_tree.class = majorityValue(binary_targets);
        return
    end

    % find the best_attribute 
    best_attribute = chooseBestDecisionAttribute(examples, attributes, binary_targets)
    
    % decision tree = new tree with root best_attribute
    decision_tree.op = best_attribute;
    
    % initialize kids to be 2x1 cell array
    decision_tree.kids = cell(2,1);
    
    for possible_value = 0:1
        % get elements of examples with best_attribute == possible_value and the corresponding binary_targets
        [reduced_examples, reduced_binary_targets] = getExamplesWithAttributeOfValue(examples, binary_targets, best_attribute, possible_value);
       
        
        if (isempty(reduced_examples))
            subtree.class = majorityValue(binary_targets);
            
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
            % TODO: fix the performance issue by prealocating the array
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


function [ best_attribute ] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
    % Returns the attribute from 'attributes' which splits the examples
    % resulting in the greatest information gain.
    best_gain = 0;
    best_attribute = 0;
    
    for i = 1:length(attributes)
       attribute = attributes(i);
       attribute_gain = gain(examples, binary_targets, attribute);
       
       if(attribute_gain > best_gain)
           best_gain = attribute_gain;
           best_attribute = attribute;
       end
    end   
    
end

function [ gain ] = gain(examples, binary_targets, attribute)
    % Returns the information gain of an attribute
    p = sum(binary_targets == 1);
    n = sum(binary_targets == 0);
    
    gain = entropy(p,n) - remainder(examples, binary_targets, attribute);
end



function [ entropy ] = entropy(p, n)
    % Calculates the entropy given the number of positive and negative
    % examples
    if (p == 0 || n == 0) 
        entropy = 0;
        return
    end
    
    positive_ratio = p / (p + n);
    negative_ratio = n / (p + n);
    entropy = -positive_ratio*log2(positive_ratio) - negative_ratio * log2(negative_ratio);
    
end


function [ remainder_entropy ] = remainder(examples, binary_targets, attribute)
    p = sum(binary_targets == 1);
    n = sum(binary_targets == 0);

    [~, positive_bin_tars] = getExamplesWithAttributeOfValue(examples, binary_targets, attribute, 1);
    [~, negative_bin_tars] = getExamplesWithAttributeOfValue(examples, binary_targets, attribute, 0);
    
    p1 = sum(positive_bin_tars == 1);
    n1 = sum(positive_bin_tars == 0);
    
    p0 = sum(negative_bin_tars == 1);
    n0 = sum(negative_bin_tars == 0);
    
    positive_entropy = entropy(p1, n1);
    negative_entropy = entropy(p0, n0);
    
    
    remainder_entropy = ((p0+n0)/(p+n)) * negative_entropy + ((p1+n1)/(p+n)) * positive_entropy;
end






function [ M ]  = majorityValue(binary_targets)
    % Returns the mode of the binary-targets
    M = mode(binary_targets); 
end


function [ allAreSame ] = allBinaryTargetsAreSame(binary_targets)
% returns True iff all binary_targets have the same value
% used as part of decisionTreeLearning algorithm
% TODO: Fails when binary_targets is an empty vector, not sure if we 
%       have to handle this case though
    allAreSame = all(binary_targets == binary_targets(1));
end