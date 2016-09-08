#' @export
#' @rdname get_gho_codes
filter_attrs <- function (x, ...) {
  .dots <- lazyeval::lazy_dots(...)
  filter_attrs_(x, .dots = .dots)
}

filter_attrs_ <- function(x, .dots) {
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
