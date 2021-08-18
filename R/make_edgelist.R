#' Make edgelist
#'
#' This function makes edge list from the input (edgelist) data frame.
#' @param data is a dataframe with columns "from" and "to" as well as edge attributes (optional). Edge attribute names may not be the same as any node attribute names.
#' @param edge_attributes (optional) is a vector of column names for any edge attributes. Edge attribute names may not be the same as any node attribute names.
#' @keywords edge
#' @export
#' @examples
#' make_edgelist()

make_edgelist <- function(data, edge_attributes = "") {
  edgelist <- select(data, from, to, any_of(edge_attributes))

  graph <- igraph::graph.data.frame(edgelist, directed = T)


  edgelist$edge_betweenness <- edge_betweenness(graph, e = E(graph) )

  return(edgelist)
}
