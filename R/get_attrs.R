#' Get Dimension Attributes
#'
#' @param dimension A GHO dimension.
#'
#' @return A \code{data_frame} of attributes.
#' @export
#'
get_attrs <- function(dimension = "GHO") {
  xml_dim <- get_gho(
    url = build_gho_url(dimension = dimension)
  ) %>%
    httr::content() %>%
    xml2::xml_find_all("//Dimension") %>%
    xml2::xml_find_all("//Code")

  codes <- xml_dim %>%
    xml2::xml_attr("Label")

  browser()

  dplyr::data_frame(
    code = rep(codes,
               unlist(lapply((xml_dim), xml2::xml_length)) - 1),
    key = xml_dim %>%
      xml2::xml_find_all("./Attr") %>%
      xml2::xml_attr("Category"),
    value = xml_dim %>%
      xml2::xml_find_all("./Attr/Value/Display") %>%
      xml2::xml_contents() %>%
      as.character
  )
}
