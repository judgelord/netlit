augment_nodelist <- function(nodelist, edgelist = NULL, graph = NULL){

  if (!inherits(nodelist, "netlit_nodelist")) {
    abort("'nodelist' must be the output of a call to make_nodelist().")
  }

  node <- attr(nodelist, "node")
  if (is_empty(node)) node <- names(nodelist)[1]

  if (is_empty(graph)) {
    if (!is_empty(edgelist)) {
      if (!inherits(edgelist, "netlit_edgelist")) {
        abort("'edgelist' must be the output of a call to make_edgelist().")
      }
      graph <- igraph::graph_from_data_frame(edgelist, directed = TRUE)
    }
  }

  if (!is_empty(graph)) {
    if (!inherits(graph, "igraph")) {
      abort("'graph' must be an igraph object.")
    }
    degree_value <- igraph::degree(graph, mode = "in")
    nodelist$degree <- degree_value[match(nodelist[[node]], names(degree_value))]
  }

  betweenness_value <- igraph::betweenness(graph)
  nodelist$betweenness <- betweenness_value[match(nodelist[[node]], names(betweenness_value))]

  return(nodelist)
}
