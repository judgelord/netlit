Install this package with 
```
devtools::install_github("judgelord/NetLit")
```

This package provides functions to generate network statistics from a literature review. Specifically, it takes `data` where each row is a proposed relationship ("edges") between two concepts or variables ("nodes"). 

# Basic Usage

The `review()` function takes in a dataframe, `data`, that must include `from` and `to` columns (a directed graph structure). 

The package loads example `data` from [this project on redistricting](https://github.com/judgelord/redistricting).

[insert example data]

`review()` returns a list of 2 with an edgelist, and nodelist augmented with a betweenness score from `igraph::degree()`:

[insert example output]

# Additional Features
Optional additional columns in the `data` argument may specify edge attributes (for example, in the example data below, `edge`, `mechanism`, and `cites` and attributes of the proposed relationship between the variables specified in the `to` and `from` columns.  

Node attributes may be specified in an optional `node_attributes` argument. `node_attributes` must be a dataframe with a column `node` with values matching the `to` or `from` columns of the `data` argument.


[insert example output]

