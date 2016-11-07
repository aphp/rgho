#' Filter a GHO Object on Attribute Values
#'
#' @param x \code{gho} object to
#'   filter.
#' @param  ... Logical predicates. Multiple conditions are
#'   combined with &.
#'
#' @return A \code{gho} object.
#' @export
filter_gho <- function (x, ...) {
  .dots <- lazyeval::lazy_dots(...)
  filter_gho_(x, .dots = .dots)
}

filter_gho_ <- function(x, .dots) {
  if (is.null(gho_attr <- attr(x, "attrs"))) {
    stop("Attempt to filter a GHO object with no attribute.")
  }

  filtered_attrs <- gho_attr %>%
    dplyr::filter_(.dots = .dots)

  codes <- unique(filtered_attrs$code)

  build_gho(
    x[x %in% codes],
    labels = attr(x, "labels")[x %in% codes],
    attrs = filtered_attrs
  )
}
