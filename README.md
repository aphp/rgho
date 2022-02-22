# rgho - Access WHO Global Health Observatory Data From R

[![Travis-CI Build Status](https://travis-ci.org/pierucci/rgho.svg?branch=devel)](https://travis-ci.org/pierucci/rgho) [![](https://www.r-pkg.org/badges/version/rgho)](https://www.r-pkg.org/pkg/rgho) 

`rgho` is an `R` package to access [WHO GHO data](https://www.who.int/data/gho/) from `R` via the Athena web service, an API providing a simple query interface to the World Health Organization's data and statistics content.

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

  * Introduction in `vignette("a-intro", "rgho")`.
  * List of GHO dimensions in `vignette("b-dimensions", "rgho")`.
  * List of codes for the `GHO` dimension in `vignette("c-codes-gho", "rgho")`.
  * List of codes for the `COUNTRY` dimension in `vignette("d-country", "rgho")`.
  * Details about how requests are performed in `vignette("e-details", "rgho")`.

## Dev

Antoine Filipović-Pierucci & Kevin Zarca

<h1 align="center">
<a href="http://recherche-innovation.aphp.fr/urc-eco/">
	<img width="220" src="./inst/media/logo.png" title="Special thanks to Dave Null, our contact who processed all the emails we send to WHO.">
</a>
</h1>
