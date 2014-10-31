function [ predictions ] = testTrees( T, x2 )
% testTrees takes an array/cell of six trees T (one tree to classify each
% emotion) and an array of example data. This function returns an array of 
% predicted emotion labels (1 to 6) for these examples.

    no_emotions = 6;
    classifications = zeros(length(x2), no_emotions);
    scores = zeros(length(x2), no_emotions);

    % Generate a matrix where column = emotion and row value is 
    % classification of example for the emotion.
    for i=1:no_emotions
        [classifications(:,i), scores(:,i)] = getClassesAndScores(T{i}, x2);
    end

    predictions = zeros(length(x2), 1);
    
    for x=1:length(x2)
        %predictions(i) =  chooseEmotionRandom(classifications(i,:), scores(i,:));
        predictions(i) =  chooseEmotionRandom(classifications(i,:));
    end
    
end

function [ classifications, scores ] = getClassesAndScores(tree, data)
% Takes a decision tree and a data set and returns a vector of the 
% classification made by the decision tree for each example. 

    classifications = zeros(length(data), 1);
    scores = zeros(length(data), 1);
    for j = 1:length(data)
        [classifications(j), scores(j)] = testExample(tree, data(j)); 
    end
end


function [ emotion ] = chooseEmotionUsingScores(classifications, scores) 
% Takes an (1x6) array that corresponds to the classifications
% of an instance by each emotion. Based on these classifications this 
% function returns a prediction of the emotion.

    pos_emotions = find(classifications==1);
    
    n = length(pos_emotions);
    
    if(n == 0)
        % No positive classification so
        % return an emotion at random
        emotion = randi([1,6]); % floor((rand(1) * 6)+1);
        
    elseif (n == 1)
        % Only one tree classified positive.
        emotion = pos_emotions(1); 
        
    else
        % Multiple trees classified example positively so
        % choose classification with best score.
        
        mx = max(arrayfun(@(x,y) x*y, classifications, scores));
        emotion = datasample(find(scores==mx),1);
    end
        

end

function [ emotion ] = chooseEmotionRandom(classifications) 
% Takes an (1x6) array that corresponds to the classifications
% of an instance by each emotion. Based on these classifications this 
% function returns a prediction of the emotion.

    pos_emotions = find(classifications==1);
    
    n = length(pos_emotions);
    
    if(n == 0)
        % No positive classification so
        % return an emotion at random
        emotion = randi([1,6]); % floor((rand(1) * 6)+1);
        
    elseif (n == 1)
        % Only one tree classified positive.
        emotion = pos_emotions(1); 
        
    else
        % Multiple trees classified example positively so
        % choose between these emotions at random.
        emotion = datasample(pos_emotions,1);
        
    end
        

end