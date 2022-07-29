  <!-- badges: start -->
  [![R-CMD-check](https://github.com/aphp/rgho/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aphp/rgho/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->
  
# rgho - Access WHO Global Health Observatory Data From R

`rgho` is an `R` package to access [WHO GHO data](https://www.who.int/data/gho/) from `R` via the OData API an API providing a simple query interface to the World Health Organization's data and statistics content.

You can install:

  * the latest released version from CRAN with:

```r
install.packages("rgho")
```

  * the latest development version from github with:

```r
devtools::install_github("aphp/rgho")
```

## Main features

  * List available dimensions and values with `get_gho_dimensions()` and `get_gho_values()`.
  * Download data with `get_gho_data()`.
  
## Documentation

  * Introduction in `vignette("a-intro", "rgho")`.
  * List of GHO dimensions in `vignette("b-dimensions", "rgho")`.
  * List of values for the `GHO` dimension in `vignette("c-values-gho", "rgho")`.
  * List of values for the `COUNTRY` dimension in `vignette("d-country", "rgho")`.
  * Details about how requests are performed in `vignette("e-details", "rgho")`.

## Dev

Kevin Zarca

<h1 align="center">
<a href="https://recherche-innovation.aphp.fr/urc-eco/">
	<img width="220" src="./inst/media/logo.png">
</a>
</h1>
