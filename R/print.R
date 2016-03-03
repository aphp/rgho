#' @export
as.data.frame.gho <- function(x, row.names = NULL, optional = FALSE, ...) {
  data.frame(
    Label = attr(x, "label"),
    ID = as.vector(x)
  )
}

#' @export
print.gho <- function(x, ...) {
  print(as.data.frame(x), ...)
}
