function [ closest_cases ] = retrieve( CB, newcase )
% retrieve uses the cbr and the similarity function to extract the nearest
% matching case. Uses . . . retrieval function. 

  %find the clusters that match and add to caselist
  caselist = {};
  for i = 1:length(CB.clusters)
       if(~isempty(intersect(CB.clusters(i).index, newcase.des)))
          caselist = horzcat(CB.clusters(i).cases, caselist);
       end
  end
             
  % Re-establish : 
%   find the cases that contains AU from the caselist and add to bestlist
  bestlist = {};
  for j = 1:length(caselist)
      matchcase = caselist{j};
      if(~isempty(intersect(newcase.des, matchcase.des)))
        bestlist{end+1} = matchcase;
      end
  end
  
  % we skip the typicallity and longest intersect and use the knn to get 
  % solution to with the bestlist. 
  % Because in k-nn we will taken typicallity and intersection in to account
  % k_nn with best cases and k = 20 ??
  k = 20;
  simfunc = 'cosine';
  closest_cases = k_nn(k, bestlist, newcase, simfunc);
  
end

