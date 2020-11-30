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
#' @importFrom httr parse_url
#' @importFrom httr build_url
#' @importFrom httr use_proxy
#' @importFrom httr content
#' @importFrom httr user_agent
#'
#' @importFrom memoise memoise
#' @importFrom memoise timeout
#'
#' @importFrom curl ie_get_proxy_for_url
#'
#' @importFrom readr read_csv
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%$%"
#' @importFrom magrittr "%<>%"
#' @importFrom magrittr "extract2"
#'
#' @importFrom tibble as_tibble
#'
#' @importFrom tidyr spread_
#'
#' @importFrom lazyeval lazy_dots
#'
#' @importFrom stats runif
#' @importFrom stats setNames
#'
#' @importFrom utils head
#'
#' @importFrom jsonlite fromJSON
#'
#' @importFrom rlang quos "!!!" .data
#'
NULL
