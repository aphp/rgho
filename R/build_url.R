#' Construct GHO request URL
#'
#' @param base_url Base URL of the API.
#' @param dimension Dimension of interest.
#' @param code A vector of requested codes.
#' @param filter A named list of filtering parameters.
#' @param ... Other optional URL parameters.
#'
#' @return An URL as a string.
#'
#'
build_gho_url_ <- function(base_url = "http://apps.who.int/gho/athena/api/",
                           dimension = "GHO", code = NULL,
                           filter = NULL, ...) {

  if (is.null(dimension) & ! is.null(code)) {
    stop("A 'dimension' is needed to define a 'code'.")
  }

  url <- httr::parse_url(base_url)

  url$path <- paste0(url$path, dimension)

  if (! is.null(code)){
    url$path <- paste0(
      url$path,
      "/",
      paste(code, collapse = ",")
    )
  }

  if (! is.null(filter)) {
    url$query$filter <- names(filter) %>%
      paste(unlist(filter), sep = ":") %>%
      paste(collapse = ";")
  }

  if (length(list(...))) {
    url$query %<>%
      c(Filter(function(x) ! is.null(x), list(...)))
  }

  httr::build_url(url)
}

#' @rdname build_gho_url_
build_gho_url <- memoise::memoise(build_gho_url_)
