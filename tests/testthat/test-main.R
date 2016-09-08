context("main")

test_that("get_gho_dimensions works", {
  gho_dim <- get_gho_dimensions()

  expect_identical(
    sort(gho_dim),
    c("ADVERTISINGTYPE", "AGEGROUP", "ALCOHOLPOLICYYEAR", "ALCOHOLTYPE",
      "AWARENESSACTIVITYTYPE", "BACGROUP", "BEVERAGETYPE", "CASE_DEFINITION",
      "CHILDCAUSE", "CLINICALSUPERVISION", "COMMUNITYACTIONTYPE", "CONSUMPTIONTYPE",
      "COORDINATINGENTITIES", "COUNTRY", "CTRYGROUP", "DATASOURCE",
      "DAY", "DHSMICSGEOREGION", "DISEASECAUSE", "DISEASECAUSEGROUP",
      "DISEASECAUSESUBGROUP", "DISEASESUBCAUSE", "DONORTYPE", "DRINKDRIVINGDEFINITIONTYPE",
      "DRIVERTYPE", "DRIVINGTESTTYPE", "DRUG", "DRUGPRESCRIPTION",
      "DRUGSUPERVISION", "EDUCATIONLEVEL", "EMFBODYPART", "EMFEXPOSED",
      "EMFFIELD", "EMFFREQUENCY", "EMFRADIOBAND", "ENVCAUSE", "ESSMEDSRESPONSE",
      "GBDCAUSECODE", "GBDCHILDCAUSES", "GBDREGION", "GBDTYPE", "GHECAUSE",
      "GHECAUSELEVEL1", "GHECAUSELEVEL2", "GHECAUSELEVEL3", "GHECAUSELEVEL4",
      "GHECAUSES", "GHO", "GHOCAT", "GOVERNMENTBENEFIT", "GROUP", "HARMANDCONSEQUENCE",
      "HEALTHSTATUS", "ICD10CAUSEGROUP", "ICD10CHAPTER", "ICDIMPL",
      "INADEQUACY", "INCOMELEVEL", "INDICATOR", "INDUSTRYTYPE", "LEGISLATIONTYPE",
      "LOCATION", "LOCATIONTYPE", "MEASUREIMPORTANCETYPE", "MEASUREMENTMETHODS",
      "MGHEREG", "MONTH", "MORTCAUSE", "MOTOCYCLEOCCUPANTTYPE", "NATIONALSYSTEMTYPE",
      "NGO", "OECDREGION", "OPENACCESSSERVICE", "PENALTYTYPE", "PERIODICITY",
      "PHONEACCESSTYPE", "PLACE", "POLICYADOPTIONLEVEL", "POLICYFRAMEWORK",
      "POLICYSECTOR", "PRICEMEASURETYPE", "PROGRAMME", "PROVIDER",
      "PUBLICPLACE", "PUBLICPRIVATESETTING", "PUBLISHSTATE", "QTR",
      "REGION", "RENDERER", "RESIDENCEAREATYPE", "ROADUSERTYPE", "SEATTYPE",
      "SEX", "SOCIALCOSTTYPE", "SOCIOECONOMIC", "SPECIALPOPULATION",
      "SPONSORSHIPORIGINATOR", "STANDARDOFCARE", "SUBREGION", "SUBSTANCETYPE",
      "SUBSTANCETYPEDISORDER", "SUNBED_ACCESS", "SUNBED_CONTROL", "SUNBED_INFO",
      "SUNBED_SAFETY", "SUNBED_TRAINING", "UNMDGREGION", "UNREGION",
      "VEHICLESTANDARD", "WEALTHQUINTILE", "WEEK", "WHOINCOMEREGION",
      "WORLDBANKINCOMEGROUP", "WORLDBANKREGION", "YEAR")
  )
  expect_identical(
    length(gho_dim),
    115L
  )
  expect_identical(
    head(sort(attr(gho_dim, "labels"))),
    c("Age Group", "Beverage Types", "Body part", "Case definition",
      "Cause", "Cause")
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
    "A 'GHO' object of 115 elements.",
    fixe = TRUE
  )
})

test_that("get_gho_codes works", {
  codes_region <- get_gho_codes("REGION")

  expect_identical(
    sort(codes_region),
    c("AFR", "AMR", "EMR", "EUR", "GBD_REG14_AFRD", "GBD_REG14_AFRE",
      "GBD_REG14_AMRA", "GBD_REG14_AMRB", "GBD_REG14_AMRD", "GBD_REG14_EMRB",
      "GBD_REG14_EMRD", "GBD_REG14_EURA", "GBD_REG14_EURB", "GBD_REG14_EURC",
      "GBD_REG14_SEARB", "GBD_REG14_SEARD", "GBD_REG14_WORLD", "GBD_REG14_WPRA",
      "GBD_REG14_WPRB", "GLOBAL", "NA", "NOTSPEC", "SEAR", "WB_HI",
      "WB_LI", "WB_LMI", "WB_UMI", "WHO_HI_AMR", "WHO_HI_EMR", "WHO_HI_EUR",
      "WHO_HI_GLOBAL", "WHO_HI_SEAR", "WHO_HI_WPR", "WHO_LMI_AFR",
      "WHO_LMI_AMR", "WHO_LMI_EMR", "WHO_LMI_EUR", "WHO_LMI_HIC", "WHO_LMI_SEAR",
      "WHO_LMI_WORLD", "WHO_LMI_WPR", "WHO_NONMEM", "WPR")
  )
  expect_identical(
    length(codes_region),
    43L
  )
  expect_identical(
    head(sort(attr(codes_region, "labels"))),
    c("Africa", "Africa region, stratum D (AFR D)", "Africa region, stratum E(AFR E)",
      "Americas", "Americas region, stratum A (AMR A)", "Americas region, stratum B (AMR B)"
    )
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
    "A 'GHO' object of 43 elements.",
    fixed = TRUE
  )


  codes_gho <- get_gho_codes()

  expect_identical(
    dim(attr(codes_gho, "attrs"))[2],
    7L
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
