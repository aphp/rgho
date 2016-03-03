# rgho - Access WHO Global Health Observatory Data From R

`rgho` is an `R` package to access WHO GHO data from R via the Athena web service,     an API providing a simple query interface to the World Health Organization's data and statistics content.

You can install:

  * the latest released version from CRAN with:

```r
install.packages("rgho")
```

  * the latest development version from github with:

```r
devtools::install_github("pierucci/rgho")
```

## Main features

  * List available dimensions and codes with `get_gho_dimensions()` and `get_gho_codes()`.
  * Download data with `get_gho_data()`

## Devs

[Antoine Filipović-Pierucci](https://pierucci.github.io/).
