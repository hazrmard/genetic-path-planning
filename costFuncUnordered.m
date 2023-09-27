function [total_cost, prob] = costFuncUnordered(sol, prob)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    total_cost = 0;
    for j=1:length(sol)-1
        a = sol(j); b = sol(j+1);
        if isempty(prob.allPairsPaths{a,b})
            [path, cost, ~] = AStar(a, b, prob.fitness_local, prob.adj);
            prob.allPairsPaths{a,b} = path;
            prob.costMatrix(a,b) = cost;
        end
        total_cost = total_cost + prob.costMatrix(a,b);
    end
end