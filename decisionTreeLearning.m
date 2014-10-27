function [decision_tree] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.

if (allSame(binary_targets) | isempty(attributes))
    decision_tree = leafNode(majorityValue(binary_targets));
else
    best = chooseBestDecisionAttribute(examples, attributes, binary_targets);
    tree.op = best;
    tree.kids = {getSubtree(0, best), getSubtree(1, best)}; 
    decision_tree = tree;
end

    function [subtree] = getSubtree(u, best)
    % Returns the subtree for the best attribute valued u.
    examples_i = [];
    targets_i = [];
    for i=1:length(binary_targets),
        if (examples(i, best) == u)
            examples_i = [examples_i; examples(i,:)];
            targets_i(end+1) = binary_targets(i);
        end
    end
    if (isempty(examples_i))
        subtree = leafNode(majorityValue(binary_targets));
    else
        new_attrib = attributes;
        new_attrib(best) = [];
        subtree = decisionTreeLearning(examples_i, new_attrib, targets_i);
    end
    end

end

function [best] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
% Returns the attribute that results in the highest information gain.

p = sum(binary_targets == 1);
n = sum(binary_targets == 0);

gains = [];
for i=1:length(attributes),
    gains(i) = I(p, n) - remainder(attributes(i));
end
[maxGain, maxGainIndex] = max(gains); % [value, index]
best = maxGainIndex;

    function [I] = I(p, n);
    a = p / (p + n);
    b = n / (p + n);
    I = -(a * log2(a)) - (b * log2(b));
    end

    function[rem] = remainder(i)
    % returns remainder for the attribute numbered i
    ps = [0, 0]; % p0, p1
    ns = [0, 0]; % n0, n1
    for j=1:length(binary_targets),
        value = examples(j, i);
        valpair = [value, 1 - value];
        if (binary_targets(j))
            ps = ps + valpair;
        else
            ns = ns + valpair;
        end
    end
    for k=1:2,
        r(k) =  ((ps(k) + ns(k))/(p + n)) * I(ps(k), ns(k));
    end
    rem = r(1) + r(2);
    end
end

function [leaf] = leafNode(value)
% Returns a leaf node with the value given
leaf.kids = [];
leaf.op = [];
leaf.class = value;
end

function [M]  = majorityValue(binary_targets)
% Returns the mode of the binary-targets
M = mode(binary_targets); 
end

function [tree] = getTree()
% returns an initialise tree struct where the tree op = attr
end

function [all_same] = allSame(binary_targets)
% Returns whether or not all values in binary_targets are the same.
all_same = (range(binary_targets) == 0);
end
