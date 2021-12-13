
<!-- README.md is generated from README.Rmd. Please edit that file -->

## \# netlit: Augment a literature review with network analysis statistics

`netlit` provides functions to generate network statistics from a
literature review. Specifically, it processes a dataset where each row
is a proposed relationship (“edges”) between two concepts or variables
(“nodes”).

To install `netlit` from CRAN, run the following:

``` r
install.packages("netlit")
```

## Basic Usage

The `review()` function takes in a dataframe, `data`, that includes
`from` and `to` columns (a directed graph structure).

In the example below, we use example data from [this project on
redistricting](https://github.com/judgelord/redistricting). These data
are a set of related concepts (`from` and `to`) in the redistricting
literature and citations for these relationships (`cites` and
`cites_empirical`). See `vignette("netlit")` for more details on this
example.

``` r
library(netlit)

data("literature")

names(literature)
```

    #>  [1] "core"                  "from"                  "edge"                  "to"                    "cites_pre2010"         "cites"                 "cites_empirical"       "mechanism"            
    #>  [9] "cite_weight"           "cite_empirical_weight"

`netlit` offers four functions: `make_edgelist()`, `make_nodelist()`,
`augment_nodelist()`, and `review()`.

`review()` is the primary function (and probably the only one you need).
The others are helper functions that perform the individual steps that
`review()` does all at once. `review()` takes in a dataframe with at
least two columns representing linked concepts (e.g., a cause and an
effect) and returns data augmented with network statistics. Users must
either specify “from” nodes and “to” nodes with the `from` and `to`
arguments or include columns named `from` and `to` in the supplied
`data` object.

`review()` returns a list of three objects:

1.  an augmented `edgelist` (a list of relationships with
    `edge_betweenness` calculated),
2.  an augmented `nodelist` (a list of concepts with `degree` and
    `betweenness` calculated), and
3.  a `graph` object suitable for use in other `igraph` functions or
    other network visualization packages.

Users may wish to include edge attributes (e.g., information about the
relationship between the two concepts) or node attributes (information
about each concept). We show how to do so below. But first, consider the
basic use of `review()`:

``` r
lit <- review(literature, from = "from", to = "to")

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

``` r
head(lit$edgelist)
```

    #>                                from                                                              to edge_betweenness
    #> 1           partisan gerrymandering concentration of likely donors in map-drawing party's districts                2
    #> 2 change in constituency boundaries                                    individual legislator voting                1
    #> 3 change in constituency boundaries                                            legislative outcomes                1
    #> 4 change in constituency boundaries                                         effect of personal vote                1
    #> 5                       compactness                                              partisan advantage               12
    #> 6                   competitiveness                                                   voter turnout                1

``` r
head(lit$nodelist)
```

    #>                                  node degree betweenness
    #> 1             partisan gerrymandering      1           4
    #> 2   change in constituency boundaries      0           0
    #> 3                         compactness      2           0
    #> 4                     competitiveness      0           0
    #> 5                           computers      0           0
    #> 6 demographic and ideological sorting      0           0

Edge and node attributes can be added using the `edge_attributes` and
`node_attributes` arguments. `edge_attributes` is a vector that
identifies columns in the supplied data frame that the user would like
to retain. `node_attributes` is a separate dataframe that contains
attributes for each node in the primary data set. The example
`node_attributes` data include one column `type` indicating a type for
each each node/variable/concept.

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
              edge_attributes = names(literature), # c("cites", "cites_empirical"),
              node_attributes = node_attributes)

lit
```

    #> A netlit_review object with the following components:
    #> 
    #> $edgelist
    #>  - 69 edges
    #>  - edge attributes: core, edge, cites_pre2010, cites, cites_empirical, mechanism, cite_weight, cite_empirical_weight, edge_betweenness
    #> $nodelist
    #>  - 69 nodes
    #>  - node attributes: type, degree, betweenness
    #> $graph
    #>    an igraph object

``` r
head(lit$edgelist)
```

    #>                                from                                                              to core               edge cites_pre2010                                          cites
    #> 1           partisan gerrymandering concentration of likely donors in map-drawing party's districts   NA          increases          <NA>                                  Kirkland 2013
    #> 2 change in constituency boundaries                                    individual legislator voting   NA no effect, effects          <NA>      Bertelli & Carson 2011, Hayes et al. 2010
    #> 3 change in constituency boundaries                                            legislative outcomes   NA            effects          <NA> Bertelli & Carson 2011, Gul & Pesendorfer 2010
    #> 4 change in constituency boundaries                                         effect of personal vote   NA          decreases          <NA>                         Bertelli & Carson 2011
    #> 5                       compactness                                              partisan advantage   NA          increases          <NA>                             Chen & Rodden 2013
    #> 6                   competitiveness                                                   voter turnout   NA          no effect          <NA>                       Moskowitz & Schneer 2019
    #>                             cites_empirical
    #> 1                             Kirkland 2013
    #> 2 Bertelli & Carson 2011, Hayes et al. 2010
    #> 3                    Bertelli & Carson 2011
    #> 4                                      <NA>
    #> 5                        Chen & Rodden 2013
    #> 6                  Moskowitz & Schneer 2019
    #>                                                                                                                                                                                                                                                                                                                                mechanism
    #> 1                                                                                          Parties care about other resources in addition to votes, such as donations. They can use redistricting to concentrate likely donors into their districts and remove them from opponents' districts, thus increasing their odds of reelection.
    #> 2 Bertelli and Carson argue that partisan gerrymandering is a form of risk-sharing, in which individual members do not have to radically change their positions while maintaining their odds of reelection. In contrast, Hayes et al. say that legislators respond to the demographic changes of their constituency after redistricting.
    #> 3                          Bertelli & Carson: Partisan gerrymandering helps the majority party achieve its policy goals by increasing the odds of electoral success without requiring much sacrifice by individual members. Gul & Pesendorfer: use formal theory to show that policy outcomes are biased towards the redistricting party
    #> 4                                                                                                                                                                                               When new voters are added to an incumbent's district, that incumbent's personal characteristics play less of a role in their reelection.
    #> 5                                                                                                                                                                                                           Democrats' concentration in cities leads to a Republican bias, due to the geographic, majoritarian nature of U.S. elections.
    #> 6                                            Residents of competitive districts systematically differ from those in non-competitive districts, leading cross-sectional studies to erroneously find a relationship between competitiveness and turnout. In addition, most voters aren't aware of the competitiveness of their House race.
    #>   cite_weight cite_empirical_weight edge_betweenness
    #> 1           1                     1                2
    #> 2           1                     1                1
    #> 3           1                     1                1
    #> 4           1                     0                1
    #> 5           1                     1               12
    #> 6           1                     1                1

``` r
head(lit$nodelist)
```

    #>                                  node      type degree betweenness
    #> 1             partisan gerrymandering      <NA>      1           4
    #> 2   change in constituency boundaries      <NA>      0           0
    #> 3                     competitiveness      <NA>      0           0
    #> 4                           computers      <NA>      0           0
    #> 5 demographic and ideological sorting condition      0           0
    #> 6       dispersed minority population condition      0           0
