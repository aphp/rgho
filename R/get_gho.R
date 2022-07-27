#' GET a GHO URL
#'
#' Given a url, tries to find local proxy settings and GET
#' the content of the GHO page.
#'
#' The function re-tries failed attempts using exponential
#' backoff with jitter.
#'
#' @param url the url to retrieve, given as a character
#'   string.
#' @param verbose Verbose mode?
#' @param retry Maximum number of \code{GET} re-trials.
#'
#' @return The result from \code{\link[httr]{GET}}.
#' @keywords internal
get_gho <- function(url = getOption("rgho.baseurl") , verbose = options()$rgho.verbose,
                     retry = options()$rgho.retry) {
  ODataQuery$new(url)
}
