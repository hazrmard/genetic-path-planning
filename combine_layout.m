function [adj, coords, bounds] = combine_layout(adj1, coords1, bounds1, adj2, coords2, bounds2, via1, via2)
% Combine two floor plans, given their adjacency matrices and node
% coordinates, and the node connecting from one to another.
s1 = length(adj1);
s2 = length(adj2);
adj = zeros(s1+s2);
adj(1:s1,1:s1) = adj1;
adj(s1+1:end, s1+1:end) = adj2;
% Set distance between connecting points to 1
adj(via1, via1+via2) = 1;
adj(via1+via2, via1) = 1;
coords = [coords1; coords2];
max_coord = max(coords1);
coords(s1+1:end,:) = coords(s1+1:end, :) + max_coord;
if ~isempty(bounds1) && ~isempty(bounds2)
    for i=1:2:length(bounds2)
        bounds2{i} = bounds2{i} + max_coord(1);
        bounds2{i+1} = bounds2{i+1} + max_coord(2);
    end
    bounds = [bounds1, bounds2];
else
    bounds = {};
end
end

