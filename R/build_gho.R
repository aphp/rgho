#' Check and Build a gho Object
#'
#' @param x A vector of codes.
#' @param label A vector of labels.
#' @param attr A \code{data_frame} of attributes.
#'
#' @return A \code{gho} object.
build_gho <- function(x, label, attrs = NULL) {
  stopifnot(
    length(dim(x)) == 1,
    length(dim(label)) == 1,
    is.character(x),
    is.character(label),
    "tbl_df" %in% class(attr) | is.null(attrs)
  )
  structure(
    as.vector(x),
    label = as.vector(label),
    attrs = attrs,
    class = "gho"
  )
}
