function kids = crossoverFunc(parents, fitnessVals, nKids)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% See: order-based permutations for cross-overs in travelling salesman like
% problems.
kids = cell(nKids, 1);
k=1;
ntries = 0;
while k <= nKids && ntries < length(parents) ^ 2
    ntries = ntries + 1;
    % weights = max(fitnessVals) - fitnessVals;
    % weights = (weights+1e-6) / (sum(weights) + 1e-6);
    % ps = datasample(1:length(parents), 2, 'Replace', false, 'Weights', weights);
    % p1 = idx(ps(1)); p2 = idx(ps(2));
    ps = datasample(1:length(parents), 2, 'Replace', false);
    p1 = ps(1); p2 = ps(2);
    pi = parents{p1}; pj = parents{p2};
    intersections = intersect(pi, pj);
    if isempty(intersections)
        continue
    % if there are intersections:
    else
        point = intersections(randi(length(intersections),1));
        pointi = find(pi==point, 1);
        pointj = find(pj==point, 1);
        kids{k} = [pi(1:pointi), pj(pointj+1:end)];
        k = k+1;
        if (k>=nKids)
            break
        end
        kids{k} = [pj(1:pointj), pi(pointi+1:end)];
        k = k+1;
    end

end

end