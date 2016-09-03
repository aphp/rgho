#' rgho: Access WHO Global Health Observatory Data From R
#'
#' Access WHO Global Health Observatory data from R via the
#' Athena web service, an application program interface
#' providing a simple query interface to the World Health
#' Organization's data and statistics content.
#'
#' @docType package
#' @name rgho
#'
#' @importFrom httr parse_url
#' @importFrom httr build_url
#' @importFrom httr use_proxy
#' @importFrom httr content
#' @importFrom httr user_agent
#'
#' @importFrom memoise memoise
#'
#' @importFrom curl ie_get_proxy_for_url
#'
#' @importFrom xml2 xml_find_all
#' @importFrom xml2 xml_attr
#' @importFrom xml2 xml_contents
#' @importFrom xml2 xml_text
#'
#' @importFrom readr read_csv
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%$%"
#' @importFrom magrittr "%<>%"
#' @importFrom magrittr "extract2"
#'
#' @importFrom dplyr data_frame
#' @importFrom dplyr filter_
#' @importFrom dplyr bind_rows
#'
#' @importFrom tidyr spread_
#'
#' @importFrom lazyeval lazy_dots
#'
#' @importFrom stats runif
#'
#' @importFrom utils head
#'
NULL
