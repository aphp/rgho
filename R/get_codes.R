#' Returns GHO Codes for a Given Dimension
#'
#' @param dimension A GHO dimension.
#'
#' @return GHO codes as a character vector, and labels as a \code{label} attribute.
get_gho_codes_ <- function(dimension) {
  stopifnot(
    dimension %in% get_gho_dimensions()
  )

  xml_codes <- get_gho(
    url = build_gho_url(dimension = dimension)
  ) %>%
    httr::content() %>%
    xml2::xml_find_all("//Code")

  res <- xml_codes %>%
    xml2::xml_attr("Label")

  labels <- xml_codes[1] %>%
    xml2::xml_find_all("//Code/Display") %>%
    xml2::xml_contents() %>%
    as.character()

  structure(res, labels = labels)
}

#' @rdname get_gho_codes_
#' @export
get_gho_codes <- memoise::memoise(get_gho_codes_)
