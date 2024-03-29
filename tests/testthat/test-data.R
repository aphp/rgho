context("Get GHO Data")

baseurl <- getOption("rgho.baseurl")

skip_if_offline()
  test_that("404 error when url not found", {
      options(rgho.baseurl = "https://httpbin.org/status/404")
      get_gho_data(
        code = "MDG_0000000001",
        filter = list(
          YEAR = 2015
        )
      ) %>%
      expect_message("[45]04")
  })

  test_that("get_gho data works without filter", {
    options(rgho.baseurl = baseurl)
    result <- get_gho_data(
      code = "CHILDMORT5TO14",
      filter = list(
        YEAR = 2021
      )
    ) %>%
      arrange(Id)
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true(head(result$NumericValue,1) > 3 & head(result$NumericValue,1) < 4)
      expect_gt(nrow(result), 30)
    }

  })

  test_that("get_gho data works with 1 filter", {
    result <- get_gho_data(
      code = "MDG_0000000001",
      filter = list(
        COUNTRY = "FRA"
      )
    ) %>%
      arrange(Id)
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true(head(result$NumericValue,1) > 50 & head(result$NumericValue,1) < 60)
      expect_gt(nrow(result), 200)
    }

  })

  test_that("get_gho data works with 2 filters", {
    result <- get_gho_data(
      code = "LIFE_0000000029",
      filter = list(
        YEAR = 2015,
        REGION = "AFR",
        SEX = "MLE"
      )
    ) %>%
      arrange(Id)
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true("6891564" %in% result$Id)
      expect_gt(nrow(result), 10)
    }

  })

  test_that("Bad vector type returns a message", {
    result <- get_gho_data(
      code = "MDG_0000000001",
      filter = list(
        YEAR = "2015"
      )
    ) %>%
    expect_message("400")
  })

