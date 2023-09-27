function[adj, coords, bounds] = l2()
% 2 floor duplicate of l1, 2 elevators, side by side
% use mapMaze to make different floor plans
[adj1, coords1, bounds1] = l1();
[adj2, coords2, bounds2] = l1();

[adj, coords, bounds] = combine_layout(adj1, coords1, bounds1, adj2, coords2, bounds2, 66, 1);
end

