#' Values Taken by an Attribute
#'
#' Given a GHO object and an attribute name, return the
#' distinct values taken by the attribute.
#'
#' @param x A GHO object.
#' @param attribute Name of an attribute.
#'
#' @return A character vector of the distinct values taken
#'   by the attribute.
#' @export
values_attrs <- function(x, attribute) {
  gho_attr <- attr(x, "attr")
  stopifnot(
    ! is.null(gho_attr),
    length(attribute) == 1,
    attribute %in% names(gho_attr)
  )

  res <- gho_attr[[attribute]]
  sort(unique(res[! is.na(res)]))
}
