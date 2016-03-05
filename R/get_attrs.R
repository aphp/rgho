#' Get Dimension Attributes
#'
#' @param dimension A parsed XML list of \code{Code} elements.
#'
#' @return A \code{data_frame} of attributes.
#'
get_attrs_ <- function(xml_dim) {

  codes <- xml_dim %>%
    xml2::xml_attr("Label")

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
  ) %>%
    tidyr::spread_(key_col = "key", value_col = "value")
}

#' @rdname get_attrs_
get_attrs <- memoise::memoise(get_attrs_)
