function [stops, cost, timeTaken] = AStarUnordered(prob, cost_fn)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tic;
permutations = perms(prob.stops);
% TODO: Add post-processing of permutations
% [permutations, prob] = postProcessUnordered(permutations, prob);
costs = inf(1, length(permutations));
for i=1:length(costs)
   costs(i) = cost_fn(permutations(i,:));
end
[cost, idx] = min(costs);
stops = permutations(idx, :);
timeTaken = toc;
end