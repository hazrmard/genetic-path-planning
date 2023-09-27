function [adj, coords, bounds] = random_layout(n)
%RANDOM_LAYOUT Summary of this function goes here
%   Detailed explanation goes here
if nargin==0
    n = 6;
end
adj = zeros(n);
adj(randperm(n^2,ceil(n^2/2))) = 1;
fig = figure();
pl = plot(digraph(adj), 'Layout', 'force');
x = pl.XData; y = pl.YData;
close(fig);
coords = [x', y'];
bounds = [];
end

