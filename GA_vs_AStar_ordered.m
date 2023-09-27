% Comparing A* vs GA
close all;
rng default;
clear;

trials = 50;
% optimiztion options
opts = optimoptions( ...
    'ga', ...
    'CrossoverFraction', 1.0,...
    'CrossoverFcn',@crossoverFunc,...
    'PopulationSize',30,...
    'CreationFcn',@creationFuncRnd,...
    'EliteCount',5,...,
    'MaxStallGenerations',100,...
    'FunctionTolerance',0,...
    'MaxGenerations', 20);

resGA = struct('time',[], 'cost', [], 'path', [], 'dist', []);
resAS = struct('time',[], 'cost', [], 'path', [], 'dist', []);

for t=1:trials
    prob = getAdjDigraphCoords("l1", 1, 1, false);
    dist = distances(prob.digr);
    nNodes = length(prob.adj);
    nodes = datasample(1:nNodes, 2, 'Replace',false);
    prob.start = nodes(1);
    prob.goal = nodes(2);
    fitness = @(sol) costFunc(sol, prob.adj, prob.start, prob.goal, prob.coords, prob.occupancy, 0, 1, 1, 1);

    [path, cost, timeTaken, prob] = GAVariable(opts, prob, fitness);
    resGA(t).time = timeTaken;
    resGA(t).cost = cost;
    resGA(t).path = path;
    resGA(t).dist = dist(prob.start, prob.goal);

    [path, cost, timeTaken] = AStar(prob.start, prob.goal, fitness, prob.adj);
    resAS(t).time = timeTaken;
    resAS(t).cost = cost;
    resAS(t).path = path;
    resAS(t).dist = dist(prob.start, prob.goal);
    fprintf("trial #%2d/%d, from %2d to %2d\n", t, trials, prob.start, prob.goal);
end
%%
fig = figure();
% Time vs path length
ax = subplot(1,1,1);
scatter([resGA.dist], [resGA.time], 'DisplayName','GA'); hold on;
scatter([resAS.dist], [resAS.time], 'DisplayName','AS');
% set(gca, 'yscale', 'log');
ylabel('Time taken /s'); xlabel('Cartesian distance');
legend;
%%
fig = figure();
% Time vs path nodes
ax = subplot(1,1,1);
scatter(arrayfun(@(x) length([x.path]), resGA), [resGA.time], 'DisplayName','GA'); hold on;
scatter(arrayfun(@(x) length([x.path]), resGA), [resAS.time], 'DisplayName','AS')
set(gca, 'yscale', 'log');
ylabel('Time taken /s'); xlabel('Nodes in path');
legend;
%%
fig = figure();
% histogram of fitnesses
ax = subplot(1,1,1);
h = histogram([resGA.cost], 10, 'DisplayStyle', 'bar', 'DisplayName', 'GA'); hold on;
xline(mean([resGA.cost]), 'LineWidth',4, 'Color','red', 'DisplayName', 'GA-mean');
h = histogram([resAS.cost], 10, 'BinEdges', h.BinEdges, 'DisplayStyle', 'bar', 'DisplayName', 'AS');
xline(mean([resAS.cost]), 'LineWidth',4, 'Color','blue', 'DisplayName', 'AS-mean');
xlabel('Fitness value'); ylabel('Frequency');
legend;