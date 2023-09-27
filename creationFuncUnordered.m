function population = creationFuncUnordered(opts, prob)
% Creates a cell array of different orders of stopping points.
% Each population member has the same initial gene (starting point)
    population = cell(opts.PopulationSize, 1);
    for i=1:opts.PopulationSize
        order = randperm(length(prob.stops)-1);
        population{i,1} = [prob.stops(1), prob.stops(order+1)];
    end
end