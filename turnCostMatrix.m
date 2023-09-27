function mat = turnCostMatrix(adj, coords)
% TODO
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
euc = squareform(pdist(coords));
adjTurn = adj; adjTurn(adj>0)=1;
man = distances(digraph(adjTurn));
mat = man / (euc+1e-6);
mat(adj==0) = 0;
mat(isnan(adj)) = NaN;

% digr = digraph(adj);
% mat = zeros(length(adj));
% for i=1:length(adj)
%     paths = shortestpathtree(digr, i,"all",'OutputForm','cell');
%     for j=1:length(paths)
%         [tc, ~] = turnCost(coords(paths{j},:));
%         mat(i,j) = tc;
%     end
% end
end