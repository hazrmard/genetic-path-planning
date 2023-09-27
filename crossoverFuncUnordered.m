function kids = crossoverFuncUnordered(parents, fitnessVals, nKids)
% For each member of the parents population,
% Takes a segment from the chromosme, and reverses it.
% The first gene in the chromosome is not changed (static starting point).
    kids = cell(nKids, 1);
    for i=1:nKids
        p = randi(length(parents));
        parent = parents{p, 1};
        i1 = 1 + randi(length(parent)-2);
        i2 = i1 + randi(length(parent)-i1);
        child = parent;
        child(i1:i2) = fliplr(child(i1:i2));
        kids{i,1} = child;
    end
end