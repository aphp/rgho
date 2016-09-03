context("main")

test_that("get_gho_dimensions works", {
  gho_dim <- get_gho_dimensions()

  expect_identical(
    head(gho_dim),
    c("GHO", "GHOCAT", "DATASOURCE", "GBDCHILDCAUSES", "ICD10CAUSEGROUP",
      "ICD10CHAPTER")
  )
  expect_identical(
    length(gho_dim),
    115L
  )
  expect_identical(
    head(attr(gho_dim, "labels")),
    c("Indicator", "Indicator Categories", "Data Source", "Child cause",
      "ICD10CAUSEGROUP", "ICD10CHAPTER")
  )
  expect_identical(
    length(attr(gho_dim, "labels")),
    115L
  )
  expect_identical(
    attr(gho_dim, "attrs"), NULL
  )
  expect_output(
    print(gho_dim),
    "A 'GHO' object of 115 elements.

                 Label              ID
1            Indicator             GHO
2 Indicator Categories          GHOCAT
3          Data Source      DATASOURCE
4          Child cause  GBDCHILDCAUSES
5      ICD10CAUSEGROUP ICD10CAUSEGROUP
6         ICD10CHAPTER    ICD10CHAPTER
...

(Printing 6 first elements.)",
    fixe = TRUE
  )
})

test_that("get_gho_codes works", {
  codes_region <- get_gho_codes("REGION")

  expect_identical(
    head(codes_region),
    c("AFR", "AMR", "SEAR", "EUR", "EMR", "WPR")
  )
  expect_identical(
    length(codes_region),
    43L
  )
  expect_identical(
    head(attr(codes_region, "labels")),
    c("Africa", "Americas", "South-East Asia", "Europe", "Eastern Mediterranean",
      "Western Pacific")
  )
  expect_identical(
    length(attr(codes_region, "labels")),
    43L
  )
  expect_identical(
    attr(codes_region, "attrs"),
    NULL
  )
  expect_output(
    print(codes_region),
    "A 'GHO' object of 43 elements.

                  Label   ID
1                Africa  AFR
2              Americas  AMR
3       South-East Asia SEAR
4                Europe  EUR
5 Eastern Mediterranean  EMR
6       Western Pacific  WPR
...

(Printing 6 first elements.)",
    fixed = TRUE
  )


  codes_gho <- get_gho_codes()

  expect_identical(
    dim(attr(codes_gho, "attrs")),
    c(2196L, 7L)
  )
  expect_output(
    print(codes_gho),
    "Attributes:

CATEGORY
DEFINITION_XML
DISPLAY_ES
DISPLAY_FR
IMR_ID
RENDERER_ID",
    fixed = TRUE
  )
})

test_that("get_gho_data works", {

  result1 <- get_gho_data(
    dimension = "GHO",
    code = "MDG_0000000001"
  )
  result2 <- get_gho_data(
    dimension = "GHO",
    code = "MDG_0000000001",
    filter = list(
      REGION = "EUR",
      YEAR = "2015"
    )
  )
  expect_identical(
    dim(result1),
    c(5330L, 11L)
  )
  expect_identical(
    dim(result2),
    c(54L, 11L)
  )
  expect_identical(
    names(result1), names(result2)
  )
  expect_identical(
    names(result1),
    c("GHO", "PUBLISHSTATE", "YEAR", "REGION", "WORLDBANKINCOMEGROUP",
      "COUNTRY", "Display Value", "Numeric", "Low", "High", "Comments")
  )
})

test_that("wrong inputs fail", {
  expect_error(get_gho_codes("REGON"))
  expect_error(get_gho_data(
    dimension = "GHO",
    code = "MDG_000000001"
  ))
  expect_error(get_gho_data(
    dimension = "GHOo",
    code = "MDG_0000000001"
  ))
  expect_error(
    get_gho_data(
      dimension = "GHO",
      code = "MDG_0000000001",
      filter = list(
        REGION = c("EUR", "test"),
        YEAR = "2015"
      )
    )
  )
})
