%% Author: Ibrahim Ahmed
% relevant files:
%   - fitnessFunc.m
%   - crossoverFunc.m

rng default;

isRnd = input("Set size of random graph (0, for hard-coded example): ");

if isstring(isRnd)
    func = str2func(isRnd);
    [adj, coords] = to_graph(func());
    x = coords(:,1); y = coords(:,2);
    digr = digraph(adj);
    dist = distances(digr);
    pl = plot(digr, 'XData',x,'YData',y);
else
    if isRnd > 0 | isempty(isRnd)
        adj = zeros(isRnd);
        adj(randperm(numel(adj),int32(sqrt(numel(adj))))) = 1;
    else
    adj = [
        [0,1,1,0];
        [0,0,0,1];
        [0,1,0,0];
        [1,0,0,0];
    ];
    end
    digr = digraph(adj);
    dist = distances(digr);
    pl = plot(digr, 'Layout', 'force');
    x = pl.XData; y = pl.YData;
end
%%
% disp(["Graph is cyclic: ", isdag(digr)]);
start = input("start node: ");
goal = input("goal node: ");
% This is the solution space specification. For a navigation problem,
% nvars can be the nodes of a graph representing the adjacency matrix
nNodes = length(adj);
numVars = nNodes-2;
% Lower, upper bound of solution
% Solution is list of intermediate nodes
% 0 represents end of path
lb = zeros(1,numVars); ub = ones(1,numVars) * nNodes;

% The fitness function measures how good a candidate solution is.
% For example, given the nodes to traverse, whether a collision will occur.
FitnessFunc = @(sol) fitnessFunc(sol, adj, start, goal, dist);

CrossoverFunc = @crossoverFunc;

CreationFunc = @(GenomeLength, FitnessFcn, options) creationFunc(start, goal, adj, options.PopulationSize);

% optimiztion options
opts = optimoptions( ...
    'ga', ...
    'PlotFcn',{'gaplotscores','gaplotbestf','gaplotdistance'},...
    'CreationFcn', CreationFunc,...
    'MutationFcn',{},...
    'SelectionFcn', 'selectionstochunif',...
    'CrossoverFcn', CrossoverFunc,...
    'CrossoverFraction', 0.8,...
    'PopulationSize',100,...
    'MaxStallGenerations',max(100, (numVars+2)^2),...
    'FunctionTolerance',0,...
    'MaxGenerations', 1000);


[x,fval] = ga(FitnessFunc,numVars,[],[],[],[],lb,ub,[],1:numVars,opts);

if fval>=length(adj)
    disp(x);
    disp('Not possible');
else
    sol = [start, x(x~=0), goal]; % remove no-ops
    sol = sol(1:find(sol==goal)); % remove nodes past goal
    disp(sol);
    highlight(pl, sol(1:end-1), sol(2:end));
end
%%