clean_json <- function(x, verbose = options()$rgho.verbose,
                       n_print = 10) {
  stopifnot(length(x) == 1)

  pattern <- '(\\S)\\"\\"'

  if (verbose) {
    pos <- gregexpr(pattern, x)[[1]]
    if (any(pos > 0)) {
      message(sprintf(
        "Corrected json errors in %i place(s):",
        length(pos)))
      for (i in pos) {
        message(sprintf(
          "\n%s\n",
          substr(
            x,
            max(i-n_print, 1),
            min(i+n_print, nchar(x))
          )
        ))
      }
    }
  }

  gsub(pattern, '\\1\\"', x)
}

gracefully_fail <- function(remote_file, config) {
  #https://community.rstudio.com/t/internet-resources-should-fail-gracefully/49199/12
  try_GET <- function(x, ...) {
    tryCatch(
      httr::GET(url = x, ...),
      error = function(e) conditionMessage(e),
      warning = function(w) conditionMessage(w)
    )
  }
  is_response <- function(x) {
    class(x) == "response"
  }

  # First check internet connection
  if (!curl::has_internet()) {
    return(structure(list(), message = "No internet connection."))
  }
  # Then try for timeout problems
  resp <- try_GET(remote_file, config = config)
  if (!is_response(resp)) {
    return(structure(list(), message = resp))
  }
  # Then stop if status > 400
  if (httr::http_error(resp)) {
    return(structure(list(), message = httr::http_status(resp)$message))
  }
  resp
}

return_if_message <- function(x, display = FALSE) {
  if(!length(x) & !is.null(attr(x, "message"))) {
    if (attr(x, "message") == "No internet connection") memoise::forget(get_gho)
    if(display) message(attr(x, 'message'))
    x_ <- quo(invisible(structure(list(),
                                         message = attr(x, "message"),
                                         class = "gho")))
    call <- rlang::expr(return(rlang::eval_tidy(!!x_)))
    rlang::eval_bare(call, env = parent.frame())
  }
}


