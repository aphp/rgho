context("filter_attrs")

## TODO: Rename context
## TODO: Add more tests

test_that("correct inputs work", {
  codes <- get_gho_codes()
  filtered_codes <- filter_attrs(codes, CATEGORY == "Urban health")
  expect_identical(
    length(filtered_codes), 35L
  )
  expect_identical(
    head(filtered_codes),
    c("AIR_2", "AIR_3", "AIR_7", "AIR_9", "EQ_ANC", "EQ_DTP3")
  )
  expect_identical(
    tail(filtered_codes),
    c("EQ_CONTRACEPTIVE", "EQ_HANDWASHING", "EQ_CONDOMUSE", "EQ_DIRTFLOOR",
      "EQ_OPENDEFECATION", "EQ_OVERWEIGHTADULT")
  )
  expect_identical(
    dim(attr(filtered_codes, "attrs")),
    c(35L, 7L)
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
