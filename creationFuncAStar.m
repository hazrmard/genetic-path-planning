function pop = creationFuncAStar(opts, prob)
%populationFunc creates an initial population for the graph
% Author: Ibrahim Ahmed
pop = cell(opts.PopulationSize,1);

for i=1:size
    w = rand(1,3);
    w = w / sum(w);
    % weights for distance, traffic, congestion
    wd = w(1); wt = w(2); wc = w(3);
  
    fitness = @(sol) costFunc(sol, prob.adj, prob.start, prob.goal, prob.coords, prob.occupancy, 0, wd, wt, wc);
    [path, cost, ~] = AStar(prob.start, prob.goal, fitness, prob.adj);
    pop{i,1} = path;
end