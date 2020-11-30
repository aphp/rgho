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
get_gho_ <- function(url, verbose = options()$rgho.verbose,
                     retry = options()$rgho.retry) {
  proxy <- get_proxy()

  if (verbose) {
    message(sprintf("URL: %s", url))

    if (is.null(proxy)) {
      message("Trying request without proxy settings.")
    } else {
      message("Trying request with proxy settings.")
    }
  }

  n <- 0
  while(n <= retry){
    if (verbose) message(sprintf("Try #%i.", n))

    res <- try(httr::GET(
      url = url,
      config = c(
        proxy, # NULL is no proxy
        httr::user_agent("https://pierucci.org/rgho/")
      )
    ), silent = TRUE)


    # dont retry if proxy error
    if (! is_error(res) || length(res) > 1 && res$status_code == 407L) break

    if (verbose) message(sprintf("Request failed:\n%s", format_error(res)))
    wait(n, verbose)
    n <- n + 1
  }


  if (is_error(res)) {
    message(sprintf(
      "Error during request:\n%s",
      format_error(res)
    ))
    stop_quietly()
  }

  if (verbose) message("Success.")
  res
}

#' @rdname get_gho_
get_gho <- memoise::memoise(
  get_gho_,
  ~ memoise::timeout(options()$rgho.memotime)
)

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
  Sys.sleep(waiting_time)
}
