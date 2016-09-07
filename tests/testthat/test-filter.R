context("filter_attrs")

test_that("correct inputs work", {
  codes <- get_gho_codes()
  filtered_codes <- filter_attrs(codes, CATEGORY == "Urban health")
  expect_identical(
    length(filtered_codes), 35L
  )
  expect_identical(
    sort(filtered_codes),
    c("AIR_2", "AIR_3", "AIR_7", "AIR_9", "EQ_ADOBIRTH", "EQ_ANC",
      "EQ_BMI30", "EQ_CONDOMUSE", "EQ_CONTRACEPTIVE", "EQ_DIRTFLOOR",
      "EQ_DTP3", "EQ_HANDWASHING", "EQ_HIVPREV", "EQ_HOUSENETS", "EQ_INFANTMORT",
      "EQ_ITN", "EQ_ITNUNDER5", "EQ_KNHIV", "EQ_MEAIMM", "EQ_OPENDEFECATION",
      "EQ_OVERWEIGHT", "EQ_OVERWEIGHTADULT", "EQ_SBA", "EQ_SLEPTNETS",
      "EQ_SLUM", "EQ_SOLIDFUELS", "EQ_STUNT", "EQ_TOBACCO", "EQ_U5MORT",
      "EQ_U5SLEPTNETS", "EQ_UNDERWEIGHT", "EQ_URBPOP", "EQ_WATERIMPROVED",
      "EQ_WATERPIPED", "EQ_WATERPREMISES")
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
