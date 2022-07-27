.onLoad <- function(libname, pkgname) {
  op <- options()
  op.rgho <- list(
    rgho.http_proxy = NULL,
    rgho.n = 6,
    rgho.baseurl = "https://ghoapi.azureedge.net/api/"
  )
  toset <- !(names(op.rgho) %in% names(op))
  if(any(toset)) options(op.rgho[toset])

  invisible()
}
