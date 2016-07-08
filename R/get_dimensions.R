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
    url = build_gho_url(dimension = NULL)
  )

  if (httr::http_type(resp) != "application/xml") {
    stop(sprintf(
      "Unexpected type: '%s', expected 'application/xml'.",
      httr::http_type(resp)
    ))
  }

  xml_dim <-  resp %>%
    httr::content(as = "text") %>%
    xml2::read_xml() %>%
    xml2::xml_find_all("//Dimension")

  res <- xml_dim %>%
    xml2::xml_attr("Label")

  labels <- xml_dim %>%
    xml2::xml_find_all("//Dimension//Display") %>%
    xml2::xml_text()

  build_gho(
    res, labels = labels
  )
}
