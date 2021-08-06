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

review <- function(data, node_attributes = tibble(node = "")){

  d <- clean_input(data)

  edgelist <- make_edgelist(d)

  nodelist <- make_nodelist(d) %>% augment_nodelist(edgelist)

  return(list(nodelist = nodelist,
              edgelist = edgelist)
  )
}
