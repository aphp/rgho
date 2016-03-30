#' GET a GHO URL
#'
#' Given a url, tries to find local proxy settings and GET the content of the GHO page.
#'
#' @param url the url to retrieve, given as a character string.
#' @param debug Print debugging messages?
#'
#' @return The result from \code{httr} GET function.
#'
get_gho_ <- function(url, debug = FALSE) {
  proxy_list <- get_proxy_list(url)

  if (is.null(proxy_list)) {
    if (debug) message("Trying request without proxy settings.")
    res <- httr::GET(url = url)

  } else {
    for (i in seq_along(proxy_list)) {
      if (debug) message(sprintf("Trying request with proxy settings #%i.", i))
      res <- httr::GET(url = url, config = proxy_list[[i]])

      if (! httr::http_error(res)) {
        if (debug) message("Success.")
        break
      }
      if (debug) message("Failure.")
    }
  }
  if (httr::http_error(res)) {
    stop(httr::http_status(res)$message)
  }
  res
}

#' @rdname get_gho_
get_gho <- memoise::memoise(get_gho_)
