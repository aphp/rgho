library(dplyr)

resp <- rgho:::build_gho_url(
  dimension = "GHO",
  format = "json"
) %>%
  rgho:::get_gho()

test <- resp %>%
  httr::content(as = "text") %>%
  rgho:::clean_json() %>%
  jsonlite::fromJSON(
    simplifyVector = F,
    simplifyDataFrame = F,
    simplifyMatrix = F
  )

f1 <- function(x) {
  res1 <- matrix(
    c("label", "display", x$label, x$display),
    nrow = 2
  )

  #res2 <- dplyr::bind_rows(x$attr)
  res2 <- Reduce(rbind, x$attr)
  res3 <- rbind(
    res1,
    res2
  )
  res4 <- as.data.frame(res3)
  rownames(res4) <- NULL
  names(res4) <- c("category", "value")
  res4$id <- x$label

  res4
}

x <- test$dimension[[1]]$code

profvis::profvis(
  {
    r1 <- lapply(x, f)

    r2 = dplyr::bind_rows(r1)
    #     tidyr::spread_(r2 ,key_col = "category", value_col = "value")
  }
)
g <- function(x, y) rbind(unlist(x), unlist(y))

r2 <- lapply(r1, as.data.frame)

microbenchmark::microbenchmark({
  do.call(rbind, r1)
}, {
  plyr::rbind.fill(r2)
},
times = 10
)

