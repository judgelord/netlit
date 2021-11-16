
<!-- README.md is generated from README.Rmd. Please edit that file -->

## \# netlit: Augment a literature review with network analysis statistics

`netlit` provides functions to generate network statistics from a
literature review. Specifically, it process a dataset where each row is
a proposed relationship (“edges”) between two concepts or variables
(“nodes”).

To install `netlit` from CRAN, run the following:

``` r
install.packages("netlit")
```

## Basic Usage

The `review()` function takes in a data frame, `data`, that includes
`from` and `to` columns (a directed graph structure).

In the example below, we use example data from [this project on
redistricting](https://github.com/judgelord/redistricting). See
`vignette("netlit")` for more details on this example.

``` r
library(netlit)

data("literature")

names(literature)
```

    #>  [1] "core"                  "from"                  "edge"                  "to"                    "cites_pre2010"         "cites"                 "cites_empirical"       "mechanism"            
    #>  [9] "cite_weight"           "cite_empirical_weight"

The four functions `netlit` offers are `make_edgelist()`,
`make_nodelist()`, `augment_nodelist()`, and `review()`. `review()` is
the primary function (and probably the only one you need), and the
others are helper functions that perform the individual steps that
`reviews()` all at once. `review()` takes in a data set with a `from`
column, a `to` column, and possibly edge attributes and returns a data
structure that includes the inputs augmented with network statistics and
an `igraph` graph that can be plotted using functionality in `igraph` or
other network visualization packages. We demonstrate `review()` below:

``` r
lit <- review(literature)

lit
```

    #> A netlit_review object with the following components:
    #> 
    #> $edgelist
    #>  - 69 edges
    #>  - edge attributes: edge_betweenness
    #> $nodelist
    #>  - 69 nodes
    #>  - node attributes: degree, betweenness
    #> $graph
    #>    an igraph object

Edge and node attributes can be added as well using the
`edge_attributes` and `node_attributes` arguments. `edge_attributes`
identifies the column in the data set that correspond to edge
attributes, and `node-attributes` is a separate dataset contain
attributes for each node in the primary data set.

``` r
data("node_attributes")

head(node_attributes)
```

    #>                                                                  node   type
    #> 1 alignment of floor vote breakdown with statewide majority of voters effect
    #> 2                                              bipartisan gerrymander policy
    #> 3                                        campaign resource allocation   <NA>
    #> 4                                                   campaign spending effect
    #> 5                                                   candidate quality effect
    #> 6                                   change in constituency boundaries   <NA>

``` r
lit <- review(literature,
              edge_attributes = c("mechanism", "cites"),
              node_attributes = node_attributes)

lit
```

    #> A netlit_review object with the following components:
    #> 
    #> $edgelist
    #>  - 69 edges
    #>  - edge attributes: cites, mechanism, edge_betweenness
    #> $nodelist
    #>  - 69 nodes
    #>  - node attributes: type, degree, betweenness
    #> $graph
    #>    an igraph object
