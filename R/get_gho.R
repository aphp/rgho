#' GET a GHO URL
#'
#' Given a url, tries to find local proxy settings and GET the content of the GHO page.
#'
#' The function re-tries failed attempts using exponential backoff with jitter.
#'
#' @param url the url to retrieve, given as a character string.
#' @param verbose Verbose mode?
#' @param retry Maximum number of \code{GET} re-trials.
#'
#' @return The result from \code{\link[httr]{GET}}.
#' @keywords internal
get_gho_ <- function(url, verbose = FALSE, retry = 5) {
  proxy_list <- get_proxy_list(url)

  if (verbose) message(sprintf("URL: %s", url))

  if (is.null(proxy_list)) {
    if (verbose) message("Trying request without proxy settings.")
    n <- 0

    while(n <= retry){
      if (verbose) message(sprintf("Try #%i.", n))

      res <- try(httr::GET(
        url = url,
        config = httr::user_agent("https://pierucci.github.io/rgho/")
      ), silent = TRUE)
      if (! is_error(res)) break

      if (verbose) message(sprintf("Request failed:\n%s", format_error(res)))
      wait(n, verbose)
      n <- n + 1
    }
  } else {
    for (i in seq_along(proxy_list)) {
      if (verbose) message(sprintf("Trying request with proxy settings #%i.", i))

      n <- 0
      while(n <= retry){
        if (verbose) message(sprintf("Try #%i.", n))

        res <- try(httr::GET(
          url = url,
          config = list(
            proxy_list[[i]],
            httr::user_agent("https://pierucci.github.io/rgho/")
          )
        ), silent = TRUE)
        if (! is_error(res)) break

        if (verbose) message(sprintf("Request failed:\n%s", format_error(res)))
        wait(n, verbose)
        n <- n + 1
      }

      if (! is_error(res)) break

      if (verbose) message("Failure.")
    }
  }

  if (is_error(res)) {
    stop(sprintf(
      "Error during request:\n%s",
      format_error(res),
      call. = FALSE
    ))
  }

  if (verbose) message("Success.")
  res
}

#' @rdname get_gho_
get_gho <- memoise::memoise(get_gho_)

is_error <- function(x) {
  inherits(x, "try-error") || httr::http_error(x)
}

format_error <- function(x) {
  if (inherits(x, "try-error")) {
    x

  } else if (httr::http_error(x)) {
    httr::http_status(x)$message

  } else {
    "Unknown error during HTTP request."
  }
}

wait <- function(n, verbose = FALSE) {
  waiting_time <- stats::runif(1, 0, 2^n)
  if (verbose) message(sprintf(
    "Waiting %.1fs.",
    waiting_time
  ))
  Sys.sleep(runif(1, 1, 1+2^n))
}
