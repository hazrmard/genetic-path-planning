function [path, totalCost, timeTaken, prob] = GAVariable(opts, prob, fitness)
%GAVariable - Genetic Search with variable length chromosomes

% Create initial population
ticPop = tic;
population = opts.CreationFcn(opts, prob);
tocPop = toc(ticPop);

avgFitness = nan(opts.MaxGenerations, 1);
fitnessVals = zeros(length(population), 1);
for i=1:length(fitnessVals)
    [fitnessVals(i), prob] = fitness(population{i}, prob);
end
avgFitness(1) = mean(fitnessVals);
minFitness = [min(fitnessVals)];
if prob.verbose
    % figPlot = figure();
    % pl1 = subplot(2,1,1); title(pl1, sprintf("Gen %d population fitness", 0)); xlabel("Population");
    % pl2 = subplot(2,1,2); title(pl2, "Average/min fitness over generation"); xlabel("Generation");
    % l1 = bar(pl1, fitnessVals);
    % l2 = plot(pl2, avgFitness); hold on;
    % l3 = plot(pl2, minFitness); hold off;

    lines = [];
    hold(prob.axMap, 'on');
    for j=1:prob.highlightn
        pathj = population{j,1};
        xj = prob.coords(pathj, 1);
        yj = prob.coords(pathj, 2);
        l = plot(prob.axMap, xj, yj);
        lines = [lines, l];
    end
    prob.lines = lines;
end

timeSearch = 0.;
% if prob.verbose
%     disp("Press any key "); pause;
% end
%%
for gen = 1:opts.MaxGenerations
    ticSearch = tic;

    [fitnessVals, idx] = sort(fitnessVals);
    population = population(idx,1);

    % Elitism
    % for i=1:opts.EliteCount
    %     population{i,1} = parents{i,1};
    % end

    % Selection
    [parents, pfitnessVals] = opts.SelectionFcn(population, fitnessVals, opts.PopulationSize);

    % Crossover
    nKids = ceil((opts.PopulationSize - opts.EliteCount) * opts.CrossoverFraction);
    kids = opts.CrossoverFcn(parents, pfitnessVals, nKids);
    for i=1:nKids
        population{opts.EliteCount+i,1} = kids{i, 1};
    end

    % Mutation
    nMut = opts.PopulationSize - nKids - opts.EliteCount;
    if (nMut > 0) && (~isempty(opts.MutationFcn))
        idx = randi(opts.PopulationSize, nMut);
        for i=1:nMut
            population{opts.EliteCount+nKids+i,1} = opts.MutationFcn(parents{idx(i),1});
        end
    end

    % Post process
    if ~isempty(prob.postProcessFcn)
        [population, prob] = prob.postProcessFcn(population, prob);
    end

    % score population
    for i=1:length(fitnessVals)
        [fitnessVals(i), prob] = fitness(population{i,1}, prob);
    end
    
    avgFitness(gen) = mean(fitnessVals);
    minFitness = [minFitness, min(fitnessVals)];
    tocSearch = toc(ticSearch);
    timeSearch = timeSearch + tocSearch;

    % Untimed operations in loop
    if prob.verbose
        % Metrics figure
        % set(l1, 'XData', 1:length(fitnessVals), 'YData', fitnessVals);  title(pl1, sprintf("Gen %d population fitness", gen));
        % set(l3, 'XData', 1:length(minFitness), 'YData', minFitness);
        % set(l2, 'XData', 1:opts.MaxGenerations, 'YData', avgFitness);
        % Graph map figure
        % Plot population
        for j=1:prob.highlightn
            pathj = population{j,1};
            xj = prob.coords(pathj, 1);
            yj = prob.coords(pathj, 2);
            set(prob.lines(j), 'XData', xj, 'YData', yj);
        end
        pause(prob.interval);
    end
end

[totalCost, idx] = min(fitnessVals);
path = population{idx,1};
timeTaken = timeSearch + tocPop;
end