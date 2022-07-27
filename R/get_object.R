#' @rdname man-gho
#' @export
get_gho_dimensions <- function() {
  resp <- get_gho()$path("Dimension")
  build_gho(resp)
}

#' @rdname man-gho
#' @export
get_gho_codes <- function(dimension = "GHO") {
  dims <- get_gho_dimensions()
  return_if_message(dims)
  stopifnot(
    dimension %in% dims$Code
  )

  vals <- get_gho()$path(sprintf("DIMENSION/%s/DimensionValues", dimension))

  res <- build_gho(vals)
  structure(res[c("Code", "Title")],
            url = attr(res, "url"))
}
