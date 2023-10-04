function [contourMatrix, contourObject] = plot_occupancy(occupancy, coords, ax, bounds)
% Create a contour map representing node congestion/occupancy on the floor
% map.
state = false;
if nargin>2
    state = ishold(ax);
else
    ax = gca;
end
min_x = min(coords(:,1));
max_x = max(coords(:,1));
min_y = min(coords(:,2));
max_y = max(coords(:,2));
if nargin >= 4
    for i=1:2:length(bounds)
        min_x = min([min_x, bounds{i}]);
        max_x = max([max_x, bounds{i}]);
    end
    for i=2:2:length(bounds)
        min_y = min([min_y, bounds{i}]);
        max_y = max([max_y, bounds{i}]);
    end
end
x=linspace(min_x, max_x, length(coords));
y=linspace(min_y,max_y,length(coords));
[X,Y]=meshgrid(x,y);
% Create interpolating functon F, with known occupancy values at coords
F = scatteredInterpolant(coords(:,1),coords(:,2), occupancy');
% Then use the function to make a heatmap over the whole floor plan. This
% is for visualization only. During calculation, the occupancy value of the
% nodes is considered only, not interpolated values between nodes.
[contourMatrix, contourObject] = contourf( ...
    ax, X,Y,F(X,Y),10, ...
    'LineColor','none', 'FaceAlpha', 0.3);
if ~state
    hold(ax,"off");
end
end