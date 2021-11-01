Install this package with 
```
devtools::install_github("judgelord/NetLit")
```

This package provides functions to generate network statistics from a literature review. Specifically, it takes `data` where each row is a proposed relationship ("edges") between two concepts or variables ("nodes"). 

# Basic Usage

The `review()` function takes in a dataframe, `data`, that must include `from` and `to` columns (a directed graph structure). 

The package loads example `data` from [this project on redistricting](https://github.com/judgelord/redistricting).

```
> data
                                       from                                          to                        cites
1                                 computers                       detect gerrymandering       Altman & McDonald 2010
2                                 computers                        public participation       Altman & McDonald 2010
3     legislator information about district floor votes align with district preferences                       Butler
4           number of competitive districts            preserve communities of interest Gimpel & Harbridge-Yong 2020
5                        partisan advantage                             proportionality          Caughey et al. 2017
6                        partisan advantage             number of competitive districts                         <NA>
7                   partisan gerrymandering                              efficiency gap                    Chen 2017
8          preserve communities of interest                         constitutional test          Stephanopoulos 2012
9               mean-median vote comparison                       detect gerrymandering         McDonald & Best 2015
10              mean-median vote comparison                         constitutional test         McDonald & Best 2015
```


`review()` returns a list of 3: 

1. an `edgelist`
2. a `nodelist` augmented with a betweenness score from `igraph::degree()`,
3. `graph`, an 'igraph` object

```
> review(data)
$nodelist
# A tibble: 51 × 3
   node                                        degree betweenness
   <chr>                                        <dbl>       <dbl>
 1 detect gerrymandering                            2         0  
 2 public participation                             1         0  
 3 floor votes align with district preferences      2         0  
 4 preserve communities of interest                 1        96  
 5 proportionality                                  1        18  
 6 number of competitive districts                  4        85.5
 7 efficiency gap                                   3         0  
 8 constitutional test                              2         0  
 9 unconstitutional government interest             1         0  
10 instability                                      1         0  
# … with 41 more rows

$edgelist
                                       from                                          to edge_betweenness
1                                 computers                       detect gerrymandering              1.0
2                                 computers                        public participation              1.0
3     legislator information about district floor votes align with district preferences              1.0
4           number of competitive districts            preserve communities of interest            104.0
5                        partisan advantage                             proportionality             27.0
6                        partisan advantage             number of competitive districts             29.0
7                   partisan gerrymandering                              efficiency gap              5.0
8          preserve communities of interest                         constitutional test              9.0
9               mean-median vote comparison                       detect gerrymandering              1.0
10              mean-median vote comparison                         constitutional test              1.0
11                  partisan gerrymandering        unconstitutional government interest              9.0
12                  partisan gerrymandering                                 instability              9.0
13                  partisan gerrymandering                          elite polarization              3.0
14              majority minority districts          number of minority representatives              1.0
15              majority minority districts             number of competitive districts             13.5
16              majority minority districts                          partisan advantage              8.5
17              majority minority districts                               voter turnout              1.0
18                 redistricting commission                     partisan gerrymandering             22.0
19                  partisan gerrymandering                    partisan donor advantage              9.0
20        change in constituency boundaries                           legislator voting              1.0
21        change in constituency boundaries                        legislative outcomes              1.0
22                          competitiveness                               voter turnout              3.0
23                                  sorting                          elite polarization              1.0
24                               contiguity                          partisan advantage             22.0
25            electorate composition change                        incumbent vote share              1.0
26            electorate composition change                               personal vote              1.0
27        House-Senate Delegation alignment                               pork spending             11.0
28          incumbent's constituents change             number of competitive districts             22.0
29 stability in voters' fellow constituents                        voter sense of place             10.0
30   voter information about their district                                     rolloff              1.0
31   voter information about their district                                voter recall             10.0
32   voter information about their district                         split ticket voting             10.0
33            electorate composition change                campaign resource allocation              1.0
34                    geographic clustering                          partisan advantage             22.0
35         preserve communities of interest    stability in voters' fellow constituents             18.0
36         preserve communities of interest      voter information about their district             27.0
37         preserve communities of interest                                     rolloff              9.0
38          number of competitive districts                          elite polarization              2.5
39                       partisan advantage floor votes align with district preferences              9.0
40                       partisan advantage    floor votes align with state preferences              9.0
41                       partisan advantage                          partisan advantage              0.0
42                       partisan advantage                           legislator voting              9.0
43                       partisan advantage                          elite polarization              3.5
44                       partisan advantage                              efficiency gap              4.0
45                       partisan advantage             number of competitive districts             29.0
46                          proportionality           House-Senate Delegation alignment             20.0
47                              compactness                     minority representation              1.0
48                              compactness                                 compactness              0.0
49                           efficiency gap                              efficiency gap              0.0
50                         equal population                            equal population              0.0
51                 redistricting commission          representation of majority opinion              1.0
52                 redistricting commission                elite ideological moderation              1.0
53                 redistricting commission                             competitiveness              2.0
54                  redistricting by courts                             competitiveness              2.0
55                   upcoming redistricting       legislative majority-seeking behavior              1.0
56                     partisan dislocation                        partisan dislocation              0.0
57                  partisan gerrymandering                          partisan advantage             54.0
58         preserve communities of interest                     partisan gerrymandering             54.0

$graph
IGRAPH d2e2672 DN-- 51 58 -- 
+ attr: name (v/c), degree (v/n), betweenness (v/n), edge_betweenness (e/n)
+ edges from d2e2672 (vertex names):
 [1] computers                            ->detect gerrymandering                      
 [2] computers                            ->public participation                       
 [3] legislator information about district->floor votes align with district preferences
 [4] number of competitive districts      ->preserve communities of interest           
 [5] partisan advantage                   ->proportionality                            
 [6] partisan advantage                   ->number of competitive districts            
 [7] partisan gerrymandering              ->efficiency gap                             
 [8] preserve communities of interest     ->constitutional test                        
+ ... omitted several edges
```

# Additional Features
Optional additional columns in the `data` argument may specify edge attributes (for example, in the example data below, `edge`, `mechanism`, and `cites` and attributes of the proposed relationship between the variables specified in the `to` and `from` columns.  

Node attributes may be specified in an optional `node_attributes` argument. `node_attributes` must be a dataframe with a column `node` with values matching the `to` or `from` columns of the `data` argument.


```
# now with node and edge attributes 
lit <- review(data,
              edge_attributes = c("mechanism", "cites", "cites_empirical", "cite_weight", "cite_weight_empirical"),
              node_attributes = node_attributes
              )
```
