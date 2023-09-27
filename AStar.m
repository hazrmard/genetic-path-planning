function [path, totalCost, timeTaken] = AStar(start, goal, cost_func, adj)
    tic;
    numNodes = size(adj, 1);
    % g(node) is cost to go from start to current node
    g = inf(1, numNodes); % Initialize g(n) values
    g(start) = 0;
    % h(node) is heuristic from current node to goal:
    % if heuristic is 0, A*==Dijkstra's algorithm
    h = zeros(1, numNodes); % Initialize h(n) values
    
    openList = [start,]; % Priority queue for open nodes
    openF = [g(start) + h(start),]; % corresponding fitness values
    
    parent = zeros(1, numNodes); % Parent array to reconstruct path
    
    while ~isempty(openList)
        [currentF, idx] = min(openF);
        currentNode = openList(idx);
        % [currentNode, idx] = min(openList);
        % currentF = openF(idx);
        openList(idx) = [];
        openF(idx) = [];
        
        path = reconstructPath(parent, currentNode);
        totalCost = g(currentNode);
        if currentNode == goal
            timeTaken = toc;
            return;
        end
        
        % If cost(i,j) is 0, it means it is not possible
        neighbors = find(adj(currentNode, :) > 0);
        for i = 1:length(neighbors)
            neighbor = neighbors(i);
            
            tentativeG = cost_func([path, neighbor]);
            
            if tentativeG < g(neighbor)
                parent(neighbor) = currentNode;
                g(neighbor) = tentativeG;
                fValue = g(neighbor) + h(neighbor);
                if ~any(openList==neighbor)
                    openList = [neighbor, openList];
                    openF = [fValue, openF];
                end
            end
        end
    end
    
    % No path found
    path = [];
    totalCost = -1;
    timeTaken = toc;
end

function path = reconstructPath(parent, goal)
    path = [];
    node = goal;
    while node > 0
        path = [node, path];
        node = parent(node);
    end
end

