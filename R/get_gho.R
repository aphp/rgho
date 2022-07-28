#' GET a GHO URL
#'
#' @param url the url to retrieve, given as a character
#'   string.
#'
#' @return A `ODataQuery` object.
#' @keywords internal
get_gho <- function(url = getOption("rgho.baseurl")) {
  ODataQuery$new(url)
}

#' @rdname man-gho
#' @export
get_gho_dimensions <- function() {
  resp <- get_gho()$path("Dimension")
  build_gho(resp)
}

#' @rdname man-gho
#' @export
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function was deprecated in favor of get_gho_values
#' @keywords internal
#'
get_gho_codes <- function(...){
  lifecycle::deprecate_soft("3.0.0", "get_gho_codes()", "get_gho_values()")
  get_gho_values(...)
}


#' @rdname man-gho
#' @export
get_gho_values <- function(dimension = "GHO") {
  dims <- get_gho_dimensions()
  return_if_message(dims)
  stopifnot(
    dimension %in% dims$Code
  )

  vals <- get_gho()$path(sprintf("DIMENSION/%s/DimensionValues", dimension))

  res <- build_gho(vals)
  structure(res[c("Code", "Title")],
            url = attr(res, "url"))
}

#' @rdname man-gho
#' @export
get_gho_indicators <- function(filter = NULL) {
  resp <- get_gho()$path("Indicator")
  table <- if (!is.null(filter)){
    build_gho(resp$filter(list_to_filter(filter)))
  } else {
    build_gho(resp)
  }
  url <- attr(table, "url")
  structure(table, class = c("gho", class(table)),
            url = url)
}

#' Check and Build a gho Object
#'
#' @param x A ODataQuery object
#'
#' @return A \code{gho} object.
#' @keywords internal
#'

build_gho <- function(x){
  w <- graceful_fail(x$url, config = c(
    httr::user_agent("https://github.com/aphp/rgho/")
  ))
  return_if_message(w, display = TRUE, n = 2)
  ret <- x$retrieve()
  structure(ret$value,
            class = c("gho", "data.frame"),
            url = ret$`@odata.context`)
}


