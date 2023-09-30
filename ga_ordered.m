%% Author: Ibrahim Ahmed
% relevant files:
%   - costFunc.m
%   - crossoverFunc.m
% Requires
% - Global Optimization Toolbox
% - Optimization Toolbox
% - Statistics and Machine Learning Toolbox

close all;
clear;
rng default;

wdist = 1;
wcong = 0.1;
wturn = 0.;

prob = getProb();
%%

% The fitness function measures how good a candidate solution is.
% fitness = @(sol, prob) [costFunc(sol, prob.adj, prob.start, prob.goal, prob.coords, prob.occupancy, 0, wdist, wturn, wcong), prob];

% optimiztion options
opts = optimoptions( ...
    'ga', ...
    'SelectionFcn',@selectionFunc,...
    'CrossoverFraction', 1.0,...
    'CrossoverFcn',@crossoverFunc,...
    'PopulationSize',30,...
    'CreationFcn',@creationFuncRnd,...
    'EliteCount',5,...,
    'MaxStallGenerations',max(100, length(prob.adj)^2),...
    'FunctionTolerance',0,...
    'MaxGenerations', 20);


[path, cost, timeTaken, prob] = GAVariable(opts, prob, @fitness);


disp("Best solution: "); disp(path);
disp("Best fitness: "); disp(cost);
hold(prob.axMap, 'on');
% highlight(prob.pl, path(1:end-1), path(2:end));
delete(prob.lines);
plot(prob.axMap, prob.coords(path,1), prob.coords(path, 2), 'Color', 'black', 'LineWidth', 3);

function [cost, prob] = fitness(sol, prob)
    cost = costFunc(sol, prob.adj, prob.start, prob.goal, prob.coords, prob.occupancy, 0, wdist, wturn, wcong);
end
