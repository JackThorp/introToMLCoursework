function [ closest_cases ] = retrieve( CB, newcase )
% retrieve uses the cbr and the similarity function to extract the nearest
% matching case. Uses . . . retrieval function. 

  index_scores = zeros(1,length(CB.clusters));
  
  % Get the index score on each cluster for newcase. Score is the sum of
  % the proportions of newcases AU's that the cluster contains.
  for i=1:length(CB.clusters)
      for j=1:length(newcase.des)
          AU = newcase.des(j);
          AU_score = (CB.clusters(i).index(AU)) / (CB.g_index(AU)); 
          index_scores(i) = index_scores(i) + AU_score;
      end
  end

  % Get cases from top three scoring clusters.
  [~, sortIndex] = sort(index_scores,'descend');
  
  % 3 chosen because it halves search - could do 2?
  caselist = horzcat(CB.clusters(sortIndex(1)).cases, ...
            CB.clusters(sortIndex(2)).cases, ...
            CB.clusters(sortIndex(3)).cases,...
            CB.clusters(sortIndex(4)).cases);%,...
%             CB.clusters(sortIndex(5)).cases,...
%             CB.clusters(sortIndex(6)).cases);
 
  % k_nn with best cases and k = 20 ??
  k = 20;
  simfunc = 'cosine';
  closest_cases = k_nn(k, caselist, newcase, simfunc);
  
end

