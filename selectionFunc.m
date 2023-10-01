function [parents, fitnessVals] = selectionFunc(population, fitnessVals, num)
%Select a subset of parents from the population.
%Given a cell array of population members, and their corresponding fitness
%values, and the number of desired parents, sample parents with probability
%proportional to their fitness value. Return the cell array of parents and
%the fitness values.
weights = max(fitnessVals) + 1e-6 - fitnessVals; % ensure positive
weights = (weights+1e-6) / (sum(weights) + 1e-6); % ensure normalized
[parents, idx] = datasample(population, num, 'Replace', false, 'Weights', weights);
fitnessVals = fitnessVals(idx);
end