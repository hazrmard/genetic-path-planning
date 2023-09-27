function prob = getAdjDigraphCoords(isRnd, start, goal, verbose, axMap, occupancy)
% Create the `prob` structure used by GAVariable for genetic search.
% The `prob` struct defines additional variables/functions needed on top of
% optimoptions function that Matlab's default GA function uses.

prob = make_prob();
% Initial parameters
prob.postProcessFcn = @postProcessUnordered;
prob.interval = 0;
prob.highlightn = 10;
prob.verbose = true;

% Populate other parameters that are empty:
if nargin==0
    isRnd = input("Set size of random graph, or name of layout file: ");
    if isempty(isRnd)
        isRnd = "l1";
    end
end
if nargin >= 4
    % Unless verbose is explicitly specified, assume verbose:
    prob.verbose = verbose;
end
if prob.verbose
    if nargin < 5
        prob.axMap = gca;
    else
        prob.axMap = axMap;
    end
end

% Get floor map
if isstring(isRnd)
    layouts = split(isRnd, '+');
    func = str2func(layouts{1});
    [prob.adj, prob.coords, prob.bounds] = func();
    for i=2:length(layouts)
        func = str2func(layouts{i});
        [adji, coordsi, boundsi] = func();
        [prob.adj, prob.coords, prob.bounds] = combine_layout( ...
            prob.adj, prob.coords, prob.bounds, ...
            adji, coordsi, boundsi, ...
            length(prob.adj), 1);
    end
else
    [prob.adj, prob.coords, prob.bounds] = random_layout(isRnd);
end

prob.digr = digraph(prob.adj);
if nargin  < 6 || occupancy=="Random"
    prob.occupancy = randi(10, 1, length(prob.adj));
else
    prob.occupancy = occupancy;
end
plot_occupancy(prob.occupancy, prob.coords, prob.axMap); hold(prob.axMap, "on");
if ~isempty(prob.bounds)
    plot_bounds(prob.bounds, prob.axMap);
else
    x = prob.coords(:,1); y = prob.coords(:,2);
    plot(prob.axMap, prob.digr, 'XData',x,'YData',y);
end
grid(prob.axMap, "on");

% Get start,stop,goal points
if nargin < 2  || isempty(start)
    scoords = ginput(1);
    if ~isempty(scoords)
        [start, ~] = dsearchn(prob.coords, scoords);
    end
    if isempty(start)
        start = input("start node (press enter to select via mouse): ");
    end
    prob.start = reshape(start, 1, []);
end
if nargin < 3 || isempty(goal)
    gcoords = ginput;
    if ~isempty(gcoords)
        [goal, ~] = dsearchn(prob.coords, gcoords);
    end
    if isempty(goal)
        goal = input("goal node (press enter to select via mouse): ");
    end
    prob.goal = reshape(goal, 1, []);
end
if length(prob.start) > 1 || length(prob.goal) > 1
    prob.stops = [prob.start, prob.goal];
    prob.probtype = 'unordered';
    prob.allPairsPaths = cell(length(prob.adj));
else
    prob.stops = [];
    prob.probtype = 'ordered';
    prob.postProcessFcn = [];
    prob.allPairsPaths = [];
end

% Normalize matrices
prob.occupancy = prob.occupancy / max(prob.occupancy(:));
prob.adj = prob.adj / max(prob.adj(:));
end