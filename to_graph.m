function [G, coords] = to_graph(points)
%convert an array of structs of form `struct ('location',[],
%'connected',[])` into an adjacency matrix and the array of coordinates.
% The array of structs is returned by functions in the 'layouts' directory
n = length(points);
G = zeros(n);
coords = zeros([n,2]);
for i=1:n
    pt = points(i);
    coords(i,:) = pt.location;
    for j=1:length(pt.connected)
        dist = norm(pt.location - points(pt.connected(j)).location);
        G(i,pt.connected(j)) = dist;
    end
end
end