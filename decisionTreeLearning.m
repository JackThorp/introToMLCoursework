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
    best_attribute = chooseBestDecisionAttribute(examples, attributes, binary_targets);
    
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


function [ best_attribute ] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
    % Returns the attribute from 'attributes' which splits the examples
    % resulting in the greatest information gain.
    best_attribute = 0;
end

function [ gain ] = gain(examples, binary_targets, attribute)
    % Returns the information gain of an attribute
    attr_values = 2;
    tar_splits = cell(attr_values, 1);
    for i=1:length(examples)
        attr_val = examples(i, attribute)+1; % +1 for zero indexing...
        tar_splits{attr_val} = [tar_splits{attr_val};binary_targets(i)];
    end
    
    gain = entropy(binary_targets);
    gain = gain - sum(arrayfun(@(c) (length(c)/length(examples))*entropy(c), tar_splits));
end

function [ entropy ] = entropy(binary_targets)
    % Returns the entropy of set by inspecting binary_targets.
    
    target_values = 2; % positive or negative
    target_counts = zeros([target_values 1]);
    for i = 1:length(binary_targets)
        val = binary_targets(i)+1; %for non-zero indexing.
        target_counts(val) = target_counts(val) + 1;
    end
    proportions = target_counts / length(binary_targets);
    entropy = sum(arrayfun(@(p) purity(p), proportions));
end

function [ purity ] = purity(value)
% Would have used anonymous function in entopy but -0*log2(0) is NaN in
% matlab?
    if (in ==0)
        purity = 0;
    else
        purity = -in*log2(in);
    end
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