context("objects")

test_that("api base url is correct and objects are of correct size", {
  expect_identical(
    rgho:::get_gho()$url,
    "https://ghoapi.azureedge.net/api/"
  )
  dims <- get_gho_dimensions()
  if (length(dims)){
    expect_identical(
      attr(dims,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#DIMENSION"
    )
  }
  codes <- get_gho_codes()
  if (length(codes)){
    expect_identical(
      attr(codes,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#Collection(Default.DIMENSION_VALUE)"
    )
    expect_gt(nrow(codes), 2000)
  }
  codes <- get_gho_codes("AGEGROUP")
  if (length(codes)){
    expect_identical(
      attr(codes,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#Collection(Default.DIMENSION_VALUE)"
    )
    expect_gt(nrow(codes), 50)
  }
})

test_that("Connection errors", {
    if(curl::has_internet()){
    options(rgho.baseurl = "http://httpbin.org/status/404")
    expect_message(get_gho_dimensions(), "404")
    expect_message(get_gho_codes(dimension = "COUNTRY"), "404")
  } else {
    expect_message(get_gho_dimensions(), "No internet connection")
    expect_message(get_gho_codes(), "No internet connection")
  }
})
