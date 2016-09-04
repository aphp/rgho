library(dplyr)

resp <- rgho:::build_gho_url(
  dimension = "COUNTRY",
  format = "json"
) %>%
  rgho:::get_gho()

httr::http_type(resp)

test <- resp %>%
  httr::content(as = "text") %>%
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
  lapply(function(x) x$attr) %>%
  unlist



f <- function(x) {
  list(x$label, x$display, g(x))
}

g <- function(x) {
  lapply(x$attr, function(y) c(y$category, y$value))
}

xxx=test$dimension[[1]]$code %>% lapply(f)
