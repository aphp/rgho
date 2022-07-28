context("Get GHO Data")

baseurl <- getOption("rgho.baseurl")

skip_if_offline()
  test_that("404 error when url not found", {
      options(rgho.baseurl = "http://httpbin.org/status/404")
      get_gho_data(
        code = "MDG_0000000001",
        filter = list(
          YEAR = 2015
        )
      ) %>%
      expect_message("404")
  })

  test_that("get_gho data works without filter", {
    options(rgho.baseurl = baseurl)
    result <- get_gho_data(
      code = "NTD_ONCHSTATUS"
    )
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true("27601256" %in% result$Id)
      expect_gt(nrow(result), 30)
    }

  })

  test_that("get_gho data works with 1 filter", {
    result <- get_gho_data(
      code = "MDG_0000000001",
      filter = list(
        COUNTRY = "FRA"
      )
    )
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true("27870102" %in% result$Id)
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
    )
    expect_s3_class(result, "gho")
    if (length(result)){
      expect_true("25033041" %in% result$Id)
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
