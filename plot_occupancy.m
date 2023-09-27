function [contourMatrix, contourObject] = plot_occupancy(occupancy, coords, ax)
state = false;
if nargin>2
    state = ishold(ax);
else
    ax = gca;
end
x=linspace(min(coords(:,1)),max(coords(:,1)),length(coords));
y=linspace(min(coords(:,2)),max(coords(:,2)),length(coords));
[X,Y]=meshgrid(x,y);
F = scatteredInterpolant(coords(:,1),coords(:,2), occupancy');
[contourMatrix, contourObject] = contourf(ax, X,Y,F(X,Y),10,'LineColor','none', 'FaceAlpha', 0.3);
if ~state
    hold(ax,"off");
end
end