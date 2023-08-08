context("search")

baseurl <- getOption("rgho.baseurl")

skip_if_offline()
  test_that("search_values is working", {
    if(curl::has_internet()){
      result <- search_values("Adult", dimension = "GHO")
      expect_s3_class(result, "gho")
      if (length(result)){
        expect_true("Adult_curr_cig_smoking" %in% result$Code)
        expect_gt(nrow(result), 60)
      }
      options(rgho.baseurl = "http://httpbin.org/status/404")
      expect_message(search_values("Adult", dimension = "GHO"), "[45]04")
    }
    options(rgho.baseurl = baseurl)

  })
  test_that("search_dimensions is working", {
      result <- search_dimensions("age")
      expect_s3_class(result, "gho")
      if (length(result)){
        expect_true("AGEGROUP" %in% result$Code)
        expect_gt(nrow(result), 2)
      }
      options(rgho.baseurl = "http://httpbin.org/status/404")
      expect_message(search_dimensions("age"), "[45]04")
    options(rgho.baseurl = baseurl)
  })

  test_that("search_gho is working", {

    value <- get_gho_values(dimension = "COUNTRY")
      result <- search_gho(value, "fra")
      expect_s3_class(result, "gho")
      if (length(result)){
        expect_true("FRA" %in% result$Code)
        expect_identical(names(result), c("Code", "Title"))
      }
    options(rgho.baseurl = baseurl)
  })
