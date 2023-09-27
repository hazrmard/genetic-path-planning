function total_cost = costFunc(path, adj, start, goal, coords, occupancy,...
    init_heading, wdist, wturn, wcong)
%costFunc Cost of traversing the path so far. No penalty for not reaching
%goal. `path` is entire path, including start and goal nodes.
total_cost = 0;
heading = init_heading;
% TODO: don't recalculate these factors at every call. Perhaps adj,
% occupancy matrices, and turnCost func can be pre-normalized?
max_turn_cost = 180;
max_occupancy_cost = max(occupancy(:));
max_dist_cost = max(adj(:));

if length(path) < 2
    total_cost = nan;
    return;
end
for i = 1:length(path)-1
    segment = adj(path(i),path(i+1));
    % If a valid edge:
    if segment > 0
        dist_cost = segment;
        [turn_cost, heading] = turnCost(coords(path(i:i+1), :), heading);
        occupancy_cost = occupancy(path(i+1));
        cost = wdist * dist_cost / max_dist_cost + ...
               wturn * turn_cost / max_turn_cost + ...
               wcong * occupancy_cost / max_occupancy_cost;
    % If invalid edge, add cost to next node in path
    else
        total_cost = inf;
        break;
    end
    total_cost = total_cost + cost;
end
end