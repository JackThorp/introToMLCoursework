function [ predictions ] = testCBR( CBR, x2 )
% takes the trained CBR system and the features x2 and produces a vector
% of label predictions. 
% We will use this function in our 10-fold validation. 

predictions = zeros(length(x2),1);
for i = 1:length(x2)
    des = find(x2(i,:));
    new_case = makeCase(des, [], 0);
    closest_cases = retrieve( CBR, new_case );
    solved_case  = reuse( closest_cases, new_case );
%     CBR = retain( CBR, solved_case );
    predictions(i) = solved_case.sol;
end

end

