#' Returns Available GHO Dimensions
#'
#' @return GHO dimensions as a character vector, and labels as a \code{label} attribute.
#'
get_gho_dimensions_ <- function() {
  xml_dim <- get_gho(
    url = build_gho_url(dimension = NULL)
  ) %>%
    httr::content() %>%
    xml2::xml_find_all("//Dimension")

  res <- xml_dim %>%
    xml2::xml_attr("Label")

  labels <- xml_dim %>%
    xml2::xml_find_all("//Dimension//Display") %>%
    xml2::xml_contents() %>%
    as.character()

  structure(res, labels = labels)
}

#' @rdname get_gho_dimensions_
#' @export
get_gho_dimensions <- memoise::memoise(get_gho_dimensions_)
