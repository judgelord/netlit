#' Clean input data
#'
#' This function cleans the input.
#' @param data is a dataframe with columns "from" and "to" as well as edge attributes (optional).
#' @keywords clean
#' @export
#' @examples
#' clean_input()

clean_input <- function(data){
  data_clean <- tidyr::drop_na(data, to, from)

  if(nrow(data) != nrow(data_clean)){
    message(paste("Dropping",
                  nrow(data) - nrow(data_clean),
                  "rows missing `from` or `to` values")
            )
  }
  return(data_clean)
}
