function[adj, coords, bounds] = l2()
% 2 floor duplicate of l1, 2 elevators, side by side
%L2 layout. Each layout is a function that returns the adjacency matrix,
%the coordinates of each node/vertex, and optionally the bounds of
%obstacles (for visualization). Bounds is a cell array of polygon
%coordinates of walls/pillars etc {[x1],[y1],[x2],[y2],...}
[adj1, coords1, bounds1] = l1();
[adj2, coords2, bounds2] = l1();

[adj, coords, bounds] = combine_layout(adj1, coords1, bounds1, adj2, coords2, bounds2, 66, 1);
end

