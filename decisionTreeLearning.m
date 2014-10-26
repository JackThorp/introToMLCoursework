function [decision_tree] = decisionTreeLearning(examples, attributes, binary_targets)

% function to return the decision tree for a specific target classification 
% e.g anger. The binary_targets vector should be appropriatley formatted
% for the desired decision tree.

if (allSame(binary_targets) | isempty(attributes))
    decision_tree = leafNode(majorityValue(binary_targets));
else
    best = chooseBestDecisionAttribute(examples, attributes, binary_targets);
    tree.op = best;
    decision_tree = tree;
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
best = attributes(maxGainIndex);

    function [I] = I(p, n);
    a = p / (p + n);
    b = n / (p + n);
    I = -(a * log2(a)) - (b * log2(b));
    end

    function[rem] = remainder(i)
    % returns remainder for the attribute numbered i
    p = [0, 0]; % p0, p1
    n = [0, 0]; % n0, n1
    for j=1:length(binary_targets),
        value = examples(j, i);
        valpair = [value, 1 - value0];
        if (binary_targets(j))
            p = p + valpair;
        else
            n = n + valpair;
        end
    end
    for k=1:2,
        r(k) =  ((p(k) + n(k))/(p + n)) * I(p(k), n(k));
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
