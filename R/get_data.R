#' Returns GHO Data
#'
#' Given a code, returns the corresponding GHO data.
#'
#' Filtering parameters are given as a named list of the
#' form \code{list(COUNTRY = "FRA", ...)}.
#'
#'
#' @param code A GHO code.
#' @param filter A named list of filtering parameters (see
#'   details).
#'
#' @return A \code{data frame}.
#'
#' @export
#'
#' @examples
#'
#'\dontrun{
#' result <- get_gho_data(
#'   code = "MDG_0000000001"
#' )
#' print(result, width = Inf)
#'
#'
#' result <- get_gho_data(
#'   code = "MDG_0000000001",
#'   filter = list(
#'     REGION = "EUR",
#'     YEAR = "2015"
#'   )
#' )
#' print(result, width = Inf)
#'}
get_gho_data <- function(code, filter = NULL) {
  codes <- get_gho_codes()
  return_if_message(codes)
  stopifnot(
    code %in% codes$Code
  )

  resp <- get_gho()$path(code)
  table <- if (!is.null(filter)){
    build_gho(resp$filter(list_to_filter(filter)))
  } else {
    build_gho(resp)
  }
  remove_na <- table %>%
    apply(MARGIN = 2, FUN = function(x) !all(is.na(x), na.rm = TRUE))

  url <- attr(table, "url")
  table <- table[remove_na]
  for (x in names(table)){
    if (grepl("Dim", x) & grepl("Type", x)){
      table <- tidyr::pivot_wider(table,  names_from = x, values_from = gsub("Type", "", x))
    }
  }
  structure(table, class = c("gho", class(table)),
            url = url)
}
