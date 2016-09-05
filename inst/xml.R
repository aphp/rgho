library(dplyr)

resp <- rgho:::build_gho_url(
  dimension = "GHO",
  format = "json"
) %>%
  rgho:::get_gho()
resp_dim <- rgho:::build_gho_url(
  dimension = NULL,
  format = "json"
) %>%
  rgho:::get_gho()

httr::http_type(resp)

test <- resp %>%
  httr::content(as = "text") %>%
  rgho:::clean_json() %>%
  jsonlite::fromJSON(
    simplifyVector = F,
    simplifyDataFrame = F,
    simplifyMatrix = F
  )

id <- test$dimension[[1]]$code %>%
  lapply(function(x) x$label) %>%
  unlist
label <- test$dimension[[1]]$code %>%
  lapply(function(x) x$display) %>%
  unlist
list_attr <- test$dimension[[1]]$code %>%
  lapply(function(x) c(x$attr[[2]]$category,
                       x$attr[[2]]$value)) %>% head %>%
  Reduce(dplyr::)
unlist



f <- function(x) {
  c(x$label, x$display, unlist(lapply(x$attr, g)))
}

g <- function(x) {
  x$value
}

xxx=test$dimension[[1]]$code %>% lapply(f)

func <- function(resp) {

  list_resp <- resp %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON(
      simplifyVector = F,
      simplifyDataFrame = F,
      simplifyMatrix = F
    )

    tab_res <- list_resp$dimension[[1]]$code %>%
      lapply(
        function(x) {
          dplyr::bind_rows(
            tibble::tibble(
              category = c("label", "display"),
              value = c(x$label, x$display)
            ),
            Reduce(dplyr::bind_rows, x$attr)
          ) %>%
            tibble::add_column(
              id = rep(x$label, length(x$attr) + 2)
            )
        }
      ) %>%
      Reduce(rbind, .) %>%
      tidyr::spread(key = category, value = value)

}

# jsonedit
# tibble:::as_tibble.list
# function (x, validate = TRUE, ...)
