function prob = make_prob()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
prob = struct( ...
    'probtype', [],...
    'N', [],...
    'adj', [], ...
    'digr', [], ...
    'coords', [], ...
    'figMap', [],...
    'pl', [], ...
    'axMap', [], ...
    'start', [], ...
    'goal', [], ...
    'stops', [],...
    'verbose', [], ...
    'interval', [], ...
    'highlightn', [],...
    'occupancy', [], ...
    'postProcessFcn', [],...
    'bounds', [],...
    'allPairsPaths', []);
end