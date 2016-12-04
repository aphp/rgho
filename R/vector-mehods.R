#' @export
`[.gho` <- function(x, i, ...) {
  if (! is.null(attr(x, "attrs"))) {
    attrs <- attr(x, "attrs")[i, ]
  } else {
    attrs <- NULL
  }

  build_gho(
    as.vector(x)[i],
    labels = attr(x, "labels")[i],
    attrs = attrs
  )
}

#' @export
`[[.gho` <- function(x, i, ...) {
  x[i]
}

#' @export
`[<-.gho` <- function(x, ..., value) {
  stop("Cannot replace parts of a GHO object.")
}

#' @export
`[[<-.gho` <- function(x, ..., value) {
  stop("Cannot replace parts of a GHO object.")
}

#' @export
c.gho <- function(..., recursive = FALSE) {
  stop("Cannot combine GHO objects.")
}
