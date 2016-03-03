#' Returns GHO Data
#'
#' Given a dimension and a code, returns the corresponding GHO data.
#'
#' Filtering parameters are given as a named list of the form
#' \code{list(COUNTRY = "FRA", ...)}.
#'
#' Query parameters follow the specification described on the WHO website
#' \url{http://apps.who.int/gho/data/node.resources.api}.
#'
#' @param dimension A GHO dimension.
#' @param code A GHO code.
#' @param filter A named list of filtering parameters (see details).
#' @param ... Additional query parameters (see details).
#'
#' @return A \code{data_frame}.
#'
get_gho_data_ <- function(dimension, code, filter = NULL, ...) {

  stopifnot(
    dimension %in% get_gho_dimensions(),
    code %in% get_gho_codes(dimension = dimension)
  )

  res_data <- get_gho(
    url = build_gho_url(
      dimension = dimension,
      code = code,
      format = "csv",
      filter = filter,
      ...
    )
  ) %>%
    httr::content(type = "text") %>%
    readr::read_csv()
}

#' @rdname get_gho_data_
#' @export
get_gho_data <- memoise::memoize(get_gho_data_)
