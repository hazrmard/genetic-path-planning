# layouts

This folder defines different floor layouts. Layouts are matlab functions with the signature:

```matlab
function [adj, coords, bounds] = l1()
```

Where:

`adj` is the `n x n` adjacency matrix.

`coords` is a `n x 2` matrix of coordinates.

`bounds` is an optional cell array of coordinates of obsstacles for visualization only. It is a sequence of x/y coordinates `{[x1],[y1],[x2],[y2],...}`

Layouts can be called by specifying the function name as a string when `getProb()` is called. Two layouts can be combined by using "+", like `"l1+l1"`.