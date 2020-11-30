#' Construct GHO request URL
#'
#' @param base_url Base URL of the API.
#' @param dimension Dimension of interest.
#' @param code A vector of requested codes.
#' @param filter A named list of filtering parameters.
#' @param ... Other optional URL parameters.
#'
#' @return An URL as a string.
#' @keywords internal
build_gho_url <- function(base_url = "https://apps.who.int/gho/athena/api/",
                          dimension = "GHO", code = NULL,
                          filter = NULL, ...) {

  stopifnot(
    if (is.null(dimension)) TRUE else length(dimension) == 1
  )

  if (is.null(dimension) & ! is.null(code)) {
    stop("A 'dimension' is needed when a 'code' is requested.")
  }

  url <- httr::parse_url(base_url)

  url$path <- paste0(url$path, dimension)

  if (! is.null(code)) {
    url$path %<>% paste0("/", paste(code, collapse = ","))
  }

  if (! is.null(filter)) {
    stopifnot(
      length(filter) > 0,
      ! is.null(names(filter)),
      ! is.null(dimension) && ! is.null(code),
      is.list(filter),
      all(unlist(lapply(filter, length)) == 1)
    )

    url$query$filter <- names(filter) %>%
      paste(unlist(filter), sep = ":") %>%
      paste(collapse = ";")
  }

  if (length(other <- list(...))) {
    stopifnot(
      ! is.null(names(other)),
      all(unlist(lapply(other, length)) == 1)
    )

    url$query %<>%
      c(Filter(function(x) ! is.null(x), other))
  }

  httr::build_url(url)
}
