function [post, prob] = postProcessUnordered(population, prob)
%This function looks through a population of orderings, and filters
%orderings where a later point is already traversed in the shortest path
%between two earlier points. For example, if the shortest path from a->b
%traverses c, then the optimal ordering is a,c,b. So, if an ordering is
%found such as a,b,c, it is removed from the population.
    post = {};
    for i=1:length(population)
        ordering = population{i,1};
        % Find optimal paths between consecutive stopping points in
        % ordering
        nodes_repeat = false;
        for j=1:length(ordering)-1
            a = ordering(j); b = ordering(j+1);
            if isempty(prob.allPairsPaths{a,b})
                [path, ~, ~] = AStar(a, b, prob.fitness_local, prob.adj);
                prob.allPairsPaths{a,b} = path;
            else
                path = prob.allPairsPaths{a,b};
            end
            nodes_repeat = nodes_repeat || isempty(intersect(path, ordering(j+1:end)));
        end
        if ~nodes_repeat
            post = [post; ordering];
        end
    end
end