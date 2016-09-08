context("proxy_list")

test_that("proxy parsing works", {
  p1 <- "132.432.653.123:7986"
  p2 <- "132.432.653.123:7986;132.432.653.123:7986"

  expect_identical(
    rgho:::parse_proxy_string(p1),
    list(structure(list(
      method = NULL, url = NULL, headers = NULL,
      fields = NULL, options = structure(list(
        proxy = "132.432.653.123",
        proxyport = 7986L, proxyauth = 1),
        .Names = c("proxy",
                   "proxyport", "proxyauth")),
      auth_token = NULL, output = NULL),
      .Names = c(
        "method",
        "url", "headers", "fields", "options",
        "auth_token", "output"
      ),
      class = "request"))
  )
  expect_identical(
    rgho:::parse_proxy_string(p2),
    list(structure(list(
      method = NULL, url = NULL, headers = NULL,
      fields = NULL, options = structure(list(
        proxy = "132.432.653.123",
        proxyport = 7986L, proxyauth = 1),
        .Names = c("proxy",
                   "proxyport", "proxyauth")),
      auth_token = NULL, output = NULL),
      .Names = c(
        "method",
        "url", "headers", "fields", "options", "auth_token",
        "output"
      ), class = "request"),
      structure(list(
        method = NULL, url = NULL,
        headers = NULL, fields = NULL, options = structure(list(
          proxy = "132.432.653.123",
          proxyport = 7986L, proxyauth = 1),
          .Names = c(
            "proxy",
            "proxyport", "proxyauth")), auth_token = NULL,
        output = NULL), .Names = c(
          "method",
          "url", "headers", "fields", "options", "auth_token",
          "output"
        ),
        class = "request"))
  )
})
