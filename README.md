# rgho - Access WHO Global Health Observatory Data From R

[![Travis-CI Build Status](https://travis-ci.org/pierucci/rgho.svg?branch=master)](https://travis-ci.org/pierucci/rgho) [![](http://www.r-pkg.org/badges/version/rgho)](http://www.r-pkg.org/pkg/rgho)

`rgho` is an `R` package to access [WHO GHO data](http://www.who.int/gho/database/en/) from `R` via the Athena web service, an API providing a simple query interface to the World Health Organization's data and statistics content.

You can install:

  * the latest released version from CRAN with:

```r
install.packages("rgho")
```

  * the latest development version from github with:

```r
devtools::install_github("pierucci/rgho@devel")
```

## Main features

  * List available dimensions and codes with `get_gho_dimensions()` and `get_gho_codes()`.
  * Download data with `get_gho_data()`.
  
## Documentation

  * Introduction in `vignette("intro", "rgho")`.
  * List of GHO dimensions in `vignette("dimensions", "rgho")`.
  * List of codes for the `GHO` dimension in `vignette("codes-gho", "rgho")`.

## Devs

[Antoine Filipović-Pierucci](https://pierucci.github.io/), [Kevin Zarca](http://www.urc-eco.fr/Kevin-ZARCA,402).

<h1 align="center">
<a href="http://www.urc-eco.fr">
	<img width="220" src="./inst/media/logo.png" alt="">
</a>
</h1>

