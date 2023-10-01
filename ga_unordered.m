%% Author: Ibrahim Ahmed
% Requires
% - Global Optimization Toolbox (optim options for GA)
% - Optimization Toolbox (optimoptions object)
% - Statistics and Machine Learning Toolbox (datasameple function)
% - Navigation Toolbox (making random mazes)

close all;
clear;
rng default;

wdist = 1;
wcong = 0.;
wturn = 0.;

prob = getProb();

% The local fitness function is the cost of individual paths between two
% stop points. This is the same as fitness in ordered GA
prob.fitness_local = @(sol) costFunc(sol, prob.adj, prob.start, prob.goal, ...
    prob.coords, prob.occupancy, 0, wdist, wturn, wcong);
fitness = @costFuncUnordered;

[stops, cost, timeTaken, prob] = GAVariable(prob, fitness);


disp("Best solution: "); disp(stops);
disp("Best fitness: "); disp(cost);
delete(prob.lines);
hold(prob.axMap, 'on');
for i=1:length(stops)-1
    [path, ~, ~] = AStar(stops(i), stops(i+1), prob.fitness_local, prob.adj);
    % highlight(prob.pl, path(1:end-1), path(2:end), 'EdgeColor','black', 'NodeColor','black');
    plot(prob.axMap, prob.coords(path,1), prob.coords(path,2), 'Color','black', 'LineWidth', 2);
    text(prob.axMap, prob.coords(stops(i),1), prob.coords(stops(i),2), num2str(i));
end
text(prob.axMap, prob.coords(stops(end),1), prob.coords(stops(end),2), num2str(length(stops)));
hold(prob.axMap, 'off');

%%