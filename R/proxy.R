#' Find Local Proxy Settings
#'
#' Tries to find the local proxy settings to access a given url.
#'
#' @return A proxy, or \code{NULL} if not proxy are found.
#' @keywords internal
get_proxy <- function() {
  proxy_string <- options()$rgho.http_proxy

  if (is.null(proxy_string)) {
    return(NULL)
  } else {
    return(parse_proxy_string(proxy_string))
  }
}

#' Parse Proxy IP From a Character String
#'
#' Given character string containig a list of proxy,
#' returns the list in a more computer readable form.
#'
#' @param proxy_string A list of proxy IP as a concatenated string.
#'
#' @return A list of proxy settings.
#' @keywords internal
parse_proxy_string <- function(proxy_string) {
  list_proxy <- httr::parse_url(proxy_string)

  if (is.null(list_proxy$hostname)) {
    stop("Invalid proxy URL.")
  }

  list_proxy$url <- list_proxy$hostname

  list_proxy$port <- as.integer(list_proxy$port)

  if (is.null(list_proxy$port)) {
    stop("Invalid proxy port.")
  }

  do.call(
    httr::use_proxy,
    list_proxy[intersect(
      names(list_proxy),
      c("url", "port", "username", "password"))]
  )
}
