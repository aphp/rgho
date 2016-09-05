to_utf8 <- function(x) {
  Encoding(x) <- "UTF-8"
  x
}

clean_json <- function(x) {
  gsub('(\\S)\\"\\"', '\\1\\"', x)
}
