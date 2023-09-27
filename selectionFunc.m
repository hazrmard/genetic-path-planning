function [parents, fitnessVals] = selectionFunc(population, fitnessVals, num)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
weights = max(fitnessVals) + 1e-6 - fitnessVals; % ensure positive
weights = (weights+1e-6) / (sum(weights) + 1e-6); % ensure normalized
[parents, idx] = datasample(population, num, 'Replace', false, 'Weights', weights);
fitnessVals = fitnessVals(idx);
end