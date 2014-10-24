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
        [reduced_examples, reduced_binary_targets] = getExamplesWithAttributeOfValue(examples, best_attribute, possible_value);
       
        
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




function [ reduced_examples, reduced_binary_targets ] = getExamplesWithAttributeOfValue(examples, attribute, value);
    % TODO: implement
    reduced_examples = 0;
    reduced_binary_targets = 0;
end





function [ best_attribute ] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
    % TODO: implement
    best_attribute = 0;
end





function [ M ]  = majorityValue(binary_targets)
    % Returns the mode of the binary-targets
    M = mode(binary_targets); 
end





function [ tree ] = getTree()
    % returns an initialise tree struct where the tree op = attr
end




function [ allAreSame ] = allBinaryTargetsAreSame(binary_targets)
% returns True iff all binary_targets have the same value
% used as part of decisionTreeLearning algorithm
% TODO: Fails when binary_targets is an empty vector, not sure if we 
%       have to handle this case though
    allAreSame = all(binary_targets == binary_targets(1));
end