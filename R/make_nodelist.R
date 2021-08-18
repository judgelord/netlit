#' Make nodelist
#'
#' This function makes a node list from the input (edgelist) data frame.
#' @param data is a dataframe with columns "from" and "to" as well as edge attributes (optional). Edge attribute names may not be the same as any node attribute names.
#' @param node_attributes (optional) is a dataframe with columns "node" as well as node attributes. Node attribute names may not be the same as any edge attribute names.
#' @keywords node
#' @export

make_nodelist <- function(data, node_attributes = tibble(node = "")){
  nodelist <- tibble(node = c(data$to, data$from)) %>%
    distinct() %>%
    left_join(node_attributes, by = "node")

  return(nodelist)
}
