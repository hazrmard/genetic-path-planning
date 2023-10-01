function pop = creationFuncRnd(prob)
%populationFunc creates an initial population for the graph
% Author: Ibrahim Ahmed
pop = cell(prob.PopulationSize,1);
nodes = 1:length(prob.adj);
i = 1;
while i <= prob.PopulationSize
    steps = 1;
    path = [prob.start,];
    reached = false;
    while (steps <= height(prob.digr.Nodes)^2)
        steps = steps + 1;
        candidates = nodes(prob.adj(path(end),:)>0);
        if isempty(candidates)
            break
        end
        node = candidates(randi(length(candidates), 1));
        path = [path, node];
        if (node==prob.goal)
            reached = true;
            break
        end
    end
    if reached
        j = 1;
        while j<length(path)
            curr = path(j);
            nextidx = j + find(path(j+1:end)==curr,1,"last");
            if ~isempty(nextidx)
                path = [path(1:j), path(nextidx+1:end)];
            end
            j = j+1;
        end
        if ~isempty(path)
            pop{i,1} = path;
            i = i+1;
        end
    end
end
end