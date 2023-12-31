function plot_bounds(bounds, ax)
%Plot walls/boundaries in map.
% bounds is a cell array of {x,y,x1,y1,...} coordinates of bounds
state = false;
if nargin>1
    state = ishold(ax);
else
    ax = gca;
end

for i=1:2:length(bounds)
    % l = plot(ax, bounds{i}, bounds{i+1}, 'LineWidth', 2); hold(ax, "on");
    fill(ax, bounds{i}, bounds{i+1}, [1, 0.6, 0], ...
        'FaceAlpha', 0.9, 'LineWidth', 1); hold(ax, "on");
end

if ~state
    hold(ax,"off");
end
end