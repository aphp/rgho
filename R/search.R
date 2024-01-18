#' Search Codes or Dimensions Labels
#'
#' @param x A character string to find in GHO labels.
#' @param dimension A GHO dimension where codes will be searched.
#' @param gho An object from \code{\link{get_gho_dimensions}} or
#'  \code{\link{get_gho_values}}.
#'
#' @return A `GHO` object
#'
#' @export
#'
#' @examples
#'
#' search_values("neonatal", dimension = "GHO")
#'
#' result <- get_gho_values(dimension = "REGION")
#' search_gho(result, "asia")
#'
search_gho <- function(gho, x) {
  return_if_message(gho)
  if (nrow(gho)){
    dplyr::filter(gho, grepl(tolower(x), tolower(.data$Title)))
  }
}

#' @rdname search_gho
#' @export
search_dimensions <- function(x) {
  search_gho(get_gho_dimensions(), x)
}

#' @rdname search_gho
#' @export
search_values <- function(x, dimension = "GHO") {get
  search_gho(get_gho_values(dimension), x)
}
