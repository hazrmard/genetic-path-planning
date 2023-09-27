function [cost, heading] = turnCost(coords, init_heading)
% Get total change in heading (degrees) from traversing nodes
% max turn cost is 180 * num nodes, assuming the nodes are in a zig-zag
% pattern and the starting heading is 180 away from initial vector
if nargin==1
    init_heading = 0;
end
cost = 0;
heading = init_heading;
for i=1:length(coords)-1
    vec = coords(i+1, :) - coords(i, :);
    ang = atan(vec(1)/vec(2)) * 180 / pi;
    if vec(2) < 0
        if vec(1) < 0
            ang = -90 - ang; % 3rd quadrant
        else
            ang = 180 + ang; % 2nd quadrant
        end
    end
    % no change needed in 1st, 4th quadrant
    delta = mod(abs(ang-heading), 180);
    cost = cost + delta;
    heading = ang;
end
end