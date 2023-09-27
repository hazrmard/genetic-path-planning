function prob = getAdjDigraphCoords(isRnd, start, goal, verbose, axMap)
% Create the `prob` structure used by GAVariable for genetic search.
% The `prob` struct defines additional variables/functions needed on top of
% optimoptions function that Matlab's default GA function uses.

if nargin==0
    isRnd = input("Set size of random graph (for hard-coded example press enter): ");
end
if isempty(isRnd)
    isRnd = "l1";
end
if nargin < 4
    % Unless verbose is explicitly specified, assume verbose:
    verbose = true;
end
if verbose
    interval = 0.2;
    highlightn = 10;
    if nargin < 5
        axMap = gca;
    end
else
    interval = 0.;
    highlightn = 0;
end

% figMap = gcf;

% Get floor map
if isstring(isRnd)
    layouts = split(isRnd, '+');
    func = str2func(layouts{1});
    [points, bounds] = func();
    [adj, coords] = to_graph(points);x
    for i=2:length(layouts)
        func = str2func(layouts{i});
        [pointsi, boundsi] = func();
        [adji, coordsi] = to_graph(pointsi);
        [adj, coords, bounds] = combine_layout(adj, coords, bounds, adji, coordsi, boundsi, length(adj), 1);
    end
    x = coords(:,1); y = coords(:,2);
    digr = digraph(adj);
    % dist = distances(digr);
    occupancy = randi(10, 1, length(adj));
    plot_occupancy(occupancy, coords, axMap); hold(axMap, "on");
    if ~isempty(bounds)
        plot_bounds(bounds, axMap);
        pl = [];
    else
        pl = plot(axMap, digr, 'XData',x,'YData',y);
    end
    grid(axMap, "on");
else
    if isRnd > 0
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
    % dist = distances(digr);
    pl = plot(axMap, digr, 'Layout', 'force');
    grid(axMap, "on");
    x = pl.XData; y = pl.YData;
    coords = [x, y];
    occupancy = randi(10, 1, length(adj));
    plot_occupancy(occupancy, coords, axMap); hold(axMap, "on");
end

% Get start,stop,goal points
if nargin < 2  || isempty(start)
    scoords = ginput(1);
    if ~isempty(scoords)
        [start, ~] = dsearchn(coords, scoords);
    end
    if isempty(start)
        start = input("start node (press enter to select via mouse): ");
    end
    start = reshape(start, 1, []);
end
if nargin < 3 || isempty(goal)
    gcoords = ginput;
    if ~isempty(gcoords)
        [goal, ~] = dsearchn(coords, gcoords);
    end
    if isempty(goal)
        goal = input("goal node (press enter to select via mouse): ");
    end
    goal = reshape(goal, 1, []);
end
if length(start) > 1 || length(goal) > 1
    stops = [start, goal];
    probtype = 'unordered';
    postProcess = @postProcessFunc;
    allPairsPaths = cell(length(adj));
else
    stops = [];
    probtype = 'ordered';
    postProcess = [];
    allPairsPaths = [];
end

% The occupancy cost of each node
cmap = jet(10);
if ~isempty(pl)
    markerSize = 2 + (occupancy / max(occupancy)) * (pl.MarkerSize);
    pl.MarkerSize = markerSize;
    nodeColor = cmap(occupancy, :);
    pl.NodeColor = nodeColor;
end

% if ~verbose
%     close(figMap);
% end

% Normalize matrices
occupancy = occupancy / max(occupancy(:));
adj = adj / max(adj(:));


% Create final problem object
prob = struct('probtype', probtype, 'N', length(adj),...
    'adj', adj, 'digr', digr, 'coords', coords, ...
    'pl', pl, 'axMap', axMap, 'start', start, 'goal', goal, 'stops', stops,...
    'verbose', verbose, 'interval', interval, 'highlightn', highlightn,...
    'occupancy', occupancy, 'postProcessFcn', @postProcessUnordered);
prob.bounds = bounds;
prob.allPairsPaths = allPairsPaths;
prob.costMatrix = nan(prob.N);
end