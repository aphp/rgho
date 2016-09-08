context("search")

test_that("search_dimension & search_codes work", {

  res1 <- search_dimensions("region")
  expect_identical(
    sort(res1),
    c("DHSMICSGEOREGION", "GBDREGION", "MGHEREG", "OECDREGION", "REGION",
      "SUBREGION", "UNMDGREGION", "UNREGION", "WHOINCOMEREGION", "WORLDBANKREGION"
    )
  )
  expect_identical(
    length(res1), 10L
  )

  res2 <- search_codes("neonatal", dimension = "GHO")
  expect_identical(
    sort(res2),
    sort(c("CM_03", "nmr", "pnmr", "WHOSIS_000003", "WHS2_515", "WHS3_56",
      "WHS4_128"))
  )
  expect_identical(
    length(res2), 7L
  )

  result <- get_gho_codes(dimension = "REGION")
  res3 <- search_gho(result, "asia")
  expect_identical(
    sort(res3),
    c("GBD_REG14_SEARB", "GBD_REG14_SEARD", "SEAR", "WHO_HI_SEAR",
      "WHO_LMI_SEAR")
  )
  expect_identical(
    length(res3),
    5L
  )
})

