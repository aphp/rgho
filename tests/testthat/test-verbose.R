context("verbose")


test_that("verbose mode works", {
  op <- options(rgho.verbose = TRUE)

  expect_message(
    get_gho_dimensions(),
    "URL: http://apps.who.int/gho/athena/api/?format=json",
    fixed = TRUE
  )
  expect_message(
    get_gho_dimensions(),
    'Corrected json errors in 1 place(s):',
    fixed = TRUE
  )
  options(op)
})
