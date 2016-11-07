.onLoad <- function(libname, pkgname) {
  op <- options()
  op.rgho <- list(
    rgho.verbose = FALSE,
    rgho.retry = 5,
    rgho.memotime = 3600,
    rgho.http_proxy = NULL
  )
  toset <- !(names(op.rgho) %in% names(op))
  if(any(toset)) options(op.rgho[toset])

  invisible()
}
