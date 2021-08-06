Install this package with 
```
devtools::install_github("judgelord/literature")
```

This package provides functions to generate network statistics from a literature review. Specifically, it takes `data` where each row is a proposed relationship ("edges") between two concepts or variables ("nodes"). The `data` argument must include columns `from` and `to` (a directed graph structure). Additional columns in the `data` argument may specify edge attributes (for example, in the example data below, `edge`, `mechanism`, and `cites` and attributes of the proposed relationship between the variables specified in the `to` and `from` columns.  


The package should load example `data` from [this project on redistricting](https://github.com/judgelord/redistricting)

```
> data
# A tibble: 176 x 6
   from         edge                     to          mechanism                  cites   cites_empirical
   <chr>        <chr>                    <chr>       <chr>                      <chr>   <chr>          
 1 metric - co… "Parabolic (but positiv… goal - com… "If communities are geogr… NA      NA             
 2 metric - co… "Parabolic, but negativ… goal - par… "Compactness requirements… NA      NA             
 3 goal - Numb… "increases (mean) but m… goal - pro… "- Competitiveness increa… NA      NA             
 4 goal - prop… "decreases. Ensuring pr… goal - Num…  NA                        NA      NA             
 5 goal - Numb… "decreases if cor(party… goal - com… "If racial groups or like… NA      NA             
 6 goal - comm… "decreases"              goal - Num… "If racial groups or like… NA      NA             
 7 goal - part… "decreases"              goal - pro… "A partisan gerrymander a… Caughe… NA             
 8 goal - prop… "decreases"              goal - par… "Proportionality is inver… NA      NA             
 9 goal - prop… "increases in expectati… goal - com… "If racial groups or muni… NA      NA             
10 goal - comm… "increases in expectati… goal - pro… "If racial groups or like… NA      NA             
# … with 166 more rows
```

`literature::review` returns a list of 2 with an edgelist, and nodelist augmented with a betweenness score from `igraph::degree()`


```
> literature::review(data)
Dropping 26 rows missing `from` or `to` values
$nodelist
# A tibble: 114 x 2
   node                                                 betweeness
   <chr>                                                     <dbl>
 1 goal - communities preserved                                 10
 2 goal - partisan advantage                                     7
 3 goal - proportionality                                        7
 4 goal - Number of competitive districts                       13
 5 policy - majority minority districts                          4
 6 effect - number of minority representatives                   2
 7 goal - proportional minority representation                   1
 8 effect - floor votes align with district preferences          0
 9 effect - legislator information about district                1
10 effect - legislator information seeking                       1
# … with 104 more rows

$edgelist
# A tibble: 150 x 2
   to                                     from                                  
   <chr>                                  <chr>                                 
 1 goal - communities preserved           metric - compactness                  
 2 goal - partisan advantage              metric - compactness                  
 3 goal - proportionality                 goal - Number of competitive districts
 4 goal - Number of competitive districts goal - proportionality                
 5 goal - communities preserved           goal - Number of competitive districts
 6 goal - Number of competitive districts goal - communities preserved          
 7 goal - proportionality                 goal - partisan advantage             
 8 goal - partisan advantage              goal - proportionality                
 9 goal - communities preserved           goal - proportionality                
10 goal - proportionality                 goal - communities preserved          
# … with 140 more rows
```
