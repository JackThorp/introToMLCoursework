%% script to train the decision trees with the entire clean dataset
cleandata = load('forstudents/cleandata_students.mat');

 decision_trees= cell(1,6);
    for emotion = 1:6 
        decision_trees{emotion} = getDecisionTree(emotion,cleandata);
        DrawDecisionTree(decision_trees{emotion},emolab2str(emotion));
    end
    
    emotion_1 = decision_trees{1};
    save('emotion_1');

    emotion_2 = decision_trees{2};
    save('emotion_2');
    
    emotion_3 = decision_trees{3};
    save('emotion_3');
    
    emotion_4  = decision_trees{4};
    save('emotion_4');
    
    emotion_5  = decision_trees{5};
    save('emotion_5');
    
    emotion_6  = decision_trees{6};
    save('emotion_6');
    