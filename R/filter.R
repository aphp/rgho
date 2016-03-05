#' @export
#' @rdname get_gho_codes_
filter_.gho <- function (.data, ..., .dots) {
  tab_attrs <- attr(.data, "attrs") %>%
    filter(.dots = .dots)

  codes <- unique(tab_attrs$code)

  build_gho(
    .data[.data %in% codes],
    label = attr(.data),
    attrs = tab_attrs
  )
}
