to_utf8 <- function(x) {
  Encoding(x) <- "UTF-8"
  x
}

clean_json <- function(x, verbose = options()$rgho.verbose,
                       n_print = 10) {
  stopifnot(length(x) == 1)
  if (verbose) {
    pos <- gregexpr('(\\S)\\"\\"', x)[[1]]
    if (length(pos)) {
      message(sprintf(
        "Corrected json errors in %i place(s):",
        length(pos)))
      for (i in pos) {
        message(substr(x,
                       max(i-n_print, 1),
                       min(i+n_print, nchar(x))))
      }
    }
  }
  gsub('(\\S)\\"\\"', '\\1\\"', x)
}
