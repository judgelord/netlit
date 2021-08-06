#' Augment nodelist and edgelist with igraph network statisitics
#'
#' This function augments the node list with outputs from the igraph package.
#' @param edgelist is a dataframe with columns "from" and "to" as well as edge attributes (optional). Edge attribute names may not be the same as any node attribute names.
#' @param nodelist is a dataframe with columns "node" as well as any node attributes. Node attribute names may not be the same as any edge attribute names.
#' @keywords node
#' @export
#' @examples
#' augment_nodelist()

augment_nodelist <- function(nodelist, edgelist){

  # calculate node attributes from network structure
  graph <- igraph::graph.data.frame(edgelist, directed = T)
  degree_value <- degree(graph, mode = "in")
  nodelist$betweeness <- degree_value[match(nodelist$node, names(degree_value))]

  return(nodelist)
}
