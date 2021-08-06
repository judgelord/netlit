Install this package with 
```
devtools::install_github("judgelord/literature")
```

This package provides functions to generate network statistics from a literature review. Specifically, it takes `data` where each row is a proposed relationship ("edges") between two concepts or variables ("nodes"). 

# Basic Usage

The `review()` function takes in a dataframe, `data`, that must include `from` and `to` columns (a directed graph structure). 

The package loads example `data` from [this project on redistricting](https://github.com/judgelord/redistricting).

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

`review()` returns a list of 2 with an edgelist, and nodelist augmented with a betweenness score from `igraph::degree()`:


```
> review(data)
Dropping 26 rows missing `from` or `to` values
$nodelist
# A tibble: 114 x 2
   node                                                 betweenness
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


# Additional Features
Optional additional columns in the `data` argument may specify edge attributes (for example, in the example data below, `edge`, `mechanism`, and `cites` and attributes of the proposed relationship between the variables specified in the `to` and `from` columns.  

Node attributes may be specified in an optional `node_attributes` argument. `node_attributes` must be a dataframe with a column `node` with values matching the `to` or `from` columns of the `data` argument.

```
> node_attributes
# A tibble: 108 x 2
   node                                           type  
   <chr>                                          <chr> 
 1 goal - Number of competitive districts         goal  
 2 goal - proportionality                         goal  
 3 goal - communities preserved                   goal  
 4 goal - partisan advantage                      goal  
 5 policy - majority minority districts           policy
 6 effect - number of minority representatives    effect
 7 metric - core retention                        metric
 8 effect - legislator information seeking        effect
 9 effect - legislator information about district effect
10 value - historical continuity                  value 
# … with 98 more rows

> literature::review(data, edge_attributes = c("mechanism", "cites"), node_attributes = node_attributes)
Dropping 26 rows missing `from` or `to` values
$nodelist
# A tibble: 114 x 3
   node                                                 type   betweeness
   <chr>                                                <chr>       <dbl>
 1 goal - communities preserved                         goal           10
 2 goal - partisan advantage                            goal            7
 3 goal - proportionality                               goal            7
 4 goal - Number of competitive districts               goal           13
 5 policy - majority minority districts                 policy          4
 6 effect - number of minority representatives          effect          2
 7 goal - proportional minority representation          goal            1
 8 effect - floor votes align with district preferences effect          0
 9 effect - legislator information about district       effect          1
10 effect - legislator information seeking              effect          1
# … with 104 more rows

$edgelist
# A tibble: 150 x 4
   to                   from                 mechanism                                       cites     
   <chr>                <chr>                <chr>                                           <chr>     
 1 goal - communities … metric - compactness "If communities are geographically concentrate… NA        
 2 goal - partisan adv… metric - compactness "Compactness requirements make extreme partisa… NA        
 3 goal - proportional… goal - Number of co… "- Competitiveness increases variance in the p… NA        
 4 goal - Number of co… goal - proportional…  NA                                             NA        
 5 goal - communities … goal - Number of co… "If racial groups or like municipal jurisdicti… NA        
 6 goal - Number of co… goal - communities … "If racial groups or like municipal jurisdicti… NA        
 7 goal - proportional… goal - partisan adv… "A partisan gerrymander aims to diverge from p… Caughey e…
 8 goal - partisan adv… goal - proportional… "Proportionality is inverse to measures of par… NA        
 9 goal - communities … goal - proportional… "If racial groups or municipal jurisdictions h… NA        
10 goal - proportional… goal - communities … "If racial groups or like municipal jurisdicti… NA        
# … with 140 more rows
```
