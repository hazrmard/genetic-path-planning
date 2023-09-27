close all; clear; rng default;

prob = getAdjDigraphCoords();

fitness = @(sol) costFunc(sol, prob.adj, prob.start, prob.goal, prob.coords, prob.occupancy, 0, 1, 0.1, 0.1);

[path, cost, timeTaken] = AStar(prob.start, prob.goal, fitness, prob.adj);

% pl = plot(prob.axMap, prob.digr, 'XData',prob.coords(:,1),'YData',prob.coords(:,2), ...
%           'MarkerSize', prob.markerSize, 'NodeColor', prob.nodeColor); 
% highlight(pl, path(1:end-1), path(2:end));

hold(prob.axMap, 'on');
plot(prob.axMap, prob.coords(path,1), prob.coords(path, 2), 'Color', 'black', 'LineWidth', 3);
hold off;

disp("Best solution: "); disp(path);
disp("Best fitness: "); disp(cost);