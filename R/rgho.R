#' rgho: Access WHO Global Health Observatory Data From R
#'
#' Access WHO Global Health Observatory data from R via the
#' Athena web service, an application program interface
#' providing a simple query interface to the World Health
#' Organization's data and statistics content.
#'
#' @docType package
#' @name rgho
#' @section Package Options:
#'
#'   \itemize{ \item \code{rgho.verbose} Should informations
#'   about the request be diplayed? Defaults to
#'   \code{FALSE}. \item \code{rgho.retry} How many times
#'   the request should be retried? Defaults to 5. \item
#'   \code{rgho.memotime} For how long should the results of
#'   a request be memoised, in seconds? Defaults to 3600. }
#'
#'
#' @importFrom magrittr "%>%"
#'
#' @importFrom dplyr select filter
#'
#' @importFrom tibble as_tibble
#'
#' @importFrom ODataQuery ODataQuery
#'
#' @importFrom rlang quos "!!!" .data quo
#'
NULL
