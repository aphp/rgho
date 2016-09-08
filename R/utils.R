to_utf8 <- function(x) {
  Encoding(x) <- "UTF-8"
  x
}

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
