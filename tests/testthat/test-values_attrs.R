context("values_attrs")

## TODO: Rename context
## TODO: Add more tests

test_that("correct inputs work", {
  codes <- get_gho_codes()

  v_cat <- values_attrs(codes, "CATEGORY")

  expect_identical(
    sort(v_cat),
    sort(c("Child health", "Demographic and socioeconomic statistics",
      "Essential health technologies", "Health Equity Monitor", "Health financing",
      "Health systems", "HIV/AIDS and other STIs", "Infectious diseases",
      "Infrastructure", "Injuries and violence", "Insecticide resistance",
      "International Health Regulations (2005) monitoring framework",
      "Malaria", "Medical equipment", "Millennium Development Goals (MDGs)",
      "Mortality and global health estimates", "Negelected tropical diseases",
      "Neglected tropical diseases", "Noncommunicable diseases", "Noncommunicable diseases CCS",
      "Nutrition", "Public health and environment", "Substance use and mental health",
      "Sustainable development goals", "Tobacco", "Tuberculosis", "Urban health",
      "World Health Statistics"))
  )

  expect_identical(
    length(v_cat), 28L
  )

  expect_identical(
    any(is.na(v_cat)), FALSE
  )

})

test_that("wrong inputs fails", {
  expect_error(
    values_attrs(get_gho_dimensions(), "TEST")
  )
  expect_error(
    values_attrs(codes, "CATGORY")
  )
  expect_error(
    values_attrs(codes, c("CATEGORY", "DISPLAY_ES"))
  )
})
