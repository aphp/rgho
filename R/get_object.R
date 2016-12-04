#' @rdname man-gho
#' @export
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

#' @rdname man-gho
#' @export
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
