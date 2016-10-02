context("filter_attrs")

test_that("correct inputs work", {
  codes <- get_gho_codes()
  filtered_codes <- filter_attrs(codes, CATEGORY == "Urban health")

  expect_identical(
    dim(attr(filtered_codes, "attrs"))[2],
    7L
  )
})

test_that("wrong inputs fail", {
  expect_error(
    filter_attrs(get_gho_dimensions(), x == 3)
  )
  expect_error(
    filter_attrs(codes, CATGORY == "Urban health")
  )
})
