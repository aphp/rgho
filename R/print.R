to_data_frame <- function(x, row.names = NULL, optional = FALSE, ...) {
  dplyr::data_frame(
    Label = attr(x, "label"),
    ID = as.vector(x)
  )
}

#' @export
print.gho <- function(x, ...) {
  cat(sprintf("A 'GHO' object of %i elements.\n\n", length(x)))
  print(to_data_frame(x), ...)
}
