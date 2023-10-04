# genetic path planning

This repository contains Matlab code for using Genetic Search with A* search for robotic path planning.

Given an unordered list of stopping points, a cost function, and a floor plan, an optimal list of stops is calculated using genetic search.

This repository provides two endpoints: A GUI application, and a function. THe application can be downloaded and installed from the [Releases Page](https://github.com/hazrmard/genetic-path-planning/releases).

![](./static/App_Screenshot.png)

For example use of the functional interface, see [ga_unordered](./ga_unordered.m).

## Usage

```matlab

% Get the problem specification (start, goal points, genetic operators)
prob = getProb();

% Set the local fitness function.
% The local fitness function is the cost of individual paths between two
% stop points. Lower is better. The following is the default implementation:
% This is the general signature:
prob.fitness_local = @(array containing ordering of stop points) (fitness value)

% Set the global fitness function. Lower is better. This is the fitness of the sequence of stopping points.
% The signature is
fitness = @(array of stop points, prob) (fitness value, prob)

% Run the genetic search:
[stops, cost, timeTaken, prob] = GAVariable(prob, fitness);
```