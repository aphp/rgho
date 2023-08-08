context("objects")

test_that("api base url is correct and objects are of correct size", {
  expect_identical(
    rgho:::get_gho()$url,
    "https://ghoapi.azureedge.net/api/"
  )
  dims <- get_gho_dimensions()
  if (length(dims) && length(dims$url)){
    expect_identical(
      attr(dims,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#DIMENSION"
    )
  }
  value <- get_gho_values()
  if (length(value) && length(value$url)){
    expect_identical(
      attr(value,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#Collection(Default.DIMENSION_VALUE)"
    )
    expect_gt(nrow(value), 2000)
  }
  value <- get_gho_values("AGEGROUP")
  if (length(value) && length(value$url)){
    expect_identical(
      attr(value,"url"),
      "https://ghoapi.azureedge.net/api/$metadata#Collection(Default.DIMENSION_VALUE)"
    )
    expect_gt(nrow(value), 50)
  }
})

test_that("Connection errors", {
    if(curl::has_internet()){
    options(rgho.baseurl = "https://httpbin.org/status/404")
    expect_message(get_gho_dimensions(), "[45]04")
    expect_message(get_gho_values(dimension = "COUNTRY"), "[45]04")
  } else {
    expect_message(get_gho_dimensions(), "No internet connection")
    expect_message(get_gho_values(), "No internet connection")
  }
})
