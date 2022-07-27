#' @rdname man-gho
#' @export
print.gho <- function(x, n = options()$rgho.n, ...) {
  if (n == Inf) {
    n <- nrow(x)
  }

  cat(sprintf("A 'GHO' object of %i elements.\n\n", nrow(x)))

  print.data.frame(head(x,n), ...)

  if (n < nrow(x)) {
    cat(sprintf("...\n\n(Printing %i first elements.)\n", n))
  }

  # if (! is.null(attr(x, "attrs"))) {
  #   names_attr <- names(attr(x, "attrs"))
  #   names_attr <- names_attr[names_attr != "code"]
  #   cat("\nAttributes:\n\n")
  #   cat(names_attr, sep = "\n")
  # }
}
