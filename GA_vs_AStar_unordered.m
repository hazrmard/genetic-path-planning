% Comparing A* vs GA
close all;
rng default;
clear;

trials = 100;
maxstops = 10;

resGA = struct('time',[], 'cost', [], 'path', [], 'dist', []);
resAS = struct('time',[], 'cost', [], 'path', [], 'dist', []);

for t=1:trials
    prob = getProb("l1", 1, 1, false);
    nNodes = length(prob.adj);
    costAdj = 1 * prob.adj + 1 * prob.occupancy;
    costMatrix = distances(digraph(costAdj));
    fitness = @(sol) sum(costMatrix(sub2ind([nNodes, nNodes], sol(1:end-1), sol(2:end))));

    dist = distances(prob.digr);
    stops = datasample(1:nNodes, min(randi([3,maxstops]), nNodes), 'Replace',false);
    prob.start = stops(1);
    prob.goal = stops(2);
    prob.stops = stops;

    [path, cost, timeTaken, prob] = GAVariable(prob, fitness);
    resGA(t).time = timeTaken;
    resGA(t).cost = cost;
    resGA(t).path = path;
    resGA(t).dist = dist(prob.start, prob.goal);

    [path, cost, timeTaken] = AStarUnordered(prob, fitness);
    resAS(t).time = timeTaken;
    resAS(t).cost = cost;
    resAS(t).path = path;
    resAS(t).dist = dist(prob.start, prob.goal);
    fprintf("trial #%2d/%d, for %d stops\n", t, trials, length(prob.stops));
end
%%
% fig = figure();
% % Time vs path length
% ax = subplot(1,1,1);
% scatter([resGA.dist], [resGA.time], 'DisplayName','GA'); hold on;
% scatter([resAS.dist], [resAS.time], 'DisplayName','AS');
% % set(gca, 'yscale', 'log');
% ylabel('Time taken /s'); xlabel('Cartesian distance');
% legend;
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