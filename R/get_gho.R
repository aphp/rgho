#' GET a GHO URL
#'
#' Given a url, tries to find local proxy settings and GET the content of the GHO page.
#'
#' The function re-tries failed attempts using exponential backoff with jitter.
#'
#' @param url the url to retrieve, given as a character string.
#' @param debug Print debugging messages?
#' @param max_try Maximum number of \code{GET} re-trials.
#'
#' @return The result from \code{httr} GET function.
#'
get_gho_ <- function(url, debug = TRUE, max_try = 5) {
  proxy_list <- get_proxy_list(url)

  if (debug) message(sprintf("URL: %s", url))
  if (is.null(proxy_list)) {
    if (debug) message("Trying request without proxy settings.")
    n <- 0
    while(n <= max_try){
      if (debug) message(sprintf("Try #%i.", n))
      res <- try(httr::GET(url = url))
      if (! is_error(res)) break
      waiting_time <- runif(1, 0, 2^n)
      if (debug) message(sprintf(
        "Request failed (%s), waiting %.1fs.",
        format_error(res),
        waiting_time
      ))
      Sys.sleep(runif(1, 0, 2^n))
      n <- n + 1
    }
  } else {
    for (i in seq_along(proxy_list)) {
      if (debug) message(sprintf("Trying request with proxy settings #%i.", i))

      n <- 0
      while(n <= max_try){
        if (debug) message(sprintf("Try #%i.", n))
        res <- try(httr::GET(url = url, config = proxy_list[[i]]))
        if (! is_error(res)) break
        waiting_time <- runif(1, 0, 2^n)
        if (debug) message(sprintf(
          "Request failed (%s), waiting %.1fs.",
          format_error(res),
          waiting_time
        ))
        Sys.sleep(runif(1, 0, 2^n))
        n <- n + 1
      }

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
  if (is_error(res)) {
    stop("Error during request.")
  }
  res
  stop(httr::http_type(res))
}

#' @rdname get_gho_
get_gho <- memoise::memoise(get_gho_)

is_error <- function(x) {
  inherits(x, "try-error") || httr::http_error(x)
}

format_error <- function(x) {
  if (inherits(x, "try-error")) {
    x$message
  } else if (httr::http_error(x)) {
    httr::http_status(res)$message
  } else {
    "Unknown error."
  }
}
