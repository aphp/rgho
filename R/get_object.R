#' Returns Available GHO Dimensions
#'
#' @return GHO dimensions as a character vector, and labels as a \code{label} attribute.
#'
#' @export
#'
#' @examples
#'
#' get_gho_dimensions()
#'
get_gho_dimensions <- function() {
  resp <- get_gho(
    url = build_gho_url(dimension = NULL, format = "json")
  )

  if (httr::http_type(resp) != "application/json") {
    stop(sprintf(
      "Unexpected type: '%s', expected 'application/json'.",
      httr::http_type(resp)
    ))
  }

  tab_res <- parse_json(resp, type = "dimension")

  build_gho(
    tab_res$label, labels = tab_res$display,
    attrs = dplyr::select_(tab_res, ~ -label, ~ -display)
  )
}

#' Returns GHO Codes for a Given Dimension
#'
#' @param dimension A GHO dimension.
#' @param x For \code{filter}, \code{gho} object to
#'   filter.
#' @param  ... Logical predicates. Multiple conditions are
#'   combined with &.
#'
#' @return GHO codes as a character vector, labels as a
#'   \code{label} attribute and other attributes in a \code{attrs}
#'   attribute, as a \code{data_frame}.
#' @export
#'
#' @examples
#'
#' get_gho_codes(dimension = "GHO")
#'
#' results <- get_gho_codes(dimension = "COUNTRY")
#' filter_attrs(
#'   results,
#'   WHO_REGION_CODE == "EUR"
#' )
#'
get_gho_codes <- function(dimension = "GHO") {
  stopifnot(
    dimension %in% get_gho_dimensions()
  )

  resp <- get_gho(
    url = build_gho_url(dimension = dimension, format = "json")
  )

  if (httr::http_type(resp) != "application/json") {
    stop(sprintf(
      "Unexpected type: '%s', expected 'application/json'.",
      httr::http_type(resp)
    ))
  }

  tab_res <- parse_json(resp, type = "code")

  build_gho(
    tab_res$label, labels = tab_res$display,
    attrs = dplyr::select_(tab_res, ~ -label, ~ -display)
  )
}

parse_json <- function(resp, type = c("dimension", "code")) {
  type <- match.arg(type)

  list_resp <- resp %>%
    httr::content(as = "text") %>%
    clean_json %>%
    jsonlite::fromJSON(
      simplifyVector = F,
      simplifyDataFrame = F,
      simplifyMatrix = F
    )

  switch(
    type,
    dimension = {
      x <- list_resp$dimension
    },
    code = {
      x <- list_resp$dimension[[1]]$code
    }
  )

  g <- function(x, y) rbind(unlist(x), unlist(y))

  f <- function(x) {
    if (length(x$attr) > 1) {
      mat_attr <- Reduce(g, x$attr)
    } else {
      mat_attr <- rbind(unlist(x$attr))
    }

    res <- rbind(
      matrix(
        c("label", "display", x$label, x$display),
        nrow = 2
      ),
      mat_attr
    )

    cbind(res, x$label)
  }

  do.call(rbind, lapply(x, f)) %>%
    tibble::as_tibble() %>%
    stats::setNames(c("category", "value", "code")) %>%
    tidyr::spread_(key_col = "category", value_col = "value")
}
