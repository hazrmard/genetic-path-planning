function chromosome = mutationFuncUnordered(chromosome)
%Mutates one pair of genes in the chromosome. The two genes swap places.
% The first gene is kept the same (static starting point).
idx = datasample(2:length(chromosome),2,'Replace', false);
x = chromosome(idx(1));
chromosome(idx(1)) = chromosome(idx(2));
chromosome(idx(2)) = x;
end