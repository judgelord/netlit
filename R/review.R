#' Creates a nodelist augmented with igraph network statisitics
#'
#' This function creates a node list with outputs from the igraph package.
#' @param edgelist is a dataframe with columns "from" and "to" as well as edge attributes (optional). Edge attribute names may not be the same as any node attribute names.
#' @param node_attributes (optional) is a dataframe with columns "node" as well as any node attributes. Node attribute names may not be the same as any edge attribute names.
#' @return A list of 2: an edgelist and a nodelist
#' @keywords node
#' @export
#' @examples
#' review(data)

review <- function(data, edge_attributes = "", node_attributes = dplyr::tibble(node = "")){

  d <- clean_input(data)

  edgelist <- make_edgelist(d, edge_attributes = edge_attributes)

  nodelist <- make_nodelist(d, node_attributes = node_attributes) 
  
  nodelist <- augment_nodelist(nodelist, edgelist)

  return(list(nodelist = nodelist,
              edgelist = edgelist,
              graph = igraph::graph_from_data_frame(d=edgelist, vertices=nodelist, directed=T))
  )
}
