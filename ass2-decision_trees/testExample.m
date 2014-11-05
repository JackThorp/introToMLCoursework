function [ class, score ] = testExample(tree, example)
% Takes a tree and an example array of attributes, and returns
% the tree's classification and score.
    if (isempty(tree.kids))
        class = tree.class;
        score = tree.score;
    else
        [class, score] = testExample(tree.kids{example(tree.op) + 1}, example);
    end

end
