#' Check and Build a gho Object
#'
#' @param x A ODataQuery object
#'
#' @return A \code{gho} object.
#' @keywords internal
#'

build_gho <- function(x){
  w <- graceful_fail(x$url, config = c(
    httr::user_agent("https://pierucci.org/rgho/")
  ))
  return_if_message(w, display = TRUE, n = 2)
  ret <- x$retrieve()
  structure(ret$value,
            class = c("gho", "data.frame"),
            url = ret$`@odata.context`)
}

