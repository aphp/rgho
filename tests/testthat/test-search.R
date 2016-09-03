context("search")

test_that("search_dimension & search_codes work", {

  res1 <- search_dimensions("region")
  expect_identical(
    head(res1),
    c("GBDREGION", "REGION", "SUBREGION", "UNMDGREGION", "UNREGION",
      "WHOINCOMEREGION")
  )
  expect_identical(
    length(res1), 10L
  )

  res2 <- search_codes("neonatal", dimension = "GHO")
  expect_identical(
    head(res2),
    c("WHS3_56", "WHOSIS_000003", "WHS4_128", "WHS2_515", "CM_03",
      "nmr")
  )
  expect_identical(
    length(res2), 7L
  )

  result <- get_gho_codes(dimension = "REGION")
  res3 <- search_gho(result, "asia")
  expect_identical(
    head(res3),
    c("SEAR", "WHO_LMI_SEAR", "GBD_REG14_SEARB", "GBD_REG14_SEARD",
      "WHO_HI_SEAR")
  )
  expect_identical(
    length(res3),
    5L
  )
})

