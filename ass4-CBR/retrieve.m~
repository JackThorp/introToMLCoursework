function [ closest_cases ] = retrieve( CB, newcase )
% retrieve uses the cbr and the similarity function to extract the nearest
% matching case. Uses . . . retrieval function. 

  %find the clusters that match and add to caselist
  caselist = {};
  for i = 1:length(CB.cases)
       if(~isempty(intersect(CB.cases{i}.des, newcase.des)))
          caselist = horzcat(CB.cases{i}, caselist);
       end
  end
             
  
  % we skip the typicallity and longest intersect and use the knn to get 
  % solution to with the bestlist. 
  % Because in k-nn we will taken typicallity and intersection in to account
  % k_nn with best cases and k = 20 ??
  k = 20;
  simfunc = 'cosine';
  closest_cases = k_nn(k, caselist, newcase, simfunc);
  
end

