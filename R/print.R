to_data_frame <- function(x) {
  dplyr::data_frame(
    Label = attr(x, "labels"),
    ID = as.vector(x)
  )
}

#' @export
print.gho <- function(x, ...) {
  cat(sprintf("A 'GHO' object of %i elements.\n\n", length(x)))
  print(to_data_frame(x), ...)
}
